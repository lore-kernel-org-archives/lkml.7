Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3DBC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3302089E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbfHHFnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 01:43:32 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:52937 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728090AbfHHFnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 01:43:31 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x785hTrE023834
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 01:43:29 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x785hOIX027452
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 01:43:29 -0400
Received: by mail-qk1-f197.google.com with SMTP id d203so3230877qke.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 22:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=c6yvSjRSPSPtd7WKVRhn/33mlt2UI1aeE4hr0QgnAWg=;
        b=bVRwpBpg29Mn6idOcxABkANhqCtRfKqi5GBcYzhncgpXQh7zsqRm+sST90vd9jVcaP
         g3zuskxTFDmBEh1SYaoGnqenYrLXGj2ZvrxTwWcfdtyqG9niHPMYyv496eXmfc3xvNnv
         6+iv/0HP+YZyNeVxsws/E9QYGsHjhYqV30R0ZirnE+Tctn9N+xdvKqnUwOBIqvWGQq6q
         TDUld1ZEXo6gHGLR6R1oKoARpwmbB4D/AJElLYWq1ldN5J8KFT0a96njeH+50qPGdcKV
         6YsPotK1Q5/bsDXuwL5gpRvEK9W94a6f4z2YybxbIpUP8TZX27pd8GB15bYyjA3CviwW
         Sjrg==
X-Gm-Message-State: APjAAAWAMOM5QKViaCKJSKpFaZ/tvB5Svq7NgyjYuUpFO8sj4EgSIoNz
        vlFQklH7cRK4xVxlNEmVSp12D+XR7NDwNMM229x2A68wv3mTsnKDw0Xu3H/qSY39af0oOdqbPqD
        88QlSWf9h4u6eeuKGmE+QC4vMcjnAZFHZ3cA=
X-Received: by 2002:a37:dcc7:: with SMTP id v190mr12012685qki.169.1565243004365;
        Wed, 07 Aug 2019 22:43:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzKldRnyI5SL9XuBns9hAd6WuyGhSYe29+X/2gQVf84YuCE8HdYQj3/BaWF8ziX92uInHbLyQ==
X-Received: by 2002:a37:dcc7:: with SMTP id v190mr12012675qki.169.1565243004139;
        Wed, 07 Aug 2019 22:43:24 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id h18sm36284621qkj.134.2019.08.07.22.43.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 22:43:23 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/netfilter/nf_nat_proto.c - make tables static
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 08 Aug 2019 01:43:22 -0400
Message-ID: <55481.1565243002@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse warns about two tables not being declared.

  CHECK   net/netfilter/nf_nat_proto.c
net/netfilter/nf_nat_proto.c:725:26: warning: symbol 'nf_nat_ipv4_ops' was not declared. Should it be static?
net/netfilter/nf_nat_proto.c:964:26: warning: symbol 'nf_nat_ipv6_ops' was not declared. Should it be static?

And in fact they can indeed be static.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/net/netfilter/nf_nat_proto.c b/net/netfilter/nf_nat_proto.c
index 7ac733ebd060..0a59c14b5177 100644
--- a/net/netfilter/nf_nat_proto.c
+++ b/net/netfilter/nf_nat_proto.c
@@ -722,7 +722,7 @@ nf_nat_ipv4_local_fn(void *priv, struct sk_buff *skb,
 	return ret;
 }
 
-const struct nf_hook_ops nf_nat_ipv4_ops[] = {
+static const struct nf_hook_ops nf_nat_ipv4_ops[] = {
 	/* Before packet filtering, change destination */
 	{
 		.hook		= nf_nat_ipv4_in,
@@ -961,7 +961,7 @@ nf_nat_ipv6_local_fn(void *priv, struct sk_buff *skb,
 	return ret;
 }
 
-const struct nf_hook_ops nf_nat_ipv6_ops[] = {
+static const struct nf_hook_ops nf_nat_ipv6_ops[] = {
 	/* Before packet filtering, change destination */
 	{
 		.hook		= nf_nat_ipv6_in,

