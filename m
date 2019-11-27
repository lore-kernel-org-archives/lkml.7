Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A14FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF232075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890844;
	bh=uOQtTCLHEwtW2ut6Q0nPb0g093HpDJgAfOS0CS1GpVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fj80TUVPN5mY5eItRMNrkCC/ZSL/YUNs3nCXObsm5Ma/eCj46WMe694qwl6btPcXs
	 Z1F5DlVla4IOppl4WOq8RyPtKJ7/3kYUaPeqlFxdpMAU/qSYDWnqsxOtuUNX53mM73
	 FM4ANTBP3/sAVxWHoSOGQXtonRtwO4N+aCpyWwl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfK0Vkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:40:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729345AbfK0Umk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:42:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4C3E21787;
        Wed, 27 Nov 2019 20:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887359;
        bh=uOQtTCLHEwtW2ut6Q0nPb0g093HpDJgAfOS0CS1GpVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xF7guyWLGVGrTPmCxHpslmFtoXAUeRdkc82UQOrOmF7o/nkDMIEn2qi7iVcQAvvaF
         kCZ7u5Ihzd1c3g8VbjHp/2ByVtaaVJ0hyrjdXH67oOw1Qlpko72uwyzCvpucjuklFm
         ENQVn3jsf1nFxQDM2LGUQ8W87n9TLmy9jYhO+icw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 081/151] igb: shorten maximum PHC timecounter update interval
Date:   Wed, 27 Nov 2019 21:31:04 +0100
Message-Id: <20191127203035.945658108@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miroslav Lichvar <mlichvar@redhat.com>

[ Upstream commit 094bf4d0e9657f6ea1ee3d7e07ce3970796949ce ]

The timecounter needs to be updated at least once per ~550 seconds in
order to avoid a 40-bit SYSTIM timestamp to be misinterpreted as an old
timestamp.

Since commit 500462a9d ("timers: Switch to a non-cascading wheel"),
scheduling of delayed work seems to be less accurate and a requested
delay of 540 seconds may actually be longer than 550 seconds. Shorten
the delay to 480 seconds to be sure the timecounter is updated in time.

This fixes an issue with HW timestamps on 82580/I350/I354 being off by
~1100 seconds for few seconds every ~9 minutes.

Cc: Jacob Keller <jacob.e.keller@intel.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 9eb9b68f8935e..ae1f963b60923 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -65,9 +65,15 @@
  *
  * The 40 bit 82580 SYSTIM overflows every
  *   2^40 * 10^-9 /  60  = 18.3 minutes.
+ *
+ * SYSTIM is converted to real time using a timecounter. As
+ * timecounter_cyc2time() allows old timestamps, the timecounter
+ * needs to be updated at least once per half of the SYSTIM interval.
+ * Scheduling of delayed work is not very accurate, so we aim for 8
+ * minutes to be sure the actual interval is shorter than 9.16 minutes.
  */
 
-#define IGB_SYSTIM_OVERFLOW_PERIOD	(HZ * 60 * 9)
+#define IGB_SYSTIM_OVERFLOW_PERIOD	(HZ * 60 * 8)
 #define IGB_PTP_TX_TIMEOUT		(HZ * 15)
 #define INCPERIOD_82576			BIT(E1000_TIMINCA_16NS_SHIFT)
 #define INCVALUE_82576_MASK		GENMASK(E1000_TIMINCA_16NS_SHIFT - 1, 0)
-- 
2.20.1



