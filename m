Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B08ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25A521925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263173;
	bh=Hm2bO/RDltKNgb/ZjztRh+l33r259jfwpk6W8oAqsqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pc8j6AO04OaQ63m1o5yivFwGr3t0So/mcehhgHAE9uZJ4H//qaPGqq7dBmyrpBBVj
	 D6+Ddtegj9aV0CrggQ4JLK5LQW/U638PI3MlwEhh0SBj9AZuNrzzdetpO/Zd77Hqsi
	 DC3yzPR5AsWteM1lQzbR+71k+4cVASvZmV8eOLrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438539AbfJPV7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438164AbfJPV6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:30 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B586D21925;
        Wed, 16 Oct 2019 21:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263109;
        bh=Hm2bO/RDltKNgb/ZjztRh+l33r259jfwpk6W8oAqsqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYpZMmW4ZociwpWybXflDqYDcA/+yG0TG3zQNNbQcYXC4JM5u+1f44b4I0UzEu4F7
         25ElEoQgm8qKU4fF/xCAYr8SpbxUl6LG5U9Db3UTYLhz3mGxkvePELU2ZbLCPKjYIz
         qJRlU4naJ8f5RM7hdIxcvz0Ns4OwX0ZNllyVF33o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacky Cao <Jacky.Cao@sony.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 5.3 033/112] USB: dummy-hcd: fix power budget for SuperSpeed mode
Date:   Wed, 16 Oct 2019 14:50:25 -0700
Message-Id: <20191016214853.416181811@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky.Cao@sony.com <Jacky.Cao@sony.com>

commit 2636d49b64671d3d90ecc4daf971b58df3956519 upstream.

The power budget for SuperSpeed mode should be 900 mA
according to USB specification, so set the power budget
to 900mA for dummy_start_ss which is only used for
SuperSpeed mode.

If the max power consumption of SuperSpeed device is
larger than 500 mA, insufficient available bus power
error happens in usb_choose_configuration function
when the device connects to dummy hcd.

Signed-off-by: Jacky Cao <Jacky.Cao@sony.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/16EA1F625E922C43B00B9D82250220500871CDE5@APYOKXMS108.ap.sony.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/dummy_hcd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -48,6 +48,7 @@
 #define DRIVER_VERSION	"02 May 2005"
 
 #define POWER_BUDGET	500	/* in mA; use 8 for low-power port testing */
+#define POWER_BUDGET_3	900	/* in mA */
 
 static const char	driver_name[] = "dummy_hcd";
 static const char	driver_desc[] = "USB Host+Gadget Emulator";
@@ -2432,7 +2433,7 @@ static int dummy_start_ss(struct dummy_h
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep = 0;
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
-	dummy_hcd_to_hcd(dum_hcd)->power_budget = POWER_BUDGET;
+	dummy_hcd_to_hcd(dum_hcd)->power_budget = POWER_BUDGET_3;
 	dummy_hcd_to_hcd(dum_hcd)->state = HC_STATE_RUNNING;
 	dummy_hcd_to_hcd(dum_hcd)->uses_new_polling = 1;
 #ifdef CONFIG_USB_OTG


