Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BA9ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C47D207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264316;
	bh=f9IPlNHLKFCsJuY8349dycvrJB7cmi/z+5puEsg0Q7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p+dAtZ7i73iIp4osh+yrPpTYjEkNxD03l5MMuXUt99dPrkvoLBX8ZRv1xYC5ScfzQ
	 RscfICHwtUB/gcIj+BN7FEMMlLwAzLi6ra3KTHhOH0q9vDfW0vNa8MdF4H760k+t27
	 Uq/6zvTeGgKGXNFVCW5GiahO8qa0TD80gFK+HC5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391797AbfJPWSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394996AbfJPVy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:54:26 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A423421A4C;
        Wed, 16 Oct 2019 21:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262865;
        bh=f9IPlNHLKFCsJuY8349dycvrJB7cmi/z+5puEsg0Q7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VLdcnChFTCsJGgBOj/5gb2EykNnIGj8SUSahL09pWBqmXmmhkYfbEo8MDLuwwtHQ5
         7V8johGqli6CCbgHELgYKrlpfqu76hmK135cwWug4bQnX6Wy6DO38apk1SPu4gykCB
         OPh1V7sJTdUfwpw4z+fBIMJv2UoPBqPk1GVtXkao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 4.9 31/92] coresight: etm4x: Use explicit barriers on enable/disable
Date:   Wed, 16 Oct 2019 14:50:04 -0700
Message-Id: <20191016214826.438744632@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Murray <andrew.murray@arm.com>

commit 1004ce4c255fc3eb3ad9145ddd53547d1b7ce327 upstream.

Synchronization is recommended before disabling the trace registers
to prevent any start or stop points being speculative at the point
of disabling the unit (section 7.3.77 of ARM IHI 0064D).

Synchronization is also recommended after programming the trace
registers to ensure all updates are committed prior to normal code
resuming (section 4.3.7 of ARM IHI 0064D).

Let's ensure these syncronization points are present in the code
and clearly commented.

Note that we could rely on the barriers in CS_LOCK and
coresight_disclaim_device_unlocked or the context switch to user
space - however coresight may be of use in the kernel.

On armv8 the mb macro is defined as dsb(sy) - Given that the etm4x is
only used on armv8 let's directly use dsb(sy) instead of mb(). This
removes some ambiguity and makes it easier to correlate the code with
the TRM.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
[Fixed capital letter for "use" in title]
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Link: https://lore.kernel.org/r/20190829202842.580-11-mathieu.poirier@linaro.org
Cc: stable@vger.kernel.org # 4.9+
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/coresight/coresight-etm4x.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -181,6 +181,12 @@ static void etm4_enable_hw(void *info)
 	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
 		dev_err(drvdata->dev,
 			"timeout while waiting for Idle Trace Status\n");
+	/*
+	 * As recommended by section 4.3.7 ("Synchronization when using the
+	 * memory-mapped interface") of ARM IHI 0064D
+	 */
+	dsb(sy);
+	isb();
 
 	CS_LOCK(drvdata->base);
 
@@ -323,8 +329,12 @@ static void etm4_disable_hw(void *info)
 	/* EN, bit[0] Trace unit enable bit */
 	control &= ~0x1;
 
-	/* make sure everything completes before disabling */
-	mb();
+	/*
+	 * Make sure everything completes before disabling, as recommended
+	 * by section 7.3.77 ("TRCVICTLR, ViewInst Main Control Register,
+	 * SSTATUS") of ARM IHI 0064D
+	 */
+	dsb(sy);
 	isb();
 	writel_relaxed(control, drvdata->base + TRCPRGCTLR);
 


