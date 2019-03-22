Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0A2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B145D20449
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254254;
	bh=jYJsPpY78m5EimvxGHqmQN7OLk6KnQdq6ED+NiqNV5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iFGNbuSEsNujUjVzfW7WAMztyHeBjxn6uZBRS3ldrFaVFbXVC4wh23Qw0ILzZdZys
	 WslIhv/plKYkmbwWjvYz9AV/Zf8707z1aQ7pM4e22jf/5XGrcZv9c+Or9a6wWdtNro
	 Q2b/8nVBlfouifhXtVVAXAWSPzBkFOE/tzKDTRKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfCVLax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729222AbfCVLas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:30:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5A4D20449;
        Fri, 22 Mar 2019 11:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254248;
        bh=jYJsPpY78m5EimvxGHqmQN7OLk6KnQdq6ED+NiqNV5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uZDVmr4Qm0CAzWV9lMBefKhqmWdLgp6mP2vxkQ/QCyUeAsTYpJhBZutTJTEb8w+GP
         orN67ch4A/IJD+T1tASn7GcrzXg8rvg41gSRQu3qqBNf42K97yxidyww/KA3BgQUFn
         LGA7cSm6TVbR7hoFCDsEbAIZdpVo1HGhdYS225xw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Healy <Chris.Healy@zii.aero>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 077/230] net: dsa: mv88e6xxx: Fix u64 statistics
Date:   Fri, 22 Mar 2019 12:13:35 +0100
Message-Id: <20190322111242.064537869@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit 6e46e2d821bb22b285ae8187959096b65d063b0d ]

The switch maintains u64 counters for the number of octets sent and
received. These are kept as two u32's which need to be combined.  Fix
the combing, which wrongly worked on u16's.

Fixes: 80c4627b2719 ("dsa: mv88x6xxx: Refactor getting a single statistic")
Reported-by: Chris Healy <Chris.Healy@zii.aero>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/dsa/mv88e6xxx.c
+++ b/drivers/net/dsa/mv88e6xxx.c
@@ -712,7 +712,7 @@ static uint64_t _mv88e6xxx_get_ethtool_s
 		if (s->sizeof_stat == 8)
 			_mv88e6xxx_stats_read(ds, s->reg + 1, &high);
 	}
-	value = (((u64)high) << 16) | low;
+	value = (((u64)high) << 32) | low;
 	return value;
 }
 


