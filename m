Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F5CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF56D218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257417;
	bh=NAa1pyDzqcgeuDqYOCQM2taqB8iacwqhA7WI1x70tBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YLNKx5hcnHCRReLX/aV/96Rd1ZDjjdM9REtifBMgrty3owGun9BiDoCcSotrcr7Lp
	 sUW+lT+fOmTMuc5togeNQMfc/bwot3sa27E+2J+UnhKjOujcKRTwfr4qsOZ5eFdToy
	 CfIl590AOXeQrvTiSM7N5P3N1A4c/J2s/25S1PK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390985AbfCVMXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:23:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390945AbfCVMXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:23:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 288C4218A1;
        Fri, 22 Mar 2019 12:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257409;
        bh=NAa1pyDzqcgeuDqYOCQM2taqB8iacwqhA7WI1x70tBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oIIZOAc633LxiAGWnk6fgB9a7sjv99fkZKcEiJmtp2R9blOUmmw3pl03esxqBhbY/
         JDeadni1390uSIgY4x/IirNMzZ+ABtNiFrob3dseqHIAB+WbX+yYwAlx8wZtg2pr7i
         tGlao8jVxg3oyfTcHjuTZ6DQHQ6XIB9eBsgJv4zU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.0 222/238] drm/amd/powerplay: correct power reading on fiji
Date:   Fri, 22 Mar 2019 12:17:21 +0100
Message-Id: <20190322111311.431505334@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Evan Quan <evan.quan@amd.com>

commit f5742ec36422a39b57f0256e4847f61b3c432f8c upstream.

Set sampling period as 500ms to provide a smooth power
reading output. Also, correct the register for power
reading.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -3491,14 +3491,14 @@ static int smu7_get_gpu_power(struct pp_
 
 	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_PmStatusLogStart);
 	cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
-							ixSMU_PM_STATUS_94, 0);
+							ixSMU_PM_STATUS_95, 0);
 
 	for (i = 0; i < 10; i++) {
-		mdelay(1);
+		mdelay(500);
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_PmStatusLogSample);
 		tmp = cgs_read_ind_register(hwmgr->device,
 						CGS_IND_REG__SMC,
-						ixSMU_PM_STATUS_94);
+						ixSMU_PM_STATUS_95);
 		if (tmp != 0)
 			break;
 	}


