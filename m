Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A489C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC7220578
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427776;
	bh=K7/Z7ULPaiMrGML8CskPhXEpmnsruK7vDzfr3sp2vPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LhvKREdEbswEYebQNrJpQVJfsuAU9dk2aUKIwQ/MB/kM+WkkAZPcFniWpfVjX6zB3
	 m+HIUtJUMAwnFKgU/44itlk/1IEVPMbaClwsaWyV9GHCMp68tqxwCT50FjBnRityGz
	 3MaXCkcSG9fCaal43gi1mRdNZHg/HTq1PgZjHEkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfEIStf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbfEIStc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:49:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C401320578;
        Thu,  9 May 2019 18:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427772;
        bh=K7/Z7ULPaiMrGML8CskPhXEpmnsruK7vDzfr3sp2vPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fbNp7PiylVii+xeuwG/HYvqNdmMtpG3aIqLCQZuXlabTNoCUPMzusH00cM1uvA/B+
         Bqq+h72qtUqWZAV5GrmUUBtg9W09HTx09gKHuyWgEv1BRGZ2wLAzQfymEN7yJ4r7NT
         e/j7kyWKRq/Q0FYzXUI5xVSQoGrVmMtjIqZWSY9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 64/66] ASoC: Intel: avoid Oops if DMA setup fails
Date:   Thu,  9 May 2019 20:42:39 +0200
Message-Id: <20190509181308.092615871@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181301.719249738@linuxfoundation.org>
References: <20190509181301.719249738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Zwisler <zwisler@chromium.org>

commit 0efa3334d65b7f421ba12382dfa58f6ff5bf83c4 upstream.

Currently in sst_dsp_new() if we get an error return from sst_dma_new()
we just print an error message and then still complete the function
successfully.  This means that we are trying to run without sst->dma
properly set up, which will result in NULL pointer dereference when
sst->dma is later used.  This was happening for me in
sst_dsp_dma_get_channel():

        struct sst_dma *dma = dsp->dma;
	...
        dma->ch = dma_request_channel(mask, dma_chan_filter, dsp);

This resulted in:

   BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
   IP: sst_dsp_dma_get_channel+0x4f/0x125 [snd_soc_sst_firmware]

Fix this by adding proper error handling for the case where we fail to
set up DMA.

This change only affects Haswell and Broadwell systems.  Baytrail
systems explicilty opt-out of DMA via sst->pdata->resindex_dma_base
being set to -1.

Signed-off-by: Ross Zwisler <zwisler@google.com>
Cc: stable@vger.kernel.org
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/common/sst-firmware.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -1251,11 +1251,15 @@ struct sst_dsp *sst_dsp_new(struct devic
 		goto irq_err;
 
 	err = sst_dma_new(sst);
-	if (err)
-		dev_warn(dev, "sst_dma_new failed %d\n", err);
+	if (err)  {
+		dev_err(dev, "sst_dma_new failed %d\n", err);
+		goto dma_err;
+	}
 
 	return sst;
 
+dma_err:
+	free_irq(sst->irq, sst);
 irq_err:
 	if (sst->ops->free)
 		sst->ops->free(sst);


