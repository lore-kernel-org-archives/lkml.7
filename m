Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E293FC2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 15:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9EB20665
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 15:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbYCYNu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfLVPBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 10:01:43 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:34272 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLVPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 10:01:43 -0500
Received: by mail-wr1-f53.google.com with SMTP id t2so14025757wrr.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 07:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gl7chWP2aE6GWYGbzGtWKK4CAYr1zMg2FVacNjK9hDE=;
        b=KbYCYNu8LaU3vq+Hp1ZoqUJrehF2FhnA0crKKfASQew6hnz6ctoDvSbsNURObrJdEQ
         8ioU/sb2EFx5UUyZfEIdWB0r2DLWBWJGHhMtewPUfcqiL5x5lZYL8kpYbypuLfYA9zvK
         cobymV2ni5ly8dq9gl5pQbGR2cmZcQIvGi7YidoVjj3WvNVDOYHts7aqEPCHp7VG7oFR
         lnonaLcdNs8x8fqTV+NJLQUx/t95bYr9/QR+YQRS42QPnw71uNcWKswF3t7eC1FPH2kz
         c3DRS72AV+/f6uo7uaAajGFHLvtDZu9RLEVnIq9dj3XxpAZxRukSR6PfvH9yP9S9nUb7
         mYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gl7chWP2aE6GWYGbzGtWKK4CAYr1zMg2FVacNjK9hDE=;
        b=XNWFKA0xCxHqGbH0PyQquo7MpB15SOfRiWtjQH1sFTpvSmchKgwyRZNzBnEE3VurVC
         b2ChkkhqZMAe3pbhoue7vXkVnl8pV2xsdfuLRh1qELDMgaSZstlxUSoMaNe8LeOyfhqA
         Y8lfLINiYJrEFNudvKhDIQQaONReIC072DQRhVPIegKsmDsxDVhr5fWNiCqOPRXgbUjo
         agYrLDxMAwR9YBJJDO7hVwjioltzCab+ux37tzinUBw4TjWwnTv9vuNffQBIrnnxCFXd
         6sYeugx5EunBf9n3yj9WAY925WjFPMfvV8ta8DE7CrQJ9xJ8dJMU7ujOwc1j0VFv6eCL
         MElg==
X-Gm-Message-State: APjAAAVPDXTOFTtzQTxoV7VIjQHHzhW9pKjDZ8ZWVSBfP2p4Wfe+3PTo
        zb06oV+yVpT/to42MaDyOniOIbs=
X-Google-Smtp-Source: APXvYqy/zP2TFUUv3ctlhkPasGWCn6xqtfB4DD4zqu+PT293pahKku7ufJRa4ge8tGpzdxf+Y3iynA==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr25876707wrr.226.1577026900876;
        Sun, 22 Dec 2019 07:01:40 -0800 (PST)
Received: from avx2 ([46.53.254.212])
        by smtp.gmail.com with ESMTPSA id b137sm9218941wme.26.2019.12.22.07.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 07:01:40 -0800 (PST)
Date:   Sun, 22 Dec 2019 18:01:37 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH -mm 3/3 v2] ELF, coredump: allow process with empty address
 space to coredump
Message-ID: <20191222150137.GA1277@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unmapping whole address space at once with

	munmap(0, (1ULL<<47) - 4096)

or equivalent will create empty coredump.

It is silly way to exit, however registers content may still be useful.

The right to coredump is fundamental right of a process!

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c                                  |   10 +++++-
 tools/testing/selftests/exec/Makefile            |    1 
 tools/testing/selftests/exec/coredump-zero-vma.c |   38 +++++++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1595,6 +1595,10 @@ static int fill_files_note(struct memelfnote *note)
 	if (size >= MAX_FILE_NOTE_SIZE) /* paranoia check */
 		return -EINVAL;
 	size = round_up(size, PAGE_SIZE);
+	/*
+	 * "size" can be 0 here legitimately.
+	 * Let it ENOMEM and omit NT_FILE section which will be empty anyway.
+	 */
 	data = kvmalloc(size, GFP_KERNEL);
 	if (ZERO_OR_NULL_PTR(data))
 		return -ENOMEM;
@@ -2257,9 +2261,13 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
 
+	/*
+	 * Zero vma process will get ZERO_SIZE_PTR here.
+	 * Let coredump continue for register state at least.
+	 */
 	vma_filesz = kvmalloc(array_size(sizeof(*vma_filesz), (segs - 1)),
 			      GFP_KERNEL);
-	if (ZERO_OR_NULL_PTR(vma_filesz))
+	if (!vma_filesz)
 		goto end_coredump;
 
 	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
