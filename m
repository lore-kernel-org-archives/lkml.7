Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F2FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7374720854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NxaklE5x";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NxaklE5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfCHIba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:31:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35296 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfCHIb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:31:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E69FC60328; Fri,  8 Mar 2019 08:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552033888;
        bh=r6UpcGLRfUb4r7DBjUfSRXiQc48oEnolLIxnTH75ChY=;
        h=From:To:Cc:Subject:Date:From;
        b=NxaklE5x2ELaM/gFytbR+GEkRGeacUNo/hR7NgwJhxqwWT+ckD+GRNaebFS78GjlD
         wCqHtsnQ53ml9r7OGTrCPN4h4m/GWB19qt4RJ1MZtSPLIyuuJ84OsQ/zxSAJy0DjsS
         Q3stJBp6gLYIQhJGHkm21sHUwr1E3TQ/gRCMRJww=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE8EB60DB4;
        Fri,  8 Mar 2019 08:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552033888;
        bh=r6UpcGLRfUb4r7DBjUfSRXiQc48oEnolLIxnTH75ChY=;
        h=From:To:Cc:Subject:Date:From;
        b=NxaklE5x2ELaM/gFytbR+GEkRGeacUNo/hR7NgwJhxqwWT+ckD+GRNaebFS78GjlD
         wCqHtsnQ53ml9r7OGTrCPN4h4m/GWB19qt4RJ1MZtSPLIyuuJ84OsQ/zxSAJy0DjsS
         Q3stJBp6gLYIQhJGHkm21sHUwr1E3TQ/gRCMRJww=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE8EB60DB4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     vinholikatti@gmail.com, alim.akhtar@samsung.com,
        pedrom.Sousa@synopsys.com
Cc:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 0/3] scsi: ufs: runtime pm fixes
Date:   Fri,  8 Mar 2019 14:00:50 +0530
Message-Id: <20190308083053.30631-1-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are some runtime pm fixes I stumbled upon while
working on adding support for controlling multiple
power domains (needed on qualcomm sdm845 platforms)
in the ufshcd-pltfrm driver.

Rajendra Nayak (3):
  scsi: ufs: Fix runtime pm handling in ufshcd-pltfrm
  scsi: ufs: Add error checks for pm_runtime_get_sync()
  scsi: ufs: qcom: Remove unnecessary runtime pm calls

 drivers/scsi/ufs/ufs-qcom.c      | 2 --
 drivers/scsi/ufs/ufshcd-pltfrm.c | 3 +++
 drivers/scsi/ufs/ufshcd.c        | 5 ++++-
 3 files changed, 7 insertions(+), 3 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

