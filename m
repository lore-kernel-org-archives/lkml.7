Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DDAC5ACC3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3BA207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KIGdsn3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403781AbfFJOSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:18:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45303 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390731AbfFJOSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:18:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so9355744wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 07:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s4szSUhcpAQe3MUVSSzcKPCedAzZYQ7v5/OeaQpJ8N0=;
        b=KIGdsn3oVOuNw1zsjs29vr+zW4Lw36Zv2j0oud8g4U+6yuc30bcucXFpYWHnJGqMkh
         Ge1T6Om3fnQ/9pB1w4wDJDxuxH3sTzCBulDQ4DtuklOJhG4di12UQ5LaWElAnUCJ+bE3
         cVKRWAQf03a42GDmKl/dZgp+gE5umAZ3K4oWDIgHD0HFWpKRimCfkBrHuVUBoj8kqTDZ
         95DfZMaso54MhOGoSugfFenvGbQABILUKcWLmQyjakt8s6X3XViF++QUzgSEpNKWvB/p
         ySZ3LkMfVYuQz9saHbV0M/uwVhHF6xjyqt3xPISdDt4zDISt+zh/RwwDZypCjv38nQK0
         TItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s4szSUhcpAQe3MUVSSzcKPCedAzZYQ7v5/OeaQpJ8N0=;
        b=B4BDcVyS+QZwPLPRNL2ix8h6UlKwtz/Ch7i4B8HyCAZ5YDgbdRzj0R8r3EzbcNoH4b
         T+dqRRQXRNQWoBZo1LGTBp53K5L74XQQFBwcQXdAlFOPD8E3KP5jfeUZ1Qloi+4WagZS
         2kId2UqCGo6sYx3/kfZbgGo4X8hHr+m0hgIuouZAQe3+ONygse6oaML0PnSSC+KGglNj
         5GJfjBVDF5OljxD35hayVX+s1vsrc1GOs+nELFTujRylMT2sCnxACjq6vhH9kLrZG8zi
         uhjtcmOTJV7Q2yT87lTmsRzdRhmRKLxXth+R/d4S2JB/3sQEYmZ+XhfAACVea2Uy0wtt
         +dhA==
X-Gm-Message-State: APjAAAW5ZdbwHiykmB/TD60IAU4mHa+SLfl2e/A/YwcgscDsVeEQa8Vd
        I/wYsfgBjWzQdSRxqSxXK0SgTxQ7SCQ=
X-Google-Smtp-Source: APXvYqyO3Z+0c7/VZTaaMwr1b3kWxQmFnYgZPQZxOUUtEKtVWpUipIUFTzk+QyldcgrMHUlxXhNdIA==
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr29952440wrj.103.1560176292399;
        Mon, 10 Jun 2019 07:18:12 -0700 (PDT)
Received: from localhost.localdomain (catv-89-135-96-219.catv.broadband.hu. [89.135.96.219])
        by smtp.gmail.com with ESMTPSA id v3sm7536032wmh.31.2019.06.10.07.18.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 07:18:11 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Federico Vaga <federico.vaga@cern.ch>,
        Pat Riehecky <riehecky@fnal.gov>,
        Alessandro Rubini <rubini@gnudd.com>
Subject: [PATCH] fmc: Delete the FMC subsystem
Date:   Mon, 10 Jun 2019 16:18:09 +0200
Message-Id: <20190610141809.17542-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FMC subsystem was created in 2012 with the ambition to
drive development of drivers for this hardware upstream.

The current implementation has architectural flaws and would
need to be revamped using real hardware to something that can
reuse existing kernel abstractions in the subsystems for e.g.
I2C, FPGA and GPIO.

We have concluded that for the mainline kernel it will be
better to delete the subsystem and start over with a clean
slate when/if an active maintainer steps up.

For details see:
https://lkml.org/lkml/2018/10/29/534

