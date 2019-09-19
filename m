Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3A0C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571C721920
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568930772;
	bh=86kqvSFFKbHrMzZZpPowSo1otANBdqPFlVJptpXJ1Jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U9K4r86ppxOl3Owe08JDLfA3jq5dO6htwnEu4OsIrUfG576rXfhHhiHgpn0Rjk5dv
	 8KqvmFNr2YaHikgXO/yJ518XFFmlJKBymBzceNKC4PCOssM3InXJ+BZuFqli24nmXa
	 H7lnm9yoOh+yItIItn4B0EEI1Q2697hsBprEPddY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405141AbfISWGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405090AbfISWGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:06:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ECB221907;
        Thu, 19 Sep 2019 22:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930768;
        bh=86kqvSFFKbHrMzZZpPowSo1otANBdqPFlVJptpXJ1Jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Na0ZsGsSKy71sBoKyI4eW9fco/Jj3MqqTGD0ZrdBrveQSD7pEstK+zKXxIVrtpBTY
         qs8nPovC3vqYqbjsAEYm46/vvpqhl4wVbSQl4XaVAh4vHMHhE6kzhOdONUPzjW9aM/
         xNY9z7bCue195eYLJyNtYvoX1dMTFnHN9TQ5A768=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 09/21] net: dsa: Fix load order between DSA drivers and taggers
Date:   Fri, 20 Sep 2019 00:03:10 +0200
Message-Id: <20190919214703.159203244@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214657.842130855@linuxfoundation.org>
References: <20190919214657.842130855@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit 23426a25e55a417dc104df08781b6eff95e65f3f ]

The DSA core, DSA taggers and DSA drivers all make use of
module_init(). Hence they get initialised at device_initcall() time.
The ordering is non-deterministic. It can be a DSA driver is bound to
a device before the needed tag driver has been initialised, resulting
in the message:

No tagger for this switch

Rather than have this be fatal, return -EPROBE_DEFER so that it is
tried again later once all the needed drivers have been loaded.

Fixes: d3b8c04988ca ("dsa: Add boilerplate helper to register DSA tag driver modules")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/dsa2.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -623,6 +623,8 @@ static int dsa_port_parse_cpu(struct dsa
 	tag_protocol = ds->ops->get_tag_protocol(ds, dp->index);
 	tag_ops = dsa_tag_driver_get(tag_protocol);
 	if (IS_ERR(tag_ops)) {
+		if (PTR_ERR(tag_ops) == -ENOPROTOOPT)
+			return -EPROBE_DEFER;
 		dev_warn(ds->dev, "No tagger for this switch\n");
 		return PTR_ERR(tag_ops);
 	}


