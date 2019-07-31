Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0044EC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E72206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWc+Afyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfGaSTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:19:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34044 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfGaSTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:19:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so32329762pfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=e0gVq6uy00cY6V3t0O5fCn9fm+ZnY+YHyPLBNweEeig=;
        b=EWc+AfytrePtRJmEbBdd1N1YdQb0s26K0I8f3iwJU8tRvHSw1+z/FjCaGin2jzyAez
         8uXcOmsUUV/nl/gZczxf6yUeh+1DqpyqaihJUa+srT4ZMKiV2B/5yxDznsfNFcMGp7op
         thkoFXnGxyZPalFv9iHZ2ai2C32G2SK5k5eXtapW+S7cvQBJ0+hOp7BEL6wZycHv+BHE
         FqQruUo4fSHHp7hQV8yGiYtK/XRbshryulJNMDl8htn1UJJ8zlXtoKGfonLlYYpGDZ+Z
         DPV8LZtNCZMKbXX0tOuBHvgQYn/KjlTbHb1e6KRHN7z9r/gcdLu66urKNLyaavw8Fk3p
         LvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=e0gVq6uy00cY6V3t0O5fCn9fm+ZnY+YHyPLBNweEeig=;
        b=Wbmr3yDYtwlaDXZ3oI9U7+bNSHQ9zZD8sLxqObiNHeNXUXW4jf2ylCisvMmQ1dd00g
         Ztix8RUUxZ860NmLujBk9V0J0B3IOZbzIZaX3xZ42ZNDztlv70MR6dKAgRto16BzB9ab
         GoSAV4ZN2w9QRj+vca8fGKVnoHsgaD98sf2ADOos9JzQ8WwMndQ/G9onDBMFKoP+bj8U
         CFljl2SsOS2wV4YGMchnTaiJab7SmT5HOezUEyLQxQ3G7qpiHmK/Q0dR+kdfE4XGjCtB
         SoDDGR8eE8lr5qwI8qpvpSbY5co0MWwY5ED/I3R+dZDWd+Qf32QOzS+6w9CwxxhDkRXk
         /o/A==
X-Gm-Message-State: APjAAAU6sEaR0rW4NVctqywJ0qaS+xcweMs8xpxVbMHTkiCZjlqnCIko
        HKgShRlxIO5T0AY0ckk2GiM=
X-Google-Smtp-Source: APXvYqx9+Ao6DKAXKMVrhBtgZRmkqziTJWZ3wkHgIlFSCp2BGCIzyU5oU3YbeUH35XPlNymmENDeww==
X-Received: by 2002:a17:90a:cf8f:: with SMTP id i15mr4095141pju.110.1564597146552;
        Wed, 31 Jul 2019 11:19:06 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id s66sm73305597pfs.8.2019.07.31.11.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 11:19:06 -0700 (PDT)
Date:   Wed, 31 Jul 2019 23:49:00 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [Patch v2 06/10] staging: rtl8723bs: os_dep: Remove unused defines
 related to combo scan
Message-ID: <20190731181900.GA9503@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove below defines WEXT_CSCAN_AMOUNT WEXT_CSCAN_BUF_LEN
WEXT_CSCAN_NPROBE_SECTION

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
v2 - Add patch number

 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 99e6b10..73b412e 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -21,13 +21,10 @@
 #define RATE_COUNT 4
 
 /*  combo scan */
-#define WEXT_CSCAN_AMOUNT 9
-#define WEXT_CSCAN_BUF_LEN		360
 #define WEXT_CSCAN_HEADER		"CSCAN S\x01\x00\x00S\x00"
 #define WEXT_CSCAN_HEADER_SIZE		12
 #define WEXT_CSCAN_SSID_SECTION		'S'
 #define WEXT_CSCAN_CHANNEL_SECTION	'C'
-#define WEXT_CSCAN_NPROBE_SECTION	'N'
 #define WEXT_CSCAN_ACTV_DWELL_SECTION	'A'
 #define WEXT_CSCAN_PASV_DWELL_SECTION	'P'
 #define WEXT_CSCAN_HOME_DWELL_SECTION	'H'
-- 
2.7.4

