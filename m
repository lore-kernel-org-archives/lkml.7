Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70593C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC1D21901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391678AbfGYLPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:15:08 -0400
Received: from esa01.kjsl.com ([198.137.202.87]:30969 "EHLO esa01.kjsl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388791AbfGYLPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:15:07 -0400
Received: from unknown (HELO people.danlj.org) ([IPv6:2607:7c80:54:5:7609:68e3:940d:b47c])
  by esa01.kjsl.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 11:15:06 +0000
Received: from people.danlj.org (localhost [127.0.0.1])
        by people.danlj.org (8.14.7/8.14.7) with ESMTP id x6PBF5PJ008672
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:15:05 -0400
Received: (from johnsonm@localhost)
        by people.danlj.org (8.14.7/8.15.2/Submit) id x6PBF4XX008671;
        Thu, 25 Jul 2019 07:15:04 -0400
Date:   Thu, 25 Jul 2019 07:15:04 -0400
From:   "Michael K. Johnson" <johnsonm@danlj.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: Add PLL Enable support to internal clock
 setup
Message-ID: <20190725111504.GA8647@people.danlj.org>
References: <20190717023951.5064-1-ben.chuang@genesyslogic.com.tw>
 <CAPDyKFqgTnudMumvrCJqi8FDfNNUU5AedP3hV=hwO1roG336Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqgTnudMumvrCJqi8FDfNNUU5AedP3hV=hwO1roG336Hw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Working around Ben's SMTP server noise, responding on his behalf...)

On Wed, Jul 24, 2019 at 09:19:30AM +0200, Ulf Hansson wrote:
> This looks like it could be changed to an usleep_range(), perhaps an
> additional change on top?
...
> Ditto.

In both cases yes, changed.

> > +       mdelay(1);
> 
> This is new, maybe add a comment and change to usleep_range().

Entirely removed.

New patch attached for any further review, I can re-send the patchset
properly without the notice for merge when you're happy with it.


The GL9750 and GL9755 chipsets, and possibly others, require PLL Enable
setup as part of the internal clock setup as described in 3.2.1 Internal
Clock Setup Sequence of SD Host Controller Simplified Specification
Version 4.20.  This changes the timeouts to the new specification of
150ms for each step and is documented as safe for "prior versions which
do not support PLL Enable."

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 59acf8e3331e..14957578bf2e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1636,8 +1636,8 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 	clk |= SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
-	/* Wait max 20 ms */
-	timeout = ktime_add_ms(ktime_get(), 20);
+	/* Wait max 150 ms */
+	timeout = ktime_add_ms(ktime_get(), 150);
 	while (1) {
 		bool timedout = ktime_after(ktime_get(), timeout);
 
@@ -1650,7 +1650,28 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 			sdhci_dumpregs(host);
 			return;
 		}
-		udelay(10);
+		usleep_range(10,15);
+	}
+
+	clk |= SDHCI_CLOCK_PLL_EN;
+	clk &= ~SDHCI_CLOCK_INT_STABLE;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Wait max 150 ms */
+	timeout = ktime_add_ms(ktime_get(), 150);
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (clk & SDHCI_CLOCK_INT_STABLE)
+			break;
+		if (timedout) {
+			pr_err("%s: PLL clock never stabilised.\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return;
+		}
+		usleep_range(10,15);
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 199712e7adbb..72601a4d2e95 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -114,6 +114,7 @@
 #define  SDHCI_DIV_HI_MASK	0x300
 #define  SDHCI_PROG_CLOCK_MODE	0x0020
 #define  SDHCI_CLOCK_CARD_EN	0x0004
+#define  SDHCI_CLOCK_PLL_EN	0x0008
 #define  SDHCI_CLOCK_INT_STABLE	0x0002
 #define  SDHCI_CLOCK_INT_EN	0x0001
 
