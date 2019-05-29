Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ADEC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC57E240DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJHbBfQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfE2TLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 15:11:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41915 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2TLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 15:11:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so2526348wrm.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/tsvRp9laXBjB1a3tF2UBNPt/FfsvWNcZfhMdtVC5VM=;
        b=pJHbBfQEa0/Yb1N0GrHDO0HxsotKlL8w7iEkHBuxgjKQL1WcjmFnAv9/8LQZy6LsGp
         J6Ylx1hirDYH5Vz1+33CynrvRphDqFAA+gwL5N4kRgu5yUENGvfYHIMVyul1NngxFW64
         yoenu5o9tIHDepjh5p4Vi78xsddHV2nPEINoPbyO2A9vJEf4tHRI5v4HJ7bbvEwy0O+Q
         VzqLqEnW7OJVSi/F/z/pYGHG4U5qaXWjHtzfHOS7/DdO2xEuwIwBmiuj7bkI1HcCtvA/
         2L/nT+JQqkd3g5vDslpAyFC1uc2pl6XpQ8AviVoNuE6xZSApkQ7U/sHD0wOCylI2GuxZ
         nAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/tsvRp9laXBjB1a3tF2UBNPt/FfsvWNcZfhMdtVC5VM=;
        b=MfzYTZw46KIVczWvzHHu3w2yliDh8h8A5v9LyeSG/qJHOtpIX1KCxY5hcC3iuLRGxX
         gx0cCRgcL/Ddz7bkodJ2xHbzUFZ+ziYcDKZHOMTcKJOyJfnmjisoMfsUybNdfO5jbdDy
         zK1icLX7ZJ0pbSA8PudNm+LmfOnkVHEfRvU/n+No9AlXgiQzbQ5xBznszrwtWEQERedt
         6JDl1z1ZI6E4yKb4UZUhg7i1IwhoH1uzoL+m9LY6yzhGpnGKxnQzeqB8l5agJqv6FrVM
         B2r/BxgooZnfx524fxXxV39t014clr0ytQzDfIjJGIX8WtZyLfF3huS7C8/Pv1YFLakX
         MBhw==
X-Gm-Message-State: APjAAAVXqSjllBlyfrMpSgoy9TomkDPZ7MxBhNVFFSZeFLykQrwRGXEZ
        9ZS9K49ET6/jqSBHEB8biREn4xI=
X-Google-Smtp-Source: APXvYqy0ssmpfrSA0mrBERiaTSOFb2gFTjTrs4jkpON5ra66cflokgtToxmWl98+tmcoF+8MjsHZyg==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr182222wrl.134.1559157074035;
        Wed, 29 May 2019 12:11:14 -0700 (PDT)
Received: from avx2 ([46.53.251.224])
        by smtp.gmail.com with ESMTPSA id h12sm476214wre.14.2019.05.29.12.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 12:11:13 -0700 (PDT)
Date:   Wed, 29 May 2019 22:11:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] proc: use typeof_member() macro
Message-ID: <20190529191110.GB5703@avx2>
References: <20190529190720.GA5703@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190529190720.GA5703@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't repeat function signatures twice.

This is a kind-of-precursor for "struct proc_ops".

Note:

	typeof(pde->proc_fops->...) ...;

can't be used because ->proc_fops is "const struct file_operations *".
"const" prevents assignment down the code and it can't be deleted
in the type system.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	Note 2: 100% false positives with checkpatch.pl :^)

 fs/proc/inode.c |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -200,7 +200,8 @@ static loff_t proc_reg_llseek(struct file *file, loff_t offset, int whence)
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	loff_t rv = -EINVAL;
 	if (use_pde(pde)) {
-		loff_t (*llseek)(struct file *, loff_t, int);
+		typeof_member(struct file_operations, llseek) llseek;
+
 		llseek = pde->proc_fops->llseek;
 		if (!llseek)
 			llseek = default_llseek;
@@ -212,10 +213,11 @@ static loff_t proc_reg_llseek(struct file *file, loff_t offset, int whence)
 
 static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
-	ssize_t (*read)(struct file *, char __user *, size_t, loff_t *);
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	ssize_t rv = -EIO;
 	if (use_pde(pde)) {
+		typeof_member(struct file_operations, read) read;
+
 		read = pde->proc_fops->read;
 		if (read)
 			rv = read(file, buf, count, ppos);
@@ -226,10 +228,11 @@ static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count,
 
 static ssize_t proc_reg_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
-	ssize_t (*write)(struct file *, const char __user *, size_t, loff_t *);
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	ssize_t rv = -EIO;
 	if (use_pde(pde)) {
+		typeof_member(struct file_operations, write) write;
+
 		write = pde->proc_fops->write;
 		if (write)
 			rv = write(file, buf, count, ppos);
@@ -242,8 +245,9 @@ static __poll_t proc_reg_poll(struct file *file, struct poll_table_struct *pts)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	__poll_t rv = DEFAULT_POLLMASK;
-	__poll_t (*poll)(struct file *, struct poll_table_struct *);
 	if (use_pde(pde)) {
+		typeof_member(struct file_operations, poll) poll;
+
 		poll = pde->proc_fops->poll;
 		if (poll)
 			rv = poll(file, pts);
@@ -256,8 +260,9 @@ static long proc_reg_unlocked_ioctl(struct file *file, unsigned int cmd, unsigne
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	long rv = -ENOTTY;
-	long (*ioctl)(struct file *, unsigned int, unsigned long);
 	if (use_pde(pde)) {
+		typeof_member(struct file_operations, unlocked_ioctl) ioctl;
+
 		ioctl = pde->proc_fops->unlocked_ioctl;
 		if (ioctl)
 			rv = ioctl(file, cmd, arg);
@@ -271,8 +276,9 @@ static long proc_reg_compat_ioctl(struct file *file, unsigned int cmd, unsigned
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	long rv = -ENOTTY;
-	long (*compat_ioctl)(struct file *, unsigned int, unsigned long);
 	if (use_pde(pde)) {
+		typeof_member(struct file_operations, compat_ioctl) compat_ioctl;
+
 		compat_ioctl = pde->proc_fops->compat_ioctl;
 		if (compat_ioctl)
 			rv = compat_ioctl(file, cmd, arg);
@@ -286,8 +292,9 @@ static int proc_reg_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	int rv = -EIO;
-	int (*mmap)(struct file *, struct vm_area_struct *);
 	if (use_pde(pde)) {
+		typeof_member(struct file_operations, mmap) mmap;
+
 		mmap = pde->proc_fops->mmap;
 		if (mmap)
 			rv = mmap(file, vma);
@@ -305,7 +312,7 @@ proc_reg_get_unmapped_area(struct file *file, unsigned long orig_addr,
 	unsigned long rv = -EIO;
 
 	if (use_pde(pde)) {
-		typeof(proc_reg_get_unmapped_area) *get_area;
+		typeof_member(struct file_operations, get_unmapped_area) get_area;
 
 		get_area = pde->proc_fops->get_unmapped_area;
 #ifdef CONFIG_MMU
@@ -326,8 +333,8 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 {
 	struct proc_dir_entry *pde = PDE(inode);
 	int rv = 0;
-	int (*open)(struct inode *, struct file *);
-	int (*release)(struct inode *, struct file *);
+	typeof_member(struct file_operations, open) open;
+	typeof_member(struct file_operations, release) release;
 	struct pde_opener *pdeo;
 
 	/*