Suggested-by: Federico Vaga <federico.vaga@cern.ch>
Cc: Federico Vaga <federico.vaga@cern.ch>
Cc: Pat Riehecky <riehecky@fnal.gov>
Cc: Alessandro Rubini <rubini@gnudd.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
If people are happy with this, I will queue the removal
in the GPIO kernel tree.
---
 Documentation/fmc/API.txt              |  47 ---
 Documentation/fmc/FMC-and-SDB.txt      |  88 ------
 Documentation/fmc/carrier.txt          | 311 --------------------
 Documentation/fmc/fmc-chardev.txt      |  64 ----
 Documentation/fmc/fmc-fakedev.txt      |  36 ---
 Documentation/fmc/fmc-trivial.txt      |  17 --
 Documentation/fmc/fmc-write-eeprom.txt |  98 -------
 Documentation/fmc/identifiers.txt      | 168 -----------
 Documentation/fmc/mezzanine.txt        | 123 --------
 Documentation/fmc/parameters.txt       |  56 ----
 drivers/fmc/Kconfig                    |  51 ----
 drivers/fmc/Makefile                   |  15 -
 drivers/fmc/fmc-chardev.c              | 200 -------------
 drivers/fmc/fmc-core.c                 | 389 -------------------------
 drivers/fmc/fmc-debug.c                | 173 -----------
 drivers/fmc/fmc-dump.c                 |  59 ----
 drivers/fmc/fmc-fakedev.c              | 355 ----------------------
 drivers/fmc/fmc-match.c                | 114 --------
 drivers/fmc/fmc-private.h              |   9 -
 drivers/fmc/fmc-sdb.c                  | 220 --------------
 drivers/fmc/fmc-trivial.c              | 102 -------
 drivers/fmc/fmc-write-eeprom.c         | 176 -----------
 drivers/fmc/fru-parse.c                |  81 -----
 include/linux/fmc-sdb.h                |  39 ---
 include/linux/fmc.h                    | 272 -----------------
 25 files changed, 3263 deletions(-)
 delete mode 100644 Documentation/fmc/API.txt
 delete mode 100644 Documentation/fmc/FMC-and-SDB.txt
 delete mode 100644 Documentation/fmc/carrier.txt
 delete mode 100644 Documentation/fmc/fmc-chardev.txt
 delete mode 100644 Documentation/fmc/fmc-fakedev.txt
 delete mode 100644 Documentation/fmc/fmc-trivial.txt
 delete mode 100644 Documentation/fmc/fmc-write-eeprom.txt
 delete mode 100644 Documentation/fmc/identifiers.txt
 delete mode 100644 Documentation/fmc/mezzanine.txt
 delete mode 100644 Documentation/fmc/parameters.txt
 delete mode 100644 drivers/fmc/Kconfig
 delete mode 100644 drivers/fmc/Makefile
 delete mode 100644 drivers/fmc/fmc-chardev.c
 delete mode 100644 drivers/fmc/fmc-core.c
 delete mode 100644 drivers/fmc/fmc-debug.c
 delete mode 100644 drivers/fmc/fmc-dump.c
 delete mode 100644 drivers/fmc/fmc-fakedev.c
 delete mode 100644 drivers/fmc/fmc-match.c
 delete mode 100644 drivers/fmc/fmc-private.h
 delete mode 100644 drivers/fmc/fmc-sdb.c
 delete mode 100644 drivers/fmc/fmc-trivial.c
 delete mode 100644 drivers/fmc/fmc-write-eeprom.c
 delete mode 100644 drivers/fmc/fru-parse.c
 delete mode 100644 include/linux/fmc-sdb.h
 delete mode 100644 include/linux/fmc.h

