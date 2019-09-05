Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D74FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C972207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vmsh8nYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391291AbfIESdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:33:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44518 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbfIESdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:33:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id 30so3889088wrk.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B5O8eGkbGw+ETECQevuBRCR0HQOeLcREPjZ6QhzTv+c=;
        b=Vmsh8nYxnAh2orLd9VI9I62UBJ6glfX/55rAjzstLrdFRdhaw5ET8IGXbqkKIZ59vS
         iHkfgmCqjZnoS0r9kpEWt4IyjeNE7dO/HGlzmJWqno8p8FSjJQwBEAxfdD83PG+hrE2+
         I/S27/3KA+hzqQNIw29MPHO4Gt/qiufVujeeMafwUCNpWmw1Bby3/Xp7EJ9ppnC1ZddH
         Yyb+XzhE3D3wBD99xpBqMw0bw+JU+3IT3tw2w+3pLq+thSPkDS+8MKShOywUd9sy3FWp
         7Kq84cbsEUYcWzOJ1RczkqxM6rIhVRPxGhHJO5DzEjGD2dVHIcuOzM7Zva/Spudqaian
         TcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=B5O8eGkbGw+ETECQevuBRCR0HQOeLcREPjZ6QhzTv+c=;
        b=UoeZf2rp1KZxG8jbohS++8GThey7BF3tG2+qm0xDLPeXfDetVjeGSolzYPQUPefMYO
         Y+ujgmzngbNsNlixFwh6zL22Ox0fC2H88DAIsR/Cmk3mKw5S0KHF8DM9m/CPKhDG5fsE
         8UPqxe8p/3e2FmNzkC/69IeATcZCVUodlh1nNCL/kMfCVyQiOAZkNDPXvuPQSthkiaDn
         QqUjKg6Rg9TNUA4zHaNpoKALA5B2bVf78HLdOO5DYMccKPRz9RopH+wxerJhQHnmVdU3
         hq2zPPef0j1HIAsjOmtFB66t2i5YOgAd02gj3Bdd0Y+z7Ijcb1o7uqdzHW7XGp1LmTso
         rATQ==
X-Gm-Message-State: APjAAAU0/12KtNLWpo2MX2B3s8i4vieXP9UNy1UWafNwdVe6fl1CQ2T3
        anmzDWwlAy/AubB7M1sjlp4=
X-Google-Smtp-Source: APXvYqx+x9GUtN1lafnRmnXBSsfRNt5BA2TCgYoqdrKwy2zQ5dAjLgpIHWfDFQEmcv3vzIlepZ6/tw==
X-Received: by 2002:adf:9050:: with SMTP id h74mr3739633wrh.191.1567708389260;
        Thu, 05 Sep 2019 11:33:09 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id o22sm5997845wra.96.2019.09.05.11.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 11:33:08 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        David Francis <David.Francis@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        Anthony Koo <anthony.koo@amd.com>,
        Aidan Wood <Aidan.Wood@amd.com>,
        Chris Park <Chris.Park@amd.com>,
        Eric Yang <Eric.Yang2@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Move static keyword to the front of declaration
Date:   Thu,  5 Sep 2019 20:33:06 +0200
Message-Id: <20190905183306.32670-1-kw@linux.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the static keyword to the front of declaration of DC_BUILD_ID,
and resolve the following compiler warning that can be seen when
building with warnings enabled (W=1):

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:75:1: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Related: https://lore.kernel.org/r/20190827233017.GK9987@google.com

 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 87ca5a290d12..a5a89bc0e1d1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -72,7 +72,7 @@
 #define DC_LOGGER \
 	dc->ctx->logger
 
-const static char DC_BUILD_ID[] = "production-build";
+static const char DC_BUILD_ID[] = "production-build";
 
 /**
  * DOC: Overview
-- 
2.22.1

