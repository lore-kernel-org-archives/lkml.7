Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD79C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 21:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE55C222BE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 21:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDe/bect"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfJEVAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 17:00:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44221 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJEVAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 17:00:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so9110244qkk.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 14:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6Ua1I+2M2qoT07tdXa/jnXqB1E3SjZfA0FzE39UU4k=;
        b=HDe/bectkhxOTjQu81H1au6waX8eiM8mrl9C1ALRX5Wd2J0FUzCU4sr3uq+zFmitbC
         lQQ5/fxF1klH+2MBcgyQGIlgZZu9H7rcsIgrh/FKkhxRBhBItv/71LUQYw5A+YTcl1Wy
         UlWGhnp4Z+ZgeHSsLWJBd6WMGWMHgBpoMLkpaIoECSM6DRahXkgxdHPhoqNOm3F8uFxw
         Hw8x3K+rBXhn2E+Z4LkuvH5Q2UfNFMowEkOvKe0FSPNxmznMEEa7xBABwN0G54sEKCI9
         dj0mLhzh9v3DJ48Y8hAM0h2Mq9TiOzPaRBYJefM617RJ6A9zWH9Wca+IXbQ6w0zKcWS6
         Mu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6Ua1I+2M2qoT07tdXa/jnXqB1E3SjZfA0FzE39UU4k=;
        b=ncAnbmfYyxbntgOq4jJbP08z84goGH4G6L7vPvv15+J+Aaad2d7++4mE+VoZ8mH5yG
         7Jc8jEecgclfO4/bi8MseV2zkcs00pE3E0Wbo1VPBxzxgKMDWS4pyXMfCkwPQuQOTs+V
         6SBWmYQ0gsI0NTIXPhaDyaJNqaqgph3QFBAbxL5n847id9to+3dYX1jj7fcbdeFwT2kz
         py8kkc0MjtJ/ChU5Z0ygiJAr1BK0y4Qo9l4Ep9I/dwZA5rZv/ujeGrDxW3Z1Sa48HEPl
         y4sRQSPGjg60gDqiMhdNV+coHy8t3cvJKSOTz5K9IlReKbtQn6QL4za+t3vsSFtAYfVV
         OcjQ==
X-Gm-Message-State: APjAAAW5oe+zvPBlvrmf31Lim+ScDHywfAxBTvzWX++F5oWozLzxlV86
        /NHJy8Y6v+hwA6l5n5yjgGg=
X-Google-Smtp-Source: APXvYqxJun7iRszFAI9NdRXgTWDsFzTwVD6yJc1NlRlXkMp9xw5DzxO2sm5bQgmXLg5mHif4LC/uTg==
X-Received: by 2002:a37:9e57:: with SMTP id h84mr16952030qke.226.1570309251624;
        Sat, 05 Oct 2019 14:00:51 -0700 (PDT)
Received: from GBdebian.terracota.local ([177.103.155.130])
        by smtp.gmail.com with ESMTPSA id l23sm9285014qta.53.2019.10.05.14.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 14:00:51 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: add blank line after declarations
Date:   Sat,  5 Oct 2019 18:00:46 -0300
Message-Id: <20191005210046.27224-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix CHECK: add blank line after declarations

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/greybus/control.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/greybus/control.h b/drivers/staging/greybus/control.h
index 3a29ec05f631..5a45d55349a1 100644
--- a/drivers/staging/greybus/control.h
+++ b/drivers/staging/greybus/control.h
@@ -24,6 +24,7 @@ struct gb_control {
 	char *vendor_string;
 	char *product_string;
 };
+
 #define to_gb_control(d) container_of(d, struct gb_control, dev)
 
 struct gb_control *gb_control_create(struct gb_interface *intf);
-- 
2.20.1

