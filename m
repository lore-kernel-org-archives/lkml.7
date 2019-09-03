Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D412DC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2A023878
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567527928;
	bh=YaelBjv9CrC3Jq0WoYTd+rflT0fewMxLIJgPOZWkLcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pMasLTbTQarG0XT0na4R7m51D09dY4CnbXHt+1+IJXsdD2pdkoYTRIAKqvY1KYrEI
	 +n3uaxybamqBScnUzCYtKuvJzUzPf4VclsK02cG35sC9qsl2+Oh3lrxQ7cgzMM0eKI
	 z7BkR1syjqkU0WIFiPY6ylfeH1UOn7wIxw1ieMsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbfICQZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730322AbfICQZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:25:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19B0A2343A;
        Tue,  3 Sep 2019 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567527915;
        bh=YaelBjv9CrC3Jq0WoYTd+rflT0fewMxLIJgPOZWkLcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yThhcpjJ9ttmo1oTs1wt3c1R1/rgO50Rn6XiBjbSuPsRQNsefJ7r7grfFCqU/Uf2Q
         uAhnpQsOnf0ThglT40I+UYN58AItz17Y0XZfWvWaSIaZeB7x8tZSD6xrXYkropFo6D
         RRt7hPu+Wd4eT2Zb/wiZllOuZB/pTqhGafpgaWXk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Anuj Phogat <anuj.phogat@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 23/23] drm/i915/icl: whitelist PS_(DEPTH|INVOCATION)_COUNT
Date:   Tue,  3 Sep 2019 12:24:24 -0400
Message-Id: <20190903162424.6877-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162424.6877-1-sashal@kernel.org>
References: <20190903162424.6877-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lionel Landwerlin <lionel.g.landwerlin@intel.com>

[ Upstream commit cf8f9aa1eda7d916bd23f6b8c226404deb11690c ]

The same tests failing on CFL+ platforms are also failing on ICL.
Documentation doesn't list the
WaAllowPMDepthAndInvocationCountAccessFromUMD workaround for ICL but
applying it fixes the same tests as CFL.

v2: Use only one whitelist entry (Lionel)

Signed-off-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Tested-by: Anuj Phogat <anuj.phogat@gmail.com>
Cc: stable@vger.kernel.org # 6883eab27481: drm/i915: Support flags in whitlist WAs
Cc: stable@vger.kernel.org
Acked-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20190628120720.21682-4-lionel.g.landwerlin@intel.com
(cherry picked from commit 3fe0107e45ab396342497e06b8924cdd485cde3b)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/intel_workarounds.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/i915/intel_workarounds.c b/drivers/gpu/drm/i915/intel_workarounds.c
index efea5a18fa6db..edd57a5e0495f 100644
--- a/drivers/gpu/drm/i915/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/intel_workarounds.c
@@ -1107,6 +1107,19 @@ static void icl_whitelist_build(struct intel_engine_cs *engine)
 
 		/* WaEnableStateCacheRedirectToCS:icl */
 		whitelist_reg(w, GEN9_SLICE_COMMON_ECO_CHICKEN1);
+
+		/*
+		 * WaAllowPMDepthAndInvocationCountAccessFromUMD:icl
+		 *
+		 * This covers 4 register which are next to one another :
+		 *   - PS_INVOCATION_COUNT
+		 *   - PS_INVOCATION_COUNT_UDW
+		 *   - PS_DEPTH_COUNT
+		 *   - PS_DEPTH_COUNT_UDW
+		 */
+		whitelist_reg_ext(w, PS_INVOCATION_COUNT,
+				  RING_FORCE_TO_NONPRIV_RD |
+				  RING_FORCE_TO_NONPRIV_RANGE_4);
 		break;
 
 	case VIDEO_DECODE_CLASS:
-- 
2.20.1

