Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0308CC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EB22083D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098673;
	bh=vQM7VMwsskklyustEC80r5Fmc9gAEQWNtfV7+lJNjSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ecT/qKHCHe4V6q4E9Wjq214ya+ObItj6spMQcAEohQtvCWjbOjaNw3thfPXJE+Jxa
	 kCvaroc0RSyAmqv1Rjd8fmrbu72BSX1Q9E/sWJCMwGxgCBDGMZYy4o3dqzeMqwTx3A
	 8xcYxdmAKKpfjYw7gtabZjeEFWMoVajpeAJjRms0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfFIQod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729328AbfFIQoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:44:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8192220833;
        Sun,  9 Jun 2019 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098670;
        bh=vQM7VMwsskklyustEC80r5Fmc9gAEQWNtfV7+lJNjSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1U1FngC4ogL0YxoDYmBXGJSd7PrCURN/eANYUrAfrlQO5Iuie0q6kQqLiBHc7r+9
         wzz3kDINrzQ/BFJVIoockShhB0u1xfizDLSKXTyRrJvNPv5GQqxm1IU02m4ZN7w9Zc
         Rdx2wmbqkgbaIU7roYOoOjsJ1rsLMen8lwZjdTKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 19/70] ipmr_base: Do not reset index in mr_table_dump
Date:   Sun,  9 Jun 2019 18:41:30 +0200
Message-Id: <20190609164128.656779522@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.541128197@linuxfoundation.org>
References: <20190609164127.541128197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 7fcd1e033dacedd520abebc943c960dcf5add3ae ]

e is the counter used to save the location of a dump when an
skb is filled. Once the walk of the table is complete, mr_table_dump
needs to return without resetting that index to 0. Dump of a specific
table is looping because of the reset because there is no way to
indicate the walk of the table is done.

Move the reset to the caller so the dump of each table starts at 0,
but the loop counter is maintained if a dump fills an skb.

Fixes: e1cedae1ba6b0 ("ipmr: Refactor mr_rtm_dumproute")
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ipmr_base.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -335,8 +335,6 @@ next_entry2:
 	}
 	spin_unlock_bh(lock);
 	err = 0;
-	e = 0;
-
 out:
 	cb->args[1] = e;
 	return err;
@@ -374,6 +372,7 @@ int mr_rtm_dumproute(struct sk_buff *skb
 		err = mr_table_dump(mrt, skb, cb, fill, lock, filter);
 		if (err < 0)
 			break;
+		cb->args[1] = 0;
 next_table:
 		t++;
 	}


