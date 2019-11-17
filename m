Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF78C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 17:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105652075C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 17:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="IRanUKst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfKQRai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 12:30:38 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:60774 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfKQRah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 12:30:37 -0500
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Nov 2019 12:30:36 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 47A2CB5E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 17:22:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id v3Hyx6LoKSkj for <linux-kernel@vger.kernel.org>;
        Sun, 17 Nov 2019 11:22:56 -0600 (CST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 1DF75B4B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 11:22:56 -0600 (CST)
Received: by mail-yb1-f198.google.com with SMTP id j66so11788888ybg.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 09:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RIby2qRx5cEwNIrcIoDIHdDJ6ejQhdeyp3owCLM8obk=;
        b=IRanUKstwT1MnUfDW4znsizornJMbx0pRICZZKzplIGIiA3OJ+MupXA0DK7QXt6M9c
         hLWZAgq6YTjDz4dClo6XI8qh6O0AEshigJzSARu8dQPCU/R2YI+MPH1d8HMEVvptX2LP
         2CqovGn7TmSCS387hLEScYeCaCvqJ7vdrnljOcqfc19SjC6HnDNMpXbGuCNHzOtb4iDh
         bzFKDt1m+gnvDulkJgW4pgrRQ6i895IiisubEZ7hz9iMljjm1AQWK17ZTWMch9u/EvYT
         NccpkOgcjITRXlYagZbOT2+7he8di4ZPpkTv9UfOdlWEinhxUTaz056LWuOkx75Bq4gO
         mg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RIby2qRx5cEwNIrcIoDIHdDJ6ejQhdeyp3owCLM8obk=;
        b=JIc0lQxphpMlKBDqEpGFxIMDXKyCC9Rv/NkH/5qrvvjvA05favqRz8etMWiLcRhVIa
         1uWbAP6CBC7m9Sb3ztKAVwqtdSsfAJ5RpAqfD30ayIsNx8VG7vzBWtO/ypiHaiYiEuxs
         rVTZP/J+k8bjdg3kj0kbSlWuzpgY8jG9xyPfL73m23KdqXJSzQ0zkS30z1/+E3s8EwW+
         kubahSY9VaZQvvFv7vit3l79YC1s656ucEaJhIz/EWhg6JIStzWM/B6EAG+jUqVPnvf3
         71SGPqqMlEb/wFtR7yo1g1LwCoP3vd1gpa6oDOkxMfBcX2mlcgC2+d94T+0u7Leno3LZ
         UoPw==
X-Gm-Message-State: APjAAAVD7lYWJ62tTRl/Gb/Wy6yq9CCHLJCj9Hd+ra+5eYkczvA6oZms
        CpsiOxnhmUUujXA3m52R2JCaXc3OVZ7i6X08sJI7g6CnfnCeSuSSvPaNu+SWSwzB3Vj7i66o4Yz
        r3Yk9zef7VY4aH8kiu18jzSscML93
X-Received: by 2002:a81:71c4:: with SMTP id m187mr16741526ywc.327.1574011375498;
        Sun, 17 Nov 2019 09:22:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRSZyGvEeTEQTqYLBwcl2GMjbN83a4HUDRBI+2xrk9iViMa5K8z+axNVTrtuWEQ1cR/lc6Mw==
X-Received: by 2002:a81:71c4:: with SMTP id m187mr16741510ywc.327.1574011375242;
        Sun, 17 Nov 2019 09:22:55 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id 124sm6654970ywo.98.2019.11.17.09.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 09:22:54 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        David Francis <David.Francis@amd.com>,
        Eric Yang <Eric.Yang2@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Eric Bernstein <eric.bernstein@amd.com>,
        Chris Park <Chris.Park@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        David Galiffi <david.galiffi@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Fix error returned by program_hpd_filter
Date:   Sun, 17 Nov 2019 11:22:34 -0600
Message-Id: <20191117172236.2140-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

program_hpd_filter() currently fails to check for the errors
returned in construct(). This patch returns error in
case of failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index ca20b150afcc..bbb648a50c41 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1379,9 +1379,8 @@ static bool construct(
 	 * If GPIO isn't programmed correctly HPD might not rise or drain
 	 * fast enough, leading to bounces.
 	 */
-	program_hpd_filter(link);
+	return program_hpd_filter(link);
 
-	return true;
 device_tag_fail:
 	link->link_enc->funcs->destroy(&link->link_enc);
 link_enc_create_fail:
-- 
2.17.1

