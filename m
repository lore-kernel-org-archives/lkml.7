Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40E9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 06:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A4520856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 06:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2vGvNxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfJ3GEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 02:04:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43835 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfJ3GEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 02:04:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id b19so1083299otq.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 23:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MYUu1o7Gjm7ckCy0ST4zrokOEsSb5X/Ix76ieyroiBg=;
        b=u2vGvNxWEd7pbOofdxcD51Nta46qikqUEbSqvdYbQx3dwLyGVjuT0dz+sBt/HjyWu9
         X1OxswKBfFc5XJH8PQoFI/jPHSmjluPw/jKTIaJzAbEfKbRSrVPbeKuTq+Y6DrZBPR6g
         ORGQDV7y6CcJTFa3mGxFkZAwAOV2nsTsgbEA9R+PIU3Y+X6mcmLw+dle0TUSFUxNP4No
         9PYFYTwsNMdvqzCZMoXme3Q+kGHQOAZf5pY1Zzca+voLifsEGvMWX+7Io/z/lkP34yC0
         +AWvq5Cq2/I55/foTxl6rUzsg4KDS28bBChsrzLzVLEKGq6rouciX31QhBRMaOcUe42u
         mt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MYUu1o7Gjm7ckCy0ST4zrokOEsSb5X/Ix76ieyroiBg=;
        b=XLoHgWiBMMVcxtGHgIn8k28BKI6ZjHPZbihNsc8a1E0vspeStg3VzZE0CBjrqBbCxH
         HCHJa71X0Rt63yIZQCu/8l6J0w+F/p1me+3+UdDCtwEPlDFz2oQwQkOUTBdcGHT5rXVj
         xddRlKBEFO1F+cpEntIv+RVrAqLXmO+SL2JUsuYdi+kZn+75Bajfz0RebM3F1mQw2wSj
         9FizCT4ajQ/VwNnGeyqWinPTWdKdWpb6YgXf4b0ZpIejs61x8zDsrNg9KTKywjFJ5NZY
         tmXxEX11vvI3G8+WPDDGHLlXdswp83LLvs1yR4Szx92jxqyvkAvM2RhZFuaS63W76uvx
         vgUg==
X-Gm-Message-State: APjAAAWlz+zsPpjQYcu2sAWe1aWuiAtZIvDwrnYmBjsXXDjFpwZZlqUJ
        BTtaKCTedIXsmNT87QJzKvQ=
X-Google-Smtp-Source: APXvYqyX+UhlPFCyIwKYvVsfzhxhIg1E26Bf7G5FWzbhdidLyzy1q7F7RKCzz37gAMTjxjqPDuxLHQ==
X-Received: by 2002:a9d:82e:: with SMTP id 43mr21630303oty.23.1572415475989;
        Tue, 29 Oct 2019 23:04:35 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 34sm472147otf.55.2019.10.29.23.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 23:04:35 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     Roman Li <Roman.Li@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH -next] drm/amd/display: Add a conversion function for transmitter and phy_id enums
Date:   Tue, 29 Oct 2019 23:04:11 -0700
Message-Id: <20191030060411.21168-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:2520:42:
error: implicit conversion from enumeration type 'enum transmitter' to
different enumeration type 'enum physical_phy_id'
[-Werror,-Wenum-conversion]
        psr_context->smuPhyId = link->link_enc->transmitter;
                              ~ ~~~~~~~~~~~~~~~~^~~~~~~~~~~
1 error generated.

As the comment above this assignment states, this is intentional. To
match previous warnings of this nature, add a conversion function that
explicitly converts between the enums and warns when there is a
mismatch.

See commit 828cfa29093f ("drm/amdgpu: Fix amdgpu ras to ta enums
conversion") and commit d9ec5cfd5a2e ("drm/amd/display: Use switch table
for dc_to_smu_clock_type") for previous examples of this.

Fixes: e0d08a40a63b ("drm/amd/display: Add debugfs entry for reading psr state")
Link: https://github.com/ClangBuiltLinux/linux/issues/758
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 38 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 7b18087be585..38dfe460e13b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2447,6 +2447,41 @@ bool dc_link_get_psr_state(const struct dc_link *link, uint32_t *psr_state)
 	return true;
 }
 
+static inline enum physical_phy_id
+transmitter_to_phy_id(enum transmitter transmitter_value)
+{
+	switch (transmitter_value) {
+	case TRANSMITTER_UNIPHY_A:
+		return PHYLD_0;
+	case TRANSMITTER_UNIPHY_B:
+		return PHYLD_1;
+	case TRANSMITTER_UNIPHY_C:
+		return PHYLD_2;
+	case TRANSMITTER_UNIPHY_D:
+		return PHYLD_3;
+	case TRANSMITTER_UNIPHY_E:
+		return PHYLD_4;
+	case TRANSMITTER_UNIPHY_F:
+		return PHYLD_5;
+	case TRANSMITTER_NUTMEG_CRT:
+		return PHYLD_6;
+	case TRANSMITTER_TRAVIS_CRT:
+		return PHYLD_7;
+	case TRANSMITTER_TRAVIS_LCD:
+		return PHYLD_8;
+	case TRANSMITTER_UNIPHY_G:
+		return PHYLD_9;
+	case TRANSMITTER_COUNT:
+		return PHYLD_COUNT;
+	case TRANSMITTER_UNKNOWN:
+		return PHYLD_UNKNOWN;
+	default:
+		WARN_ONCE(1, "Unknown transmitter value %d\n",
+			  transmitter_value);
+		return PHYLD_0;
+	}
+}
+
 bool dc_link_setup_psr(struct dc_link *link,
 		const struct dc_stream_state *stream, struct psr_config *psr_config,
 		struct psr_context *psr_context)
@@ -2517,7 +2552,8 @@ bool dc_link_setup_psr(struct dc_link *link,
 	/* Hardcoded for now.  Can be Pcie or Uniphy (or Unknown)*/
 	psr_context->phyType = PHY_TYPE_UNIPHY;
 	/*PhyId is associated with the transmitter id*/
-	psr_context->smuPhyId = link->link_enc->transmitter;
+	psr_context->smuPhyId =
+		transmitter_to_phy_id(link->link_enc->transmitter);
 
 	psr_context->crtcTimingVerticalTotal = stream->timing.v_total;
 	psr_context->vsyncRateHz = div64_u64(div64_u64((stream->
-- 
2.24.0.rc1

