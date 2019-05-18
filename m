Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E2EC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 13:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79622206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 13:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7NJYpUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfERNnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 09:43:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33794 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfERNnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 09:43:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id w7so4648147plz.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 06:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QtUJrjIqrPWsj5/m1a8zRfPnwpigJLhDkg+YiJdkqnM=;
        b=Z7NJYpUQD90B/2h4MTsHIw9ijXPWhBbsoaY48acKPyQE2Jb/VTUBX/mf+42IudJwPt
         omV+sUUeYVGy7bWWgocJ8vmaa7tRXc1V9eb5WQ7LiAyqNAW+yPwPlZEJgpPH4UYZ1WTV
         ZMMea0dDHzwkDbCKWwFArZsx/c2yDrOPpDd0/NvuunYAkOMz98DhO7MbAqLrCWOvsXuE
         YAASwKyDwshJpr8tJChkuEf1DoJNgB91zPNlCyAcmQUoZxLCuKRzye2ceLJxqQ6piLz6
         9UbAimsON+1tHBbamaFMmPZ7qP4p+jIjSQQX32L0wCbrb7gFr01/sR1xUW4QZ+Qp6OBM
         VsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QtUJrjIqrPWsj5/m1a8zRfPnwpigJLhDkg+YiJdkqnM=;
        b=jeNkQfTY6ZdtWsgylcSHvV4Rk/ixiMWFWXcP41EAO1W7uogSScYSxtUTkBMYlBuGZj
         JVEpnQJWyJYURt3A5BMuj3YK8PUbicYVsvXgxpkVwrJZFACAcrE2zygfAZ8FPhD16Lhl
         G6zjhISeiMUK2f+/bRJyTF/tZtUH8jllnMfj57PxuaJC9DsqABHwTDRwjItlGMFOrd1D
         x1QNNJ1cI8HkixwacFYzgtd38UYKKakQp9H9XjB9qsXSUyZJ3lURfHBgXyNGRL4osl4c
         NwXYNzFiwIsXaba3p2Raa9atuPuQTR9FO9jWcnfro0YN1v76lN7cKbNbMSeJJKxih0Sv
         A7HA==
X-Gm-Message-State: APjAAAUzfffdBoEKmh+9aKfiXqZBwJJa9JFnhLrRYIXoNFcfo0TJd7LE
        +9HkodT9ivdNPh1MZNyssRaFhtWqoAWkOQ==
X-Google-Smtp-Source: APXvYqwekrpEtVV0a6ftK/9ORGfaA4+lu/FPvftFnFd++JD2PFRNqoDxOZvt2mfZT/Ym9DUd8JCG5g==
X-Received: by 2002:a17:902:6b0b:: with SMTP id o11mr63385245plk.266.1558186994609;
        Sat, 18 May 2019 06:43:14 -0700 (PDT)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id 85sm16194005pgb.52.2019.05.18.06.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 06:43:13 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Bhawanpreet.Lakha@amd.com, michel.daenzer@amd.com,
        Dmytro.Laktyushkin@amd.com, Anthony.Koo@amd.com,
        ken.chalmers@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Weitao Hou <houweitaoo@gmail.com>
Subject: [PATCH] gpu: fix typos in code comments
Date:   Sat, 18 May 2019 21:41:41 +0800
Message-Id: <20190518134141.23214-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix eror to error

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index f70437aae8e0..df422440845b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -183,8 +183,8 @@ static bool calculate_fb_and_fractional_fb_divider(
 *RETURNS:
 * It fills the PLLSettings structure with PLL Dividers values
 * if calculated values are within required tolerance
-* It returns	- true if eror is within tolerance
-*		- false if eror is not within tolerance
+* It returns	- true if error is within tolerance
+*		- false if error is not within tolerance
 */
 static bool calc_fb_divider_checking_tolerance(
 		struct calc_pll_clock_source *calc_pll_cs,
-- 
2.18.0

