Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F97C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9E42171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568738135;
	bh=N1zCtYdfz6IPFrdGpdXh9jUSgmObjnjYMcgU90vUt1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sCNUqpREJCsBAMN96AUhlPwRdi4m4FcdhIEzrV3Vd8CEUseoyiV8TR9f3g+VlAk/8
	 /YyCTDSqvKMnxFqjRO0rwZd/AomYFrnm9547w9j9w+4WQoYyfy4RP4qjbV9iMBYnCa
	 9IsyIaB535uxg8RONy4xMa+vHlfCTRd+E6uOXPNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbfIQQfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:35:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33680 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbfIQQfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:35:22 -0400
Received: by mail-io1-f66.google.com with SMTP id m11so9221651ioo.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VVJL//iLgewkEoRfC7CxEoEman5r0AHZTTZchJ8JH74=;
        b=OubrW9S48K1g7uFLUI7/zdWhbZmzku0sG+Nhd8AwOW7CSGHvs/Z9b6+gZyg+sqsdF6
         Q6zJZMOJSHVeqyT1TsznCMpK2XWpajqZAMVVDOy9cIXTDMv6oIlo2VUQwB6GgUkyhNxG
         fw1N9WrsgavfRe6U5Loa41EJOuzhUnE7RemXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VVJL//iLgewkEoRfC7CxEoEman5r0AHZTTZchJ8JH74=;
        b=IQ5U0RUYXEUJw+xgjysPnCOw9pc+7ekAdwQqdv/nEi4V3m42s4akdToPYYy95q8YEM
         HxMGRAxMjCFqU8fwG+JgfuPBm1RgovxbVQUhx+M+F+C06v35/D6gkMRcvv4H0k23orrI
         0uJOuhZUxI+OKXa//ZD2hHaguypQ1FP+aqori5fAkTlWjXxnjO7wOtw1jxnbhS1p5/RZ
         6klEEHlA/PzXFTQ1bDSrrRlYEQrg/NF6FhaQKYli1AxN1cIaFXJXeWg1RZn9LzQPHgid
         nJO5m5hsjoTbLtbtfxeR7T2bb2nb0CTA9yZWWya8s06NppRm1psmid4ykKrlhwvO797S
         FD1g==
X-Gm-Message-State: APjAAAXv1rQK6xT8S0vi3I/p1nMmmPXfH8xifzhNok/SZaIdlc3FAQQ8
        UzjWazF0TfC8N8BBr+PkYmsV4A==
X-Google-Smtp-Source: APXvYqxfbzWoJgWSpGE8if7ltPy0aR4ZcyEh3dO0n7WdjWUwwfzIKTeQ9T1Ymv3OWkH26HL19qL+wg==
X-Received: by 2002:a05:6638:3a5:: with SMTP id z5mr2781140jap.95.1568738121535;
        Tue, 17 Sep 2019 09:35:21 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v3sm2593781ioh.51.2019.09.17.09.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 09:35:21 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab@kernel.org, helen.koike@collabora.com,
        skhan@linuxfoundation.org, andrealmeid@collabora.com,
        dafna.hirschfeld@collabora.com, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/5] doc: media: vimc: Update module parameter usage information
Date:   Tue, 17 Sep 2019 10:35:11 -0600
Message-Id: <f21e40f304507dffe2de240fdaeb881305c270ca.1568689325.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1568689325.git.skhan@linuxfoundation.org>
References: <cover.1568689325.git.skhan@linuxfoundation.org>
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

