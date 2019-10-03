Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6876C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA0821A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8DW/BVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfJCMZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:25:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34549 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfJCMZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:25:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id a11so2728980wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 05:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kV9zD3uPi2Di+JDBMvIhoGzUBhhzE8EsX3G3Pd160Mg=;
        b=V8DW/BVJzXo83wv+ti+YBzIQbU/EjZU8jXLzTaUOimwwfAdnB7yMfiY/2u0Zp/8J/n
         OO9VWqoqqFB9/uPCgkJ//TsbKC88/NPnTEiITwUP4dWbSYYolhylZude1ZhxhAiZnrWX
         wUqNUhmmlcnNSqW03PI2RVjA/dDT+Dcv8sbu3+L1S7H6TFwzotYP2kLef2ETDL43Tb9L
         pKGRQ53KW3YOs0KbfMZpgTb4paCq87eCwcMq9pBAtB0CX54YoZ11cEczGui/XnGRDxu4
         bdhsxCl3fl3a9D6BHElIEnCm66/7Y3iB4spRPBd/PESr+4XPpiyDAMUUEWSZH9TMJsVF
         8/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kV9zD3uPi2Di+JDBMvIhoGzUBhhzE8EsX3G3Pd160Mg=;
        b=Hio2lrfAgL/L9aNOMp7Xxyjgw9DFTkHiruz6fkXeZ0r4o02H4KJN3b+RhX/dSZmedS
         3MFOmH6My5c2sB08oe3+3s2kFNu/14l9+CdmgtIDnC07JpKmySk87UHp6vF7HewgwHPY
         TDuKPSRjiOLuly60Wm1zJHw4IkuvfU1GArThfpaU0A0QETAN748timRIgq1KgDIEaWh+
         K9zCn9Qhj/YHNuk/q6iDhQuVXVn8dlFNPdZbRielfP/SyZNJNY8ehRQZAJpWvZO/22jX
         OikEBcz5co4NCpZyiwFqQqANiIMZITkzkDFY9SbOw4zl1cRGJ5tPzraEUlgrNB3JmPG5
         LeZg==
X-Gm-Message-State: APjAAAXAxN0cRWXShTOtj7SdhVaBGhZ59stmFpHFOD8lYvlYrlV2eLl3
        JGiOaNQ424+g0uGNzo8q+Yg=
X-Google-Smtp-Source: APXvYqyI7O5U6bzRp+8a31fdCe0kFkw+s+Pm1GROZezzzHsmTS6VCjKEMIo458h06THaxOS6yJNOng==
X-Received: by 2002:a5d:42cb:: with SMTP id t11mr6541793wrr.99.1570105533510;
        Thu, 03 Oct 2019 05:25:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id f17sm2699322wru.29.2019.10.03.05.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 05:25:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: rtl8188eu: cleanups in update_hw_ht_param()
Date:   Thu,  3 Oct 2019 14:25:10 +0200
Message-Id: <20191003122514.1760-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup code in function update_hw_ht_param(). 

Michael Straube (4):
  staging: rtl8188eu: convert variables from unsigned char to u8
  staging: rtl8188eu: rename variables to avoid mixed case
  staging: rtl8188eu: cleanup whitespace in update_hw_ht_param
  staging: rtl8188eu: cleanup comments in update_hw_ht_param

 drivers/staging/rtl8188eu/core/rtw_ap.c | 31 +++++++++++--------------
 1 file changed, 13 insertions(+), 18 deletions(-)

-- 
2.23.0

