Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1A2C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C53920673
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384431;
	bh=082BMeEI5De5r+ZXqfTJEGduL6z/t1hEjdp/Pelq80c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BG+cnlAD0FL4iEDdnXFRtWBe1ZjvvNiHv26KBT/jSfVVUNq1KjWNI/NMuxrhyRJdb
	 IzPIwC/0SHZO/wvkymEDKSrkCBdGrJB40VM0C5FX4qxmdZP/BD0OD8b+z/6129vU3H
	 qjWk0vWCClvV6UefsO/OzBsxgcVENBt/t/noqmbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbfJFRhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729505AbfJFRhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:37:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C3B82080F;
        Sun,  6 Oct 2019 17:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383435;
        bh=082BMeEI5De5r+ZXqfTJEGduL6z/t1hEjdp/Pelq80c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rOOMYWIH+Rr0o1f2FvBfxsfO35S72BSFRm5w5hWnE+3tNJ/AHFUoD7XPnsjRxrQHn
         dsQTGOTOfhIBENz63H/m5LW2gfLIRV3aQUX17ml1CWXVRsWW4xxmPuE4Wz36rMBsBI
         mPp4HmRev8HtPzleqwuB3aGcPvX6+/uDwo1yh8v8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 103/137] soundwire: intel: fix channel number reported by hardware
Date:   Sun,  6 Oct 2019 19:21:27 +0200
Message-Id: <20191006171217.508937732@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 18046335643de6d21327f5ae034c8fb8463f6715 ]

On all released Intel controllers (CNL/CML/ICL), PDI2 reports an
invalid count, force the correct hardware-supported value

This may have to be revisited with platform-specific values if the
hardware changes, but for now this is good enough.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190806005522.22642-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/intel.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 60293a00a14ee..8a670bc86c0ce 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -283,6 +283,16 @@ intel_pdi_get_ch_cap(struct sdw_intel *sdw, unsigned int pdi_num, bool pcm)
 
 	if (pcm) {
 		count = intel_readw(shim, SDW_SHIM_PCMSYCHC(link_id, pdi_num));
+
+		/*
+		 * WORKAROUND: on all existing Intel controllers, pdi
+		 * number 2 reports channel count as 1 even though it
+		 * supports 8 channels. Performing hardcoding for pdi
+		 * number 2.
+		 */
+		if (pdi_num == 2)
+			count = 7;
+
 	} else {
 		count = intel_readw(shim, SDW_SHIM_PDMSCAP(link_id));
 		count = ((count & SDW_SHIM_PDMSCAP_CPSS) >>
-- 
2.20.1



