Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9C2C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BA120674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNH2euNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfIDVDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:03:33 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40575 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDVDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:03:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id g4so139970qtq.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CzEDh/TsIq7upWl5Yv4giE6ogitNU/Rn6EYmhnKlYvk=;
        b=oNH2euNPlkfsmgsbVWioFIdW/n5Zsqzl3Xc42ZsNtjCeEXUBg47otMMdcUkPnpAVeq
         fSYRdgt/3W0BQMYCwvFNN88AczjtCFjXr4iMki7BjJk+cuGkWJytORNuhmWSNBVh7CGN
         r1pPapMWW4MdJiPK45JbSB3idS16Kazwy6D+S7mhUIytq+2+zUAmksQjRzAMfe9xkmLt
         +zZ/8NcM53m5NFTwk400QeODytz4F8l30idy13m6BbHs56HtLEzq/uYEWL79u6i+lNkk
         RSbVGU0l3NARncpWYVOpRPerW03Ma9wvaOhOo/W+2eeufNqnodfid9F92qhWaubQl3b8
         DiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CzEDh/TsIq7upWl5Yv4giE6ogitNU/Rn6EYmhnKlYvk=;
        b=OD/jrEtopg2PGxLZyHG40GcT0BvrUj7dR3d12TdoNWlh1xlqYq2nSD2ZfZ26WWpWqW
         Au6fKxl/4QchA9HOHvQvp2TDoVFDiWjkarcA2AcYK2AXAkh+AVIYlp59UlF5F+BLEJvJ
         Jbb1Ez3eEciSm930j4a9hkFcYrLkmOZS2QTyovdDzm951qXn1XbXPkt+LFFIBXgG+hFH
         Kp5RWJe81weuelUmhGH+a/GtZKPishmxH280W4wlueL0MLBRMVrZsCavt/88Z0ejTcLJ
         U1i3S7UXXE4qf/sjclzW9+k3218wMCDL69D6Z3bVmDHav3FhQWtxzVuXsMqk0uzrdujM
         1yNQ==
X-Gm-Message-State: APjAAAVRlYNbEGsLmOnEd40uoR9jjLp8mU2TprwlvtWNij9W2hxJ3zAM
        Xbzst3jKJo+2f568PTAui6U=
X-Google-Smtp-Source: APXvYqyiG8Lc/uvqk95Uzde1T+GxJ7uHvZpxs0K5bY6Y8JzN3eTEDKj2o6jwgMg/OfQN/pNR4g2eJA==
X-Received: by 2002:ac8:2b82:: with SMTP id m2mr69263qtm.35.1567631011842;
        Wed, 04 Sep 2019 14:03:31 -0700 (PDT)
Received: from 657840b88179.ic.unicamp.br (wifi-177-220-84-123.wifi.ic.unicamp.br. [177.220.84.123])
        by smtp.gmail.com with ESMTPSA id t55sm81669qth.6.2019.09.04.14.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:03:31 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanet.br.org
Subject: [PATCH] staging: rtl8192e: remove unnecessary blank line
Date:   Wed,  4 Sep 2019 21:03:26 +0000
Message-Id: <20190904210326.17983-1-martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpath error "CHECK: Blank lines aren't necessary after an open
brace '{'"
in rtllib.h:482.

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 7a0128815..328f410da 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -479,7 +479,6 @@ enum wireless_mode {
 #define P80211_OUI_LEN 3
 
 struct rtllib_snap_hdr {
-
 	u8    dsap;   /* always 0xAA */
 	u8    ssap;   /* always 0xAA */
 	u8    ctrl;   /* always 0x03 */
-- 
2.20.1

