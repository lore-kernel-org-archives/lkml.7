Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82580C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBFD20661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgtK9Xky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfLCJh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:37:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33487 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfLCJhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:37:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id y23so1893509wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 01:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oCN7pz3yAoKGoMLvmy5rlcCyhRV2qLjVV6V8OqEy5PE=;
        b=bgtK9XkyFkP1bsI29YXYqdbMkGSQjyI28y6K/8WybibRvbWCTqShPJGZkU0YrzmoR3
         9M8V6TtPnfjrvL6Xb2JHhWf6IoA41e+O2x40OgWnVmZvldHQq9uU9wGLCPI/SmTZ/d5E
         kmsPZNBRa5nsHt0v/zcRSGrcdQIBHl3wmOWpdySleKbqNmg+XFmG/dni+BVDE8SVtm6M
         wOj2ZyJDObQjH9R2l7qsdcuBqe1xIdy3w9zhZcHY001OCckQzUCuhcFOeu01uJYeQLci
         oRHmBFznR6KAwiOTh7VbR4GbzVP19nk5XFDRQ+GtUAoTcCoXv43aAMq8uASL4CO/M7RG
         CvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oCN7pz3yAoKGoMLvmy5rlcCyhRV2qLjVV6V8OqEy5PE=;
        b=o6Ujmr17NWInmwSX+8E0cZKMJMzgUP4t/AMqSILlwMfdMwfaPZI3QZQWjp2Te9l63I
         Di4znO0KteVGr/vLD6gnnEs3hw1iUIYmxkmbnkFXT8GXC6dsjYzhMFSopUMz8xCayEtA
         ejzhCC/l1o7KedUzTWxyL8S+yEBD0SMSgS4NAUQVatlZI4p1Rr7MgbHjgJXN2Sz8hY0O
         y0XuppgCwd++rfXF/WEvqdLtLp8v9E2zfDgs862l39JbM7u/SNuGtFwyumt3TctJFBNe
         Y7dmK7ToLf6XPZ+Q5i4PgNsdd1FXjh/LaVMy6bKrasritFupwJy75pSOC7q80eJjTZ5k
         DATQ==
X-Gm-Message-State: APjAAAX7lmkWzoG6OJqfE1mfZNeG9xuzyh/nZ1bIf0cvLuLUq+A/mkEp
        +5o2TfcuJzbhx+GIgiypXNDVzg==
X-Google-Smtp-Source: APXvYqyXUpra7J9XUgJTFsT+iufEQ4Tcv7s9+1tOrfuu+RhyxB1ghRETwz9NvfKEJHygwSUFWsMzRg==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr32458430wmi.152.1575365832444;
        Tue, 03 Dec 2019 01:37:12 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:8196:cbcc:fb2c:4975])
        by smtp.gmail.com with ESMTPSA id w13sm2935751wru.38.2019.12.03.01.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 01:37:11 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org, rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, edubezval@gmail.com, linux-pm@vger.kernel.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/4] thermal/drivers/cpu_cooling: Add idle cooling device documentation
Date:   Tue,  3 Dec 2019 10:37:02 +0100
Message-Id: <20191203093704.7037-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203093704.7037-1-daniel.lezcano@linaro.org>
References: <20191203093704.7037-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide some documentation for the idle injection cooling effect in
order to let people to understand the rational of the approach for the
idle injection CPU cooling device.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../driver-api/thermal/cpu-idle-cooling.rst   | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 Documentation/driver-api/thermal/cpu-idle-cooling.rst

