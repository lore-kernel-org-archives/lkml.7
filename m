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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54D7C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C6B206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX6JIZqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfDBGdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:33:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45392 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDBGdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:33:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so5816169pfi.12;
        Mon, 01 Apr 2019 23:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dHZ0ys7QT6DS6LbvlqKk410H9kGaWEJZlcsSa1/ZJoE=;
        b=FX6JIZqz0xEX86ficCeBVsIIY/NYiOZpzl/XHvjJ6TU8RYpOvRwUlwPkKEFUL9uOR/
         moSQzqJ5yuOrjJAYZeym+ZuP9M3TPlLGgtRtvEwF1lngzxMM/4SF6R68O8+LweVtSCK6
         hq0Dv6XVHuw2EXQ2Iduf1MctTp41niv4mFVEGRR5V2mSNK2s6o4dbCzkRG4wdDmV0RgO
         Okbavz9RaJc/Vn7fTxoLfkMdVPcAuJp+zVs8N1pqSx+nMoHVAOiecRJQ23BMlsCnN71d
         xcwhGHgckkSshU9sUBZqhd86yQk+TLDvcK6Gpc/O2MdIth2kFA2ymvxtS8JZH0+zqaNM
         reDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dHZ0ys7QT6DS6LbvlqKk410H9kGaWEJZlcsSa1/ZJoE=;
        b=cJqUIxYrljJ2hgGb7nqpEeRSYCdfUisEjlLt7C2HvsBpQyfRrQFx2PgMrcWVzYATN8
         NkU/nramlcdkEv1XEtzJOT3RTGLHhUhbxiJgMLGD4X1CuCWlixOxNHEPmQjdewL36cav
         mvhn4cEeFJqwD3WdLbkoLKM0sbX6X88cptXFSF7pXZV+M26mpQWAmD0iBZfLlkEPPUwV
         eflJgvuX3UJv5xvyNJT2vBIV7DBYEOh0C6+xs9+mGUaB3fM4KHJDnfhC6Ia66fnWTjRl
         LlxKQfxbHHz7pODCJ6PUzoYm8AvBV8H++Ar+odnIUE3BVizp+oxecmBlJJbOh/0LYR4S
         S5HA==
X-Gm-Message-State: APjAAAVs7fNDOucf9b3QTpvHOn3gXSVw1pa5env/teC9+jpF2ZTXHH/f
        hXHr4tXCPyy+4vm9QBnjC4k=
X-Google-Smtp-Source: APXvYqzxU/1cn6HqqwqwGRcNz4T2n8y3agd6WUAA5BYTS+jULwsi9YHs0mVX43LpBeAFRJ3Mo+hlOA==
X-Received: by 2002:a63:7444:: with SMTP id e4mr46906923pgn.261.1554186782569;
        Mon, 01 Apr 2019 23:33:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 23:33:02 -0700 (PDT)
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
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 17/18] counter: ftm-quaddec: Documentation: Add specific counter sysfs documentation
Date:   Tue,  2 Apr 2019 15:30:52 +0900
Message-Id: <3273619b1e22d8dbcd0beccd9a887f14a8aa38e0.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Havelange <patrick.havelange@essensium.com>

This adds documentation for the specific prescaler entry.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../ABI/testing/sysfs-bus-counter-ftm-quaddec    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
new file mode 100644
index 000000000000..7d2e7b363467
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
@@ -0,0 +1,16 @@
+What:		/sys/bus/counter/devices/counterX/countY/prescaler_available
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available values for the respective Count Y
+		configuration are listed in this file. Values are delimited by
+		newline characters.
+
+What:		/sys/bus/counter/devices/counterX/countY/prescaler
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Configure the prescaler value associated with Count Y.
+		On the FlexTimer, the counter clock source passes through a
+		prescaler (i.e. a counter). This acts like a clock
+		divider.
-- 
2.21.0

