Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB501C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FF221882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMKqtIsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfKGTFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:05:52 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43767 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfKGTFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:05:52 -0500
Received: by mail-qv1-f67.google.com with SMTP id cg2so1237643qvb.10;
        Thu, 07 Nov 2019 11:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W47odrIZjcYj4z0Bgkfmue2TCHoiOu56PCWwIh8207g=;
        b=mMKqtIsq5pYYAfZq2O+8PKS6LuoNfzmmsez9yRUYkHSSU/sFfqaFYiuykAOrmHjpdO
         iPdMku3aBjtDrw1zEfGG1dz17wpBhtqcevu7Lo0iIM8jtfWqkOlyyoIWijjCJq5NVxqB
         X2xB9wMzKESpobnCUIqgKric4uF6oJHLVbvLT3sRVAbCmSA1sE0rc/+NJibDJJBbwL0/
         EKXPuRTmPx7JAYngCv7bhF/FJitCOCP4Or/Q30CCMj+cNoZRNTlp/SvSetRPgG+2kkqM
         Ok1kS5o13/rZYYEOiza/EzqA34y9MN3peKdGtC1itTzYpEzLHQMgk7FPC/Tfg6iCARgF
         DVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W47odrIZjcYj4z0Bgkfmue2TCHoiOu56PCWwIh8207g=;
        b=Pl7lnZ71yU/KJ8qRqKHPodXKS2I9rvbfJVERXO6ckvOq5Ikc7kxYbGXFZr67NaqXs2
         PcG2yM2O5ojl/TE648qwSSuZ+jVUPgdJKL3HlRw/NymSZkmI80G+8NHGk2txgtQZADCG
         uaMgOzQ8h2T6ZNUXD25K7RF1PmAO/OUHhBwwI/H1YGP5X0+OmNJsstF0d2o8Rr81/3aI
         AZUrNN77t4BVfMbUdTXvdE1yA+boCX9wMcRzlT57vEnLq8ehl/8y1r/0yzU9t0tu4KvR
         IrwMnM2wY7GDNmTentxtnMRuQcvFxSCVlhRbQ6kG83YlNXGGcPVmaj5cKDRWT+mYJ9sX
         iIKA==
X-Gm-Message-State: APjAAAVyyVXcNwmiN1ODE5qJ1igVVH44+IFjP0/GUlhSC/Jzm95oJ1Lv
        VrFaId14nVps9ejIlec2bJ0=
X-Google-Smtp-Source: APXvYqxhEAzOELijW4I0V72qVYbNj3+14XAXPmhY2Xi5OjfA8i2GcsCy1+UGFSvZBQ+tREInF2pbCg==
X-Received: by 2002:a0c:a046:: with SMTP id b64mr5088475qva.6.1573153548680;
        Thu, 07 Nov 2019 11:05:48 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id h21sm153692qkj.116.2019.11.07.11.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 11:05:48 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     Frank.li@nxp.com, corbet@lwn.net, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RFC PATCH] Documentation: perf: fix kernel-doc warnings in imx-ddr.rst
Date:   Thu,  7 Nov 2019 15:57:55 -0300
Message-Id: <20191107185755.29586-1-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Unexpected indentation errors were reported due to missing blank lines.
Now fixed. No change in content otherwise.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/perf/imx-ddr.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/perf/imx-ddr.rst b/Documentation/admin-guide/perf/imx-ddr.rst
index 517a205abad6..75c8b46ba6f9 100644
--- a/Documentation/admin-guide/perf/imx-ddr.rst
+++ b/Documentation/admin-guide/perf/imx-ddr.rst
@@ -18,6 +18,7 @@ The "format" directory describes format of the config (event ID) and config1
 devices/imx8_ddr0/format/. The "events" directory describes the events types
 hardware supported that can be used with perf tool, see /sys/bus/event_source/
 devices/imx8_ddr0/events/.
+
   e.g.::
         perf stat -a -e imx8_ddr0/cycles/ cmd
         perf stat -a -e imx8_ddr0/read/,imx8_ddr0/write/ cmd
@@ -31,16 +32,19 @@ in the driver.
   Filter is defined with two configuration parts:
   --AXI_ID defines AxID matching value.
   --AXI_MASKING defines which bits of AxID are meaningful for the matching.
+
         0：corresponding bit is masked.
         1: corresponding bit is not masked, i.e. used to do the matching.
 
   AXI_ID and AXI_MASKING are mapped on DPCR1 register in performance counter.
   When non-masked bits are matching corresponding AXI_ID bits then counter is
   incremented. Perf counter is incremented if
+
           AxID && AXI_MASKING == AXI_ID && AXI_MASKING
 
   This filter doesn't support filter different AXI ID for axid-read and axid-write
   event at the same time as this filter is shared between counters.
+
   e.g.::
         perf stat -a -e imx8_ddr0/axid-read,axi_mask=0xMMMM,axi_id=0xDDDD/ cmd
         perf stat -a -e imx8_ddr0/axid-write,axi_mask=0xMMMM,axi_id=0xDDDD/ cmd
@@ -48,5 +52,6 @@ in the driver.
   NOTE: axi_mask is inverted in userspace(i.e. set bits are bits to mask), and
   it will be reverted in driver automatically. so that the user can just specify
   axi_id to monitor a specific id, rather than having to specify axi_mask.
+
   e.g.::
         perf stat -a -e imx8_ddr0/axid-read,axi_id=0x12/ cmd, which will monitor ARID=0x12
-- 
2.24.0

