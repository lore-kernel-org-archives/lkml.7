Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23891C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1E92084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsVsUpDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfDBGae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:30:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33291 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfDBGad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:30:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id b12so6039533pgk.0;
        Mon, 01 Apr 2019 23:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3TIN7GVmzZf2vc4K8K5AuMdS/7XAlZhj8cjpR6bpjs=;
        b=JsVsUpDoZ8mC7tNQGcsRzmeEU0alBBVqm5MslrRSC6T2ZRVw+zUqt5rkWJPxMciLun
         u1i9k9xtM7TlZs7oEbetVzr+i3i4A49Y87c5Mnd8cseTs6iZILi+vQRtwcijBUdNfCRb
         +nTtiJ1hSXrpi2IK5px1Acc9Z4uLWXcrCIikshC3zYiwtMYyHAh8twl5Iy3ELpSpOvT4
         Uo3t9KZC8d5Egtkyew32U3Qx7qUMG6Om1tO8BNDXO30ragx0q7HIT5cpWIZOjUYVnoT+
         SoXITqElV2aKCzMkVYJGgaYBQYAiVGcrKp3GZezuaueYlH+Zlp4NqkPcIDSkw9996Gt0
         V8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3TIN7GVmzZf2vc4K8K5AuMdS/7XAlZhj8cjpR6bpjs=;
        b=UpTC3znTdvzIx0bXHl6zhRtfOicaKkB0+TDhk3rABUoi6JUTcYIeckPsZBnRcoWWR9
         FRTeSTbgQ0q2ICgF9KMTWDy8xaQ10qy+n6XKNwgYposeILdoFkA7I+SUKweS+D0dBXhJ
         +u45i8EaiWzHIyy1fb9HSkSJ9AkH//948ez2X3gBZsCJ3jz3F0VLMEfPNB0K++af4NPH
         1KVhUmUkcqRgYp4v8/F51T4MbuWdCQpRFhGM7cENJoPlxVL5VgjaQmIyRcZebjzfjrZP
         mk4I3rrR85ngR74zUm6aUrV0pH6vrbhrgb7j4a2QW4Pc8HG7jfAo1wz2UYGMIk3nWg5Q
         nFlg==
X-Gm-Message-State: APjAAAWKwmmgVGAhl4oofCNqNv5hFr55bbw5JjCOafTxWGRbD9NPqRla
        iCpyce8Q3VdhlssNJbASlNg=
X-Google-Smtp-Source: APXvYqzSeGoSAa/6Nug0zyY9tEFUnup6xUq83Lxmbp4KhfmcdS/VfA1Xkq1I1CPJp/NHDZYDlGfFwQ==
X-Received: by 2002:a63:fc43:: with SMTP id r3mr47039829pgk.44.1554186632252;
        Mon, 01 Apr 2019 23:30:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 23:30:31 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        thierry.reding@gmail.com, esben@haabendal.dk,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patrick.havelange@essensium.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v10 02/18] counter: Documentation: Add Generic Counter sysfs documentation
Date:   Tue,  2 Apr 2019 15:30:37 +0900
Message-Id: <bd8362f23b99af938c7bced2104eca29888253b3.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds standard documentation for the userspace sysfs
attributes of the Generic Counter interface.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 230 ++++++++++++++++++++
 MAINTAINERS                                 |   1 +
 2 files changed, 231 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
