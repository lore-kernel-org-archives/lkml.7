Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C346FC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8945220684
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHafZmcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfJFSpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 14:45:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42653 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfJFSpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 14:45:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so12610749wrw.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 11:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BLRrAgbsWXih4clGwXHcgrN0r/ckYeUc4/Lev7iwj68=;
        b=pHafZmcDa364Q+dhPwlr7nhIUd5zHshMdZyjz7Y7GDSIfFpX/YbNDhOvFAEOvj/iQ+
         5hdLUEO95bV4YepysYlupbJSaabQV6Ehas7boCto1zLVYsaXL4DktUp7G5TC3pFHs7An
         zp3Z22ww9U4Uq1FjK20ciIvF35SrU4VL7804N/2wa9K85nZkxiRmXVQObvcGGLQidhTE
         qxQiW15HWzAIS55aZTFP+Yqqk3JmsllabxNfrbOfUtysj+Ai77ytuHqqsn/nJ49kROvF
         K1GdxiPyI945K3m5B4MkqjheEpJLwlOIrf/UM5Uf2TDUHOfH74bZ5mouOwmgMOds55Jn
         e0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BLRrAgbsWXih4clGwXHcgrN0r/ckYeUc4/Lev7iwj68=;
        b=NNyneGBc/JhjBego+lJheE4jRvs238li1M0CUogaU56oPm1vR2tiHBT2haLGjNiYRu
         9mcpx6IECA4/RCLksFxVsyvrYMRnXgbcQwhL+7HjAFKXIPC4X9OKRX4yd3NR6AywkByq
         TgDlkZQG503ndPSCKQFmw9hTOyROQq5N+PNxw7uZFU99yDxVvaXCX+xGl0TA87uvRbXh
         PilYnC3NXZJ8JgGtBJnUYJfNgWze2SAtaNwbe7kYEFg1fPr3XU9QqEJL9SHR8adtZ0rG
         GYlxFxMExo3Dek5TGWltChrKhnbZwHivNhwjVtmIA6BGcxjOxuH+G+NS2DFuvRegj8yB
         GtLw==
X-Gm-Message-State: APjAAAWK+NesFRTN7ywgn63ANd2ANyRJDL0DyjQS0NQzQBdfdsrxnwQ8
        e566pm2yqg7tFwgMFUBiWA==
X-Google-Smtp-Source: APXvYqyepOGf8igYvzB3AfpQ0u4G7hwVSLG3irfa8mVsmI7KDrPS/UPu3wZ+wh+hsyCmfg0oT0uC0g==
X-Received: by 2002:adf:ce83:: with SMTP id r3mr18656090wrn.219.1570387507029;
        Sun, 06 Oct 2019 11:45:07 -0700 (PDT)
Received: from ninjahub.lan (host-92-15-175-166.as43234.net. [92.15.175.166])
        by smtp.googlemail.com with ESMTPSA id a7sm28150963wra.43.2019.10.06.11.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 11:45:06 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy@googlegroups.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, olsonse@umich.edu,
        hsweeten@visionengravers.com, abbotti@mev.co.uk,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] staging: comedi: Fix camelcase check warning
Date:   Sun,  6 Oct 2019 19:44:53 +0100
Message-Id: <20191006184453.11765-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Capitalize unit_ma to fix camelcase check warning.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/comedi/comedi.h    | 4 ++--
 drivers/staging/comedi/comedidev.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/comedi.h b/drivers/staging/comedi/comedi.h
index 09a940066c0e..df770043b37d 100644
--- a/drivers/staging/comedi/comedi.h
+++ b/drivers/staging/comedi/comedi.h
@@ -674,7 +674,7 @@ struct comedi_rangeinfo {
  * linear (for the purpose of describing the range), with sample value %0
  * mapping to @min, and the 'maxdata' sample value mapping to @max.
  *
- * The currently defined units are %UNIT_volt (%0), %UNIT_mA (%1), and
+ * The currently defined units are %UNIT_volt (%0), %UNIT_MA (%1), and
  * %UNIT_none (%2).  The @min and @max values are the physical range multiplied
  * by 1e6, so a @max value of %1000000 (with %UNIT_volt) represents a maximal
  * value of 1 volt.
@@ -909,7 +909,7 @@ struct comedi_bufinfo {
 #define RF_EXTERNAL		0x100
 
 #define UNIT_volt		0
-#define UNIT_mA			1
+#define UNIT_MA			1
 #define UNIT_none		2
 
 #define COMEDI_MIN_SPEED	0xffffffffu
diff --git a/drivers/staging/comedi/comedidev.h b/drivers/staging/comedi/comedidev.h
index 0dff1ac057cd..54c091866777 100644
--- a/drivers/staging/comedi/comedidev.h
+++ b/drivers/staging/comedi/comedidev.h
@@ -603,7 +603,7 @@ int comedi_check_chanlist(struct comedi_subdevice *s,
 
 #define RANGE(a, b)		{(a) * 1e6, (b) * 1e6, 0}
 #define RANGE_ext(a, b)		{(a) * 1e6, (b) * 1e6, RF_EXTERNAL}
-#define RANGE_mA(a, b)		{(a) * 1e6, (b) * 1e6, UNIT_mA}
+#define RANGE_mA(a, b)		{(a) * 1e6, (b) * 1e6, UNIT_MA}
 #define RANGE_unitless(a, b)	{(a) * 1e6, (b) * 1e6, 0}
 #define BIP_RANGE(a)		{-(a) * 1e6, (a) * 1e6, 0}
 #define UNI_RANGE(a)		{0, (a) * 1e6, 0}
-- 
2.21.0

