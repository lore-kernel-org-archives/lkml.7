Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D2BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E0920714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418700;
	bh=kONIw5+RCqk1HwlcwgcSjjpoDAD2z8bX2w4D1uCG3oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iPc5mKMEhOlZ+584zdWE+PcKf9BGsAsG3mm2bAYuT0tVbqlDE+knQI5V+NDgMgcWA
	 Oj6XfLU9vH22m/2DwPEHXPKVL06gwivDY5T7v3wIbLaRzIaVBRLi7WaTefoUldTi7g
	 ETUeevzfi4q61zES3wWDpwQoSQ3clI7GTAwmpFlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKVKbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:31:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbfKVKbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:31:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8603C20714;
        Fri, 22 Nov 2019 10:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418696;
        bh=kONIw5+RCqk1HwlcwgcSjjpoDAD2z8bX2w4D1uCG3oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P5lGBCQtyAylC315pfEcShSgbSEfKIsjt8TRvkR9q4Qvh0Cs38r7Ff940ktqPFrrs
         oMuPvbAd+b/ARjMjEjWNBGgUMeazCiO+rTp/FJsmoyr8uK/MkBU8sz92K/GpWonYAa
         lTPXBHj/Zjj0N33bzNp3e4AIArOBcYTVlKlhcsEU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mitch Williams <mitch.a.williams@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 020/159] i40e: use correct length for strncpy
Date:   Fri, 22 Nov 2019 11:26:51 +0100
Message-Id: <20191122100721.179620692@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mitch Williams <mitch.a.williams@intel.com>

[ Upstream commit 7eb74ff891b4e94b8bac48f648a21e4b94ddee64 ]

Caught by GCC 8. When we provide a length for strncpy, we should not
include the terminating null. So we must tell it one less than the size
of the destination buffer.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 565ca7c835bc3..e22ebe460b131 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -605,7 +605,8 @@ static long i40e_ptp_create_clock(struct i40e_pf *pf)
 	if (!IS_ERR_OR_NULL(pf->ptp_clock))
 		return 0;
 
-	strncpy(pf->ptp_caps.name, i40e_driver_name, sizeof(pf->ptp_caps.name));
+	strncpy(pf->ptp_caps.name, i40e_driver_name,
+		sizeof(pf->ptp_caps.name) - 1);
 	pf->ptp_caps.owner = THIS_MODULE;
 	pf->ptp_caps.max_adj = 999999999;
 	pf->ptp_caps.n_ext_ts = 0;
-- 
2.20.1



