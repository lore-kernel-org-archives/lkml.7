Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2419BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F033B2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfCVPr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:47:57 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:57763 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfCVPr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:47:56 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MIdaF-1hARKf0n1p-00EbpP; Fri, 22 Mar 2019 16:47:36 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Chen <peter.chen@nxp.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 15/25] usb: gadget: composite: fix dereference after null check coverify warning
Date:   Fri, 22 Mar 2019 16:44:06 +0100
Message-Id: <20190322154425.3852517-16-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UHzL1C8wGGWp8Z6rjDkjmcHGnCq4ZND0jlzDxvJEFDcI4QzSMpX
 dsftbYeAGsMIFPD3UOU5TnyF8SXJLoet5YoGqms2eDMcAbOsUXpW4yNA5pRGqiOk0rbsZLX
 5D2zbCjflsuGo9WxH+hGNkOkmS9hj+qWw3upfwWO8h/HExl2fLpZWc7ZcXE6JHsQ8uRH4fE
 OIe92it/gkA8w2+2FL1Rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v5QA9vpxahI=:qJY+RRUd76611b6rhteEig
 AsQOUp5bSnEEEzkTdVW9NLcXJ5Cq8jB02RvZYy2O0FEFm60pPUsWk0HP4gHBHTehIW+HMAfBy
 AFO84IxV+HvBB+ju/QocvQPTE0nboh4Lk226699EBvWpPMO522ULxsZ8q0zcdCgDh+anExwMt
 +fEk7FN2FKE8FFTvyuyfVLn1HH2xIrm5j0EJUtEq7QVSKCg87HbBzpSB0lBG39gqG3LSlVkc7
 VLcf/9POgw3Ee8TmH6QpPHtz2kzEEiwzWOt8ayKALq9+AjQccqS2zZd59jjXmN+KyJ0eVlwdO
 fMCAPmYmwbp54/xSa9rd4gqTzzPem1W3kVe1zbYso+mutniDwUomwHLYaOiYjAYdj3CSPQQZX
 FQqAoy4zlNCerzTp0cGrfQ8C6suDk/mumdzBu5Ahzo/FKLcM10+kH1/T9R9FL8KeWjRPmEkYK
 o/S7V/RCO8izxzeSE84tMkw1couiEVonzKsUsgKY7ajMrHXp/kAoKoxbsaSmblXpLDjuwD7HL
 mgdj5Gn0hEwp2WHqPHjwLOQXQzyPH/uQH1DC9CjvGZxwWlJb/UyCDUM4y76B7hPEITZLXBKDp
 j+gx9NHB78d7YbNt/QREUwN+tMhxYw07DUhSeb0wfO4wuqGdb4dZHZE301FjRxPa+a6Sy0/hr
 oWHRMlHzgGaJuh7/xSWREO4g1vaeZjEXecO9dmDvbnVjLC2bATUujRZ1jK6huBFaJENLIEsw1
 R+EO3OqdzB67zjhLnWcsvtenpGK96csHQFvcrg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Chen <peter.chen@nxp.com>

cdev->config is checked for null pointer at above code, so cdev->config
might be null, fix it by adding null pointer check.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
(cherry picked from commit c526c62d565ea5a5bba9433f28756079734f430d)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/composite.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 58f5fbdb6959..8bf54477f472 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1819,6 +1819,8 @@ unknown:
 			break;
 
 		case USB_RECIP_ENDPOINT:
+			if (!cdev->config)
+				break;
 			endp = ((w_index & 0x80) >> 3) | (w_index & 0x0f);
 			list_for_each_entry(f, &cdev->config->functions, list) {
 				if (test_bit(endp, f->endpoints))
-- 
2.20.0

