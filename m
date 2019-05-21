Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C61C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0A22173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzhMW9Ya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfEUIqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:46:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39078 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfEUIqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:46:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id w22so8233282pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/46rsZ0TTMrZw/Frg4uFqjjAL1q6S8X5odognbNJDoY=;
        b=LzhMW9YayLa5GY6/vmBvGp2kse5Fixy6Xsdk/iyVU62XdxrPJ0x5UvnjPxwfYgru5R
         8UUw1s+oKunkhSYNIfLDSskfqkrQYRp32RDWmDJ4iLRW2fiA1n6ez9cBsKawuf38QHXb
         5aC72kWzyFTVTJpiOG+Ev/6VPgn6PEHisMBF6TNEcCAHzbFGvyKQ0974b3U1VHakm5WL
         h9lHZzzQ3oFRlRARlJwWABqNrcU5clCp9+5Ulwo6fu7ujMDNFplHQ94wOgVlrYKqC6/c
         85jzYTD8U9QC1xZ8KCmH45tzQB3e4IelUGSR/lBv9p5KYoyOFpf6UlKEEXp0sfVvWmmO
         yTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/46rsZ0TTMrZw/Frg4uFqjjAL1q6S8X5odognbNJDoY=;
        b=cosmmsPeeCw+XKRs8zNzH5OaFCqTC2BtnhKdLeY08rNCVpT9JP6fl5FoJkSMYWps7A
         sb80dr9yoU8jg6Vii3YNBNttS4vjk9GPIWFPdUrMRg3jL0FwDUTbyKaC63/iAvi7Rs9r
         XkZ8iswtr/qp+zWgqracRSCp6fgdfbyfcEkt8ukMRpAs9PUvrSymP+xhiT9BMzfjse9Q
         zwG8AJXyMu0L6cvVRsDZcn5kIw1WL4HamOFewFKNzUIsDRMhsz09lK4prs3db0nBjFAN
         YnMCLFPl1L5HKOxshYhezbZoOVNukoZ/jwpoygPA5lK7lmhUplI2wRw55gYOivV+ovrR
         ebSA==
X-Gm-Message-State: APjAAAXN4ERVz61x/xzNKA0szCjTw/1xK63UkVNYw1UKh0TH3LooVgz+
        LWnqSOH7o9/nfSJ0XCAPdJa8GoYAmYQ=
X-Google-Smtp-Source: APXvYqy4dRls5P1e9lP9u8PPoItgcIzOKqgbOp/mXH0oODOhwFC5OKsknSna+GUPTAhsByuIUJjhbw==
X-Received: by 2002:a62:5801:: with SMTP id m1mr49165659pfb.32.1558428380247;
        Tue, 21 May 2019 01:46:20 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id s24sm24300431pfe.57.2019.05.21.01.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:46:19 -0700 (PDT)
Date:   Tue, 21 May 2019 16:46:06 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6_sockglue.c: Fix a missing-check bug in
 net/ipv6/ipv6_sockglue.c
Message-ID: <20190521084152.GI5263@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function ip6_ra_control(), the pointer new_ra is allocated a memory 
space via kmalloc(). And it is used in the following codes. However, 
when there is a memory allocation error, kmalloc() fails. Thus null 
pointer dereference may happen. And it will cause the kernel to crash. 
Therefore, we should check the return value and handle the error.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

---
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 40f21fe..0a3d035 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -68,6 +68,8 @@ int ip6_ra_control(struct sock *sk, int sel)
 		return -ENOPROTOOPT;
 
 	new_ra = (sel >= 0) ? kmalloc(sizeof(*new_ra), GFP_KERNEL) : NULL;
+	if (sel >= 0 && !new_ra)
+		return -ENOMEM;
 
 	write_lock_bh(&ip6_ra_lock);
 	for (rap = &ip6_ra_chain; (ra = *rap) != NULL; rap = &ra->next) {
