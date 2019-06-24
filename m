Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F785C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC05C2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370998;
	bh=2bCaQpKfQhYXu+UNFytJt21KrwSS7cGYWdbooSHkFCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h4jUagFVGQMPVV+odYlCxSAZofbyeF8qpnV+nMkEGlo7HLDys7Tr2bwaMc3UUiy6E
	 GS78tfpXbHtOib2Au0OsNai0T9mWjdPdiPf/du2HGrFYrmjSvD77WpeyvZN5P09JmA
	 XiUg0c8YVyqz/+8FWwWqUyCbm/j4FW6qLfB8rkW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfFXKI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730352AbfFXKIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:08:04 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FF2F20645;
        Mon, 24 Jun 2019 10:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370884;
        bh=2bCaQpKfQhYXu+UNFytJt21KrwSS7cGYWdbooSHkFCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sl5RZk8a7XojLLaqMYvXQ3x/bfkDBiWWOAI+Ex3oeaafTt9VcM7Odyi9mjpzW2/fj
         00j2LBm7JXZXAG5N8vwxHXuLwvZORBHW2nuaCsCJhMSeY6pCsvilwutgtsxSp/XD0C
         MSz5qNAgeUCVqfSxqETkXEPwQqfvSMwrKCrCkjpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.1 007/121] mmc: core: Add sdio_retune_hold_now() and sdio_retune_release()
Date:   Mon, 24 Jun 2019 17:55:39 +0800
Message-Id: <20190624092321.017259033@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

commit b4c9f938d542d5f88c501744d2d12fad4fd2915f upstream.

We want SDIO drivers to be able to temporarily stop retuning when the
driver knows that the SDIO card is not in a state where retuning will
work (maybe because the card is asleep).  We'll move the relevant
functions to a place where drivers can call them.

Cc: stable@vger.kernel.org #v4.18+
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/sdio_io.c    |   40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/sdio_func.h |    3 +++
 2 files changed, 43 insertions(+)

--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -19,6 +19,7 @@
 #include "sdio_ops.h"
 #include "core.h"
 #include "card.h"
+#include "host.h"
 
 /**
  *	sdio_claim_host - exclusively claim a bus for a certain SDIO function
@@ -775,3 +776,42 @@ void sdio_retune_crc_enable(struct sdio_
 	func->card->host->retune_crc_disable = false;
 }
 EXPORT_SYMBOL_GPL(sdio_retune_crc_enable);
+
+/**
+ *	sdio_retune_hold_now - start deferring retuning requests till release
+ *	@func: SDIO function attached to host
+ *
+ *	This function can be called if it's currently a bad time to do
+ *	a retune of the SDIO card.  Retune requests made during this time
+ *	will be held and we'll actually do the retune sometime after the
+ *	release.
+ *
+ *	This function could be useful if an SDIO card is in a power state
+ *	where it can respond to a small subset of commands that doesn't
+ *	include the retuning command.  Care should be taken when using
+ *	this function since (presumably) the retuning request we might be
+ *	deferring was made for a good reason.
+ *
+ *	This function should be called while the host is claimed.
+ */
+void sdio_retune_hold_now(struct sdio_func *func)
+{
+	mmc_retune_hold_now(func->card->host);
+}
+EXPORT_SYMBOL_GPL(sdio_retune_hold_now);
+
+/**
+ *	sdio_retune_release - signal that it's OK to retune now
+ *	@func: SDIO function attached to host
+ *
+ *	This is the complement to sdio_retune_hold_now().  Calling this
+ *	function won't make a retune happen right away but will allow
+ *	them to be scheduled normally.
+ *
+ *	This function should be called while the host is claimed.
+ */
+void sdio_retune_release(struct sdio_func *func)
+{
+	mmc_retune_release(func->card->host);
+}
+EXPORT_SYMBOL_GPL(sdio_retune_release);
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -162,4 +162,7 @@ extern int sdio_set_host_pm_flags(struct
 extern void sdio_retune_crc_disable(struct sdio_func *func);
 extern void sdio_retune_crc_enable(struct sdio_func *func);
 
+extern void sdio_retune_hold_now(struct sdio_func *func);
+extern void sdio_retune_release(struct sdio_func *func);
+
 #endif /* LINUX_MMC_SDIO_FUNC_H */


