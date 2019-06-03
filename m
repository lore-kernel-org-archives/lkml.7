Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1067DC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9CB27F6F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553424;
	bh=Eoqrcd+Jb5+J5XJOqRM1pn5UpfVPaTOv7EbLS0XI0AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mh+bbKqY+MHeyvvYUqkMJR/nqPOeppyeYT1MXge1osZRi++o4+RxcB5V69e43an5z
	 iksUKv8BfnRgKK4SKPrg79N+kpaCiYajVon/9dSgthzpFAeqQWk/MzfM1U/ZVDTgxG
	 PCF0VMfmwLQxUp+D/yxgzHA9Fve7hYVuc4UmRqWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfFCJLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbfFCJLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:11:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD65127E51;
        Mon,  3 Jun 2019 09:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553111;
        bh=Eoqrcd+Jb5+J5XJOqRM1pn5UpfVPaTOv7EbLS0XI0AU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R9+ke6ZFK/cu6t/tJNUIzJKrFuxeFAgGYdPulFnFI18lL81G9qsuoUQ/RoT3xw180
         XNWVR6bFqjNaixfPu6bIKn42QZYwLt8ca2+p+0kw2UdqejTTjOPMy4gIRLd3XuLPxi
         Nm4UCRFhNwio6k/a0L844frNs6pIjoBO6Xtik1c4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        kbuild test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 05/36] ipv4/igmp: fix build error if !CONFIG_IP_MULTICAST
Date:   Mon,  3 Jun 2019 11:08:53 +0200
Message-Id: <20190603090521.307430808@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090520.998342694@linuxfoundation.org>
References: <20190603090520.998342694@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 903869bd10e6719b9df6718e785be7ec725df59f ]

ip_sf_list_clear_all() needs to be defined even if !CONFIG_IP_MULTICAST

Fixes: 3580d04aa674 ("ipv4/igmp: fix another memory leak in igmpv3_del_delrec()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/igmp.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -187,6 +187,17 @@ static void ip_ma_put(struct ip_mc_list
 	     pmc != NULL;					\
 	     pmc = rtnl_dereference(pmc->next_rcu))
 
+static void ip_sf_list_clear_all(struct ip_sf_list *psf)
+{
+	struct ip_sf_list *next;
+
+	while (psf) {
+		next = psf->sf_next;
+		kfree(psf);
+		psf = next;
+	}
+}
+
 #ifdef CONFIG_IP_MULTICAST
 
 /*
@@ -632,17 +643,6 @@ static void igmpv3_clear_zeros(struct ip
 	}
 }
 
-static void ip_sf_list_clear_all(struct ip_sf_list *psf)
-{
-	struct ip_sf_list *next;
-
-	while (psf) {
-		next = psf->sf_next;
-		kfree(psf);
-		psf = next;
-	}
-}
-
 static void kfree_pmc(struct ip_mc_list *pmc)
 {
 	ip_sf_list_clear_all(pmc->sources);


