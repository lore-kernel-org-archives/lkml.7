Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F810C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0574C2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802686;
	bh=rjddxsjkbCSnuJKV0HAoHUNmScnWMLNIN/aIj+jKF10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IxJTUij+GdzsEwPWgnePQZ6dthcgYoLUbPBA1mN/ZK20N/LVI2uvnEar5ADfwc3b+
	 4lkgxejv15Lb2mTc9uBv2D/9u9vWq3i4yTyU7jwzQ8NHw4khlp/59ZCFmOIac4YZ9b
	 z0YZoOAeUWLRw6+IUHgTz/xwUz6Cg5uZd1Krbpc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfHNRLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730579AbfHNRLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:11:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32CBF2084D;
        Wed, 14 Aug 2019 17:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802679;
        bh=rjddxsjkbCSnuJKV0HAoHUNmScnWMLNIN/aIj+jKF10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2jGM1++9BeRhiZlqXi6tTd81y0CF8ruAqpgi+HlEnLyXFVpI4x0ocq4WAiXI2qZ3y
         sW1b8uZoBd+6u8DS7b2484ok8zyXenjZGGsgDHz56O+Yk3Wf0t8GZZhL5aV1np0oNV
         brhtjKdu5ua8pd42A5xoDQv5tj89Rm4PeWnD7BcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Vandita Kulkarni <vandita.kulkarni@intel.com>,
        Deepak M <m.deepak@intel.com>,
        Madhav Chauhan <madhav.chauhan@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH 4.19 76/91] drm/i915: Fix wrong escape clock divisor init for GLK
Date:   Wed, 14 Aug 2019 19:01:39 +0200
Message-Id: <20190814165753.012400453@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165748.991235624@linuxfoundation.org>
References: <20190814165748.991235624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>

commit 73a0ff0b30af79bf0303d557eb82f1d1945bb6ee upstream.

According to Bspec clock divisor registers in GeminiLake
should be initialized by shifting 1(<<) to amount of correspondent
divisor. While i915 was writing all this time that value as is.

Surprisingly that it by accident worked, until we met some issues
with Microtech Etab.

v2: Added Fixes tag and cc
v3: Added stable to cc as well.

Signed-off-by: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
Reviewed-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=108826
Fixes: bcc657004841 ("drm/i915/glk: Program txesc clock divider for GLK")
Cc: Deepak M <m.deepak@intel.com>
Cc: Madhav Chauhan <madhav.chauhan@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190712081938.14185-1-stanislav.lisovskiy@intel.com
(cherry picked from commit ce52ad5dd52cfaf3398058384e0ff94134bbd89c)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/vlv_dsi_pll.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/vlv_dsi_pll.c
+++ b/drivers/gpu/drm/i915/vlv_dsi_pll.c
@@ -413,8 +413,8 @@ static void glk_dsi_program_esc_clock(st
 	else
 		txesc2_div = 10;
 
-	I915_WRITE(MIPIO_TXESC_CLK_DIV1, txesc1_div & GLK_TX_ESC_CLK_DIV1_MASK);
-	I915_WRITE(MIPIO_TXESC_CLK_DIV2, txesc2_div & GLK_TX_ESC_CLK_DIV2_MASK);
+	I915_WRITE(MIPIO_TXESC_CLK_DIV1, (1 << (txesc1_div - 1)) & GLK_TX_ESC_CLK_DIV1_MASK);
+	I915_WRITE(MIPIO_TXESC_CLK_DIV2, (1 << (txesc2_div - 1)) & GLK_TX_ESC_CLK_DIV2_MASK);
 }
 
 /* Program BXT Mipi clocks and dividers */


