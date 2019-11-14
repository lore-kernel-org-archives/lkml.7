Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A412CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783F820725
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkN+qodG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKNNZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:25:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55615 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfKNNZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:25:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so5661399wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 05:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y+NZFoUdEcf0PJWdPHX/G2eqhW4MUVM4QQTYn0oEj1I=;
        b=CkN+qodGvOgi3HNbVRPFCi2d/Rmb81dIwiBAj8ecN7XnKalPX/eTzj1ufQjZktOPYc
         tZlxPbHyj1g0xIzlwH31cxxmWqqXe7kqTrS4ZaJWbJQ4dtpuDEZCJZbZaFhNLOcUaoya
         nfax5ZQZUKlsOXpqBbFmiLtLqiz03tpU4fUlK/MHW62aO0TQ/6HBb2cldcFVX4LltOmk
         lanEy0j4Mc1NNHCD2Ry6TByzlRM4P2rlz2NEf1JMUXv8Wf/ObZneHSDcOh7K0v4ckgRC
         aupF0h6wmETm+DNx30WlXJJ2ar1bpMKgQQPIky5OWhbcaNENwEZMTHQeLpagqyQAMZ7B
         33+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y+NZFoUdEcf0PJWdPHX/G2eqhW4MUVM4QQTYn0oEj1I=;
        b=rPfMkLnB4wtxx6uLxERL4dAjVi/YV+xlD9wY7wqIMyh+B3r/yzNrIPjptrNxzdH8p7
         D0p/YbdL99C6hOkLakObpED+4351RojBQB1G1EimvbEXx9oYYYLmdcVhlHXf9LhwAxso
         Fl7/sFDNyN9I+u/fUmPE5ke4n8fQ789ssTtpYNAADT4diZXpnzF5BQ8EN03KgkL8qHjr
         3ivAEfwcubkdlytUqqbtTV6gIrOXsM8PD1+AcAoMJ2tivQULIdWFxjJxgGkGWgJSqPyv
         qzxtUSiTdasXpsuwUKVlCiLF2a4NN2EfiI1hE3RL5R8EeZA+MUQetc0GKiWCRdGRvCMp
         6Bdw==
X-Gm-Message-State: APjAAAVOeJz5VlGdgZ73bAbyOtYM6Hbz+dZqbRip3WsCj0GQxL+G6gBi
        crK540s9PsRqoRM38kwnddo=
X-Google-Smtp-Source: APXvYqxdDVgViAKJ2YgU7ehgIo/fK4DVrmQv2FVO8JOYUn+KW7EwMEZTGrXyImi3jae5SwSx24noRQ==
X-Received: by 2002:a1c:2e09:: with SMTP id u9mr7768943wmu.108.1573737928601;
        Thu, 14 Nov 2019 05:25:28 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id l4sm5897905wme.4.2019.11.14.05.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 05:25:28 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        hjc@rock-chips.com
Cc:     heiko@sntech.de, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/rockchip: use DRM_DEV_WARN macro in debug output
Date:   Thu, 14 Nov 2019 16:25:20 +0300
Message-Id: <20191114132520.7323-2-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191114132520.7323-1-wambui.karugax@gmail.com>
References: <20191114132520.7323-1-wambui.karugax@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of dev_warn in debug output with the new DRM specific
DRM_DEV_WARN debug output macro to maintain consistency across the driver.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index e5864e823020..d7ee8d1835c4 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -796,7 +796,8 @@ static struct i2c_adapter *inno_hdmi_i2c_adapter(struct inno_hdmi *hdmi)
 
 	ret = i2c_add_adapter(adap);
 	if (ret) {
-		dev_warn(hdmi->dev, "cannot add %s I2C adapter\n", adap->name);
+		DRM_DEV_WARN(hdmi->dev,
+			     "cannot add %s I2C adapter\n", adap->name);
 		devm_kfree(hdmi->dev, i2c);
 		return ERR_PTR(ret);
 	}
-- 
2.17.1

