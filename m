Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2006C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 00:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7988D20748
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 00:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shvCV5hp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKZAfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 19:35:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43288 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfKZAfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 19:35:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so20372998wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 16:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDFio4Lhb0kKhPkBrIjIeoSXog1kC5Yksq1DrKHrUpU=;
        b=shvCV5hpquBUdbjLWkMX/ziKHTReuQPJ1XIUHiUBGiHEt4QY+rZ9xJyLIA5SxNKv9E
         AGYuY2h8k29ml7h96ZPB7TggN266SvZSY7Y6DpFj6ltmmUJtFeUXfoxGMlexiCrpkBxp
         xmuowIDQk1i1byxc+xFD0MacBpt+QBPACAMHGSEqqdTc6Dx1CB3GvJH5kvY1wp40TK7G
         51QQureKo/wpA5rywxNdU4nRAToqJ1WvUlcNhiu8WQMAUi4LjxDC6Gqvn1lHsvGCiHsv
         d8AjhzrpUT6FV/aiYuDvDs+VIPFpg2YX/n8mWHANVrAxSCNIq6T5CdreKzesRxny1dT/
         3sIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDFio4Lhb0kKhPkBrIjIeoSXog1kC5Yksq1DrKHrUpU=;
        b=S/1QS73P3tXNo2mxwFMZFSCg+DAnU0rpcRe+2CA2N44jIZGpFc+KxSHt6hx1x258Ax
         PopT1jwXNhE+3ZOH7R7BN4OsS4ac0hmZmyUgC4CPRpwTx3em6KV99VVqnij44oXSmMP/
         ZjYfm8uXPV2WwcnAionQUai0y7KCA2ilh+aFp97JZ+C2qYZAv+iPYjicQ4Moy+47+MB9
         i5WmvMBhDHfufv/moD5jfIl9IXlXElKnyDbEtwszB1/0KSxBlAdB1Do0lSYQuWZj2fhI
         8Z3JXGQ+IEBqC+lw7vQjPB+7Flhz96YEFnLFsUdYGdQxEtNzOKpGeWkIh6qab9iEoYC8
         xW5A==
X-Gm-Message-State: APjAAAUqYfczylVI33xLxY5tOMNthV9XHnMs5N9kTvMPP0AKvQHNoFRW
        kRJ+2G9CJndLAvsfx4nYVQ==
X-Google-Smtp-Source: APXvYqyu132ZmglcrvSPz+8EVxEATNEzWOBwq3t6Y4W5mdmx+mzod7l10tqmW8Pwcy3RFUL83wVRgA==
X-Received: by 2002:adf:db01:: with SMTP id s1mr32001656wri.372.1574728531157;
        Mon, 25 Nov 2019 16:35:31 -0800 (PST)
Received: from ninjahub.lan (host-2-102-12-67.as13285.net. [2.102.12.67])
        by smtp.googlemail.com with ESMTPSA id t14sm12159380wrw.87.2019.11.25.16.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 16:35:30 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, David1.Zhou@amd.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, airlied@linux.ie, amd-gfx@lists.freedesktop.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] drm: radeon: replace 0 with NULL
Date:   Tue, 26 Nov 2019 00:35:14 +0000
Message-Id: <20191126003514.133692-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 0 with NULL to fix sparse tool  warning
 warning: Using plain integer as NULL pointer

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index b9aea5776d3d..2269cfced788 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -288,7 +288,7 @@ static void radeon_audio_interface_init(struct radeon_device *rdev)
 	} else {
 		rdev->audio.funcs = &r600_funcs;
 		rdev->audio.hdmi_funcs = &r600_hdmi_funcs;
-		rdev->audio.dp_funcs = 0;
+		rdev->audio.dp_funcs = NULL;
 	}
 }
 
-- 
2.23.0

