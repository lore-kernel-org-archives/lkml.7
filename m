Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C437BC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933642085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCGEFHdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfEBHMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:12:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44365 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfEBHMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:12:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so672448pfm.11;
        Thu, 02 May 2019 00:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PKBU7pt8rvrhzoOSyv05XPu1ZaQkpgjUMyroog+NNeg=;
        b=oCGEFHdyBrMaNvRzkrSjazbvihEhYjGKP5k8vSj9bkqv848Mt88G2AdBlGPujjGTzt
         CaySq+CTRVp/Nx++BPv70omHi0/l77MZLmMdVHl7u5YNjf388MenEovTIFy4DNXplx9M
         XPttBa0o6pwfraiPzypQgEc3EBe2IHvQSGATJycrh7CJP1zm+xfcbcyq0rFhlatKAmQS
         1fwFaaFnMtoiDFUKHkaatc1Wybm/0OPQOrGm2Jhqg0DsY7/EbUxF7oKrIk+MgV25y0gA
         Jv4snS8ZZRPaNHGp4gbHN2a/iChz++JcyTOFYWCCL5x0xJIx3zqUgxqEcWEq23FC/699
         psQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PKBU7pt8rvrhzoOSyv05XPu1ZaQkpgjUMyroog+NNeg=;
        b=sr/NGqsnMEnUY4uxIcmopxJtBWGBeuUIrJbk4slBMRQWBPEG1C0GokJEbqVChPK/BK
         eBzj6QcQl2otXPgFypY8wrC2vVhoBb31n8Wjfll/CYhVMlhjnnbzWGkDVLpRXuPwhXCV
         4wTLMiguUTYUTdIugQwdLCOqFACXuMbKs1nosgFW3x62MSY6XpZ4JXNhj/z/RdhxYPng
         3psiEOduMuSJC4QeQW1xnjXczsLPzDThSzP6ZMKeCWoRVqhy8TEqMxkguz+9Y0S9T5PG
         lzLgouD+voLnQ2OaSK0Ycp17iC+1d+V/V+a/zhSHiaT8f/saiQKiY60wx/fvPmhkreAt
         qkqA==
X-Gm-Message-State: APjAAAWiH0BycAR79U2mohfpgk5Yz9Ue6iqQWkhglbWUo4e5IfgwCkbT
        +mAJckad8qmY5TXqKivPsII=
X-Google-Smtp-Source: APXvYqyE4c+8yniLY+crklQailEtZHDTotQES4gMKpDihqPrCQutVnQh+EHFtzkorGpG+iYFg07ZZQ==
X-Received: by 2002:a62:fb16:: with SMTP id x22mr2528077pfm.140.1556781121316;
        Thu, 02 May 2019 00:12:01 -0700 (PDT)
Received: from laptop.DHCP ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u24sm4686976pfh.91.2019.05.02.00.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:12:00 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 26/27] Documentation: x86: convert x86_64/cpu-hotplug-spec to reST
Date:   Thu,  2 May 2019 15:06:32 +0800
Message-Id: <20190502070633.9809-27-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502070633.9809-1-changbin.du@gmail.com>
References: <20190502070633.9809-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../x86/x86_64/{cpu-hotplug-spec => cpu-hotplug-spec.rst}    | 5 ++++-
 Documentation/x86/x86_64/index.rst                           | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)
 rename Documentation/x86/x86_64/{cpu-hotplug-spec => cpu-hotplug-spec.rst} (88%)

diff --git a/Documentation/x86/x86_64/cpu-hotplug-spec b/Documentation/x86/x86_64/cpu-hotplug-spec.rst
similarity index 88%
rename from Documentation/x86/x86_64/cpu-hotplug-spec
rename to Documentation/x86/x86_64/cpu-hotplug-spec.rst
index 3c23e0587db3..8d1c91f0c880 100644
--- a/Documentation/x86/x86_64/cpu-hotplug-spec
+++ b/Documentation/x86/x86_64/cpu-hotplug-spec.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================
 Firmware support for CPU hotplug under Linux/x86-64
----------------------------------------------------
+===================================================
 
 Linux/x86-64 supports CPU hotplug now. For various reasons Linux wants to
 know in advance of boot time the maximum number of CPUs that could be plugged
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index e2a324cde671..c04b6eab3c76 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -12,3 +12,4 @@ x86_64 Support
    mm
    5level-paging
    fake-numa-for-cpusets
+   cpu-hotplug-spec
-- 
2.20.1

