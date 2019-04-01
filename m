Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF015C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9115421924
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138594;
	bh=FPEQc0NoK2Gu22YGzx6DZI1D2fRRXboz2qQ4ywVyfnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UKwgs1+T64iVkKItzwNoWqo3a/4psHbpi10pwrpCT4EyZLbK+U7ub6TzidhZXIfjR
	 mKBLtFxrqTFvFbM4ZHkh2U/gVTky2oNZDx87hkrBPNNpDWt/Hsueldv33TxlwDE+Ah
	 2vJgT6B2xEWI5lwtMPMiQydr0mFaqmB1RPiCQo00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfDARJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729025AbfDARJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:09:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2FBC21924;
        Mon,  1 Apr 2019 17:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138589;
        bh=FPEQc0NoK2Gu22YGzx6DZI1D2fRRXboz2qQ4ywVyfnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2VxjFU74AeMxTSsrZsBkKh9PPTn7cvHDudD/XZJcxTc8RaZfsRBUe6ZEI3O4ONrZM
         lva5vc0es4QwrdXJE8l3ahNv5GmVj875zLFlfIuB30Erzrm2eBzN+uGg8ZpUzYyp64
         F9PH9zbK7IGEInwEDPpFVMSmtJzKXw3tV/vD1MoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madhav Chauhan <madhav.chauhan@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 5.0 110/146] drm/i915/icl: Fix the TRANS_DDI_FUNC_CTL2 bitfield macro
Date:   Mon,  1 Apr 2019 19:02:02 +0200
Message-Id: <20190401170057.835589838@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manasi Navare <manasi.d.navare@intel.com>

commit 69903dfae0310afe8a15f5cd4e376ebb7c6da1d2 upstream.

This patch fixes the PORT_SYNC_MODE_MASTER_SELECT macro
to correctly do the left shifting to set the port sync
master select correctly.
I have tested this fix on ICL.

Fixes: 49edbd49786e ("drm/i915/icl: Define TRANS_DDI_FUNC_CTL DSI registers")
Cc: Madhav Chauhan <madhav.chauhan@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: <stable@vger.kernel.org> # v5.0+
Signed-off-by: Manasi Navare <manasi.d.navare@intel.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190319221847.21311-1-manasi.d.navare@intel.com
(cherry picked from commit 7264aebb81d15aa6bbed650c816bba90f026bc35)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_reg.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -9205,7 +9205,7 @@ enum skl_power_gate {
 #define TRANS_DDI_FUNC_CTL2(tran)	_MMIO_TRANS2(tran, \
 						     _TRANS_DDI_FUNC_CTL2_A)
 #define  PORT_SYNC_MODE_ENABLE			(1 << 4)
-#define  PORT_SYNC_MODE_MASTER_SELECT(x)	((x) < 0)
+#define  PORT_SYNC_MODE_MASTER_SELECT(x)	((x) << 0)
 #define  PORT_SYNC_MODE_MASTER_SELECT_MASK	(0x7 << 0)
 #define  PORT_SYNC_MODE_MASTER_SELECT_SHIFT	0
 


