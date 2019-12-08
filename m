Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D38DC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 17:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD8A20692
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 17:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uuzg0mJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfLHRXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 12:23:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39860 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfLHRXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 12:23:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so12374275wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 09:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TCJmDBLYuV/jWqc0iBCCs2tprqUMEIazO4OrAHZKLfw=;
        b=uuzg0mJZTMfj6yBQSj2Y0Vu0/IKwg1wRZ73Cd+dUIkTUYO809Djo7/nyFdkNX++KyF
         wl51N6LC8cyuXh4W5JdytzCFC0LzRUWUiAuDMCb0uEnWwnpgzA0on2BmJhqJ769V3OfK
         Qth3XiMqVaWMv9mDRO7j1/PdOLzt88dZ+7lIgjxOaGQverIRRk9p/+D8Tp2rL1yhs1lS
         Q95ZqZwlCuOtru4d9uIfI8RHfhbaKlS5otsQv+Pv+05cYkjzuYevogIPd0BmouIyemBH
         XxjJ8mM6I8HOtuPKDH/OquE2HUut+hnaMyxfaKKDO/ULegd/GAtu6v4bdvpxmrcu7Eor
         7Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TCJmDBLYuV/jWqc0iBCCs2tprqUMEIazO4OrAHZKLfw=;
        b=oczAxWQjdelJyyWuECqcsd4t0ZpMC74ky7J9QJabYHlsTTqmgc2mQhDrmak9KLVk6X
         bsJKGSSDRXcR2PMU+5EKEhBXgM/UVl7Lp8cQglEK2v91DjccB2f8FCO+LBEKUCoAYzPD
         akthtY2WaDljFtvEv8f22VaJRnnS3dS/5OCCZY6GgsNHSfTQFLkO3iCSPH6Ehjp9cL+I
         uvRPTsuAjF5rR0ktiTffGSW44VHbVQdAIXa2Wm60X6GEuqIYMlacnH5yYss/3/8cEunW
         yLhxz46jxJbjYEjt0Z/xRVPUUYq9CKpkFtcEoecI4KiRdnAzX6IfCS2Vqp83WFS4+kK8
         dOGw==
X-Gm-Message-State: APjAAAUl2sLdNikhka7rmq73vcsmIOxcEa5cxXkWsT+NL/YU0HgbJj7x
        LlBk/gFZsiRmLRBQ49ixlti3VEI=
X-Google-Smtp-Source: APXvYqwjfKyDgkVT30izndYAtXJS80kI/3gW8VNhHD0oJzHfdaJC5Pyld4r8NTpaFb9zIOwhVMvfzg==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr19474644wml.71.1575825785048;
        Sun, 08 Dec 2019 09:23:05 -0800 (PST)
Received: from avx2 ([46.53.249.42])
        by smtp.gmail.com with ESMTPSA id k11sm1497102wmc.20.2019.12.08.09.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 09:23:04 -0800 (PST)
Date:   Sun, 8 Dec 2019 20:23:01 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ELF: smaller code generation around auxv vector fill
Message-ID: <20191208172301.GD19716@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Filling auxv vector as array with index (auxv[i++] = ...) generates terrible
code. "saved_auxv" should be reworked because it is the worst member
of mm_struct by size/usefullness ratio but do it later.

Meanwhile help gcc a little with *auxv++ idiom.

Space savings on x86_64:

	add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-127 (-127)
	Function                                     old     new   delta
	load_elf_binary                             5470    5343    -127

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -177,7 +177,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	unsigned char k_rand_bytes[16];
 	int items;
 	elf_addr_t *elf_info;
-	int ei_index = 0;
+	int ei_index;
 	const struct cred *cred = current_cred();
 	struct vm_area_struct *vma;
 
@@ -231,8 +231,8 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	/* update AT_VECTOR_SIZE_BASE if the number of NEW_AUX_ENT() changes */
 #define NEW_AUX_ENT(id, val) \
 	do { \
-		elf_info[ei_index++] = id; \
-		elf_info[ei_index++] = val; \
+		*elf_info++ = id; \
+		*elf_info++ = val; \
 	} while (0)
 
 #ifdef ARCH_DLINFO
@@ -276,12 +276,13 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	}
 #undef NEW_AUX_ENT
 	/* AT_NULL is zero; clear the rest too */
-	memset(&elf_info[ei_index], 0,
-	       sizeof current->mm->saved_auxv - ei_index * sizeof elf_info[0]);
+	memset(elf_info, 0, (char *)current->mm->saved_auxv +
+			sizeof(current->mm->saved_auxv) - (char *)elf_info);
 
 	/* And advance past the AT_NULL entry.  */
-	ei_index += 2;
+	elf_info += 2;
 
+	ei_index = elf_info - (elf_addr_t *)current->mm->saved_auxv;
 	sp = STACK_ADD(p, ei_index);
 
 	items = (argc + 1) + (envc + 1) + 1;
@@ -339,7 +340,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	current->mm->env_end = p;
 
 	/* Put the elf_info on the stack in the right place.  */
-	if (copy_to_user(sp, elf_info, ei_index * sizeof(elf_addr_t)))
+	if (copy_to_user(sp, current->mm->saved_auxv, ei_index * sizeof(elf_addr_t)))
 		return -EFAULT;
 	return 0;
 }
