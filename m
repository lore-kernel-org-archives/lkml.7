Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1190C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874912070B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZxIzcaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfJFStY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 14:49:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52030 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfJFStY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 14:49:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so10322384wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Ryt44dYF+Okzl6PcwuHu8tX6xIio9b6pLvqbXSxoGw=;
        b=RZxIzcaNW/zmOf7xrOPscWt36vmU0tmuUzaG8uZe54nJZelFA3sje3BS0lkvKRZJgk
         qiIJ/XD2rRizNK1ed54/U4dsliO+kJkisjVClY7kMkRTwSEhUznnyxSR4LAxxinZkeSW
         laRmA8vHJWO1I9lcqt3kiZ0L2ldf+HIkAmElfR7OYaKWQmG4M/MsUGv9MeBstFI67Jw3
         7NDdM1AB4hR3dea10XAuBHmwgXbi3K/nufOSeqC9hiWT+8hv6G6hakBJ0Zlyt72HKNfD
         tGd0EDyYfYIsenmLmfGgi6GeATMtcHLL/2iYw7d8FJmt6NuOPwILzrrVWVxSKTV553kq
         cCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Ryt44dYF+Okzl6PcwuHu8tX6xIio9b6pLvqbXSxoGw=;
        b=OsIDrChkvvlzzV7R//NfMr8FHbn1jr8RN0an+5K/PPGG6jP1ZKZ28FF6Pep8P4KDhG
         hO4yc+/U8YDA/H9c1diukOd4Bo/uJJ7T0QFoNhKSI+BB/Y9W5FxmBy/f0nsQpKW7wGut
         CwEKW8naECPUbmeePHAkit/vCUxzTmAbebGn9U3R6URIP+3MigvZkQPspeyaH6enhkcy
         BmJ4LlHDImz5g1bm5ai7B4UrvGle1fNA+hmc3HNqgU8jnf7KNoVn55U878atBdmkNFwx
         CeaWplAbbjkb/Ehfyz4vPCdm3EQbB3HlyoVgxtiMGbJxWcOKLHF1ofiOMNYG3IL31kJM
         H4Jg==
X-Gm-Message-State: APjAAAUQ2SEYMUGGD75V5s/LaM/Rc0mczAjO+fhCw+zn2WBueoxf/z3B
        EBfL1pkJWWG/0ei4oVHspQ==
X-Google-Smtp-Source: APXvYqxYdZKg8geUJI5mk06Ovu8Qo9F8erhF6F7Lj32CPcZUNsOKwAOa3sgPGICZyCDhMMgZfoOdkg==
X-Received: by 2002:a1c:2053:: with SMTP id g80mr15504217wmg.18.1570387761995;
        Sun, 06 Oct 2019 11:49:21 -0700 (PDT)
Received: from ninjahub.lan (host-92-15-175-166.as43234.net. [92.15.175.166])
        by smtp.googlemail.com with ESMTPSA id y186sm29037459wmb.41.2019.10.06.11.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 11:49:21 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, olsonse@umich.edu,
        hsweeten@visionengravers.com, abbotti@mev.co.uk,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] staging: comedi: Capitalize macro name to fix camelcase checkpatch warning
Date:   Sun,  6 Oct 2019 19:49:03 +0100
Message-Id: <20191006184903.12089-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Capitalize RANGE_mA to fix camelcase check warning.
Issue reported by checkpatch.pl

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/comedi/comedidev.h           | 2 +-
 drivers/staging/comedi/drivers/adv_pci1724.c | 4 ++--
 drivers/staging/comedi/drivers/dac02.c       | 2 +-
 drivers/staging/comedi/range.c               | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/comedi/comedidev.h b/drivers/staging/comedi/comedidev.h
index 54c091866777..2fc536db203c 100644
--- a/drivers/staging/comedi/comedidev.h
+++ b/drivers/staging/comedi/comedidev.h
@@ -603,7 +603,7 @@ int comedi_check_chanlist(struct comedi_subdevice *s,
 
 #define RANGE(a, b)		{(a) * 1e6, (b) * 1e6, 0}
 #define RANGE_ext(a, b)		{(a) * 1e6, (b) * 1e6, RF_EXTERNAL}
-#define RANGE_mA(a, b)		{(a) * 1e6, (b) * 1e6, UNIT_MA}
+#define RANGE_MA(a, b)		{(a) * 1e6, (b) * 1e6, UNIT_MA}
 #define RANGE_unitless(a, b)	{(a) * 1e6, (b) * 1e6, 0}
 #define BIP_RANGE(a)		{-(a) * 1e6, (a) * 1e6, 0}
 #define UNI_RANGE(a)		{0, (a) * 1e6, 0}
diff --git a/drivers/staging/comedi/drivers/adv_pci1724.c b/drivers/staging/comedi/drivers/adv_pci1724.c
index e8ab573c839f..f20d710c19d3 100644
--- a/drivers/staging/comedi/drivers/adv_pci1724.c
+++ b/drivers/staging/comedi/drivers/adv_pci1724.c
@@ -64,8 +64,8 @@
 static const struct comedi_lrange adv_pci1724_ao_ranges = {
 	4, {
 		BIP_RANGE(10),
-		RANGE_mA(0, 20),
-		RANGE_mA(4, 20),
+		RANGE_MA(0, 20),
+		RANGE_MA(4, 20),
 		RANGE_unitless(0, 1)
 	}
 };
diff --git a/drivers/staging/comedi/drivers/dac02.c b/drivers/staging/comedi/drivers/dac02.c
index 5ef8114c2c85..4503cbdf673c 100644
--- a/drivers/staging/comedi/drivers/dac02.c
+++ b/drivers/staging/comedi/drivers/dac02.c
@@ -54,7 +54,7 @@ static const struct comedi_lrange das02_ao_ranges = {
 		UNI_RANGE(10),
 		BIP_RANGE(5),
 		BIP_RANGE(10),
-		RANGE_mA(4, 20),
+		RANGE_MA(4, 20),
 		RANGE_ext(0, 1)
 	}
 };
diff --git a/drivers/staging/comedi/range.c b/drivers/staging/comedi/range.c
index 89d599877445..dacdd7b6f1a0 100644
--- a/drivers/staging/comedi/range.c
+++ b/drivers/staging/comedi/range.c
@@ -23,11 +23,11 @@ const struct comedi_lrange range_unipolar5 = { 1, {UNI_RANGE(5)} };
 EXPORT_SYMBOL_GPL(range_unipolar5);
 const struct comedi_lrange range_unipolar2_5 = { 1, {UNI_RANGE(2.5)} };
 EXPORT_SYMBOL_GPL(range_unipolar2_5);
-const struct comedi_lrange range_0_20mA = { 1, {RANGE_mA(0, 20)} };
+const struct comedi_lrange range_0_20mA = { 1, {RANGE_MA(0, 20)} };
 EXPORT_SYMBOL_GPL(range_0_20mA);
-const struct comedi_lrange range_4_20mA = { 1, {RANGE_mA(4, 20)} };
+const struct comedi_lrange range_4_20mA = { 1, {RANGE_MA(4, 20)} };
 EXPORT_SYMBOL_GPL(range_4_20mA);
-const struct comedi_lrange range_0_32mA = { 1, {RANGE_mA(0, 32)} };
+const struct comedi_lrange range_0_32mA = { 1, {RANGE_MA(0, 32)} };
 EXPORT_SYMBOL_GPL(range_0_32mA);
 const struct comedi_lrange range_unknown = { 1, {{0, 1000000, UNIT_none} } };
 EXPORT_SYMBOL_GPL(range_unknown);
-- 
2.21.0

