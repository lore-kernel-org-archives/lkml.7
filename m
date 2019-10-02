Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E21C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8DE21929
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfJBMDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:03:35 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:45483 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfJBMDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:03:34 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mzhar-1htpHS1ojh-00vhrB; Wed, 02 Oct 2019 14:03:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     clang-built-linux@googlegroups.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>, Le Ma <le.ma@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH 6/6] [RESEND] drm/amdgpu: work around llvm bug #42576
Date:   Wed,  2 Oct 2019 14:01:27 +0200
Message-Id: <20191002120136.1777161-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191002120136.1777161-1-arnd@arndb.de>
References: <20191002120136.1777161-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YNsgZzHNCw392v1rgjHTUEZ8pz20uykSXH754RL9iIOb5deh2YJ
 VniPYenT1ADFLCFsCzgfROvSsNEN3OnGKEcwzAbZX+eQqWv1FYpwjvY8qgQaQWagz6gA/Hj
 n50Orae4/jwItelwmwUM+w8MCNKZ1bodhPFaG7DBNsILr42QtEuWuTsTPF+I9vNTWhFwdKi
 AC2C3ZG7mUNQXMnuZ9GNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4D48kbU58hA=:M0Ukpx58xOP2bgAOCbesZg
 Ll3K2WKrJMuAIV0rQMg3YrjRgy0vn19WxNhnTpIkrflyRiZWcJOM0wBeRuWKJeyvUs0Rmo5L2
 WT/4Q04J4mCDT0lGHrQHxf0CSt7FRwbIaoymM8ll6+AnjlipM3gBW2vuD399wywXHODhQH/Jj
 kmmHm0vPKelSxnjmyF5QKhW2vPKNuNrxHXBAuShJhblFiaT4Tpite+9Tpqz5t78Mv1d0c4+St
 IPO467Ji+f+nalLEiSfYfSOueaNIp0Zh2ECvF8gYGuCtq4mQgaFQma45iRPDMa0dLQp2LPHv5
 s3HOgLJcrW3+YLL3OgrgSAIqY/JojFmQs6jVGI3Y/iaIHFpiWRvNCCVqhadcZDljlJ6/isT3C
 cWMwh3wga4zB1HZAibk87TdIUOsEWosHOOSejWot8HMi7thZpGsmWSYlpaZpcggNF8Y5ef5cx
 S+AFB9lJCv6tLjnDzT5CItgHD9CSDilvn5DV5AQ2CSUe7CMLtj7FRRuRtxGnzKXWHsDiqUK2X
 dLpSNCwET1M9ENlBeQ5D+BhxBx37HFEUhCYKyJqFJoQbTkGvZkwazmwaChizrxq1gbyD4vDeD
 GqCyA1nhBCBAM2hW+2uyIFVsDMDpeg/OoBtcZMPB8aPwvr2q464wcpu+nmB0VWQnFJx8hRRKp
 kx+eBUDSoB7gkuurGSeum9uDonECxoSFhh//75/Bmdr0Te33FTyRIMUwkUlAfiVlOVC5ga602
 HNuDLNkHHth6E821u1odV2gGvJVg9mgsLl5k0rHpfHXjU15zA2Ww4I8gM2c4ZgC5ypKzC/eg5
 iac5xdsyiVk9Kf4KiWNLvvcteewurG0ZAiyq3Yo5GGXvCGBgLkIfnziVSp+lP21xvwWwPUCJr
 pxfok2TuNB12F2uGor0g==
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
Apparently this bug is still present in both the released clang-9
and the current development version of clang-10.
I was hoping we would not need a workaround in clang-9+, but
it seems that we do.
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 78452cf0115d..39459cd8ddef 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -961,6 +961,7 @@ static uint32_t sdma_v4_0_rb_cntl(struct amdgpu_ring *ring, uint32_t rb_cntl)
 	/* Set ring buffer size in dwords */
 	uint32_t rb_bufsz = order_base_2(ring->ring_size / 4);
 
+	barrier(); /* work around https://bugs.llvm.org/show_bug.cgi?id=42576 */
 	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SIZE, rb_bufsz);
 #ifdef __BIG_ENDIAN
 	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SWAP_ENABLE, 1);
-- 
2.20.0

