Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2E8C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 19:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AF02067D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 19:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbGn4JFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKWTgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 14:36:46 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35109 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKWTgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 14:36:46 -0500
Received: by mail-oi1-f193.google.com with SMTP id a69so2396463oib.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 11:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oSQc37dqCsKmcQ7zoyXBibnTMKn/Bl9FPXqYEwoE1CQ=;
        b=WbGn4JFxkkTuruODpeF0BiqIiobfrQaqt4UfNgnpPqG1TPanPiI6XYwkF1u77Wlf0x
         VhxD/a/EOS73a8zJp9qKrc7iX8zceDLI+AnOY7X0TYYEZq3rJSTzU7P2qojhdMUFWeKM
         Uz8yowHqgIaVwF6dV+5dZyBLMAz5x5ZXUzR3UvfWD5BWf3VbbHI06nncpAqYr7+WDDRZ
         vg+/vScXkLKb7RppS4/yzuaNhxsiqhuE85puhcDYDaGDITEv9jTFHXG5HlDfejIp6Q+d
         DEXwi2vDvjLuCPATa/70h8DBhHniolPlDfqCASW1kQ8N/iVhQEZBDbrGbOT7w0sgl6r8
         xoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oSQc37dqCsKmcQ7zoyXBibnTMKn/Bl9FPXqYEwoE1CQ=;
        b=bu0da1tRao5WlPpt5mvKnHiGuA5quIr41ylYg1Lk/hpKX0KEoyG9CBESgiCVjqWXcP
         kZRJtHXZ7PT5pYIvfnhRb8rIBg9zORMnB3QaRK6FOkdl0ftW8nYd7CcTPJmOYt2JNFjD
         Jg/h6mfhPLP9KCuATSoCkITq+et6mPYA8aR/BU709F3VcfIjCe0EvECx6gm6BN09Gf4K
         JppRBF9yVw3isoX6cWEqmXTxnQ6JbhibSvt5CwwwLSBQw6RFbmdMXisqljNsx+G8ELZE
         SQN5+m9Kalgt9khYg3Oahev+MMjLq8Q6y215DO+uOgA5TDPQDphPOuwiGxqyF1yh/sP8
         ak2w==
X-Gm-Message-State: APjAAAWK0sY6TDXSG3als3Zdx6ewctkfzsRGFOkWMF6/8SrsPUEB6AI/
        Rv/lbekc1Xmb/VdNghMt1Z8=
X-Google-Smtp-Source: APXvYqw88oFHCtkJk2ssxIM4pcvPnzipOe00LVFTxu4p4QE+zj9SziILY4FsQ/PNgyJqg+LhgSX0hQ==
X-Received: by 2002:aca:1715:: with SMTP id j21mr16374553oii.6.1574537804955;
        Sat, 23 Nov 2019 11:36:44 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::7])
        by smtp.gmail.com with ESMTPSA id q3sm551968oti.49.2019.11.23.11.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 11:36:44 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/display: Use NULL for pointer assignment in copy_stream_update_to_stream
Date:   Sat, 23 Nov 2019 12:36:39 -0700
Message-Id: <20191123193639.55297-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1965:26: warning:
expression which evaluates to zero treated as a null pointer constant of
type 'struct dc_dsc_config *' [-Wnon-literal-null-conversion]
                                update->dsc_config = false;
                                                     ^~~~~
../drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1971:25: warning:
expression which evaluates to zero treated as a null pointer constant of
type 'struct dc_dsc_config *' [-Wnon-literal-null-conversion]
                        update->dsc_config = false;
                                             ^~~~~
2 warnings generated.

Fixes: f6fe4053b91f ("drm/amd/display: Use a temporary copy of the current state when updating DSC config")
Link: https://github.com/ClangBuiltLinux/linux/issues/777
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c7db4f4810c6..2645d20e8c4c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1962,13 +1962,13 @@ static void copy_stream_update_to_stream(struct dc *dc,
 			if (!dc->res_pool->funcs->validate_bandwidth(dc, dsc_validate_context, true)) {
 				stream->timing.dsc_cfg = old_dsc_cfg;
 				stream->timing.flags.DSC = old_dsc_enabled;
-				update->dsc_config = false;
+				update->dsc_config = NULL;
 			}
 
 			dc_release_state(dsc_validate_context);
 		} else {
 			DC_ERROR("Failed to allocate new validate context for DSC change\n");
-			update->dsc_config = false;
+			update->dsc_config = NULL;
 		}
 	}
 }
-- 
2.24.0

