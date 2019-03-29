Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8C2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74FD217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hnisAFtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfC2Vzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:55:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41980 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfC2Vzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:55:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id y5so1619433plk.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 14:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ecc389FYQ0L59bBTC8JbGTFUcbTIY5rYmXWozIAY7B4=;
        b=hnisAFtR/2zxLT/Jp/D+xocLkDC5DbBCrBqQd1WlPOllJVYBmrOsvIlBy2t0MkoFst
         /AdTOTF4vVNZVzBuIHXNgFku7pSkultEU3AM5taXmGWgPSCbRNEnRu8me7EUPTBQVbCs
         AGBgehOsiQKtwGT+s7caWz7dhIyLweX7iSqfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ecc389FYQ0L59bBTC8JbGTFUcbTIY5rYmXWozIAY7B4=;
        b=oIowSS5Z5f4hwYCPYzBzmrZXbfWOluR07ruZvlFe8lMYIbpl4kQhZnFPJciYYAVtdi
         CM8b8sowwW36eI+5fvNSGbOelIkNa4JjqCztmSniJJ583i3a4+GaowuvxWv3zA0uvfby
         dlWAu1GGegwq5CJLsab79sbmE3fYPPVsQhmEP0NO2SQXE2GpKw8nOxq8WaLNm05Fe83E
         0oHKHn85LPpvMK/k0WJ2p2PWFBeH6rl5d2RkxG6+GOsqIYWxZd7ybskEo7irQXzRQvAT
         cd+XvTsHCKeYdRMELUbvxDqIWXR8uFVFwuOqLLzuuFAgN66wRwWGxBrgnVEz8Q8Jn1iK
         5MRQ==
X-Gm-Message-State: APjAAAW6+Iv2ZTKYrD4CdiaX+h6cYNLIG/jBiumk6QzezeaVAuZqh0Zv
        13Vlmdm/0PESELmYzwhLt5MtnA==
X-Google-Smtp-Source: APXvYqzS56Wdd5AWjHRFithraHo+bIHKtALoqOiZvTC3cbnpcBptYR/yiu6zV7xXACzJgcbuF9StdQ==
X-Received: by 2002:a17:902:b618:: with SMTP id b24mr48434370pls.73.1553896534506;
        Fri, 29 Mar 2019 14:55:34 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 20sm4301146pfn.131.2019.03.29.14.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 14:55:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Ziyuan Xu <xzy.xu@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        ryandcase@chromium.org, Elaine Zhang <zhangqing@rock-chips.com>,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clk: rockchip: Fix video codec clocks on rk3288
Date:   Fri, 29 Mar 2019 14:54:55 -0700
Message-Id: <20190329215455.159717-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that there is a typo in the rk3288 TRM.  For
GRF_SOC_CON0[7] it says that 0 means "vepu" and 1 means "vdpu".  It's
the other way around.

How do I know?  Here's my evidence:

1. Prior to commit 4d3e84f99628 ("clk: rockchip: describe aclk_vcodec
   using the new muxgrf type on rk3288") we always pretended that we
   were using "aclk_vdpu" and the comment in the code said that this
   matched the default setting in the system.  In fact the default
   setting is 0 according to the TRM and according to reading memory
   at bootup.  In addition rk3288-based Chromebooks ran like this and
   the video codecs worked.
2. With the existing clock code if you boot up and try to enable the
   new VIDEO_ROCKCHIP_VPU as a module (and without "clk_ignore_unused"
   on the command line), you get errors like "failed to get ack on
   domain 'pd_video', val=0x80208".  After flipping vepu/vdpu things
   init OK.
3. If I export and add both the vepu and vdpu to the list of clocks
   for RK3288_PD_VIDEO I can get past the power domain errors, but now
   I freeze when the vpu_mmu gets initted.
4. If I just mark the "vdpu" as IGNORE_UNUSED then everything boots up
   and probes OK showing that somehow the "vdpu" was important to keep
   enabled.  This is because we were actually using it as a parent.
5. After this change I can hack "aclk_vcodec_pre" to parent from
   "aclk_vepu" using assigned-clocks and the video codec still probes
   OK.

Fixes: 4d3e84f99628 ("clk: rockchip: describe aclk_vcodec using the new muxgrf type on rk3288")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I currently have no way to test the JPEG mem2mem driver, so hopefully
others can test this and make sure it's happy for them.  I'm just
happy not to get strange errors at boot anymore.

 drivers/clk/rockchip/clk-rk3288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 5a67b7869960..4d767f9c3a80 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -219,7 +219,7 @@ PNAME(mux_hsadcout_p)	= { "hsadc_src", "ext_hsadc" };
 PNAME(mux_edp_24m_p)	= { "ext_edp_24m", "xin24m" };
 PNAME(mux_tspout_p)	= { "cpll", "gpll", "npll", "xin27m" };
 
-PNAME(mux_aclk_vcodec_pre_p)	= { "aclk_vepu", "aclk_vdpu" };
+PNAME(mux_aclk_vcodec_pre_p)	= { "aclk_vdpu", "aclk_vepu" };
 PNAME(mux_usbphy480m_p)		= { "sclk_otgphy1_480m", "sclk_otgphy2_480m",
 				    "sclk_otgphy0_480m" };
 PNAME(mux_hsicphy480m_p)	= { "cpll", "gpll", "usbphy480m_src" };
-- 
2.21.0.392.gf8f6787159e-goog

