Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735C1C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 04:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCED206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 04:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="dDRq5svS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbfJJEh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 00:37:26 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:3586 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfJJEhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 00:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570682245; x=1602218245;
  h=from:to:cc:subject:date:message-id;
  bh=Qglj1z/rVFrSvjj0s8+qncgzWBHeOEvd87vRgzQFxfQ=;
  b=dDRq5svSVuJDpW/2PmZ1sZh6gBKPxYLeybWsRm3fw3H2PuHpi78AvKEn
   GZT9th6MgGPRowUlyQ6VUCXgpZ62JZ88AcTO4h5ykpMeZ/gYo9DHPN0q/
   0t+kIPbKaAIkVCfl+Pzix74+epiZAkVQ1ceOWU2LlUlz66OHTbZfuiET6
   3nuGd3u7cXFVizB3wlrr0ozQ1DVjSRkGJ9L+AUA1WChWEhnnCAaH1OtIA
   UkSJbo4BRLGijVS+RHJfR69PX/t5OeMuonbcZfwEcimNcfJpQ+QgkgRFj
   I2f1rkXbm024k7HnXxM2G/4rpZ0rK98WvrtLYzmunJtZwCvoARi9rEyme
   A==;
IronPort-SDR: sH0t18O0OqK10eP2OGIbFWNf0uyPEXgQ19U+6Fzb7utDKEhm4+7Oiv/lCJhWX3PkHzDjcwV12s
 jfLywTkLu05qsf1uNSuA3hthTxrzHwrELxFrCRQ1oFyhZU+tCaZZmSQk2r4+68fsP9mJy3wBUG
 geHwnVVBw20ns+hHdXQ+lqlEMHeQjo8VN3W0byQoHnXWhL0EzcMJzmbO+EUGxsWLnwnu2QpHov
 g0dIGWNBVMFWEgQduaFLhwafHMAyTso8BHjXi7FDND65dh6VOzwC4Poe7khvEO29jOjOCIDZyy
 R24=
IronPort-PHdr: =?us-ascii?q?9a23=3AWW/WFRBA94xYO51nJO2LUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPT6rsbcNUDSrc9gkEXOFd2Cra4d0KyI6euwByQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+NhS7oRveusQVgIZpN7o8xA?=
 =?us-ascii?q?bOrnZUYepd2HlmJUiUnxby58ew+IBs/iFNsP8/9MBOTLv3cb0gQbNXEDopPW?=
 =?us-ascii?q?Y15Nb2tRbYVguA+mEcUmQNnRVWBQXO8Qz3UY3wsiv+sep9xTWaMMjrRr06RT?=
 =?us-ascii?q?iu86FmQwLzhSwZKzA27n3Yis1ojKJavh2hoQB/w5XJa42RLfZyY7/Rcc8fSW?=
 =?us-ascii?q?dHW8ZRVjdBApi9b4sJAOoKIPhWoZDgrFsArBuxGw2sC/7ywTNMiHL6wag23u?=
 =?us-ascii?q?ImHgza0gEsA88CvG3IoNnoKaweVf25wanNwTjFcvhY2yry6JLQfx4hv/+CQL?=
 =?us-ascii?q?x+f8nWx0Q0Cw/Jkk+dpZD/Mj+JyugAtXWQ4ep6VeKojm4qswN+ojmux8csl4?=
 =?us-ascii?q?nJgZ8ex1fE9CR4wIY6P9y4RFJnbdOqC5ZQqj2VN5FsTsw8Xm5opT83x7sbsp?=
 =?us-ascii?q?C4ZCgH0IorywLbZvCdcIWF4gjvWPiMLTp3nn5pZbayihWq/US9y+DxUtO43E?=
 =?us-ascii?q?hEoydFiNXAqHEA2wbR58WITPZ2412v1iyV1w/J7+FJOUU0la3GJJE/2rMwjZ?=
 =?us-ascii?q?8TsVjbHi/xhUX2kLeadkU69eis7OTqerDmqYWdN49wkw3+KqAultGmDeQ2Lw?=
 =?us-ascii?q?QDW2uW9f6z1L3k+k35T7FKgeMsnqbFt5DaINwXpq+/AwBLzoYu8wizAyui3d?=
 =?us-ascii?q?gCnnQKLEhJdAyag4XmIV3CPfT1APSnj1SpijhrxvTGPrP7ApXKK3jOiLfgfL?=
 =?us-ascii?q?d960FGyQo/0cxT6pxPB7EcPP3zQFX9u8LFAR8kKwC02froCM1h1oMCXmKCGq?=
 =?us-ascii?q?uZMKLUsV+V6eMjOuqMa5EPuDb7Nfcl4+XjjWE2mVADZ6mlx5gXZ26iHvRgPU?=
 =?us-ascii?q?qZZWDggtAbEWcF7UIQVuvv3WyDQz5OYD7mTrA87zBjUNmOEIzZAI2hnerSj2?=
 =?us-ascii?q?+AApRKazUeWRi3GnDyetDBBqoB?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HSCgDHtJ5dhsbWVdFlHgELHIFwC4N?=
 =?us-ascii?q?fTBCNJYYqAQEGiykYcYV6ijABCAEBAQwBAS0CAQGEQIJUIzcGDgIDCQEBBQE?=
 =?us-ascii?q?BAQEBBQQBAQIQAQEBCAsLCCmFQII6KYM1CxZngRUBBQE1IjmCRwGCUiUFpD+?=
 =?us-ascii?q?BAzyMWIhmAQkNgUgJAQiBIoc1hFmBEIEHhGGEDYNZgkoEgTkBAQGVL5ZXAQY?=
 =?us-ascii?q?CghAUgXiTFSeEPIk/i0QBp2MCCgcGDyOBRYF8TSWBbAqBRFAQFIFbDgmOQyE?=
 =?us-ascii?q?zgQiNP4JUAQ?=
