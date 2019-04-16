Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C132C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D118120684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVdrRQ9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfDPUUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:20:08 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:42611 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbfDPUUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:20:07 -0400
Received: by mail-wr1-f51.google.com with SMTP id g3so28824159wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 13:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9zOF6V/5vTHH9QSaHzxgVevsHG8BmHbk3Dwzm6xAQoc=;
        b=mVdrRQ9On6133eywoWtk/hsvIvPHQKBL2/Wtnclodb3KSbEBEP8PT6QIeXBzSHZrCn
         ZTqhcCDxCSgphma37dTvQ0n4el7H4Ik2NN5dNIXYpA6lXuXv5z5JUWZEVnKOxJGiWfmj
         MZfnEHIX5/D1pxnZBY7+uPX4fMX1Jq4zuMN+o4bDEahysHDea7Pa93K9eZORGG3pFeQ1
         W+vmGHmrNneeK8Ev6WclI4yeYZkue2pxzTMXLdhNyZDV3SAVqi92TNJDxc40ViA7OjIB
         WsuuAPeq4rDtcRa4yQf7KZWha/4YC5ja5pwEN08m+727fsQMljKCz3KTiJsa0TAdY+d/
         Wd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9zOF6V/5vTHH9QSaHzxgVevsHG8BmHbk3Dwzm6xAQoc=;
        b=FTlOV4iKfTVSXFcEdAAfnnFY0NjL5Oj6SjKHXc7IEHu3O53lZ0hrx0jqPrJLFDWxj6
         iMrzXe94QJdLdg9uofmM487VEIlW2kECNu03EByw1K5zh0vS/TS/gjvH0Yg5n5d2o6/R
         0RQY66toL+ADv+ydZfDmb4y/bbr3Cr+Pl7zYWl40Me6d8cziFUv19yKIEnvUlofS3ZiK
         4GAg+g1VfnSopAzs/FWFXBSny4xMNUkOgILMzffarBCt4R97d1nA1ClH6bwgxVlqdRmq
         n8UcRyTTRcbbW+zzwbG5jawlLuHwz49RNvSB6YUfga/RtQaUpqOQqWvJ1ggBPpDooJJi
         QmCw==
X-Gm-Message-State: APjAAAUNEfl1pMmTbiJUjHsOxGhGq6KHS3y1E1XPme9CK6fMnTGE7DFO
        igP/2DUbCaWvGzTsC1hHkA==
X-Google-Smtp-Source: APXvYqxcffseII7ruogCSXHjWUgpT2Gt5lftQduU3gu37GMurABA/R9zAhL6YcQ/jXTfRba1e1Mzow==
X-Received: by 2002:adf:e78e:: with SMTP id n14mr31267898wrm.14.1555446005859;
        Tue, 16 Apr 2019 13:20:05 -0700 (PDT)
Received: from avx2 ([46.53.243.209])
        by smtp.gmail.com with ESMTPSA id u17sm750121wmu.36.2019.04.16.13.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 13:20:05 -0700 (PDT)
Date:   Tue, 16 Apr 2019 23:20:02 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH -mm 2/2] elf: move variables initialization closer to their
 usage
Message-ID: <20190416202002.GB24304@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -732,14 +732,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out;
 
 	elf_ppnt = elf_phdata;
-	elf_bss = 0;
-	elf_brk = 0;
-
-	start_code = ~0UL;
-	end_code = 0;
-	start_data = 0;
-	end_data = 0;
-
 	for (i = 0; i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
 		char *elf_interpreter;
 		loff_t pos;
@@ -887,6 +879,14 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (retval < 0)
 		goto out_free_dentry;
 	
+	elf_bss = 0;
+	elf_brk = 0;
+
+	start_code = ~0UL;
+	end_code = 0;
+	start_data = 0;
+	end_data = 0;
+
 	/* Now we do a little grungy work by mmapping the ELF image into
 	   the correct location in memory. */
 	for(i = 0, elf_ppnt = elf_phdata;
