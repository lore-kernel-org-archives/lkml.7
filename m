Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31045ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C51222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="S+LQGOsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436827AbfJPUAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:00:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33998 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436798AbfJPUAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:00:41 -0400
Received: by mail-qk1-f195.google.com with SMTP id q203so23998837qke.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XbQaUimD78vcQ5YhGt3SAqPD0eC6PCpt9aPKURlFvbA=;
        b=S+LQGOsCXVbkDAppXLTZQWx3ApD3aZBcmqbRDcsmDfwye32g9YsI1DNq8SQDiITNx8
         Mwxkd82MYZ12ycXdsRv9CNHcPC410C7eK3UWoKPbVXzWQiDW/SW84fKO45Is81s7Xfn5
         jLGiv34q4GSCzK0Ob1pNRPgcllgcMNO3A+TwhI/1+OX+skjjzrq/5TCPng3VwjlB802m
         OkPx+g9Te9uSWwswjm9qIli+JKp08CTymdE/XiM1DKv2c0SaxRZW13ytSw5XxWIptqNH
         1OjY3hg7xOxJbOnC2WT1wDnVZ+/mdRLSINcDNEBzMDdFGI4H07iXQxhIG8482S1SbKNp
         qjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XbQaUimD78vcQ5YhGt3SAqPD0eC6PCpt9aPKURlFvbA=;
        b=ClzgO9w8Pzp82Mg7E6QIRee+CjYZk97zjr488NzdcuXa/+iKsa24uHAOZmfS5aRbi6
         Cuaj1B8CqCMk9GOzKKxlGmlUpsE0pvUtAhHbsSy/fjM9sxw+rNlrXkoTaNFVdBWqbYOZ
         XE1wgzPvVoYcyUbSoNchPKMjQXmI0UYrPCj0hSUsttajUAySUE/z6MKtZYMRb6R5PSPC
         9tDfdxmytOAWjocWfK9MyuI9Z5EO1sVRctaScH6O2ftgK1jpTPA18w3upu5oXqF4S97V
         QCDNOicu2RrvrOpWjyUrbn5s3mkx1mo6sZ/Dn+9+ETFqxqSyIxm5aAuST7ZMy6A9TlOr
         paxA==
X-Gm-Message-State: APjAAAW1K5pqtTIWo8frlM1IgidxXNje5OD4arLw9JVUS5jp3FGKuP5e
        y92GEofqbpQcwdY37YZkxwq4xw==
X-Google-Smtp-Source: APXvYqxV3JHHx4EkCCQ727EFwQKuQaS1GMszla5iOLzh5CkwVHlhm3ZxtmVs9ZyOFMZpCXbaSs163w==
X-Received: by 2002:a37:e503:: with SMTP id e3mr43333948qkg.491.1571256040373;
        Wed, 16 Oct 2019 13:00:40 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:00:39 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de
Subject: [PATCH v7 02/25] kexec: add machine_kexec_post_load()
Date:   Wed, 16 Oct 2019 16:00:11 -0400
Message-Id: <20191016200034.1342308-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is the same as machine_kexec_prepare(), but is called after segments are
loaded. This way, can do processing work with already loaded relocation
segments. One such example is arm64: it has to have segments loaded in
order to create a page table, but it cannot do it during kexec time,
because at that time allocations won't be possible anymore.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Acked-by: Dave Young <dyoung@redhat.com>
---
 kernel/kexec.c          | 4 ++++
 kernel/kexec_core.c     | 6 ++++++
 kernel/kexec_file.c     | 4 ++++
 kernel/kexec_internal.h | 2 ++
 4 files changed, 16 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index bc933c0db9bf..f977786fe498 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -159,6 +159,10 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	kimage_terminate(image);
 
+	ret = machine_kexec_post_load(image);
+	if (ret)
+		goto out;
+
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index f7ae04b8de6f..c19c0dad1ebe 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -589,6 +589,12 @@ static void kimage_free_extra_pages(struct kimage *image)
 	kimage_free_page_list(&image->unusable_pages);
 
 }
+
+int __weak machine_kexec_post_load(struct kimage *image)
+{
+	return 0;
+}
+
 void kimage_terminate(struct kimage *image)
 {
 	if (*image->entry != 0)
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 79f252af7dee..5b7f802be177 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -441,6 +441,10 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
+	ret = machine_kexec_post_load(image);
+	if (ret)
+		goto out;
+
 	/*
 	 * Free up any temporary buffers allocated which are not needed
 	 * after image has been loaded
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 48aaf2ac0d0d..39d30ccf8d87 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -13,6 +13,8 @@ void kimage_terminate(struct kimage *image);
 int kimage_is_destination_range(struct kimage *image,
 				unsigned long start, unsigned long end);
 
+int machine_kexec_post_load(struct kimage *image);
+
 extern struct mutex kexec_mutex;
 
 #ifdef CONFIG_KEXEC_FILE
-- 
2.23.0

