Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2654C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709D220657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXzkVbie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfCJRqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 13:46:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40219 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfCJRqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 13:46:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id f11so2645858qti.7;
        Sun, 10 Mar 2019 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hbbIv4Vo3awyWNnS89ULbDFSxYn6LzfN95WMByYY4YQ=;
        b=nXzkVbieUAPZWlevcCZli84Ay/onIUf9XII0o1nL27SwJt0kRkz4VrS5QyaH422W7S
         5gCYwou+Son2Koq9dnmcRwzOsyJkWiUdM21ULrEZfmwV9oR39bYnmdOluXnM/DwRvpOm
         f06lwZySpRQh9N5n5XI+uXFcUjYtsG9NUsTeeLvBWPpiqyYdW5f2H2e63KmBDeSTVHAS
         c2IFydQ6UttxqhKBw/S/oODCi4nihZSzAsPBFKKgpyRCr2I+pz/tML0g9kQTyINHNKxa
         MvqvDkQTXW7vDa8fhiDUShxabvK/uMEpYyuU/oovC7SFQKsXhJ87uphOFc73PFj+OLpv
         lW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hbbIv4Vo3awyWNnS89ULbDFSxYn6LzfN95WMByYY4YQ=;
        b=EJBYBE56MJVQWn2keUA2R38OWlt6Wtw6GmC5hVsuD42xtrJu/zWRnUasl1uIo1TUB1
         Cs0fTEpXsjuDjo+7ZfhAJE4YeXIKX3nkmDFeIRkY85lF4nmJbrr8Yr7FmkM9CNJVl8JI
         UN7H+d1HjRhTLqXOa8271oVZfJNx962RrIuSxZ3yrlvJBfceMayauFAd5gZWJYfs7Pa9
         G2LPRDzxZlo5zuLrRW5FKOOz0ZKiDq4dReih4JPesxVp6NtU9RDEm1LpKUxDt6pT1XfM
         M0aa1zXeDrIKjILhScn/irejtRQU2vLz5d0AJKFCsZ6PRQrSCSqiRbWenbL70jBMdxo9
         B5Ew==
X-Gm-Message-State: APjAAAWiJ6M8ClLNlM42ojQggx8Ejky5Z+7M5Zssh/1ws4OC13NOJWSE
        U5N/0h1KVI1Kqb7tdir9dZQ=
X-Google-Smtp-Source: APXvYqwZjx/QWMxdBPYnnOz03fp2NwxodHwGfqMCWrebN5WP/MWwCVI0XMzguROizvhfD59snGRwOw==
X-Received: by 2002:ad4:5103:: with SMTP id g3mr296575qvp.214.1552240004890;
        Sun, 10 Mar 2019 10:46:44 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id i1sm2001897qtb.0.2019.03.10.10.46.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 10 Mar 2019 10:46:44 -0700 (PDT)
Date:   Sun, 10 Mar 2019 14:46:40 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v3 5/7] staging: iio: ad5933: add ABI documentation
Message-ID: <20190310174640.dksy7pfkptrbcdgj@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an ABI documentation for the ad5933 driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 .../ABI/testing/sysfs-bus-iio-ad5933          | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad5933

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ad5933 b/Documentation/ABI/testing/sysfs-bus-iio-ad5933
new file mode 100644
index 000000000000..8a60dd178b1f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-ad5933
@@ -0,0 +1,39 @@
+What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_start
+Date:		March 2019
+KernelVersion:	Kernel 4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The start frequency. Set this to define the frequency point at
+		which the device should start the next frequency sweep.
+
+What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_increment
+Date:		March 2019
+KernelVersion:	Kernel 4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The frequency sweep increment. Set this to define the amount by
+		which the frequency is incremented after each scan point. After
+		the measurement at a frequency point is completed, the next
+		measurement will be made at a frequency point 
+		'frequency increment'Hz	higher than the previous one unless a
+		repeat frequency command is issued. This behavior will follow
+		until the defined number of frequency points have been measured
+		or frequency sweep is somewhat reset.
+
+What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_points
+Date:		March 2019
+KernelVersion:	Kernel 4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The number of increments. This defines the number of frequency
+		points in the frequency sweep.
+
+What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_settling_cycles
+Date:		March 2019
+KernelVersion:	Kernel 4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Number of settling time cycles. This sets the delay between a
+		start frequency sweep/increment frequency /repeat frequency to
+		be proportional to the excitation signal frequency times the
+		number of settling time cycles.
-- 
2.20.1

