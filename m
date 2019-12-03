Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95231C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FB8206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="LoQBdx0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfLCKuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:50:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37912 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfLCKuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:50:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id k8so3238707ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 02:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kzBo0/F0ENPUIlctaSDvpl1PZWmzvjPaqnoF9qBbYD4=;
        b=LoQBdx0faVshNv3qf1ozgYIh6f4VI+h+4h9UACmSvYNMM80B+PQyAVUuAAP2OWcHgB
         v8R7MsUWmCKd8Qv4zVgryhTkM8xCux2HIDuOSes37Zu3RLptnqBNy+/UxD6KKk+b0MrX
         nkIA3yS7fUaDbFFJiofGbgsaTfMeuwP5Wx+y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kzBo0/F0ENPUIlctaSDvpl1PZWmzvjPaqnoF9qBbYD4=;
        b=H2adIgteMNIeAiDhyVYiXtYX3mC0+5TAdzdiv/tbdxfQi7ZeqIISCH60Pe21vbPo+K
         WyMsCnHeUkOD+RLtSw9tuRwNbCA8M/eqdh8e7rflFHn1q9uSU1nAVG27LPHvMFfZOP9B
         HD1DwG48vyJplHyBrnKRp9CN8/bEg//nIEg4RiMcI5tL+qNtAjseYhoL8Z+HSY8fDuzu
         RhafXCmGidxFAJQlvG355MYCwClknPWfpz90pdEQik6OSWm5dTKgHKHrDD6YYOuZ6S8E
         Fu6L8nY/n69wBjBhKuPhPQyBxyX6sWcHPtgP2Uyx6uqfqvyPNFL46tK6JWfT9B1NgsZZ
         Kh8Q==
X-Gm-Message-State: APjAAAUonE1XaOe1IPntWsOnt+Z1jPbfHqvMID2zNJpdz2WMb0rDws/2
        0lx5L7PwaDxFChz76HRFzxN6YgZ7N/DgzIV/
X-Google-Smtp-Source: APXvYqyaL83kNb2vcVJa6okO54S46qVXYEHwS0OHOoMWED69/vvLrnM0hc/+mbtGi0M38ZSMM3ZOsA==
X-Received: by 2002:a2e:7202:: with SMTP id n2mr1909710ljc.194.1575370201100;
        Tue, 03 Dec 2019 02:50:01 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f7sm1103243ljp.62.2019.12.03.02.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 02:49:59 -0800 (PST)
Subject: Re: fsl,p2020-esdhc sdhci quirks
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <8afd0f53-eba8-e000-d8cc-b464e65850c3@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <53c77b5b-627e-424c-234b-05f73b44863e@rasmusvillemoes.dk>
Date:   Tue, 3 Dec 2019 11:49:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8afd0f53-eba8-e000-d8cc-b464e65850c3@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2019 11.15, Rasmus Villemoes wrote:
> Hi
> 
> Commits
> 
> 05cb6b2a66fa - mmc: sdhci-of-esdhc: add erratum eSDHC-A001 and A-008358
> support
> a46e42712596 - mmc: sdhci-of-esdhc: add erratum eSDHC5 support
> 
> seem a bit odd, in that they set bits from the SDHCI_* namespace in the
> ->quirks2 member:
> 
>                 host->quirks2 |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
>                 host->quirks2 |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;

FWIW, with something like the patch below, sparse (make C=1) would complain

drivers/mmc/host/sdhci-of-esdhc.c:1306:31: warning: invalid assignment: |=
drivers/mmc/host/sdhci-of-esdhc.c:1306:31:    left side has type
restricted sdhci_quirk2_t
drivers/mmc/host/sdhci-of-esdhc.c:1306:31:    right side has type
restricted sdhci_quirk_t
drivers/mmc/host/sdhci-of-esdhc.c:1307:31: warning: invalid assignment: |=
drivers/mmc/host/sdhci-of-esdhc.c:1307:31:    left side has type
restricted sdhci_quirk2_t
drivers/mmc/host/sdhci-of-esdhc.c:1307:31:    right side has type
restricted sdhci_quirk_t

But maybe that's too much churn, dunno.

Rasmus

diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 2af445b8c325..41712b848a06 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -14,8 +14,8 @@

 struct sdhci_pltfm_data {
 	const struct sdhci_ops *ops;
-	unsigned int quirks;
-	unsigned int quirks2;
+	sdhci_quirk_t quirks;
+	sdhci_quirk2_t quirks2;
 };

 struct sdhci_pltfm_host {
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3140fe2e5dba..7316c81026a3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3613,10 +3613,10 @@ void __sdhci_read_caps(struct sdhci_host *host,
const u16 *ver,
 	host->read_caps = true;

 	if (debug_quirks)
-		host->quirks = debug_quirks;
+		host->quirks = (__force sdhci_quirk_t)debug_quirks;

 	if (debug_quirks2)
-		host->quirks2 = debug_quirks2;
+		host->quirks2 = (__force sdhci_quirk2_t)debug_quirks2;

 	sdhci_do_reset(host, SDHCI_RESET_ALL);

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0ed3e0eaef5f..5a97a6d13abf 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -369,119 +369,122 @@ enum sdhci_cookie {
 	COOKIE_MAPPED,		/* mapped by sdhci_prepare_data() */
 };

+typedef unsigned int __bitwise sdhci_quirk_t;
+typedef unsigned int __bitwise sdhci_quirk2_t;
+
 struct sdhci_host {
 	/* Data set by hardware interface driver */
 	const char *hw_name;	/* Hardware bus name */

-	unsigned int quirks;	/* Deviations from spec. */
+	sdhci_quirk_t quirks;	/* Deviations from spec. */

 /* Controller doesn't honor resets unless we touch the clock register */
-#define SDHCI_QUIRK_CLOCK_BEFORE_RESET			(1<<0)
+#define SDHCI_QUIRK_CLOCK_BEFORE_RESET			((__force sdhci_quirk_t)(1<<0))
 /* Controller has bad caps bits, but really supports DMA */
-#define SDHCI_QUIRK_FORCE_DMA				(1<<1)
+#define SDHCI_QUIRK_FORCE_DMA				((__force sdhci_quirk_t)(1<<1))
 /* Controller doesn't like to be reset when there is no card inserted. */
-#define SDHCI_QUIRK_NO_CARD_NO_RESET			(1<<2)
+#define SDHCI_QUIRK_NO_CARD_NO_RESET			((__force sdhci_quirk_t)(1<<2))
 /* Controller doesn't like clearing the power reg before a change */
-#define SDHCI_QUIRK_SINGLE_POWER_WRITE			(1<<3)
+#define SDHCI_QUIRK_SINGLE_POWER_WRITE			((__force sdhci_quirk_t)(1<<3))
 /* Controller has flaky internal state so reset it on each ios change */
-#define SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS		(1<<4)
+#define SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS		((__force sdhci_quirk_t)(1<<4))
 /* Controller has an unusable DMA engine */
-#define SDHCI_QUIRK_BROKEN_DMA				(1<<5)
+#define SDHCI_QUIRK_BROKEN_DMA				((__force sdhci_quirk_t)(1<<5))
 /* Controller has an unusable ADMA engine */
-#define SDHCI_QUIRK_BROKEN_ADMA				(1<<6)
+#define SDHCI_QUIRK_BROKEN_ADMA				((__force sdhci_quirk_t)(1<<6))
 /* Controller can only DMA from 32-bit aligned addresses */
-#define SDHCI_QUIRK_32BIT_DMA_ADDR			(1<<7)
+#define SDHCI_QUIRK_32BIT_DMA_ADDR			((__force sdhci_quirk_t)(1<<7))
 /* Controller can only DMA chunk sizes that are a multiple of 32 bits */
-#define SDHCI_QUIRK_32BIT_DMA_SIZE			(1<<8)
+#define SDHCI_QUIRK_32BIT_DMA_SIZE			((__force sdhci_quirk_t)(1<<8))
 /* Controller can only ADMA chunks that are a multiple of 32 bits */
-#define SDHCI_QUIRK_32BIT_ADMA_SIZE			(1<<9)
+#define SDHCI_QUIRK_32BIT_ADMA_SIZE			((__force sdhci_quirk_t)(1<<9))
 /* Controller needs to be reset after each request to stay stable */
-#define SDHCI_QUIRK_RESET_AFTER_REQUEST			(1<<10)
+#define SDHCI_QUIRK_RESET_AFTER_REQUEST			((__force sdhci_quirk_t)(1<<10))
 /* Controller needs voltage and power writes to happen separately */
-#define SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER		(1<<11)
+#define SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER		((__force
sdhci_quirk_t)(1<<11))
 /* Controller provides an incorrect timeout value for transfers */
-#define SDHCI_QUIRK_BROKEN_TIMEOUT_VAL			(1<<12)
+#define SDHCI_QUIRK_BROKEN_TIMEOUT_VAL			((__force sdhci_quirk_t)(1<<12))
 /* Controller has an issue with buffer bits for small transfers */
-#define SDHCI_QUIRK_BROKEN_SMALL_PIO			(1<<13)
+#define SDHCI_QUIRK_BROKEN_SMALL_PIO			((__force sdhci_quirk_t)(1<<13))
 /* Controller does not provide transfer-complete interrupt when not busy */
-#define SDHCI_QUIRK_NO_BUSY_IRQ				(1<<14)
+#define SDHCI_QUIRK_NO_BUSY_IRQ				((__force sdhci_quirk_t)(1<<14))
 /* Controller has unreliable card detection */
-#define SDHCI_QUIRK_BROKEN_CARD_DETECTION		(1<<15)
+#define SDHCI_QUIRK_BROKEN_CARD_DETECTION		((__force sdhci_quirk_t)(1<<15))
 /* Controller reports inverted write-protect state */
-#define SDHCI_QUIRK_INVERTED_WRITE_PROTECT		(1<<16)
+#define SDHCI_QUIRK_INVERTED_WRITE_PROTECT		((__force
sdhci_quirk_t)(1<<16))
 /* Controller does not like fast PIO transfers */