new file mode 100644
index 000000000000..566bd99fe0a5
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -0,0 +1,230 @@
+What:		/sys/bus/counter/devices/counterX/countY/count
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count data of Count Y represented as a string.
+
+What:		/sys/bus/counter/devices/counterX/countY/ceiling
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count value ceiling for Count Y. This is the upper limit for the
+		respective counter.
+
+What:		/sys/bus/counter/devices/counterX/countY/floor
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count value floor for Count Y. This is the lower limit for the
+		respective counter.
+
+What:		/sys/bus/counter/devices/counterX/countY/count_mode
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count mode for channel Y. The ceiling and floor values for
+		Count Y are used by the count mode where required. The following
+		count modes are available:
+
+		normal:
+			Counting is continuous in either direction.
+
+		range limit:
+			An upper or lower limit is set, mimicking limit switches
+			in the mechanical counterpart. The upper limit is set to
+			the Count Y ceiling value, while the lower limit is set
+			to the Count Y floor value. The counter freezes at
+			count = ceiling when counting up, and at count = floor
+			when counting down. At either of these limits, the
+			counting is resumed only when the count direction is
+			reversed.
+
+		non-recycle:
+			The counter is disabled whenever a counter overflow or
+			underflow takes place. The counter is re-enabled when a
+			new count value is loaded to the counter via a preset
+			operation or direct write.
+
+		modulo-n:
+			A count value boundary is set between the Count Y floor
+			value and the Count Y ceiling value. The counter is
+			reset to the Count Y floor value at count = ceiling when
+			counting up, while the counter is set to the Count Y
+			ceiling value at count = floor when counting down; the
+			counter does not freeze at the boundary points, but
+			counts continuously throughout.
+
+What:		/sys/bus/counter/devices/counterX/countY/count_mode_available
+What:		/sys/bus/counter/devices/counterX/countY/error_noise_available
+What:		/sys/bus/counter/devices/counterX/countY/function_available
+What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available values for the respective Count Y
+		configuration are listed in this file. Values are delimited by
+		newline characters.
+
+What:		/sys/bus/counter/devices/counterX/countY/direction
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the count direction of Count
+		Y. Two count directions are available: forward and backward.
+
+		Some counter devices are able to determine the direction of
+		their counting. For example, quadrature encoding counters can
+		determine the direction of movement by evaluating the leading
+		phase of the respective A and B quadrature encoding signals.
+		This attribute exposes such count directions.
+
+What:		/sys/bus/counter/devices/counterX/countY/enable
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Whether channel Y counter is enabled. Valid attribute values are
+		boolean.
+
+		This attribute is intended to serve as a pause/unpause mechanism
+		for Count Y. Suppose a counter device is used to count the total
+		movement of a conveyor belt: this attribute allows an operator
+		to temporarily pause the counter, service the conveyor belt,
+		and then finally unpause the counter to continue where it had
+		left off.
+
+What:		/sys/bus/counter/devices/counterX/countY/error_noise
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates whether excessive noise is
+		present at the channel Y counter inputs.
+
+What:		/sys/bus/counter/devices/counterX/countY/function
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count function mode of Count Y; count function evaluation is
+		triggered by conditions specified by the Count Y signalZ_action
+		attributes. The following count functions are available:
+
+		increase:
+			Accumulated count is incremented.
+
+		decrease:
+			Accumulated count is decremented.
+
+		pulse-direction:
+			Rising edges on signal A updates the respective count.
+			The input level of signal B determines direction.
+
+		quadrature x1 a:
+			If direction is forward, rising edges on quadrature pair
+			signal A updates the respective count; if the direction
+			is backward, falling edges on quadrature pair signal A
+			updates the respective count. Quadrature encoding
+			determines the direction.
+
+		quadrature x1 b:
+			If direction is forward, rising edges on quadrature pair
+			signal B updates the respective count; if the direction
+			is backward, falling edges on quadrature pair signal B
+			updates the respective count. Quadrature encoding
+			determines the direction.
+
+		quadrature x2 a:
+			Any state transition on quadrature pair signal A updates
+			the respective count. Quadrature encoding determines the
+			direction.
+
+		quadrature x2 b:
+			Any state transition on quadrature pair signal B updates
+			the respective count. Quadrature encoding determines the
+			direction.
+
+		quadrature x4:
+			Any state transition on either quadrature pair signals
+			updates	the respective count. Quadrature encoding
+			determines the direction.
+
+What:		/sys/bus/counter/devices/counterX/countY/name
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		Count Y. If possible, this should match the name of the
+		respective channel as it appears in the device datasheet.
+
+What:		/sys/bus/counter/devices/counterX/countY/preset
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If the counter device supports preset registers -- registers
+		used to load counter channels to a set count upon device-defined
+		preset operation trigger events -- the preset count for channel
+		Y is provided by this attribute.
+
+What:		/sys/bus/counter/devices/counterX/countY/preset_enable
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Whether channel Y counter preset operation is enabled. Valid
+		attribute values are boolean.
+
+What:		/sys/bus/counter/devices/counterX/countY/signalZ_action
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Action mode of Count Y for Signal Z. This attribute indicates
+		the condition of Signal Z that triggers the count function
+		evaluation for Count Y. The following action modes are
+		available:
+
+		none:
+			Signal does not trigger the count function. In
+			Pulse-Direction count function mode, this Signal is
+			evaluated as Direction.
+
+		rising edge:
+			Low state transitions to high state.
+
+		falling edge:
+			High state transitions to low state.
+
+		both edges:
+			Any state transition.
+
+What:		/sys/bus/counter/devices/counterX/name
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		the Counter. This should match the name of the device as it
+		appears in its respective datasheet.
+
+What:		/sys/bus/counter/devices/counterX/num_counts
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the total number of Counts
+		belonging to the Counter.
+
+What:		/sys/bus/counter/devices/counterX/num_signals
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the total number of Signals
+		belonging to the Counter.
+
+What:		/sys/bus/counter/devices/counterX/signalY/signal
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Signal data of Signal Y represented as a string.
+
+What:		/sys/bus/counter/devices/counterX/signalY/name
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		Signal Y. If possible, this should match the name of the
+		respective signal as it appears in the device datasheet.
diff --git a/MAINTAINERS b/MAINTAINERS
index ef497d470501..af701863a249 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3970,6 +3970,7 @@ COUNTER SUBSYSTEM
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-counter*
 F:	drivers/counter/
 F:	include/linux/counter.h
 F:	include/linux/counter_enum.h
-- 
2.21.0

