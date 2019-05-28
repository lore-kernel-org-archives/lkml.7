Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D49EC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E84520989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfE1KFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:05:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:31746 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfE1KFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:05:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 03:05:15 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga006.fm.intel.com with ESMTP; 28 May 2019 03:05:11 -0700
Subject: Re: [PATCH 2/3] mmc: core: API for temporarily disabling
 auto-retuning due to errors
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-rockchip@lists.infradead.org,
        Double Lo <double.lo@cypress.com>, briannorris@chromium.org,
        Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Jiong Wu <lohengrin1024@gmail.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>, Martin Hicks <mort@bork.org>
References: <20190517225420.176893-1-dianders@chromium.org>
 <20190517225420.176893-3-dianders@chromium.org>
 <05af228c-139b-2b7f-f626-36fb34634be5@broadcom.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4f39e152-04ba-a64e-985a-df93e6d15ff8@intel.com>
Date:   Tue, 28 May 2019 13:04:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <05af228c-139b-2b7f-f626-36fb34634be5@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/19 9:42 PM, Arend Van Spriel wrote:
> On 5/18/2019 12:54 AM, Douglas Anderson wrote:
>> Normally when the MMC core sees an "-EILSEQ" error returned by a host
>> controller then it will trigger a retuning of the card.  This is
>> generally a good idea.
> 
> Probably a question for Adrian, but how is this retuning scheduled. I recall
> seeing something in mmc_request_done. How about deferring the retuning upon
> a release host or is that too sdio specific.

Below is what I have been carrying the last 4 years.  But according to Douglas'
patch, the release would need to be further down.  See 2nd diff below.
Would that work?


diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 3f67fbbe0d75..7a81a503541b 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -16,6 +16,7 @@
 #include <linux/mmc/sdio.h>
 #include <linux/mmc/sdio_func.h>
 
+#include "host.h"
 #include "sdio_ops.h"
 #include "core.h"
 #include "card.h"
@@ -738,3 +739,15 @@ int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sdio_set_host_pm_flags);
+
+void sdio_retune_hold_now(struct sdio_func *func)
+{
+	mmc_retune_hold_now(func->card->host);
+}
+EXPORT_SYMBOL_GPL(sdio_retune_hold_now);
+
+void sdio_retune_release(struct sdio_func *func)
+{
+	mmc_retune_release(func->card->host);
+}
+EXPORT_SYMBOL_GPL(sdio_retune_release);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 22b73da42822..c915c39d519f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -679,6 +679,11 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
 	brcmf_dbg(TRACE, "Enter: on=%d\n", on);
 
 	wr_val = (on << SBSDIO_FUNC1_SLEEPCSR_KSO_SHIFT);
+
+	/* Cannot re-tune if device is asleep */
+	if (on)
+		sdio_retune_hold_now(bus->sdiodev->func1);
+
 	/* 1st KSO write goes to AOS wake up core if device is asleep  */
 	brcmf_sdiod_writeb(bus->sdiodev, SBSDIO_FUNC1_SLEEPCSR, wr_val, &err);
 
@@ -691,6 +696,7 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
 		return err;
 
 	if (on) {
+		sdio_retune_release(bus->sdiodev->func1);
 		/* device WAKEUP through KSO:
 		 * write bit 0 & read back until
 		 * both bits 0 (kso bit) & 1 (dev on status) are set
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index 5685805533b5..85c24b0694d7 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -171,4 +171,7 @@ extern void sdio_f0_writeb(struct sdio_func *func, unsigned char b,
 extern mmc_pm_flag_t sdio_get_host_pm_caps(struct sdio_func *func);
 extern int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags);
 
+extern void sdio_retune_hold_now(struct sdio_func *func);
+extern void sdio_retune_release(struct sdio_func *func);
+
 #endif /* LINUX_MMC_SDIO_FUNC_H */





diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 3f67fbbe0d75..7a81a503541b 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -16,6 +16,7 @@
 #include <linux/mmc/sdio.h>
 #include <linux/mmc/sdio_func.h>
 
+#include "host.h"
 #include "sdio_ops.h"
 #include "core.h"
 #include "card.h"
@@ -738,3 +739,15 @@ int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sdio_set_host_pm_flags);
+
+void sdio_retune_hold_now(struct sdio_func *func)
+{
+	mmc_retune_hold_now(func->card->host);
+}
+EXPORT_SYMBOL_GPL(sdio_retune_hold_now);
+
+void sdio_retune_release(struct sdio_func *func)
+{
+	mmc_retune_release(func->card->host);
+}
+EXPORT_SYMBOL_GPL(sdio_retune_release);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 22b73da42822..50c153932683 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -679,6 +679,11 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
 	brcmf_dbg(TRACE, "Enter: on=%d\n", on);
 
 	wr_val = (on << SBSDIO_FUNC1_SLEEPCSR_KSO_SHIFT);
+
+	/* Cannot re-tune if device is asleep */
+	if (on)
+		sdio_retune_hold_now(bus->sdiodev->func1);
+
 	/* 1st KSO write goes to AOS wake up core if device is asleep  */
 	brcmf_sdiod_writeb(bus->sdiodev, SBSDIO_FUNC1_SLEEPCSR, wr_val, &err);
 
@@ -731,6 +736,9 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
 
 	} while (try_cnt++ < MAX_KSO_ATTEMPTS);
 
+	if (on)
+		sdio_retune_release(bus->sdiodev->func1);
+
 	if (try_cnt > 2)
 		brcmf_dbg(SDIO, "try_cnt=%d rd_val=0x%x err=%d\n", try_cnt,
 			  rd_val, err);
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index 5685805533b5..85c24b0694d7 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -171,4 +171,7 @@ extern void sdio_f0_writeb(struct sdio_func *func, unsigned char b,
 extern mmc_pm_flag_t sdio_get_host_pm_caps(struct sdio_func *func);
 extern int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags);
 
+extern void sdio_retune_hold_now(struct sdio_func *func);
+extern void sdio_retune_release(struct sdio_func *func);
+
 #endif /* LINUX_MMC_SDIO_FUNC_H */
