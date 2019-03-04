Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DB420836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688533;
	bh=AltHwL9KrtZgBxdswZki4EFiidAdFtNyXhWJnWMUkQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FWdyMUZZfQjDLcwlWlvE1PC1gNVgndEwdk3KiY5ur3Xi3y846A17dGc9GgihyZlPa
	 Xmyz9FMpbic9kJT7dbMLDf1k2E/n9FMkZBgCqY02yqUuKiEpiQ9yPh+jx45QQ+cVzk
	 8cmSPZ1XmPY6PvvoORmb+L/CIWfD5oIJPaAbQ4bA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfCDIfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:35:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbfCDIf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:35:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E825520823;
        Mon,  4 Mar 2019 08:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688526;
        bh=AltHwL9KrtZgBxdswZki4EFiidAdFtNyXhWJnWMUkQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNIBqgoxW0AgKHejXg+vzORgxeMoozEBo8rtf2tJa4BUCOon1SMUAxaIoOQCH+qKO
         mY6mD1psoX8tgxI5olx08xhCaWkK79TPNtkBu7cMS7Nviq9GYqN5C0uxzBYce6oOcy
         ViAB9W6rh9WBgDQqo7Em6du3J7B0347SIcQ5q5vU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alamy Liu <alamy.liu@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.20 72/88] mmc: cqhci: fix space allocated for transfer descriptor
Date:   Mon,  4 Mar 2019 09:22:55 +0100
Message-Id: <20190304081633.471803653@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alamy Liu <alamy.liu@gmail.com>

commit 27ec9dc17c48ea2e642ccb90b4ebf7fd47468911 upstream.

There is not enough space being allocated when DCMD is disabled.

CQE_DCMD is not necessary to be enabled when CQE is enabled.
(Software could halt CQE to send command)

In the case that CQE_DCMD is not enabled, it still needs to allocate
space for data transfer. For instance:
  CQE_DCMD is enabled:  31 slots space (one slot used by DCMD)
  CQE_DCMD is disabled: 32 slots space

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/cqhci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -201,7 +201,7 @@ static int cqhci_host_alloc_tdl(struct c
 	cq_host->desc_size = cq_host->slot_sz * cq_host->num_slots;
 
 	cq_host->data_size = cq_host->trans_desc_len * cq_host->mmc->max_segs *
-		(cq_host->num_slots - 1);
+		cq_host->mmc->cqe_qdepth;
 
 	pr_debug("%s: cqhci: desc_size: %zu data_sz: %zu slot-sz: %d\n",
 		 mmc_hostname(cq_host->mmc), cq_host->desc_size, cq_host->data_size,


