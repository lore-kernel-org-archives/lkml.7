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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D77C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C81206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw0WAlbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfDBGcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:32:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35049 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDBGcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:32:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so5838251pfe.2;
        Mon, 01 Apr 2019 23:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=svskp7QoINQnHTiaUtBOVYrxeQ5QnKH9lu/Zsj/N//s=;
        b=Hw0WAlbzJsmhP/ZYLuuqIDUxu8G91MVcKWTy8fa0ekMx9gr12t/mcsw+A/DP3DhX1V
         l0z7FVWuNOvDfauDl3dtlj+/an3Iqrcik8h3WndhibdoAcfoZYK++qaNK42nkktj9x1G
         xejGpkYQAtWcYuh8kQHxqskYXrU315oP13Ozm/sZMMEz5mpGS8UTLSq83L/utKKEZ2WJ
         inm0ADGLe+ytH4kkWyCbsdw9EhL3/0YoBF61lb3nIf+1/yg/qdiouCWYvyIDtkg4m8hd
         1b+EhkO0NrqhAPzigiqPz+4ppE2FTZO9pf9hnjJZAyzq95HCzqUztHYKkJNvP5uyazfv
         vkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=svskp7QoINQnHTiaUtBOVYrxeQ5QnKH9lu/Zsj/N//s=;
        b=seNspA/EN/t7Joe9bAm1r79Wa3DYHX8U9rm+akj+BWSuliF07uEwiIo7FQEKbb7afO
         s/oP951TJtVs9BqjETC5VHLfUNMEHgweLdWISzOgO48hDFoea6L0jNmA2HTV3Sjcnj9b
         nFePuXGdcx1RQ+M6suKCvou9IcnZLENz6eBf4yR/nubfKtyner/n3RjE3z1CAw/Ci3Qj
         QkKiEMjTMSOXT9Vjh0gg2ZnYf5IDYCyxyXuRujhIWm81F76ntM5rYC4SHxbOUhrefn+L
         BvuZGOj5WaKIKsmeZi4j6bNY9I3NtnsrbxpwkYcpH6hxjW5fZQAzbiRwM9mFet/g/0CQ
         TTeQ==
X-Gm-Message-State: APjAAAVg676L0s8eWZ5IenKnposfohyjhEpur4gZw/bKnYF3ybFQ76Ot
        DirhQ6T7LzGsFHtPYS8QtUE=
X-Google-Smtp-Source: APXvYqyMJRpEUbsbfFckbE3oVErEbk4bfC3cfg3HieAJxmwDASP5WRC+RYolJFJE9eQ4k7wBLzWZHQ==
X-Received: by 2002:a62:ae13:: with SMTP id q19mr65909898pff.152.1554186722023;
        Mon, 01 Apr 2019 23:32:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 23:32:01 -0700 (PDT)
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
Subject: [PATCH v10 11/18] iio: counter: Add deprecation markings for IIO Counter attributes
Date:   Tue,  2 Apr 2019 15:30:46 +0900
Message-Id: <997556b04cbc210adf1cd202114f5064ec7bb9dd.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IIO counter subdirectory is now superceded by the Counter subsystem.
This patch adds deprecation warnings to the documentation of the
relevant IIO Counter sysfs attributes.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio          |  8 ++++++++
 .../ABI/testing/sysfs-bus-iio-counter-104-quad-8 | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 864f8efd12e5..6aef7dbbde44 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1656,6 +1656,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_raw
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Raw counter device counts from channel Y. For quadrature
 		counters, multiplication by an available [Y]_scale results in
 		the counts of a single quadrature signal phase from channel Y.
@@ -1664,6 +1666,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_raw
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Raw counter device index value from channel Y. This attribute
 		provides an absolute positional reference (e.g. a pulse once per
 		revolution) which may be used to home positional systems as
@@ -1673,6 +1677,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_direction_available
 KernelVersion:	4.12
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		A list of possible counting directions which are:
 		- "up"	: counter device is increasing.
 		- "down": counter device is decreasing.
@@ -1681,6 +1687,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_direction
 KernelVersion:	4.12
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Raw counter device counters direction for channel Y.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_raw
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
index 7fac2c268d9a..bac3d0d48b7b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
+++ b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
@@ -6,6 +6,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_index_synchronous_mode_available
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Discrete set of available values for the respective counter
 		configuration are listed in this file.
 
@@ -13,6 +15,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_mode
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Count mode for channel Y. Four count modes are available:
 		normal, range limit, non-recycle, and modulo-n. The preset value
 		for channel Y is used by the count mode where required.
@@ -47,6 +51,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_noise_error
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Read-only attribute that indicates whether excessive noise is
 		present at the channel Y count inputs in quadrature clock mode;
 		irrelevant in non-quadrature clock mode.
@@ -55,6 +61,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_preset
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		If the counter device supports preset registers, the preset
 		count for channel Y is provided by this attribute.
 
@@ -62,6 +70,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_quadrature_mode
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Configure channel Y counter for non-quadrature or quadrature
 		clock mode. Selecting non-quadrature clock mode will disable
 		synchronous load mode. In quadrature clock mode, the channel Y
@@ -83,6 +93,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_set_to_preset_on_index
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Whether to set channel Y counter with channel Y preset value
 		when channel Y index input is active, or continuously count.
 		Valid attribute values are boolean.
@@ -91,6 +103,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_index_polarity
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Active level of channel Y index input; irrelevant in
 		non-synchronous load mode.
 
@@ -98,6 +112,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_synchronous_mode
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Configure channel Y counter for non-synchronous or synchronous
 		load mode. Synchronous load mode cannot be selected in
 		non-quadrature clock mode.
-- 
2.21.0

