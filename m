Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E724A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na6XwXBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfCRI6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:58:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35247 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfCRI6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:58:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id g8so260944pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ArDsqRAATyCwkw9oh0nttU9vAiCnkj2gs14jUD+rGw0=;
        b=na6XwXBy9xIeSLNwnGfkGJnuAxHGxblsvtQEJyrHQM0XqMDhXnmGSO89hTr5qXQBRD
         3YYOau0UrFII5A82SBKjB5Bz2GbDVKSgoK5mfTy7B9wTFz5fbMaupP/8mWnz/Z3ARIJN
         ldMlXEBU8t3aOzSMeUqX0aC8zlPryBQkNt9TmOgZa1k5VlPeVGldOVMXXsjcOtawIi7Z
         AvT/x7mapauO3CWjciDT1IGSq3IKKk3i2HOFeLT6R+HHFui/rl+3ABPmZV3DLP5J4xKp
         4YYlJf0+EMkWaqCOiDyrJGSusQDip3GXFckvnR0MMkXIwpn230cHEogco2l4jtreWXjW
         y6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ArDsqRAATyCwkw9oh0nttU9vAiCnkj2gs14jUD+rGw0=;
        b=FKFKvIu6f0+QbmYPA4qAeqjLvvivGPoLLa6uZgvtkEKSs1AJjGnv+PQJ7Sj4bJEyoV
         enlORuMn1/NchpUBYD/PdbmBtJB37Bq93Pp2mgCp5S77ctIUbph9nxI/5myhTWUdRY+l
         AjkSkDKW1rvASm9q4yvpZ1TcxTh92tJdxxNfwxclMEDO5kvAgQa/dvd4IwfG01gaE7wP
         uRYzpevcMjuul3hwwB4nPy+vnKluZxQXpNkShR0Kyj+ai5VYLL2QWYina8J/AKAbwSHx
         l9GeHDNA+NCGPyWQime/llzFcLSH6VedmUTK5T/ktLlt8aKkxU4iZ286OwOwlR6ECwEH
         UgDQ==
X-Gm-Message-State: APjAAAWDHcuHFZHpIcmzy1TicWckbywu3ogZVVK6CZICisZEFsS+XfTo
        LWONwvgXUC+44tY4wptv7Pg=
X-Google-Smtp-Source: APXvYqzgPFqdyuUrCxZCZGsvG+g6RBic9jNExe/ikajBHgfaGjyvLp4fa13Y54sEru3gC/mWTHmcRw==
X-Received: by 2002:a17:902:7b93:: with SMTP id w19mr16271879pll.141.1552899483172;
        Mon, 18 Mar 2019 01:58:03 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:58:02 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 07/19] locking/lockdep: Update obsolete struct field description
Date:   Mon, 18 Mar 2019 16:57:21 +0800
Message-Id: <20190318085733.3143-8-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock_chain struct definition has outdated comment, update it.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 79c3873..1258a62 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -202,7 +202,11 @@ struct lock_list {
  * We record lock dependency chains, so that we can cache them:
  */
 struct lock_chain {
-	/* see BUILD_BUG_ON()s in lookup_chain_cache() */
+	/*
+	 * irq_context: the same as irq_context in held_lock below
+	 * depth:       the number of held locks in this chain
+	 * base:        the index in chain_hlocks for this chain
+	 */
 	unsigned int			irq_context :  2,
 					depth       :  6,
 					base	    : 24;
-- 
1.8.3.1

