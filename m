Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F115C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D97E2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWkdkXjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfDBGbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:31:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42007 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBGbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:31:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so5814492pfn.9;
        Mon, 01 Apr 2019 23:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=82SzGL+dDrDrdF7a/L+pw1B8d27zaqfl1K0+UvDKEBk=;
        b=AWkdkXjPM9jKJ/FBkzzrKCTtM2zDZLPz/0VBrzDEjZewLdw7S1N0/J/Wzm6Hd0cQUy
         SPks6JE8eIMbVvLb0a4OqQ4laWBi/BwsXRqP533Lb+0vI41q+QGUwG4sbygoaCqXhskQ
         EEibYKqbJtYLIKfvT/GXsTb7dWmC+XvWTJVy3B8nh9UBYyELUGqr4sefW9AeIQnvoTZt
         fguv9MXl6GgLQSpX9N+3qNMtRlo85Z9wxfDrd3O8CCDx/+Uh3+shxfZQSmcLhAiBm0Tw
         2tDgU95OAvNv4jGaBP/zws7IDfZP+qwzkx83LEX1UDfrGYZVTz/WNbtysk6rw9eKttm5
         8ZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82SzGL+dDrDrdF7a/L+pw1B8d27zaqfl1K0+UvDKEBk=;
        b=YRBojLZ63A4+y0BprqvEQGAqKmtQ7JuIqCW7z1T+h7OZzvmH4akXAimo172ysrLCsP
         wQ/gGWrtlR0CotR0Qsnu/wpqOFGOFMt6RZZuQFjCYw4yFWu3pkY44yZYsZ69qhpZSIkN
         9+cDszVyPVzcZzOd6DP5E2FKfpKhuDd7wxHuA3JdlL15CS58mKs6YaCUViPSds5UQxRC
         0+RnXFAmmgoBnIRODSMsx578QSLzLhTHp4I6pQUMjk7D06nZLKdS9krzrZhYSpS125ow
         Fg+mhrhxXq03DUzuh/+obtA2avpc61TI8lY7U1pfd049FloyNtOUlBVzhsZnhcRogUlU
         emLg==
X-Gm-Message-State: APjAAAVZ1FHoGmHaeIlKJn57eVPlaU6bfI2rudEd4x0tDVUfUi44X6ro
        Y0h7VD3T53WMriVw4zn5XG8=
X-Google-Smtp-Source: APXvYqyVC7xYZcFOZlQSgA8iyuaZfJ8F7kWF1o5LWZdzWpAa7yMl07z/TP6hWXOLoe3zitewlsFYnw==
X-Received: by 2002:aa7:8083:: with SMTP id v3mr50669006pff.135.1554186672607;
        Mon, 01 Apr 2019 23:31:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 23:31:12 -0700 (PDT)
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
Subject: [PATCH v10 06/18] counter: 104-quad-8: Documentation: Add Generic Counter sysfs documentation
Date:   Tue,  2 Apr 2019 15:30:41 +0900
Message-Id: <90ea2b39df0194bcf6389802c1b6e22decdf2f8f.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds standard documentation for the Generic Counter interface
userspace sysfs attributes of the 104-QUAD-8 driver.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../ABI/testing/sysfs-bus-counter-104-quad-8  | 36 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
new file mode 100644
index 000000000000..46b1f33b2fce
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
@@ -0,0 +1,36 @@
+What:		/sys/bus/counter/devices/counterX/signalY/index_polarity
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Active level of index input Signal Y; irrelevant in
+		non-synchronous load mode.
+
+What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_available
+What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_available
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available values for the respective Signal Y
+		configuration are listed in this file.
+
+What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Configure the counter associated with Signal Y for
+		non-synchronous or synchronous load mode. Synchronous load mode
+		cannot be selected in non-quadrature (Pulse-Direction) clock
+		mode.
+
+		non-synchronous:
+			A logic low level is the active level at this index
+			input. The index function (as enabled via preset_enable)
+			is performed directly on the active level of the index
+			input.
+
+		synchronous:
+			Intended for interfacing with encoder Index output in
+			quadrature clock mode. The active level is configured
+			via index_polarity. The index function (as enabled via
+			preset_enable) is performed synchronously with the
+			quadrature clock on the active level of the index input.
diff --git a/MAINTAINERS b/MAINTAINERS
index 663e7a62752a..d3d93a5d3b10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -272,6 +272,7 @@ ACCES 104-QUAD-8 DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 F:	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
 F:	drivers/counter/104-quad-8.c
 
-- 
2.21.0