diff --git a/Documentation/driver-api/thermal/cpu-idle-cooling.rst b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
new file mode 100644
index 000000000000..457cd9979ddb
--- /dev/null
+++ b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
@@ -0,0 +1,166 @@
+
+Situation:
+----------
+
+Under certain circumstances a SoC can reach the maximum temperature
+limit or is unable to stabilize the temperature around a temperature
+control. When the SoC has to stabilize the temperature, the kernel can
+act on a cooling device to mitigate the dissipated power. When the
+maximum temperature is reached and to prevent a reboot or a shutdown,
+a decision must be taken to reduce the temperature under the critical
+threshold, that impacts the performance.
+
+Another situation is when the silicon reaches a certain temperature
+which continues to increase even if the dynamic leakage is reduced to
+its minimum by clock gating the component. The runaway phenomena will
+continue with the static leakage and only powering down the component,
+thus dropping the dynamic and static leakage will allow the component
+to cool down.
+
+Last but not least, the system can ask for a specific power budget but
+because of the OPP density, we can only choose an OPP with a power
+budget lower than the requested one and underuse the CPU, thus losing
+performances. In other words, one OPP under uses the CPU with a power
+lesser than the power budget and the next OPP exceed the power budget,
+an intermediate OPP could have been used if it were present.
+
+Solutions:
+----------
+
+If we can remove the static and the dynamic leakage for a specific
+duration in a controlled period, the SoC temperature will
+decrease. Acting at the idle state duration or the idle cycle
+injection period, we can mitigate the temperature by modulating the
+power budget.
+
+The Operating Performance Point (OPP) density has a great influence on
+the control precision of cpufreq, however different vendors have a
+plethora of OPP density, and some have large power gap between OPPs,
+that will result in loss of performance during thermal control and
+loss of power in other scenes.
+
+At a specific OPP, we can assume injecting idle cycle on all CPUs,
+belonging to the same cluster, with a duration greater than the
+cluster idle state target residency, we drop the static and the
+dynamic leakage for this period (modulo the energy needed to enter
+this state). So the sustainable power with idle cycles has a linear
+relation with the OPP’s sustainable power and can be computed with a
+coefficient similar to:
+
+	    Power(IdleCycle) = Coef x Power(OPP)
+
+Idle Injection:
+---------------
+
+The base concept of the idle injection is to force the CPU to go to an
+idle state for a specified time each control cycle, it provides
+another way to control CPU power and heat in addition to
+cpufreq. Ideally, if all CPUs belonging to the same cluster, inject
+their idle cycle synchronously, the cluster can reach its power down
+state with a minimum power consumption and static leakage
+drop. However, these idle cycles injection will add extra latencies as
+the CPUs will have to wakeup from a deep sleep state.
+
+     ^
+     |
+     |
+     |-------       -------       -------
+     |_______|_____|_______|_____|_______|___________
+
+      <----->
+       idle  <---->
+              running
+
+With the fixed idle injection duration, we can give a value which is
+an acceptable performance drop off or latency when we reach a specific
+temperature and we begin to mitigate by varying the Idle injection
+period.
+
+The mitigation begins with a maximum period value which decrease when
+more cooling effect is requested. When the period duration is equal to
+the idle duration, then we are in a situation the platform can’t
+dissipate the heat enough and the mitigation fails. In this case the
+situation is considered critical and there is nothing to do. The idle
+injection duration must be changed by configuration and until we reach
+the cooling effect, otherwise an additionnal cooling device must be
+used or ultimately decrease the SoC performance by dropping the
+highest OPP point of the SoC.
+
+The idle injection duration value must comply with the constraints:
+
+- It is lesser or equal to the latency we tolerate when the mitigation
+  begins. It is platform dependent and will depend on the user
+  experience, reactivity vs performance trade off we want. This value
+  should be specified.
+
+- It is greater than the idle state’s target residency we want to go
+  for thermal mitigation, otherwise we end up consuming more energy.
+
+Minimum period
+--------------
+
+The idle injection duration being fixed, it is obvious the minimum
+period can’t be lesser than that, otherwise we will be scheduling the
+idle injection task right before the idle injection duration is
+complete, so waking up the CPU to put it asleep again.
+
+Maximum period
+--------------
+
+The maximum period is the initial period when the mitigation
+begins. Theoretically when we reach the thermal trip point, we have to
+sustain a specified power for specific temperature but at this time we
+consume:
+
+ Power = Capacitance x Voltage^2 x Frequency x Utilisation
+
+... which is more than the sustainable power (or there is something
+wrong on the system setup). The ‘Capacitance’ and ‘Utilisation’ are a
+fixed value, ‘Voltage’ and the ‘Frequency’ are fixed artificially
+because we don’t want to change the OPP. We can group the
+‘Capacitance’ and the ‘Utilisation’ into a single term which is the
+‘Dynamic Power Coefficient (Cdyn)’ Simplifying the above, we have:
+
+ Pdyn = Cdyn x Voltage^2 x Frequency
+
+The IPA will ask us somehow to reduce our power in order to target the
+sustainable power defined in the device tree. So with the idle
+injection mechanism, we want an average power (Ptarget) resulting on
+an amount of time running at full power on a specific OPP and idle
+another amount of time. That could be put in a equation:
+
+ P(opp)target = ((trunning x (P(opp)running) + (tidle P(opp)idle)) /
+			(trunning + tidle)
+  ...
+
+ tidle = trunning x ((P(opp)running / P(opp)target) - 1)
+
+At this point if we know the running period for the CPU, that gives us
+the idle injection, we need. Alternatively if we have the idle
+injection duration, we can compute the running duration with:
+
+ trunning = tidle / ((P(opp)running / P(opp)target) - 1)
+
+Practically, if the running power is lesses than the targeted power,
+we end up with a negative time value, so obviously the equation usage
+is bound to a power reduction, hence a higher OPP is needed to have
+the running power greater than the targeted power.
+
+However, in this demonstration we ignore three aspects:
+
+ * The static leakage is not defined here, we can introduce it in the
+   equation but assuming it will be zero most of the time as it is
+   difficult to get the values from the SoC vendors
+
+ * The idle state wake up latency (or entry + exit latency) is not
+   taken into account, it must be added in the equation in order to
+   rigorously compute the idle injection
+
+ * The injected idle duration must be greater than the idle state
+   target residency, otherwise we end up consuming more energy and
+   potentially invert the mitigation effect
+
+So the final equation is:
+
+ trunning = (tidle - twakeup ) x
+		(((P(opp)dyn + P(opp)static ) - P(opp)target) / P(opp)target )
-- 
2.17.1

