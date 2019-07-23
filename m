Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B29C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E54206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhRz0o07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbfGWKA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:00:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40102 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfGWKA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:00:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so19179947pgj.7;
        Tue, 23 Jul 2019 03:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5OAJErAik0xYRiczuYg/dRLWg9Npudu/HIsd564SyVk=;
        b=dhRz0o072/BEcOUJhWA52ddEU/HGgqq6LhasWoT8YOHZvsSAKW337oGxSi0e93Owmv
         6gfiwJMkzuSfycOhKDP4LWw9AhI8zzemt+PzF79gQzp56Sg/Tgm7ISHSaeGb4WskrkUi
         xaTvVKQRFv7b+kYCFZvV/kPT+Wy7tSPKys6ePiwR9iLwLt1hpZbT3IRLqkIiBCW+OmX4
         sXqqE9VSlc9lgZw4se9BbU0eJT3ptv6hDXYK7eSRFjogawuIMDoYud8ZcBWHSFmIhjsq
         G0WpoR6K0MDB6d22cK3/kN0vix1CS7MmYZcKmd289zUZa601dz29++rdaoheisl04ilp
         f04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5OAJErAik0xYRiczuYg/dRLWg9Npudu/HIsd564SyVk=;
        b=oSDmCr33i52B/Ydy3j/17BwEiimMvJgl6H/73MtmNsdE8x9efm8LI2IJJWTb91uhbl
         iT3FdVXhBfK0c4DYhxoXlFz+EtwwoMU0rJKpb31njqAJaKJeTpbaHjW9uSBVtKael+32
         3rspw5wuXF6Ae0RsPvYSNsybhuXaigThfe7nSQ0oEP9+R6UM8kKBq7f6um2vU6R827IT
         Fx/+dgvotnPvlECWzc3CacnA/vGMoBeRcTZbDvbEJeM6a1w9Du8/qcOhLfpJZsOXJXCj
         doBnUxYfp+GJcs1XJhgBAYVqOKU3b8h63CKkvh/WvWzQkQhrbdU7GWxDVnm3VeaCwHMO
         QhXg==
X-Gm-Message-State: APjAAAXLxXIYf/ldvDtO5WsoAhuZdpOnutO9qccU09e3yK2u7hPKODbj
        KOEAZw0+cU2K0HnpSd0p0UE=
X-Google-Smtp-Source: APXvYqwNWVAJYmjCW8kEPfETxNjyljUixVn9J0Y+PXozl+eLiUNPjvrPnnaCEuVfF1e4zAq/uJX/Mw==
X-Received: by 2002:a17:90a:ca11:: with SMTP id x17mr82284773pjt.107.1563876026282;
        Tue, 23 Jul 2019 03:00:26 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id y12sm50328188pfn.187.2019.07.23.03.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 03:00:25 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     casey@schaufler-ca.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] security: smack: Fix possible null-pointer dereferences in smack_socket_sock_rcv_skb()
Date:   Tue, 23 Jul 2019 18:00:15 +0800
Message-Id: <20190723100015.5400-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In smack_socket_sock_rcv_skb(), there is an if statement 
on line 3920 to check whether skb is NULL:
    if (skb && skb->secmark != 0)

This check indicates skb can be NULL in some cases.

But on lines 3931 and 3932, skb is used:
    ad.a.u.net->netif = skb->skb_iif;
    ipv6_skb_to_auditdata(skb, &ad.a, NULL);

Thus, possible null-pointer dereferences may occur when skb is NULL.

To fix these possible bugs, an if statement is added to check skb.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 security/smack/smack_lsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4c5e5a438f8b..5c9fc8ba6e57 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3925,6 +3925,8 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 			skp = smack_ipv6host_label(&sadd);
 		if (skp == NULL)
 			skp = smack_net_ambient;
+		if (skb == NULL)
+			break;
 #ifdef CONFIG_AUDIT
 		smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
 		ad.a.u.net->family = family;
-- 
2.17.0

