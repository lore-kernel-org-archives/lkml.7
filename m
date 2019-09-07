Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F5BC0030C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 02:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332CB2196E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 02:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567824156;
	bh=N1zCtYdfz6IPFrdGpdXh9jUSgmObjnjYMcgU90vUt1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jQirJRdCJi5zZA2ETYW1yx7poWxK2fYrrBP20clkzAsIu5QrDNBmCtJdV6k/Tj+rm
	 uu0YPGpiQJT0m2jCfZfnEUfxGKi0P29jz7qFvDo1EcXoS95GkSjJ1FwF5m8palfbjd
	 cdgN/qQ1mnNuh72jqTUBPV8fAb9jWLNbjwt7N5DY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394002AbfIGCmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 22:42:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36720 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393925AbfIGCmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 22:42:33 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so17278188iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 19:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VVJL//iLgewkEoRfC7CxEoEman5r0AHZTTZchJ8JH74=;
        b=CXsXdGbMgo8B0HLcKkmewkbaKyj9JGp1eZlWDCG8gf1EZhun7k8O0NDkuOm8RZwZSc
         KxM/uuNIEqDFy1X9oepAbzs28JBIf7cJC/iapejp4rdEPWRpej5XP48jwlN626yCWjla
         Wi7sn4TuyUrZ27Ck/R8Xr4/xrt2nB1PHJBTHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VVJL//iLgewkEoRfC7CxEoEman5r0AHZTTZchJ8JH74=;
        b=h0mqDUAHmxdZLsIlmB4poT+W/OVrZ/WEDlEPV7r524p9W94R9n0NRXAbtkpSesrVYD
         1CrA5ZRZldQucshFk3yruVRXJfN335hDBvqJV0LMIlGlT9zMWoehS4P02bPIREW02Yhm
         m+Pl3Ds4lYnHwsMFJMDHeRip3dRYbY/Oh0anCSj8u5fYS/tLNDimY6mXFZGAyl75mU+T
         lA11eiDb/bIXzAVGi07ndN35si+T14ad6jo3o196fesfNztnFHYyrczQgBRc3k7i8BuH
         JYOb/NXP2zG19FKAB7kkK7tIbcn7NJyepJjnmRG3x5IC7DtMuu/XEyCMKwn7ADuly2Hl
         Zl8A==
X-Gm-Message-State: APjAAAXsc+0TZ8TiEx1rQA3pUbOg6cXUzBQISuPb+2syPew5XPf0vLD1
        /Fn1D07NcMLV+SRHfHFKHKg1/w==
X-Google-Smtp-Source: APXvYqwhcJ9yQSmrpK2g7TxTbWN+9eG5aQFijRPt0dsWWghjUMmqMpjQJJ9qIVfacitsYqGzeAvdXg==
X-Received: by 2002:a02:3b21:: with SMTP id c33mr13797052jaa.54.1567824152636;
        Fri, 06 Sep 2019 19:42:32 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b7sm6441427iod.78.2019.09.06.19.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 19:42:32 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab@kernel.org, helen.koike@collabora.com,
        skhan@linuxfoundation.org, andrealmeid@collabora.com,
        dafna.hirschfeld@collabora.com, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] doc: media: vimc: Update module parameter usage information
Date:   Fri,  6 Sep 2019 20:42:18 -0600
Message-Id: <bf82fb10fc29c04f4da4de069974d3c584f7435e.1567822793.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1567822792.git.skhan@linuxfoundation.org>
References: <cover.1567822792.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vimc driver is now a monolithic driver. Update the module parameter
usage information to reflect that.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/media/v4l-drivers/vimc.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/media/v4l-drivers/vimc.rst b/Documentation/media/v4l-drivers/vimc.rst
index 406417680db5..a582af0509ee 100644
--- a/Documentation/media/v4l-drivers/vimc.rst
+++ b/Documentation/media/v4l-drivers/vimc.rst
@@ -76,22 +76,22 @@ vimc-capture:
 	* 1 Pad sink
 	* 1 Pad source
 
-Module options
+
+        Module options
 ---------------
 
-Vimc has a few module parameters to configure the driver. You should pass
-those arguments to each subdevice, not to the vimc module. For example::
+Vimc has a few module parameters to configure the driver.
 
-        vimc_subdevice.param=value
+        param=value
 
-* ``vimc_scaler.sca_mult=<unsigned int>``
+* ``sca_mult=<unsigned int>``
 
         Image size multiplier factor to be used to multiply both width and
         height, so the image size will be ``sca_mult^2`` bigger than the
         original one. Currently, only supports scaling up (the default value
         is 3).
 
-* ``vimc_debayer.deb_mean_win_size=<unsigned int>``
+* ``deb_mean_win_size=<unsigned int>``
 
         Window size to calculate the mean. Note: the window size needs to be an
         odd number, as the main pixel stays in the center of the window,
-- 
2.20.1

