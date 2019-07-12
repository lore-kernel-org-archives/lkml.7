Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146ABC742B1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C79208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfGLJfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:35:19 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:48107 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfGLJfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:35:19 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MuUvS-1idHrA1K1y-00raHL; Fri, 12 Jul 2019 11:35:10 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huang Rui <ray.huang@amd.com>,
        Evan Quan <evan.quan@amd.com>, xinhui pan <xinhui.pan@amd.com>,
        Rex Zhu <Rex.Zhu@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] drm/amd: work around llvm bug #42576
Date:   Fri, 12 Jul 2019 11:34:57 +0200
Message-Id: <20190712093508.1420279-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T0t9yMg8w/+NPQa9xO428uGk7wZdKsknl8QBX4d3SnulUoORRM/
 trO21OtppDiYQuT3C4jVcKiiTnNnS6/5eKvCrjLKi+uRjvPt5MQZMv9b6D5BKTd/052kBFw
 akgzrRcmNIQyyldfjHRhBbtJ6Gkx/BDwtqZB4H0qV71ENh6YpR7eLIXuvYRe6ArKTSYl++G
 QgIeU6F+4ybc1xwYgbYEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uJnPJIwtCWU=:ZuTP/RSLwgHQipfLeMHCG3
 RibAJkLb9sr5VnedmiI47Wahdi0mNwmExruwBc0yE5dw7Iz+cCTj8DYQTyJT3baRm4kedpuu9
 XE1yvzo5sYN5y2cyj9jJImvM+uCBzrCw2HvFrBwfBwdpe7pR0RzxRY58oj9Glcrggz3LJtEj3
 AnjMoWibdpZ5g3xolKyDEcUdQoOWLQHFSxM+/IS3DChRY4OoFy2dFpusCCiEVOVl0PVLXVCz+
 aXfdH5gmJdVPwVGpWJiO3DaRknezrgtxfr4QjHQBvpu7Ibhe6MH03BWKGric15VglyrwwRZ9B
 wXU9jZSZdxQ2Xu2AJQJMGskauUlJrXlfB/cnWcnHXh9z48b0t44qEWq4l1lbnBAnEEfAkSWv7
 QypLsVSqiy8fvChwlaFNg6NFL6cR8U5DrxWAJ4vtKitaK+gvnrxm01YnD3RsL51bgM7aPGGvT
 jJ3manEXCDccgF4YJk3SXXRT1yyLLnytJPHQ63o8fdpnJotMxuUQQWvenBUmALhN3LEWxvhnq
 D2kbWHN6N3gj9ABSJLsjGapb8ltOtI0cMR6i7XmBirdJOqOtLYt5511Pkow5N5zi+NsvFLaAw
 qN4Ahnbzc07s4zcPakcEjon7luREwtRxvQwpg/yd3nu4ygtnNAAeStV/UPLn1U+SLFzcFAOOe
 50s+fjsrsnPA5zEK69kR28mY+JGeNx+/8DgtT/gfNkru0iC8O/9VII1C+ZnjG8gfbizNytMBp
 jwyqt1/X9UFIp/QTWnimQBjsJyp7nqZv/yTRmg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code in the amdgpu driver triggers a bug when using clang to build
an arm64 kernel:

/tmp/sdma_v4_0-f95fd3.s: Assembler messages:
/tmp/sdma_v4_0-f95fd3.s:44: Error: selected processor does not support `bfc w0,#1,#5'

I expect this to be fixed in llvm soon, but we can also work around
it by inserting a barrier() that prevents the optimization.

Link: https://bugs.llvm.org/show_bug.cgi?id=42576
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Sending this for completeness, please decide for yourselves whether to
apply it or not, given that it's a trivial workaround but probably not
needed in the long run.
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 4428018672d3..154416a626df 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -773,6 +773,7 @@ static uint32_t sdma_v4_0_rb_cntl(struct amdgpu_ring *ring, uint32_t rb_cntl)
 	/* Set ring buffer size in dwords */
 	uint32_t rb_bufsz = order_base_2(ring->ring_size / 4);
 
+	barrier(); /* work around https://bugs.llvm.org/show_bug.cgi?id=42576 */
 	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SIZE, rb_bufsz);
 #ifdef __BIG_ENDIAN
 	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SWAP_ENABLE, 1);
-- 
2.20.0

