Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26554C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 10:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CCB218AE
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 10:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG7k8lNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDFKse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 06:48:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46805 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfDFKse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 06:48:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so4436356pgv.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 03:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=L/kr42+eOjkysqUmccLNXJpDS4JFh9FfZXCnnHxwr6Y=;
        b=CG7k8lNBGRNOa0yKycoo2KaAeQXZ+KSaS5vgpk6mtaufpbW1CM4aNibH0E/0g/nLjx
         IBndOL6lNrlzB+k/8+sp4Tjvx0wjpWNu6JtbzGBKFNW34Z5J+NbWXFqISMHXYuRFBJf6
         oyw8ZFWJTDXJtZhQ7bWG32vyeeIzb5jRr7ng7T4v9f4I1w5r00am4IKnOambMCTpcrQu
         8ihQ5grsSDCnTmM42vghTNpXNZe0As9X2YDUBLxYnQ4HiTFPF9rX8ZlqRCLJzBUJUCqr
         KNm4y9w4eXkvnGHqyocSRTNGEpbtfYLUlqutlrBP9UhKJ1zCRAbF/rYu/4e3jXlKyyNR
         e3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=L/kr42+eOjkysqUmccLNXJpDS4JFh9FfZXCnnHxwr6Y=;
        b=CsSmxZB/48mpOobVQzTjv1BoB4axi/w8sRUB4Vg51ZBJI8wmJnQq3YyZOp3mipNBgZ
         84Lse4MgeW9R9IeBfnXBqQzVr4jHZWcLyMPyspAjB1l8p6MLzAPK8JVsFHUCI8MtRK5P
         HH+p+QmQTW7HOwUYxqoUh/B24O5WjG8PZ04TxJCIgCtQ6nnEzZSgWCbbIwvxCEeTIPyf
         i3UXZ/sTiUneruxpITbLtOxJXz1dSal40fb/X7ZUss30d6XNHnySzmzzGIE9Dl1pT2Oy
         oTChVnRs9f0j1gRNxZ6tsTIgthMSEWW2wPtGiSKOoOjSijTDynl8act8ZQnYGXtQkunR
         8moQ==
X-Gm-Message-State: APjAAAXhCKxugD2HAUsFZ7PRhJVrX1hAQFZxYoutWSVqbO4J4fHIiVYj
        ZXSCz6k/GYv3v3NdvOHET+s=
X-Google-Smtp-Source: APXvYqxyHIwrk4zvUH1GdCf692OH3S3k+K/JIzrxAXrGIV/S84Qmma3LVi5bNahyTBk3pdQQpOJVvg==
X-Received: by 2002:a62:e315:: with SMTP id g21mr18037484pfh.2.1554547713454;
        Sat, 06 Apr 2019 03:48:33 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id x128sm12205090pfx.103.2019.04.06.03.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 03:48:32 -0700 (PDT)
Date:   Sat, 6 Apr 2019 16:18:28 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: pid_namespace : fix warning Using plain integer as
 NULL pointer
Message-ID: <20190406104828.GA26135@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changed passing function argument "0 to NULL" to fix below sparse
warning

kernel/pid_namespace.c:55:76: warning: Using plain integer as NULL
pointer

did changes to avoid checkpatch error "prefer a maximum 75 chars per
line"

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 kernel/pid_namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index aa6e72f..6e4afdc 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -52,7 +52,8 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
 	mutex_lock(&pid_caches_mutex);
 	/* Name collision forces to do allocation under mutex. */
 	if (!*pkc)
-		*pkc = kmem_cache_create(name, len, 0, SLAB_HWCACHE_ALIGN, 0);
+		*pkc =
+		    kmem_cache_create(name, len, 0, SLAB_HWCACHE_ALIGN, NULL);
 	mutex_unlock(&pid_caches_mutex);
 	/* current can fail, but someone else can succeed. */
 	return READ_ONCE(*pkc);
-- 
2.7.4

