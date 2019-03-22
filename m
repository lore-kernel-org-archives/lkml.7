Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C17C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEE32183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfCVPrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:47:06 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36445 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfCVPrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:47:04 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N2E5Q-1h0ShS0wrm-013iJA; Fri, 22 Mar 2019 16:46:48 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Roger Quadros <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 09/25] usb: dwc3: gadget: Fix suspend/resume during device mode
Date:   Fri, 22 Mar 2019 16:44:00 +0100
Message-Id: <20190322154425.3852517-10-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Wa0NxvaJKz9beWWyK1EmT1GXc1pQUSQRbNYzwZGpDAvrUmOYVYT
 q3CqinTh9aDABHa0qxK1R/HCGB1KbBMcCZ4Fe1UqQp5zRwBy19SpIOItH5dEX2pbxKvSgFF
 2bis02UUdwIjepEi2xBbwSpJ2hFx4+nLB5QVIycTDOHVWwD2Kh6XJ9KNymAD3uVFz0ZGpZ2
 Ce7OEFixLoPZbyvrHwDIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CS48oms4k5w=:vp39lAbh7N7UOKpIVgtHb2
 5g3ykR086ja1JLlNtCrAgvl2QwLdKiCbRBfYNF21ciOKlMv17WPa/537erZMitBhSNwPXm99A
 2gTX0rvmrp/+4haUYR7bUKtb6c0Uo70r28JLpE4DHPmV64B/o7b1E/6WV5raNX+Pi4vq7pFHJ
 2ueU8xm7rlF4d4Wyw/BzvJEuoAh3jzFCEUHRcJ4YJTGaGNFFqUMtwfOVDFvFU6lezU4drF54V
 Xnljq9Cz4tk2xij/jD+c+J5K8Ie3CrVilqDi4RL1DWWg0gUSpmvSkLTPZhr+sraqXTkEwAcKi
 hfoYCuQAsBA+lWOit8/PvhWaNiFgE5LBVMa/zvUmc5zBakF+JBnzTljv4B3WRpiGOJt9QacLk
 bt00+6NwA7CqNo/mRJiL4ST4bx1PdxmcwSzHhWmheyqkA8zwOJlh+NiWZyhPKFcvmfJ27F4JT
 vcyWAh86VImTYLsdCt/l7sqRIqryRFcic6vmAEYX/4g/iPtx8IexKcdLC2yNLUlTdE9gL4mXd
 OYvIjDi2wZYhMXFGgc63x4qofteLKsVRCwe8K6EvHCxCfuGrkkc4AqfN6XDBWMDFQaH3cdKzr
 gyn+hwdDyFlcKsQBNyvEi4vMZMmFVLlLGHQX2HP1A3vpC+FaMz+mKIhcccq2oUnRuLSIN1aHR
 TE3uxZc/aobrU7F67dA3cElJF1c8fyZbTf1LUHmdli6Up4I65GBtpbWHKO7fDozQBN0O2qpOF
 7CvpTRWDpELhDEzviXhKRn7v5bnqcPqhnVYrNg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

Gadget controller might not be always active during system
suspend/resume as gadget driver might not have yet been loaded or
might have been unloaded prior to system suspend.

Check if we're active and only then perform
necessary actions during suspend/resume.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
(cherry picked from commit 9772b47a4c2916d645c551228b6085ea24acbe5d)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/dwc3/gadget.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b6037a0ae829..58e67c228971 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2893,6 +2893,9 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
+	if (!dwc->gadget_driver)
+		return 0;
+
 	if (dwc->pullups_connected) {
 		dwc3_gadget_disable_irq(dwc);
 		dwc3_gadget_run_stop(dwc, true, true);
@@ -2911,6 +2914,9 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 	struct dwc3_ep		*dep;
 	int			ret;
 
+	if (!dwc->gadget_driver)
+		return 0;
+
 	/* Start with SuperSpeed Default */
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
-- 
2.20.0

