Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CD0C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 14:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C36127942
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 14:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK08QkHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfFBONh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 10:13:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33901 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfFBONg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 10:13:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so248272pfc.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g8nhw207JO81aJGXpFM+zIRwmOM/AtNu4yX4je0sw18=;
        b=mK08QkHS2dCObF9/dRfSwzI9Ll32nymYjdUCb8rbTWsioyWBtdIv/IUAPmCa3M2CqV
         G9M8NsIa/WNcXMjO2nXbgNFVQeo2wZx/dofGNKqWkx+jZrrATV4MM9w2/s5f0jtblbs0
         q1rldY15ERkqEIsePvMnyWdjQZ0sYZASvIay+tRVqO4cfBUxn1hwMxc1syBcaTCIB3pY
         hQqwUhh9T/CdsdoyomOr9QFbb28VzsLgb6kSf1LgqRiIrwD/nixxXTDtep0ljbdsmc3L
         9nmVfsmHgHY3gUrHClDI91nnNKKDoWYKfqDA+evTqs/wRR72Fo5XbvRpGdFgN14wh+YJ
         7URA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g8nhw207JO81aJGXpFM+zIRwmOM/AtNu4yX4je0sw18=;
        b=Pq/d5t5isYkfCQBbwREkAnwvPVvbXbiosHsmuzpkfGgxjbK0i/yWn31atxFp3JGDV/
         yvTCY6CmiKaijfixaEwPKWCIqBmQx/juqwOnHbHvg9SELM2W9dgrojj1Oq0fPfiqUweH
         QLtKG6gskS8UZi+Oy0xgsygE+PWKlHKNGlP2rYUutDr6djulQNhNsa2ZMdK7tEav2+ef
         l9Er3dg1yV1n9KmGxbglyl6gRZcdHVOCSOpBBmo0xcPAjRAS67Rh3pWLyjfnvJ6z0pYT
         8RK09CPQKf9aVnPIZJk5RhqDrd/w11aPsra3SWhwV9WBJKN81HvxQamJKTR1DDmH9VAM
         swLw==
X-Gm-Message-State: APjAAAW0VT6Jt0SzpqdsMtdjRJ9rTboCoz+LuUnupq6qtV2zx8bv7vQw
        zlAIJpqMs87ZWqduYqLSjUQ=
X-Google-Smtp-Source: APXvYqzEo+/2XW6GYocCFk4l/IkSto/Y+dKiPwCtbIjs84SIUImKPoLTDmVMAoTIiAmAGjmzqvS4GQ==
X-Received: by 2002:a63:788a:: with SMTP id t132mr22575882pgc.52.1559484816231;
        Sun, 02 Jun 2019 07:13:36 -0700 (PDT)
Received: from localhost.localdomain (119-18-21-111.771215.syd.nbn.aussiebb.net. [119.18.21.111])
        by smtp.gmail.com with ESMTPSA id x66sm12533278pfx.139.2019.06.02.07.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 07:13:35 -0700 (PDT)
From:   Rhys Kidd <rhyskidd@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Rhys Kidd <rhyskidd@gmail.com>
Subject: [PATCH 1/2] drm/nouveau/bios/init: handle INIT_RESET_BEGUN devinit opcode
Date:   Mon,  3 Jun 2019 00:13:14 +1000
Message-Id: <20190602141315.6197-2-rhyskidd@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602141315.6197-1-rhyskidd@gmail.com>
References: <20190602141315.6197-1-rhyskidd@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signal that the reset sequence has begun.

This opcode signals that the software reset sequence has begun.
Ordinarily, no actual operations are performed by the opcode.
However it allows for possible software work arounds by devinit
engines in software agents other than the VBIOS, such as the resman,
FCODE, and EFI driver.

Signed-off-by: Rhys Kidd <rhyskidd@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
index ec0e9f7224b5..a54b5e410dcd 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
@@ -1934,6 +1934,17 @@ init_ram_restrict_pll(struct nvbios_init *init)
 	}
 }
 
+/**
+ * INIT_RESET_BEGUN - opcode 0x8c
+ *
+ */
+static void
+init_reset_begun(struct nvbios_init *init)
+{
+	trace("RESET_BEGUN\n");
+	init->offset += 1;
+}
+
 /**
  * INIT_GPIO - opcode 0x8e
  *
@@ -2260,7 +2271,7 @@ static struct nvbios_init_opcode {
 	[0x79] = { init_pll },
 	[0x7a] = { init_zm_reg },
 	[0x87] = { init_ram_restrict_pll },
-	[0x8c] = { init_reserved },
+	[0x8c] = { init_reset_begun },
 	[0x8d] = { init_reserved },
 	[0x8e] = { init_gpio },
 	[0x8f] = { init_ram_restrict_zm_reg_group },
-- 
2.20.1