X-IPAS-Result: =?us-ascii?q?A2HSCgDHtJ5dhsbWVdFlHgELHIFwC4NfTBCNJYYqAQEGi?=
 =?us-ascii?q?ykYcYV6ijABCAEBAQwBAS0CAQGEQIJUIzcGDgIDCQEBBQEBAQEBBQQBAQIQA?=
 =?us-ascii?q?QEBCAsLCCmFQII6KYM1CxZngRUBBQE1IjmCRwGCUiUFpD+BAzyMWIhmAQkNg?=
 =?us-ascii?q?UgJAQiBIoc1hFmBEIEHhGGEDYNZgkoEgTkBAQGVL5ZXAQYCghAUgXiTFSeEP?=
 =?us-ascii?q?Ik/i0QBp2MCCgcGDyOBRYF8TSWBbAqBRFAQFIFbDgmOQyEzgQiNP4JUAQ?=
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="81371076"
Received: from mail-pl1-f198.google.com ([209.85.214.198])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2019 21:37:24 -0700
Received: by mail-pl1-f198.google.com with SMTP id y2so3051365plk.19
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 21:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z2jlPo7cNUsYiJLA96HLY+XLNur36/5ee7Rqvg0uC5E=;
        b=dNTKilwDzbCkPDITRIkLdIhaasmpL4sg3dWkpX64tyrjqZU8yeNkhiQZAfrNppyhsO
         HiKQGpa4g0ccHVwBwjRQdT4hBsLhsGBM8CSn9Yg0i34jv2VoIreiE9vKHxVTzcTX3eDk
         mAJeur8XgQnRq5qeffS3aYv1SZjLlg6b42WuO2VXiLW6rfwPUuPXm4Gkkj/y0B/0UG+c
         jr7nnMtONXqzItjHXrgjkk+/F9pq8rQza/Z7l8Q/SfEw+XFXu5uQtsbzPrbgVyhcrnvH
         njkvkSjkpg4zEKVVTN1mvFe0Mjwq6LuXWd53ghMOPQWWebxWjI3TJ1aLNaecQFWYSiRF
         rW1w==
X-Gm-Message-State: APjAAAXioxzJHyIeDH9MUzjq4OVjWynFs2pM0BLgKQsMHb3hvA3OchK7
        dNy71s8Eb/eYuBjpR/5IMWmmNIeQjoJcLguYzXQ0tbY1CystbarnlbcRGGzA9Xz+LEvsLB7a0+l
        v2TbblWjwZDeuUF2ctuIjGZnCLg==
X-Received: by 2002:a63:f908:: with SMTP id h8mr8409110pgi.244.1570682243561;
        Wed, 09 Oct 2019 21:37:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzHyOtObFJngENmZ9WtxzkJ1f8WRSs7XqzpzG4G5O/ox5y97nK3RVIhkAPkPbp3dMBqdu0v/w==
X-Received: by 2002:a63:f908:: with SMTP id h8mr8409069pgi.244.1570682243138;
        Wed, 09 Oct 2019 21:37:23 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id g12sm6544968pfb.97.2019.10.09.21.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:37:22 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     Yizhuo <yzhai003@ucr.edu>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: Potential uninitialized field in "pll"
Date:   Wed,  9 Oct 2019 21:38:08 -0700
Message-Id: <20191010043809.27594-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function set_chip_clock(), struct pll is supposed to be
initialized in sm750_calc_pll_value(), if condition
"diff < mini_diff" in sm750_calc_pll_value() cannot be fulfilled,
then some field of pll will not be initialized but used in
function sm750_format_pll_reg(), which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/staging/sm750fb/ddk750_chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 5a317cc98a4b..31b3cf9c2d8b 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -55,7 +55,7 @@ static unsigned int get_mxclk_freq(void)
  */
 static void set_chip_clock(unsigned int frequency)
 {
-	struct pll_value pll;
+	struct pll_value pll = {};
 	unsigned int actual_mx_clk;
 
 	/* Cheok_0509: For SM750LE, the chip clock is fixed. Nothing to set. */
-- 
2.17.1