-#define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<18)
+#define SDHCI_QUIRK_PIO_NEEDS_DELAY			((__force sdhci_quirk_t)(1<<18))
 /* Controller does not have a LED */
-#define SDHCI_QUIRK_NO_LED				(1<<19)
+#define SDHCI_QUIRK_NO_LED				((__force sdhci_quirk_t)(1<<19))
 /* Controller has to be forced to use block size of 2048 bytes */
-#define SDHCI_QUIRK_FORCE_BLK_SZ_2048			(1<<20)
+#define SDHCI_QUIRK_FORCE_BLK_SZ_2048			((__force sdhci_quirk_t)(1<<20))
 /* Controller cannot do multi-block transfers */
-#define SDHCI_QUIRK_NO_MULTIBLOCK			(1<<21)
+#define SDHCI_QUIRK_NO_MULTIBLOCK			((__force sdhci_quirk_t)(1<<21))
 /* Controller can only handle 1-bit data transfers */
-#define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<22)
+#define SDHCI_QUIRK_FORCE_1_BIT_DATA			((__force sdhci_quirk_t)(1<<22))
 /* Controller needs 10ms delay between applying power and clock */
-#define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
+#define SDHCI_QUIRK_DELAY_AFTER_POWER			((__force sdhci_quirk_t)(1<<23))
 /* Controller uses SDCLK instead of TMCLK for data timeouts */
-#define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
+#define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		((__force
sdhci_quirk_t)(1<<24))
 /* Controller reports wrong base clock capability */
-#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
+#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		((__force sdhci_quirk_t)(1<<25))
 /* Controller cannot support End Attribute in NOP ADMA descriptor */
-#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
+#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		((__force sdhci_quirk_t)(1<<26))
 /* Controller is missing device caps. Use caps provided by host */
-#define SDHCI_QUIRK_MISSING_CAPS			(1<<27)
+#define SDHCI_QUIRK_MISSING_CAPS			((__force sdhci_quirk_t)(1<<27))
 /* Controller uses Auto CMD12 command to stop the transfer */
-#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
+#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		((__force
sdhci_quirk_t)(1<<28))
 /* Controller doesn't have HISPD bit field in HI-SPEED SD card */
-#define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
+#define SDHCI_QUIRK_NO_HISPD_BIT			((__force sdhci_quirk_t)(1<<29))
 /* Controller treats ADMA descriptors with length 0000h incorrectly */
-#define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC		(1<<30)
+#define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC		((__force
sdhci_quirk_t)(1<<30))
 /* The read-only detection via SDHCI_PRESENT_STATE register is unstable */
-#define SDHCI_QUIRK_UNSTABLE_RO_DETECT			(1<<31)
+#define SDHCI_QUIRK_UNSTABLE_RO_DETECT			((__force sdhci_quirk_t)(1<<31))

