Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1978C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D81123CCB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186544;
	bh=0CbJ8rpWm3HT9n56a02/4rzdQVexT5uxY+2zHGbKtZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ST4kSzA30n8oAIW9NxWq6TKztFfHiQWCWitIEUwIFAjAaYMhgs6LSOzTugbk0P/8h
	 3GpLZ5+umDKw/8w3Zh6epEgh92Clwfqu6NlFhZeZwnx21I+pxKWTLZfnb4KyYUEP39
	 F5qFwaGHxbc24uTGskU5o4X3SmvlUDyidh9jaSZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732834AbfE3DWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729583AbfE3DQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:43 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C697E245DA;
        Thu, 30 May 2019 03:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186202;
        bh=0CbJ8rpWm3HT9n56a02/4rzdQVexT5uxY+2zHGbKtZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ntcn1jHYC9VVXoIa2ptZCZdIdy30OQDxpPOnnLAN2/B7RfVxFwzcq4osEZZft1DAm
         hOabBOYOxazxRPbbz8yF9O4Wx+2ARDAT0bNt2I+sjB/YeJDdpDVstbB+9tKA6bFJFA
         OoBLw6ijXxQVggg80PnxGfaZEOPQWKwVc7b7Udpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Rudo <prudo@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 087/276] s390/kexec_file: Fix detection of text segment in ELF loader
Date:   Wed, 29 May 2019 20:04:05 -0700
Message-Id: <20190530030531.697773045@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 729829d775c9a5217abc784b2f16087d79c4eec8 ]

To register data for the next kernel (command line, oldmem_base, etc.) the
current kernel needs to find the ELF segment that contains head.S. This is
currently done by checking ifor 'phdr->p_paddr == 0'. This works fine for
the current kernel build but in theory the first few pages could be
skipped. Make the detection more robust by checking if the entry point lies
within the segment.

Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/kexec_elf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/kexec_elf.c b/arch/s390/kernel/kexec_elf.c
index 5a286b012043b..602e7cc26d118 100644
--- a/arch/s390/kernel/kexec_elf.c
+++ b/arch/s390/kernel/kexec_elf.c
@@ -19,10 +19,15 @@ static int kexec_file_add_elf_kernel(struct kimage *image,
 	struct kexec_buf buf;
 	const Elf_Ehdr *ehdr;
 	const Elf_Phdr *phdr;
+	Elf_Addr entry;
 	int i, ret;
 
 	ehdr = (Elf_Ehdr *)kernel;
 	buf.image = image;
+	if (image->type == KEXEC_TYPE_CRASH)
+		entry = STARTUP_KDUMP_OFFSET;
+	else
+		entry = ehdr->e_entry;
 
 	phdr = (void *)ehdr + ehdr->e_phoff;
 	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
@@ -35,7 +40,7 @@ static int kexec_file_add_elf_kernel(struct kimage *image,
 		buf.mem = ALIGN(phdr->p_paddr, phdr->p_align);
 		buf.memsz = phdr->p_memsz;
 
-		if (phdr->p_paddr == 0) {
+		if (entry - phdr->p_paddr < phdr->p_memsz) {
 			data->kernel_buf = buf.buffer;
 			data->memsz += STARTUP_NORMAL_OFFSET;
 
-- 
2.20.1



