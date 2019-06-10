Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34E8C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BF22086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kc5jwzAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfFJWBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 18:01:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43827 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbfFJWBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:01:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so5726794pgv.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LW8NlLySeRobf2Ci7HrTXkKdA8X2Rlykte27NhFtAPM=;
        b=Kc5jwzAtTkGRKlstomNioaLlQ8J9mk8zkp5jLofb9ds2NEOxowbB/Yj9N9oCRokEGi
         kjyG9XuTfOcfr3i9YzvY3g4TV22KQjxGIT4JxrRc3lGLcmlciBmsEqG5Bwaqhc3zyGpU
         uAN/pDTYnp07GWZaAk1DT3YROR6eL/qD1kD8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LW8NlLySeRobf2Ci7HrTXkKdA8X2Rlykte27NhFtAPM=;
        b=IXd8MzLwqsWaT1hUBLY9PiFje7nCWeiNK/sfM4dpWcyS6PnWNPQDkOXSRyzo6xIO/X
         fibrDwjykiXEwczgM/W+iGjr+QN6uNWpllW96p08GRWyxJ3I24eTINEYDhLiQ0dCT57v
         yI6yJmlGkyxob2c0rvt1hkarR9L/epw3nyhPKCww1stqkdyCGFnLCppsRLYkJyHy6plJ
         gE5BZIONanLHhVBYmPW8i3vyEJBC27U5ZfE3HtMBH+fRGNJ4A+mD7e+VsCwL7ep1+FL2
         3/StppCOpkG90al8E4HGrf0Tmd0BtRMxUenuhwjYBK4v5dHJ7ajG1KMMwBa2828gjlSs
         tDtw==
X-Gm-Message-State: APjAAAXPZa5LzRVcvD85tmF29rQK8RCr0LpDQVT0+pc1E2kvG3hGPhAb
        9rH1JnjFARFfqfCRKJzUwsD8XKdXGcM=
X-Google-Smtp-Source: APXvYqxUuLi8u3xAFJfZU+6XKRwyLqRF6/SeEB3k4EL3uemfhDVPFi1PaYsXAtwRciV4o1p3pnpfxA==
X-Received: by 2002:a62:d0:: with SMTP id 199mr45569170pfa.253.1560204106256;
        Mon, 10 Jun 2019 15:01:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id s5sm403489pji.9.2019.06.10.15.01.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 15:01:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     groeck@chromium.org, Vadim Sukhomlinov <sukhomlinov@google.com>,
        apronin@chromium.org, mka@chromium.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM operations
Date:   Mon, 10 Jun 2019 15:01:18 -0700
Message-Id: <20190610220118.5530-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Sukhomlinov <sukhomlinov@google.com>

TPM 2.0 Shutdown involve sending TPM2_Shutdown to TPM chip and disabling
future TPM operations. TPM 1.2 behavior was different, future TPM
operations weren't disabled, causing rare issues. This patch ensures
that future TPM operations are disabled.

Signed-off-by: Vadim Sukhomlinov <sukhomlinov@google.com>
[dianders: resolved merge conflicts with mainline]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/char/tpm/tpm-chip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 8804c9e916fd..f566fa8bf704 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -294,15 +294,15 @@ static int tpm_class_shutdown(struct device *dev)
 {
 	struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
 
+	down_write(&chip->ops_sem);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		down_write(&chip->ops_sem);
 		if (!tpm_chip_start(chip)) {
 			tpm2_shutdown(chip, TPM2_SU_CLEAR);
 			tpm_chip_stop(chip);
 		}
-		chip->ops = NULL;
-		up_write(&chip->ops_sem);
 	}
+	chip->ops = NULL;
+	up_write(&chip->ops_sem);
 
 	return 0;
 }
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

