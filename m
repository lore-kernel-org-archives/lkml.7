Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE56C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38C420685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555940230;
	bh=ieX3eiRlLynF1/XO41R8r7roPVd5yucj40+FiBRbaSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q7Qq7n1ZhARVVT+8FY6TyMGGVCsoH3Tpk9vi0BoDhUNGaFHGeNu9rDgBXnDwCTPoV
	 fyABwk2SF9uPa9jyE/7qwRRyWST83o6Xj42nB8K6qZ3b1WcdLDVG38jEtSc+OT716D
	 0dfBiB9T+mihl2Vp+E1NdT3mdpLD/Z/JAadmgAYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfDVNhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:37:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfDVN2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l3+QQr+EjFlRAldxJVDW4gRFR5sdBmKFqWAZkocg8xs=; b=lJRg2Ey9VuJMHDaM95xWfOK/VU
        71Rtswr9/BcKtNlDG/1nIC+at1I73jkD+OE4VKlWeU6WuZdCyBmny4z5C8Rxg0ahm6H7fsZv2lUgB
        dey61wRY7BUWGiLkgkGWYyk82i/3IYCrf1Jn4ni92tlCpYYFxgg6Eev1gk0mQTvXozK5CI3rTLfqU
        Ow3d9kyVRTf1Y4q6qQtyRAZkq1UcZgEF0/Mh/HnuH6+nxKu9MyNWm51dCQ0Bk1sHqfTM47U1NAZD6
        0n/Jd7CP6OZiduAoQnwbueXUEPM0M18Mj+MFgo+RrLhZ+BAgT/3BFOENapFPQ8yhdDYskrPh+cnF2
        5lcNAN7w==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIYzV-0005Hs-BR; Mon, 22 Apr 2019 13:28:13 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hIYzT-0005lg-38; Mon, 22 Apr 2019 10:28:11 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH v2 28/79] docs: ptp.txt: convert to ReST and move to driver-api
Date:   Mon, 22 Apr 2019 10:27:17 -0300
Message-Id: <21d7862dfaaa7a587469aacf7b8a2e55cf705bfd.1555938376.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555938375.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion is trivial: just adjust title markups.

In order to avoid conflicts, let's add an :orphan: tag
to it, to be removed when this file gets added to the
driver-api book.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../{ptp/ptp.txt => driver-api/ptp.rst}       | 26 +++++++++++++------
 Documentation/networking/timestamping.txt     |  2 +-
 MAINTAINERS                                   |  2 +-
 3 files changed, 20 insertions(+), 10 deletions(-)
 rename Documentation/{ptp/ptp.txt => driver-api/ptp.rst} (88%)

diff --git a/Documentation/ptp/ptp.txt b/Documentation/driver-api/ptp.rst
similarity index 88%
rename from Documentation/ptp/ptp.txt
rename to Documentation/driver-api/ptp.rst
index 11e904ee073f..b6e65d66d37a 100644
--- a/Documentation/ptp/ptp.txt
+++ b/Documentation/driver-api/ptp.rst
@@ -1,5 +1,8 @@
+:orphan:
 
-* PTP hardware clock infrastructure for Linux
+===========================================
+PTP hardware clock infrastructure for Linux
+===========================================
 
   This patch set introduces support for IEEE 1588 PTP clocks in
   Linux. Together with the SO_TIMESTAMPING socket options, this
@@ -22,7 +25,8 @@
     - Period output signals configurable from user space
     - Synchronization of the Linux system time via the PPS subsystem
 
-** PTP hardware clock kernel API
+PTP hardware clock kernel API
+=============================
 
    A PTP clock driver registers itself with the class driver. The
    class driver handles all of the dealings with user space. The
@@ -36,7 +40,8 @@
    development, it can be useful to have more than one clock in a
    single system, in order to allow performance comparisons.
 
-** PTP hardware clock user space API
+PTP hardware clock user space API
+=================================
 
    The class driver also creates a character device for each
    registered clock. User space can use an open file descriptor from
@@ -49,7 +54,8 @@
    ancillary clock features. User space can receive time stamped
    events via blocking read() and poll().
 
-** Writing clock drivers
+Writing clock drivers
+=====================
 
    Clock drivers include include/linux/ptp_clock_kernel.h and register
    themselves by presenting a 'struct ptp_clock_info' to the
@@ -66,14 +72,17 @@
    class driver, since the lock may also be needed by the clock
    driver's interrupt service routine.
 
-** Supported hardware
+Supported hardware
+==================
+
+   * Freescale eTSEC gianfar
 
-   + Freescale eTSEC gianfar
      - 2 Time stamp external triggers, programmable polarity (opt. interrupt)
      - 2 Alarm registers (optional interrupt)
      - 3 Periodic signals (optional interrupt)
 
-   + National DP83640
+   * National DP83640
+
      - 6 GPIOs programmable as inputs or outputs
      - 6 GPIOs with dedicated functions (LED/JTAG/clock) can also be
        used as general inputs or outputs
@@ -81,6 +90,7 @@
      - GPIO outputs can produce periodic signals
      - 1 interrupt pin
 
-   + Intel IXP465
+   * Intel IXP465
+
      - Auxiliary Slave/Master Mode Snapshot (optional interrupt)
      - Target Time (optional interrupt)
diff --git a/Documentation/networking/timestamping.txt b/Documentation/networking/timestamping.txt
index bbdaf8990031..8dd6333c3270 100644
--- a/Documentation/networking/timestamping.txt
+++ b/Documentation/networking/timestamping.txt
@@ -368,7 +368,7 @@ ts[1] used to hold hardware timestamps converted to system time.
 Instead, expose the hardware clock device on the NIC directly as
 a HW PTP clock source, to allow time conversion in userspace and
 optionally synchronize system time with a userspace PTP stack such
-as linuxptp. For the PTP clock API, see Documentation/ptp/ptp.txt.
+as linuxptp. For the PTP clock API, see Documentation/driver-api/ptp.rst.
 
 Note that if the SO_TIMESTAMP or SO_TIMESTAMPNS option is enabled
 together with SO_TIMESTAMPING using SOF_TIMESTAMPING_SOFTWARE, a false
diff --git a/MAINTAINERS b/MAINTAINERS
index be3d80397956..e4c26dc67668 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12649,7 +12649,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 W:	http://linuxptp.sourceforge.net/
 F:	Documentation/ABI/testing/sysfs-ptp
-F:	Documentation/ptp/*
+F:	Documentation/driver-api/ptp.rst
 F:	drivers/net/phy/dp83640*
 F:	drivers/ptp/*
 F:	include/linux/ptp_cl*
-- 
2.20.1

