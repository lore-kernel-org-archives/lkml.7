Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2125C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A0A21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257370;
	bh=xZLqDWKZJR2ON60ZpOr+Z8VHxNFoZJKyNJWqjuXx1DY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UY8e0FYDSamTKyvWh/QpRx2Vz3CTLlo5JguiozYB1X/ThT5y8JHhj0N+u9T1l6KFq
	 itr+9sNn0iReNBCYJTeRWrBBxtI/90l3tJn62WW7ZuhBpO3lR28jRgiEmG5rjS4BKY
	 VDd+kC4iAzghyRQVFM4oaL29MmV9WlTh1WlULBek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390715AbfCVMWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391055AbfCVMWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:22:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ADD621900;
        Fri, 22 Mar 2019 12:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257365;
        bh=xZLqDWKZJR2ON60ZpOr+Z8VHxNFoZJKyNJWqjuXx1DY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLtQ1202GXac9/zp0/6g5RpGvZ38YHCVrXZjkHej+hpBG4jxvHO7YMzzdEmm+mRIE
         IhbDH0Gr1ryhbKCo0jckTT1QHrIpPR4pU7Wr01xJVGZlGCQh+duo1Al9ZCwR1ECRAF
         btAsG2LPIMYJZdNtyxhCLus3RSOhQ6hskweNh+oI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.0 193/238] PM / OPP: Update performance state when freq == old_freq
Date:   Fri, 22 Mar 2019 12:16:52 +0100
Message-Id: <20190322111309.590147242@linuxfoundation.org>
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

From: Viresh Kumar <viresh.kumar@linaro.org>

commit faef080f6db5320011862f7baf1aa66d0851559f upstream.

At boot up, CPUFreq core performs a sanity check to see if the system is
running at a frequency defined in the frequency table of the CPU. If so,
we try to find a valid frequency (lowest frequency greater than the
currently programmed frequency) from the table and set it. When the call
reaches dev_pm_opp_set_rate(), it calls _find_freq_ceil(opp_table,
&old_freq) to find the previously configured OPP and this call also
updates the old_freq. This eventually sets the old_freq == freq (new
target requested by cpufreq core) and we skip updating the performance
state in this case.

Fix this by also updating the performance state when the old_freq ==
freq.

Fixes: ca1b5d77b1c6 ("OPP: Configure all required OPPs")
Cc: v5.0 <stable@vger.kernel.org> # v5.0
Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
Tested-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/opp/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -743,7 +743,7 @@ int dev_pm_opp_set_rate(struct device *d
 		old_freq, freq);
 
 	/* Scaling up? Configure required OPPs before frequency */
-	if (freq > old_freq) {
+	if (freq >= old_freq) {
 		ret = _set_required_opps(dev, opp_table, opp);
 		if (ret)
 			goto put_opp;


