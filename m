Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C3BC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BF52173E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k839JJSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfH3My6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:54:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38696 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfH3My5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:54:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id e11so3521580pga.5;
        Fri, 30 Aug 2019 05:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZEiY82eKE2uACV/S5DxtDNOMIZl6DIjOCif0L4VFLrU=;
        b=k839JJSeGmhijFzWPRyX49gb6r8QPZLMmkUaUjp1GiFqnFD38Vlq+JvhhG3u7UTf9t
         Up/j5M8GMYhb1xKkzsrHtCT5xzJJ9J6pBZGurlPUU+Yqv0lFIfXLfeuHy1QaAd7yHlyf
         g1bjWCe41mSNkKAib32HB7ykqkeOaMjCwxTFEHtRhOoFy44ZXaJpm+hwvd3Vgvtxdah2
         lu8P9rpI8KsQzGF/31Ubfm7qnwT2/Rh9KYTmiRroPMyAoHmsmUExwCev/6CVAOka1aWh
         FS3/nS9LqUUwOuikgsL2ohEGiuP8eVP0HyDU3hfKiLghNx6SKnX4DZn2QA88vodTBOKU
         RHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZEiY82eKE2uACV/S5DxtDNOMIZl6DIjOCif0L4VFLrU=;
        b=HOyeru+RVHBY2L4Gg1M3aY40kPp3v0cKEpabo8sgzSe0q7dXdF1wMF2iV3/KJCzJOi
         nl5BOkkJ3gxXOj36w0gyAfXGuRwP6o2K7nWEV6t1vuHFpGeBKPjX0u9wUcCm2t8ILXKp
         LD4VOu6IBqMnaKyCJYHgDVXJdI+JASvJdU8CrjR/qivVdWpGgpnTpzCikTn0kxU1C/eb
         oGNQ2lDBr2Bu3jxH+4hXulbWzVuuX9oF2wgd8sc3JN/uJsguBmkEvNCAIKZciEk3Ylgf
         YgHRmUOAexBc1imsyFwmpqGjSNwlaE02hE3vc26wo9vhngufllr/lOhg3eUvswNcVBU6
         B8ug==
X-Gm-Message-State: APjAAAU0E3rCDpUYeOHKAugRFXz50ZSoEbLeFOAVtI2htXm84U8X0usG
        lDpFyiQKZ4l1eE7Wa037yNIXhfDw
X-Google-Smtp-Source: APXvYqz3fdB7HFxVbvIG0JkvRWCmruPHJLvE0YtMrU8AtAJfBbHQdGgf0uZ8+f3PHR5t2YR6tk2WMA==
X-Received: by 2002:a63:9d43:: with SMTP id i64mr12985521pgd.306.1567169696440;
        Fri, 30 Aug 2019 05:54:56 -0700 (PDT)
Received: from localhost.localdomain.com ([115.113.156.3])
        by smtp.gmail.com with ESMTPSA id e189sm5871043pgc.15.2019.08.30.05.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 05:54:55 -0700 (PDT)
From:   ganapat <gklkml16@gmail.com>
X-Google-Original-From: ganapat <ganapat@localhost.localdomain>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, mark.rutland@arm.com, corbet@lwn.net,
        jnair@marvell.com, rrichter@marvell.com, jglauber@marvell.com,
        gkulkarni@marvell.com
Subject: [PATCH v5 1/2] Documentation: perf: Update documentation for ThunderX2 PMU uncore driver
Date:   Fri, 30 Aug 2019 18:24:35 +0530
Message-Id: <20190830125436.16959-2-ganapat@localhost.localdomain>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190830125436.16959-1-ganapat@localhost.localdomain>
References: <20190830125436.16959-1-ganapat@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ganapatrao Kulkarni <ganapatrao.kulkarni@marvell.com>

Add documentation for Cavium Coherent Processor Interconnect (CCPI2) PMU.

Signed-off-by: Ganapatrao Kulkarni <gkulkarni@marvell.com>
---
 .../admin-guide/perf/thunderx2-pmu.rst        | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/perf/thunderx2-pmu.rst b/Documentation/admin-guide/perf/thunderx2-pmu.rst
index 08e33675853a..01f158238ae1 100644
--- a/Documentation/admin-guide/perf/thunderx2-pmu.rst
+++ b/Documentation/admin-guide/perf/thunderx2-pmu.rst
@@ -3,24 +3,26 @@ Cavium ThunderX2 SoC Performance Monitoring Unit (PMU UNCORE)
 =============================================================
 
 The ThunderX2 SoC PMU consists of independent, system-wide, per-socket
-PMUs such as the Level 3 Cache (L3C) and DDR4 Memory Controller (DMC).
+PMUs such as the Level 3 Cache (L3C), DDR4 Memory Controller (DMC) and
+Cavium Coherent Processor Interconnect (CCPI2).
 
 The DMC has 8 interleaved channels and the L3C has 16 interleaved tiles.
 Events are counted for the default channel (i.e. channel 0) and prorated
 to the total number of channels/tiles.
 
-The DMC and L3C support up to 4 counters. Counters are independently
-programmable and can be started and stopped individually. Each counter
-can be set to a different event. Counters are 32-bit and do not support
-an overflow interrupt; they are read every 2 seconds.
+The DMC and L3C support up to 4 counters, while the CCPI2 supports up to 8
+counters. Counters are independently programmable to different events and
+can be started and stopped individually. None of the counters support an
+overflow interrupt. DMC and L3C counters are 32-bit and read every 2 seconds.
+The CCPI2 counters are 64-bit and assumed not to overflow in normal operation.
 
 PMU UNCORE (perf) driver:
 
 The thunderx2_pmu driver registers per-socket perf PMUs for the DMC and
-L3C devices.  Each PMU can be used to count up to 4 events
-simultaneously. The PMUs provide a description of their available events
-and configuration options under sysfs, see
-/sys/devices/uncore_<l3c_S/dmc_S/>; S is the socket id.
+L3C devices.  Each PMU can be used to count up to 4 (DMC/L3C) or up to 8
+(CCPI2) events simultaneously. The PMUs provide a description of their
+available events and configuration options under sysfs, see
+/sys/devices/uncore_<l3c_S/dmc_S/ccpi2_S/>; S is the socket id.
 
 The driver does not support sampling, therefore "perf record" will not
 work. Per-task perf sessions are also not supported.
-- 
2.17.1