diff --git a/Documentation/fmc/API.txt b/Documentation/fmc/API.txt
deleted file mode 100644
index 06b06b92c794..000000000000
diff --git a/Documentation/fmc/FMC-and-SDB.txt b/Documentation/fmc/FMC-and-SDB.txt
deleted file mode 100644
index fa14e0b24521..000000000000
diff --git a/Documentation/fmc/carrier.txt b/Documentation/fmc/carrier.txt
deleted file mode 100644
index 5e4f1dd3e98b..000000000000
diff --git a/Documentation/fmc/fmc-chardev.txt b/Documentation/fmc/fmc-chardev.txt
deleted file mode 100644
index d9ccb278e597..000000000000
diff --git a/Documentation/fmc/fmc-fakedev.txt b/Documentation/fmc/fmc-fakedev.txt
deleted file mode 100644
index e85b74a4ae30..000000000000
diff --git a/Documentation/fmc/fmc-trivial.txt b/Documentation/fmc/fmc-trivial.txt
deleted file mode 100644
index d1910bc67159..000000000000
diff --git a/Documentation/fmc/fmc-write-eeprom.txt b/Documentation/fmc/fmc-write-eeprom.txt
deleted file mode 100644
index e0a9712156aa..000000000000
diff --git a/Documentation/fmc/identifiers.txt b/Documentation/fmc/identifiers.txt
deleted file mode 100644
index 3bb577ff0d52..000000000000
diff --git a/Documentation/fmc/mezzanine.txt b/Documentation/fmc/mezzanine.txt
deleted file mode 100644
index 87910dbfc91e..000000000000
diff --git a/Documentation/fmc/parameters.txt b/Documentation/fmc/parameters.txt
deleted file mode 100644
index 59edf088e3a4..000000000000
diff --git a/drivers/fmc/Kconfig b/drivers/fmc/Kconfig
deleted file mode 100644
index 3a75f4256d08..000000000000
diff --git a/drivers/fmc/Makefile b/drivers/fmc/Makefile
deleted file mode 100644
index e3da6192cf39..000000000000
diff --git a/drivers/fmc/fmc-chardev.c b/drivers/fmc/fmc-chardev.c
deleted file mode 100644
index 5ecf4090a610..000000000000
diff --git a/drivers/fmc/fmc-core.c b/drivers/fmc/fmc-core.c
deleted file mode 100644
index bbcb505d1522..000000000000
diff --git a/drivers/fmc/fmc-debug.c b/drivers/fmc/fmc-debug.c
deleted file mode 100644
index 32930722770c..000000000000
diff --git a/drivers/fmc/fmc-dump.c b/drivers/fmc/fmc-dump.c
deleted file mode 100644
index cd1df475b254..000000000000
diff --git a/drivers/fmc/fmc-fakedev.c b/drivers/fmc/fmc-fakedev.c
deleted file mode 100644
index 941d0930969a..000000000000
diff --git a/drivers/fmc/fmc-match.c b/drivers/fmc/fmc-match.c
deleted file mode 100644
index a0956d1f7550..000000000000
diff --git a/drivers/fmc/fmc-private.h b/drivers/fmc/fmc-private.h
deleted file mode 100644
index 1e5136643bdc..000000000000
diff --git a/drivers/fmc/fmc-sdb.c b/drivers/fmc/fmc-sdb.c
deleted file mode 100644
index d0e65b86dc22..000000000000
diff --git a/drivers/fmc/fmc-trivial.c b/drivers/fmc/fmc-trivial.c
deleted file mode 100644
index b99dbc7ee203..000000000000
diff --git a/drivers/fmc/fmc-write-eeprom.c b/drivers/fmc/fmc-write-eeprom.c
deleted file mode 100644
index 3eb81bb1f1fc..000000000000
diff --git a/drivers/fmc/fru-parse.c b/drivers/fmc/fru-parse.c
deleted file mode 100644
index eb21480d399f..000000000000
diff --git a/include/linux/fmc-sdb.h b/include/linux/fmc-sdb.h
deleted file mode 100644
index bec899f0867c..000000000000
diff --git a/include/linux/fmc.h b/include/linux/fmc.h
deleted file mode 100644
index f0d482d29df7..000000000000
-- 
2.20.1

