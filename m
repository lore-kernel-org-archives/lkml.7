Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FE8C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5C720868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S77enoKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfDPUTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:19:11 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:45955 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfDPUTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:19:11 -0400
Received: by mail-wr1-f41.google.com with SMTP id s15so28807167wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 13:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZEu0JZ7Wfybd1nQa4XJAoh1Js4Iv2SHwYmOQXO18ST4=;
        b=S77enoKWb5KwjKELwONkO10Y+sDJEFn+79JoEM0pirrXPd07j8uB9WsamrBrQwiNXV
         oxinh+4l6kls1bSJX2JbtzdG8uTeNeBouFvk6d4QpqLKVtIOcZLH+jNRkswkMo1azrBM
         itEWyy3SNstALul0jxa2DC/b7GkVyOGVEy08JyDLbnWjSYK0DXXVZ+w5YpYIffA0EE2v
         unf/ccV6ywgOU8wwitrT8/uORHG2GLYMil/3SLeZSy+9VmZBYFFIyYllszYfeq+iNOyq
         EEjVGPW1aqPwozBSopKvZ3Dt5Z2/2hqLZQo2JcOdR0o+9P31xYD0KC4K0Uc5wRL61Fns
         adpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZEu0JZ7Wfybd1nQa4XJAoh1Js4Iv2SHwYmOQXO18ST4=;
        b=bTtb/zZcRjr8VemsmzfdpbsYE1xxGSbphUd/ChU/JqIYg8+CcJwrdHrOKLZkqX66hG
         AqU49cBqzwh1EZZ8RJrkIwvKJDVDv9J285UW1I6tiZwPx2URwkx1ka5220k0hCAxMSkL
         X+PlJIwdnXW0CR0OPZSwfLmPUdSNuWr9rygrxFZQg7RkWPyF0mUhVTZ139riaQ+gvUax
         OVaHXW5nQRSeu8y5a+Fa2ysRImdMKSCQAVBhpV5iPOU5rNwmW3xAHpYb3hdNSMgYQGnx
         J7z/+5xoLlgyxmJyzY3zjJQvxIg6fZa94pNTLuyFro2fMTG63nokdsgDLKdKDPeJr1vl
         4IXA==
X-Gm-Message-State: APjAAAV/6L17sh+CFfCQgeCAdFlJ7hggfFZrjdCFlsYaeqh6tZjdsGh5
        26mhwDH8L5QIqgYgl+SYmyIurtI=
X-Google-Smtp-Source: APXvYqwXHlyRiKlP0xauKsNJQQ0WfEedSKaNzfpDpK+mlWK+JLa0FxStaoeJsAQAaXkUDuonFoJCgA==
X-Received: by 2002:adf:dcca:: with SMTP id x10mr33382519wrm.57.1555445949665;
        Tue, 16 Apr 2019 13:19:09 -0700 (PDT)
Received: from avx2 ([46.53.243.209])
        by smtp.gmail.com with ESMTPSA id o130sm283564wmo.43.2019.04.16.13.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 13:19:08 -0700 (PDT)
Date:   Tue, 16 Apr 2019 23:19:06 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH -mm 1/2] elf: save 1 indent level
Message-ID: <20190416201906.GA24304@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite

	for (...) {
		if (->p_type == PT_INTERP) {
			...
			break;
		}
	}

loop into

	for (...) {
		if (->p_type != PT_INTERP)
			continue;
		...
		break;
	}

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |  111 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 54 insertions(+), 57 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -740,69 +740,66 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	start_data = 0;
 	end_data = 0;
 
