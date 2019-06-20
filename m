Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E426FC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60FD2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7LwkGDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfFTPzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:55:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45834 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFTPzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:55:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id a14so5361084edv.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 08:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QjDX78oa2BASe824yEdzyyp19vd/Tsv5hqMbtNpObe4=;
        b=f7LwkGDE3agnu24mUX5JVPd6RwdOwcxLMc6CrExAaC56PNgJumDvFtKLuZCqkggLhU
         t8E89s0UTz8grNKBlWz2HfeSe8d8w4aTcEBQto0AB23DrdPJ7rz0BAP07hj/dlB+8iyQ
         hrQ51Oa895B0yypME4heZ7eRVDYSNCq9gY9sLNqsu4kW14z1h838WhPzq/r3fFE//ulF
         VKj6fzb252U/GEsVnFEzyba/2O7FrXxggXRcOnJvofuDqt1U1xf6DuMd/hukWjbJBiy1
         0JfH7/hSL14G5lubzX1OcG5oQEJ0SxpumifnSBrYazZswBVPV4odVkZy+Zb0VYBJuLgR
         rZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QjDX78oa2BASe824yEdzyyp19vd/Tsv5hqMbtNpObe4=;
        b=PCFmsyKAoY1kuBlzj7wmRi4woaCGE0NKAMsvt2ga8MRyN7EEfy6LyG0IvZ1+R/e/px
         9985vllR/Y9BLQOcM/FwSqyeXFy3NoxArR+Qw9/jSXQeUZRCYELyMENNPhqtBtA5jcFd
         B0F892X8vMKGo6V0SynMQ6ZCkOLKhW751c4j9VBXlRIw53ZX5eIY3CNk8/M7P3I2C0cn
         9wAPy594fQ5pO7gR0A7hTUzzz/5XCUJjdakkLca9t3byGKC1mG3aan9WJg648uU+zeK3
         WpciPuhruIFxKZxSxyCvBYv68gLt6M3YrrxHgtwRq/VvtNS8pSnEVjNbL9Y5YTpEQKYy
         rBrA==
X-Gm-Message-State: APjAAAVbShFqOkbY79ilPlmgjLVRi3TqbU+i74ZzaHZB9nIiOR/OWxaF
        +r1wz3tDyfow/UVZ9RXP+jk=
X-Google-Smtp-Source: APXvYqwKOulu/OmTBdIVTL5icCcMvO934j9hkpRe+73gTBgRLZXhe2K020ZrGLd3DjkvWhXw6oIsqw==
X-Received: by 2002:a50:86b7:: with SMTP id r52mr113818579eda.100.1561046130902;
        Thu, 20 Jun 2019 08:55:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id w6sm3874084ejf.0.2019.06.20.08.55.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:55:30 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] mtd: mtd-abi: Don't use C++ comments
Date:   Thu, 20 Jun 2019 08:55:05 -0700
Message-Id: <20190620155505.27036-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiled standalone after commit b91976b7c0e3 ("kbuild:
compile-test UAPI headers to ensure they are self-contained"),
a warning about the C++ comments appears:

  In file included from usr/include/mtd/mtd-user.hdrtest.c:1:
  In file included from ./usr/include/mtd/mtd-user.h:25:
  ./usr/include/mtd/mtd-abi.h:116:28: warning: // comments are not
  allowed in this language [-Wcomment]
  #define MTD_NANDECC_OFF         0       // Switch off ECC (Not recommended)
                                          ^
  1 warning generated.

Replace them with standard C comments so this warning no longer occurs.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 include/uapi/mtd/mtd-abi.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index aff5b5e59845..3fe9237f723a 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -113,11 +113,11 @@ struct mtd_write_req {
 #define MTD_CAP_NVRAM		(MTD_WRITEABLE | MTD_BIT_WRITEABLE | MTD_NO_ERASE)
 
 /* Obsolete ECC byte placement modes (used with obsolete MEMGETOOBSEL) */
-#define MTD_NANDECC_OFF		0	// Switch off ECC (Not recommended)
-#define MTD_NANDECC_PLACE	1	// Use the given placement in the structure (YAFFS1 legacy mode)
-#define MTD_NANDECC_AUTOPLACE	2	// Use the default placement scheme
-#define MTD_NANDECC_PLACEONLY	3	// Use the given placement in the structure (Do not store ecc result on read)
-#define MTD_NANDECC_AUTOPL_USR 	4	// Use the given autoplacement scheme rather than using the default
+#define MTD_NANDECC_OFF		0	/* Switch off ECC (Not recommended) */
+#define MTD_NANDECC_PLACE	1	/* Use the given placement in the structure (YAFFS1 legacy mode) */
+#define MTD_NANDECC_AUTOPLACE	2	/* Use the default placement scheme */
+#define MTD_NANDECC_PLACEONLY	3	/* Use the given placement in the structure (Do not store ecc result on read) */
+#define MTD_NANDECC_AUTOPL_USR	4	/* Use the given autoplacement scheme rather than using the default */
 
 /* OTP mode selection */
 #define MTD_OTP_OFF		0
-- 
2.22.0

