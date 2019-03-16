Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF18C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54047218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5k+RklA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfCPPHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:07:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45848 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfCPPHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 11:07:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id z76so7274071qkb.12;
        Sat, 16 Mar 2019 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=teRvH1G/SSs/cdMOyCk2l/NDhqU3BfU90tIYKAgSs+U=;
        b=N5k+RklAnPNQAvM/TrNx+2h7yhAQ4jXqy/Iukq81uMyL/axB3aAGt2rrL6qGMJLPts
         zm4SBSccPxBPRdjm9HEYl/7FRx8VsqhOlmRX1H+OcA7oWPXqegyZbjt7W6RyZw9Hndgs
         O4M37+jFi63dRbTTGrqwYPi3WJCIGLwueS+RN17Zi/gWUjEvW0g6njYz45V50kRohrLf
         yZICe6QQtoNB1tJrd8Jr3xK4v5RhfqvcI68lEGyTbvms+j0l7o5cbV6POYUhh+KOwSdS
         vC1fQFhuz/DVlJOCFLkPlJZocFh44GcxmhEUmci31GOjtUNar177CEYG7Bmpc4hEqfP+
         RQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=teRvH1G/SSs/cdMOyCk2l/NDhqU3BfU90tIYKAgSs+U=;
        b=M9CmPzWp92j3JWslTi8zemg4d/Xw8l5GiJgGQubDrEsNzq9VxxLNC4TBY0mzQz5C+N
         itC0zghNujAaO45nBS3vxjV8Vkq4ZMuurrqFofy2aejREiIMD7pSkj2wvRfsX+BnPqSs
         3IkUXDtzxoidXfN7J3PVpgUKttLKbTdE6zcDraGdCsqPdy2TvTSTeL9e5IcaPExykJBx
         umkT+qE8Fe3Wnx3iA4s9UHNXlp1858p/iWTuP02ckFFQgIGk3aMroh2aDlK4ucGsPhyH
         fpKN/CvHVSr1XJ429C9W1qd0uSS/8o1L4r0X9DRb9u7WwMmGBB8FveH16jj5hYhH3yHI
         aAaw==
X-Gm-Message-State: APjAAAUjIwTKChvzJO4v8ZOoRvSb1jXMctBYJkCbhZd+/ldkYgQCgBHU
        GIo65EiXZg/fYvCQ/Ijn0h4=
X-Google-Smtp-Source: APXvYqzuQ4Nw66cHQIeJASrxV39PB+QIK0Jz+nX0F0bho8vuU9tftC+kivgzRhAR1iq/mvmUchWHmA==
X-Received: by 2002:a37:a94c:: with SMTP id s73mr2912794qke.76.1552748856540;
        Sat, 16 Mar 2019 08:07:36 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d20sm2754273qto.32.2019.03.16.08.07.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 16 Mar 2019 08:07:36 -0700 (PDT)
Date:   Sat, 16 Mar 2019 12:07:32 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v4 5/7] staging: iio: ad5933: add ABI documentation
Message-ID: <20190316150732.umr64uwhi2j4qi7k@smtp.gmail.com>
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
 .../sysfs-bus-iio-impedance-analyzer-ad5933   | 35 +++++++++++++++++++
 .../sysfs-bus-iio-impedance-analyzer-ad5933   | 30 ----------------
 2 files changed, 35 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-impedance-analyzer-ad5933
 delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer-ad5933

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-impedance-analyzer-ad5933 b/Documentation/ABI/testing/sysfs-bus-iio-impedance-analyzer-ad5933
new file mode 100644
index 000000000000..a50aada68e1e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-impedance-analyzer-ad5933
@@ -0,0 +1,35 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_start
+Date:		March 2019
+KernelVersion:	3.1.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Frequency sweep start frequency in Hz.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_increment
+Date:		March 2019
+KernelVersion:	3.1.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Frequency increment in Hz (step size) between consecutive
+		frequency points along the sweep.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_points
+Date:		March 2019
+KernelVersion:	3.1.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Number of frequency points (steps) in the frequency sweep.
+		This value, in conjunction with the
+		out_altvoltageY_frequency_start and the	
+		out_altvoltageY_frequency_increment, determines the frequency 
+		sweep range for the sweep operation.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_settling_cycles
+Date:		March 2019
+KernelVersion:	3.1.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Number of output excitation cycles (settling time cycles)
+		that are allowed to pass through the unknown impedance,
+		after each frequency increment, and before the ADC is triggered
+		to perform a conversion sequence of the response signal.
diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer-ad5933 b/drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer-ad5933
deleted file mode 100644
index 79c7e88c64cd..000000000000
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer-ad5933
+++ /dev/null
@@ -1,30 +0,0 @@
-What:		/sys/bus/iio/devices/iio:deviceX/outY_freq_start
-KernelVersion:	3.1.0
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Frequency sweep start frequency in Hz.
-
-What:		/sys/bus/iio/devices/iio:deviceX/outY_freq_increment
-KernelVersion:	3.1.0
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Frequency increment in Hz (step size) between consecutive
-		frequency points along the sweep.
-
-What:		/sys/bus/iio/devices/iio:deviceX/outY_freq_points
-KernelVersion:	3.1.0
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Number of frequency points (steps) in the frequency sweep.
-		This value, in conjunction with the outY_freq_start and the
-		outY_freq_increment, determines the frequency sweep range
-		for the sweep operation.
-
-What:		/sys/bus/iio/devices/iio:deviceX/outY_settling_cycles
-KernelVersion:	3.1.0
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Number of output excitation cycles (settling time cycles)
-		that are allowed to pass through the unknown impedance,
-		after each frequency increment, and before the ADC is triggered
-		to perform a conversion sequence of the response signal.
-- 
2.20.1

