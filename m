Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674CBC74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3551C208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfGKL5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 07:57:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41908 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbfGKL5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 07:57:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id q4so2832728pgj.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 04:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/89CZRgzvFAkSINRRIbp3KoG062u70Hc6qn2oNL8CRk=;
        b=EO/q3p5K0e7VpogtJf0zPvpfyP3jLPIa/0bJg7MxF6w3P5esZV+d2/r41sLywZH8Sr
         z3jYcADOVjmKI9KobcKizH65sAu8vDvpijr/QG1H7cSPjr1VXG904m1MdZpacjhOrL7o
         YhgMoS/rGzZOmFjX2vxMPYrr+gQ8u2YlB2TlnDf4x0t5WLon0eVmjbk/4H9rnle65+C7
         6dtVv0vtmUovlCjvzEdfEhy4xqP8VdzIFea2bNE+MomWzzH6xTEhYdsEcMqEgy2x8BH8
         WuvKX1YtTh5fiEalvd7QglBIezPSdBNK/qfFSsuEsdbPOwsvjvRdtXnGLcGif4Nqca9D
         ulNw==
X-Gm-Message-State: APjAAAVuU4L0pAoTn4GXM55xFAz3uwcqwi93k4w9NIGZoebwdHcAS4y0
        qKoHTaXbBcyFYMoEhYxHwU86mQ==
X-Google-Smtp-Source: APXvYqw9WNwaKzYxtFvEIWl+TLX+n//1jtdZj2qCBnT2IWM3UQYkYN053Qrs3muiXLZFtptMQuf0ug==
X-Received: by 2002:a17:90a:20c6:: with SMTP id f64mr4441415pjg.57.1562846260621;
        Thu, 11 Jul 2019 04:57:40 -0700 (PDT)
Received: from localhost ([182.69.207.54])
        by smtp.gmail.com with ESMTPSA id u2sm5155277pgo.92.2019.07.11.04.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 04:57:39 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        Bhupesh Sharma <bhsharma@redhat.com>,
        takahiro.akashi@linaro.org, james.morse@arm.com,
        will.deacon@arm.com
Subject: [PATCH] arm64/kexec: Use consistent convention of initializing 'kxec_buf.mem' with KEXEC_BUF_MEM_UNKNOWN
Date:   Thu, 11 Jul 2019 17:27:32 +0530
Message-Id: <1562846252-7441-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()"),
we introduced the KEXEC_BUF_MEM_UNKNOWN macro. If kexec_buf.mem is set
to this value, kexec_locate_mem_hole() will try to allocate free memory.

While other arch(s) like s390 and x86_64 already use this macro to
initialize kexec_buf.mem with, arm64 uses an equivalent value of 0.
Replace it with KEXEC_BUF_MEM_UNKNOWN, to keep the convention of
initializing 'kxec_buf.mem' consistent across various archs.

Cc: takahiro.akashi@linaro.org
Cc: james.morse@arm.com
Cc: will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64/kernel/kexec_image.c        | 2 +-
 arch/arm64/kernel/machine_kexec_file.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 2514fd6f12cb..29a9428486a5 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -84,7 +84,7 @@ static void *image_load(struct kimage *image,
 
 	kbuf.buffer = kernel;
 	kbuf.bufsz = kernel_len;
-	kbuf.mem = 0;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	kbuf.memsz = le64_to_cpu(h->image_size);
 	text_offset = le64_to_cpu(h->text_offset);
 	kbuf.buf_align = MIN_KIMG_ALIGN;
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 58871333737a..ba78ee7ca990 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -177,7 +177,7 @@ int load_other_segments(struct kimage *image,
 	if (initrd) {
 		kbuf.buffer = initrd;
 		kbuf.bufsz = initrd_len;
-		kbuf.mem = 0;
+		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 		kbuf.memsz = initrd_len;
 		kbuf.buf_align = 0;
 		/* within 1GB-aligned window of up to 32GB in size */
@@ -204,7 +204,7 @@ int load_other_segments(struct kimage *image,
 	dtb_len = fdt_totalsize(dtb);
 	kbuf.buffer = dtb;
 	kbuf.bufsz = dtb_len;
-	kbuf.mem = 0;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	kbuf.memsz = dtb_len;
 	/* not across 2MB boundary */
 	kbuf.buf_align = SZ_2M;
-- 
2.7.4