-	unsigned int quirks2;	/* More deviations from spec. */
+	sdhci_quirk2_t quirks2;	/* More deviations from spec. */

-#define SDHCI_QUIRK2_HOST_OFF_CARD_ON			(1<<0)
-#define SDHCI_QUIRK2_HOST_NO_CMD23			(1<<1)
+#define SDHCI_QUIRK2_HOST_OFF_CARD_ON			((__force sdhci_quirk2_t)(1<<0))
+#define SDHCI_QUIRK2_HOST_NO_CMD23			((__force sdhci_quirk2_t)(1<<1))
 /* The system physically doesn't support 1.8v, even if the host does */
-#define SDHCI_QUIRK2_NO_1_8_V				(1<<2)
-#define SDHCI_QUIRK2_PRESET_VALUE_BROKEN		(1<<3)
-#define SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON		(1<<4)
+#define SDHCI_QUIRK2_NO_1_8_V				((__force sdhci_quirk2_t)(1<<2))
+#define SDHCI_QUIRK2_PRESET_VALUE_BROKEN		((__force sdhci_quirk2_t)(1<<3))
+#define SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON		((__force sdhci_quirk2_t)(1<<4))
 /* Controller has a non-standard host control register */
-#define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		(1<<5)
+#define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		((__force sdhci_quirk2_t)(1<<5))
 /* Controller does not support HS200 */
-#define SDHCI_QUIRK2_BROKEN_HS200			(1<<6)
+#define SDHCI_QUIRK2_BROKEN_HS200			((__force sdhci_quirk2_t)(1<<6))
 /* Controller does not support DDR50 */
-#define SDHCI_QUIRK2_BROKEN_DDR50			(1<<7)
+#define SDHCI_QUIRK2_BROKEN_DDR50			((__force sdhci_quirk2_t)(1<<7))
 /* Stop command (CMD12) can set Transfer Complete when not using
MMC_RSP_BUSY */
-#define SDHCI_QUIRK2_STOP_WITH_TC			(1<<8)
+#define SDHCI_QUIRK2_STOP_WITH_TC			((__force sdhci_quirk2_t)(1<<8))
 /* Controller does not support 64-bit DMA */
-#define SDHCI_QUIRK2_BROKEN_64_BIT_DMA			(1<<9)
+#define SDHCI_QUIRK2_BROKEN_64_BIT_DMA			((__force sdhci_quirk2_t)(1<<9))
 /* need clear transfer mode register before send cmd */
-#define SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD	(1<<10)
+#define SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD	((__force
sdhci_quirk2_t)(1<<10))
 /* Capability register bit-63 indicates HS400 support */
-#define SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400		(1<<11)
+#define SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400		((__force
sdhci_quirk2_t)(1<<11))
 /* forced tuned clock */
-#define SDHCI_QUIRK2_TUNING_WORK_AROUND			(1<<12)
+#define SDHCI_QUIRK2_TUNING_WORK_AROUND			((__force sdhci_quirk2_t)(1<<12))
 /* disable the block count for single block transactions */
-#define SDHCI_QUIRK2_SUPPORT_SINGLE			(1<<13)
+#define SDHCI_QUIRK2_SUPPORT_SINGLE			((__force sdhci_quirk2_t)(1<<13))
 /* Controller broken with using ACMD23 */
-#define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
+#define SDHCI_QUIRK2_ACMD23_BROKEN			((__force sdhci_quirk2_t)(1<<14))
 /* Broken Clock divider zero in controller */
-#define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+#define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		((__force
sdhci_quirk2_t)(1<<15))
 /* Controller has CRC in 136 bit Command Response */
-#define SDHCI_QUIRK2_RSP_136_HAS_CRC			(1<<16)
+#define SDHCI_QUIRK2_RSP_136_HAS_CRC			((__force sdhci_quirk2_t)(1<<16))
 /*
  * Disable HW timeout if the requested timeout is more than the maximum
  * obtainable timeout.
  */
-#define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
+#define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			((__force sdhci_quirk2_t)(1<<17))
 /*
  * 32-bit block count may not support eMMC where upper bits of CMD23
are used
  * for other purposes.  Consequently we support 16-bit block count by
default.
  * Otherwise, SDHCI_QUIRK2_USE_32BIT_BLK_CNT can be selected to use 32-bit
  * block count.
  */
-#define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+#define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			((__force sdhci_quirk2_t)(1<<18))

 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
