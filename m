Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D536CFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA8F207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214521;
	bh=Ue3nlCV9pACY7BcNK5tekycybXDU3j44z/a2CvMlZ5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B0S3nlHE670ZpdRRWJdiiMwMyFCEyZkFgskQ1xXXg5UYmQ7PN7DrtbStoi9wFdYjW
	 4fbxlLcc7hw4zF/z1nT62N2i33FiJhwvaxfDqonyb6fLwwEMe5BWX4sp5J+eT4FvI9
	 /72Glg5uDwNfMIn3VxonPMg7Kx8YThWfJmB7z0R8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391814AbfKHMCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:02:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389767AbfKHLn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:43:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C0CF222CB;
        Fri,  8 Nov 2019 11:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213408;
        bh=Ue3nlCV9pACY7BcNK5tekycybXDU3j44z/a2CvMlZ5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PsfxcNKW/3daXJMb9KfoopyJ7fdmNtUbzW99kN/K8aJESm0iG14/DsDq/xWiY29gC
         fPbRQtbUrOBTbRtNyZcre9hwnbW6IYH1ancppGpOEGTKiTfa4MgsGk3nBdmw5grZ6H
         kB6LZIEnvqYzhsLi5k5kWdjQ5rgEQqLieZTLLMHM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 012/103] extcon: cht-wc: Return from default case to avoid warnings
Date:   Fri,  8 Nov 2019 06:41:37 -0500
Message-Id: <20191108114310.14363-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 962341b54b99965ebec5f70c8d39f1c382eea833 ]

When we have first case to fall through it's not enough to put
single comment there to satisfy compiler. Instead of doing that,
return fall back value directly from default case.

This to avoid following warnings:

drivers/extcon/extcon-intel-cht-wc.c: In function ‘cht_wc_extcon_get_charger’:
include/linux/device.h:1420:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/extcon/extcon-intel-cht-wc.c:148:3: note: in expansion of macro ‘dev_warn’
   dev_warn(ext->dev,
   ^~~~~~~~
drivers/extcon/extcon-intel-cht-wc.c:152:2: note: here
  case CHT_WC_USBSRC_TYPE_SDP:
  ^~~~

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/extcon/extcon-intel-cht-wc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 60baaf6931032..c562d9d69ae39 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -155,7 +155,7 @@ static int cht_wc_extcon_get_charger(struct cht_wc_extcon_data *ext,
 		dev_warn(ext->dev,
 			"Unhandled charger type %d, defaulting to SDP\n",
 			 ret);
-		/* Fall through, treat as SDP */
+		return EXTCON_CHG_USB_SDP;
 	case CHT_WC_USBSRC_TYPE_SDP:
 	case CHT_WC_USBSRC_TYPE_FLOAT_DP_DN:
 	case CHT_WC_USBSRC_TYPE_OTHER:
-- 
2.20.1