-	for (i = 0; i < loc->elf_ex.e_phnum; i++) {
-		if (elf_ppnt->p_type == PT_INTERP) {
-			char *elf_interpreter;
-			loff_t pos;
-
-			/* This is the program interpreter used for
-			 * shared libraries - for now assume that this
-			 * is an a.out format binary
-			 */
-			retval = -ENOEXEC;
-			if (elf_ppnt->p_filesz > PATH_MAX || 
-			    elf_ppnt->p_filesz < 2)
-				goto out_free_ph;
-
-			retval = -ENOMEM;
-			elf_interpreter = kmalloc(elf_ppnt->p_filesz,
-						  GFP_KERNEL);
-			if (!elf_interpreter)
-				goto out_free_ph;
-
-			pos = elf_ppnt->p_offset;
-			retval = kernel_read(bprm->file, elf_interpreter,
-					     elf_ppnt->p_filesz, &pos);
-			if (retval != elf_ppnt->p_filesz) {
-				if (retval >= 0)
-					retval = -EIO;
-				goto out_free_interp;
-			}
-			/* make sure path is NULL terminated */
-			retval = -ENOEXEC;
-			if (elf_interpreter[elf_ppnt->p_filesz - 1] != '\0')
-				goto out_free_interp;
+	for (i = 0; i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
+		char *elf_interpreter;
+		loff_t pos;
 
-			interpreter = open_exec(elf_interpreter);
-			kfree(elf_interpreter);
-			retval = PTR_ERR(interpreter);
-			if (IS_ERR(interpreter))
-				goto out_free_ph;
+		if (elf_ppnt->p_type != PT_INTERP)
+			continue;
 
-			/*
-			 * If the binary is not readable then enforce
-			 * mm->dumpable = 0 regardless of the interpreter's
-			 * permissions.
-			 */
-			would_dump(bprm, interpreter);
-
-			/* Get the exec headers */
-			pos = 0;
-			retval = kernel_read(interpreter, &loc->interp_elf_ex,
-					     sizeof(loc->interp_elf_ex), &pos);
-			if (retval != sizeof(loc->interp_elf_ex)) {
-				if (retval >= 0)
-					retval = -EIO;
-				goto out_free_dentry;
-			}
+		/*
+		 * This is the program interpreter used for shared libraries -
+		 * for now assume that this is an a.out format binary.
+		 */
+		retval = -ENOEXEC;
+		if (elf_ppnt->p_filesz > PATH_MAX || elf_ppnt->p_filesz < 2)
+			goto out_free_ph;
 
-			break;
+		retval = -ENOMEM;
+		elf_interpreter = kmalloc(elf_ppnt->p_filesz, GFP_KERNEL);
+		if (!elf_interpreter)
+			goto out_free_ph;
 
-out_free_interp:
-			kfree(elf_interpreter);
+		pos = elf_ppnt->p_offset;
+		retval = kernel_read(bprm->file, elf_interpreter,
+				     elf_ppnt->p_filesz, &pos);
+		if (retval != elf_ppnt->p_filesz) {
+			if (retval >= 0)
+				retval = -EIO;
+			goto out_free_interp;
+		}
+		/* make sure path is NULL terminated */
+		retval = -ENOEXEC;
+		if (elf_interpreter[elf_ppnt->p_filesz - 1] != '\0')
+			goto out_free_interp;
+
+		interpreter = open_exec(elf_interpreter);
+		kfree(elf_interpreter);
+		retval = PTR_ERR(interpreter);
+		if (IS_ERR(interpreter))
 			goto out_free_ph;
+
+		/*
+		 * If the binary is not readable then enforce mm->dumpable = 0
+		 * regardless of the interpreter's permissions.
+		 */
+		would_dump(bprm, interpreter);
+
+		/* Get the exec headers */
+		pos = 0;
+		retval = kernel_read(interpreter, &loc->interp_elf_ex,
+				     sizeof(loc->interp_elf_ex), &pos);
+		if (retval != sizeof(loc->interp_elf_ex)) {
+			if (retval >= 0)
+				retval = -EIO;
+			goto out_free_dentry;
 		}
-		elf_ppnt++;
+
+		break;
+
+out_free_interp:
+		kfree(elf_interpreter);
+		goto out_free_ph;
 	}
 
 	elf_ppnt = elf_phdata;
