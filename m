Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F647C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3082721872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610605;
	bh=j3pVMqzDq7XnP2iyLz/eRYs301p+pk5iyQOdszhJm+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ClJaS4/hL3M61367FfXtnceSCjcbTineavRTe00QKO681yPdII8C9xtwmOJRJa5AO
	 hDoi/FBIMmTgyn8RCswfYNLbZBk9/fUrkMvuO/SJaf/tZ5+X0nt7A0MRJzcPy9z4WL
	 ut1pDsLh8uCAn7aBb9gM5VHdR/R6A5D62pMfZO6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390917AbfDRSDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390903AbfDRSDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:03:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEFF9217FA;
        Thu, 18 Apr 2019 18:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610598;
        bh=j3pVMqzDq7XnP2iyLz/eRYs301p+pk5iyQOdszhJm+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8pJkvBWTicNr3TnYT6g1bYifJL8lln1CNv4txHvx/fFzCudo9kV9pbjOvIRra3fD
         mqjkXfpeHnyrjuFr8VltnvSHOd/nc40GZyY33ewT/017PifhmXwqJ4SGsQ3lMEbmfz
         BAcsjheFBCmQLIsdQrjHAAb2P/BgD5yZ7Dhki3qI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 12/92] thermal/intel_powerclamp: fix __percpu declaration of worker_data
Date:   Thu, 18 Apr 2019 19:56:30 +0200
Message-Id: <20190418160431.455727033@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit aa36e3616532f82a920b5ebf4e059fbafae63d88 ]

This variable is declared as:
	static struct powerclamp_worker_data * __percpu worker_data;
In other words, a percpu pointer to struct ...

But this variable not used like so but as a pointer to a percpu
struct powerclamp_worker_data.

So fix the declaration as:
	static struct powerclamp_worker_data __percpu *worker_data;

This also quiets Sparse's warnings from __verify_pcpu_ptr(), like:
  494:49: warning: incorrect type in initializer (different address spaces)
  494:49:    expected void const [noderef] <asn:3> *__vpp_verify
  494:49:    got struct powerclamp_worker_data *

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/intel_powerclamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index d718cd179ddb..45d9840491bd 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -101,7 +101,7 @@ struct powerclamp_worker_data {
 	bool clamping;
 };
 
-static struct powerclamp_worker_data * __percpu worker_data;
+static struct powerclamp_worker_data __percpu *worker_data;
 static struct thermal_cooling_device *cooling_dev;
 static unsigned long *cpu_clamping_mask;  /* bit map for tracking per cpu
 					   * clamping kthread worker
-- 
2.19.1



