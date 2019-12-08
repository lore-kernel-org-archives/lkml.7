Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3097C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 17:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A70B20409
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 17:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXnxX3E0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLHRTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 12:19:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35115 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfLHRTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 12:19:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so13418850wro.2;
        Sun, 08 Dec 2019 09:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hJ551783o9ImIc/f28xz8rKXrHYxNx70TgHA3JxmnaY=;
        b=oXnxX3E0AsCAjLUi4ymzC7mQnsVvvUvM1731+3HdPdZL6kakMAdK8IyWnTBGfbIa0K
         cOumCj+euP80G+nRBykvoYFsRI/wtwDgI9gwkzMxyd93bEECKS1rt7gzkfEavMPOrSGN
         0NHudKJCMgFU29ZHDk8HNn6yZa3RJocdsfjGbJWEAhvsIMMOL6cvVmRy8dCfav3BsxTI
         PFL1PW+CUBnvlRr41msShjHwRGZkYN+kasf7ow+y70HvuXaeyig79sEP9iQXE4e189Rr
         TvaW57XFYrZxGxnfaNfK/qckAE/I8ZwtHu5TDb33Teu0EjO2Zc605+xgHm8LhwPhvAOd
         ftzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hJ551783o9ImIc/f28xz8rKXrHYxNx70TgHA3JxmnaY=;
        b=ZoKOsP0CVd93XG1qMD3EnU3vXgmOYM6UDY3wXZqj2SLF5QVcdXvqOZVRd2mWng41R4
         v/hWVnsAPBz8Oxn1Qw57jniKTdFXqm7szZ0EKLsWzm9qedIJGNa5ghYcw0ma+iuIC019
         ebhe22RfRdsCUl1KibadQw6iZd4uzORp9ArHdhLZ+ZlOXyIt0u7HnzakwzcsseVBfFk/
         eCdG0QwqGnRHAdW0+u/QBrKHugG2XYnUFOQS2bQ3TIPO6HGRfFSzpfliWzv2ItjsKuff
         Zqvk1y8/Le+vTTcaeKcSnC9PS2APdCs5XtaujUsB+mjqx8lG26utjJrSL7gajsrIaaye
         wJaQ==
X-Gm-Message-State: APjAAAUTu3Ip+HKA0FFBAtkoC6No5pKPYDa1u13yH7mjyFjRIKX+pxSH
        yXfTqdVZ2PSLUmMTVe0E9Q==
X-Google-Smtp-Source: APXvYqztbmerjte0PZPdfwvWOIfvnFfr1Lgq24F0mQ2x9aUA7P5VI0zZPPNVfdk6YUoMtOXikoulOw==
X-Received: by 2002:adf:8150:: with SMTP id 74mr27860550wrm.114.1575825561893;
        Sun, 08 Dec 2019 09:19:21 -0800 (PST)
Received: from avx2 ([46.53.249.42])
        by smtp.gmail.com with ESMTPSA id h2sm24387086wrv.66.2019.12.08.09.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 09:19:21 -0800 (PST)
Date:   Sun, 8 Dec 2019 20:19:18 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     dan.carpenter@oracle.com, will@kernel.org, ebiederm@xmission.com,
        linux-arch@vger.kernel.org, security@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] execve: warn if process starts with executable stack
Message-ID: <20191208171918.GC19716@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were few episodes of silent downgrade to an executable stack over
years:

1) linking innocent looking assembly file will silently add executable
   stack if proper linker options is not given as well:

	$ cat f.S
	.intel_syntax noprefix
	.text
	.globl f
	f:
	        ret

	$ cat main.c
	void f(void);
	int main(void)
	{
	        f();
	        return 0;
	}

	$ gcc main.c f.S
	$ readelf -l ./a.out
	  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                         0x0000000000000000 0x0000000000000000  RWE    0x10
			 					 ^^^

2) converting C99 nested function into a closure
https://nullprogram.com/blog/2019/11/15/

	void intsort2(int *base, size_t nmemb, _Bool invert)
	{
	    int cmp(const void *a, const void *b)
	    {
	        int r = *(int *)a - *(int *)b;
	        return invert ? -r : r;
	    }
	    qsort(base, nmemb, sizeof(*base), cmp);
	}

will silently require stack trampolines while non-closure version will not.

Without doubt this behaviour is documented somewhere, add a warning so that
developers and users can at least notice. After so many years of x86_64 having
proper executable stack support it should not cause too many problems.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	v2: print pathname instead of comm/pid

 fs/exec.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -761,6 +761,11 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		goto out_unlock;
 	BUG_ON(prev != vma);
 
+	if (unlikely(vm_flags & VM_EXEC)) {
+		pr_warn_once("process '%pD4' started with executable stack\n",
+			     bprm->file);
+	}
+
 	/* Move stack pages down in memory. */
 	if (stack_shift) {
 		ret = shift_arg_pages(vma, stack_shift);
