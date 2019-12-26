Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7BDC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 16:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423E1208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 16:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcJ8Fhrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfLZQVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 11:21:42 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37769 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfLZQVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 11:21:42 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so3633391pjb.2;
        Thu, 26 Dec 2019 08:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNzBbsBAeD8tPqRqiqpZEThvA8x3leCImQZb/BG9x4Q=;
        b=dcJ8Fhrh7zoSXEsaf+C3T/Q0LqszfowWt/z7VLgChyxXm0pQPLIP+DplXNKdrnu7qf
         SZay23pSuZd1w54Ak1fbvBLp5ITG4A4AKnVHe+c+9R+OU8susPdCMq8DnHz2EY+Hc+BW
         23Tve2JXWPDz7hoVEuuz0OS7VFysCGEUpoaxh5J2yw4dzUJNV5WLKabwjLMmQLh1drHO
         lFEbOImWwiONuIkiKGeg/mGWaY41/+VRKpnczJwQR4JFqnyv9R7/cTsqqqHcZg+5YNgZ
         AWD7Jco/xqChiaC1V7/jpYQ/weB6EYv38sX78OvJ1pIjDg0LeFbDrre6PrgQb/rYLtiq
         Dhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNzBbsBAeD8tPqRqiqpZEThvA8x3leCImQZb/BG9x4Q=;
        b=dniT7eWsahPzjgqACl5XePSKPcpPbxM2l24GyLMVGDDs0KRQsBvA40ksBThk2YSjno
         vX8tT6N5G50n62XqXaC66ys0sFqagN+/UNcYGX/NZ5YKE4pgLrr+uu4PUZGFBmO8NKbk
         7iV7/vlIQCZ5GKAs8ctnbJJ3DVUTti6QtgJx9Ah9uizukzzCY1+xO40uki8o75qBO+55
         sIenLN4U4LmgksYOE3XtK59Wz0kYhM7i8b9ww8S7lbJqXTCffvs8Uoq7v5Su6fwK8ZOI
         NXIV9x4Q7Tvy16rvSCz8DgFzTF/I/QqAoza0sVvSspC1GRzdLS9dGxYJpkSHPb70Cfl9
         m6XA==
X-Gm-Message-State: APjAAAWEKayyGXOqxTQikrktwZ/EE+0BEqoS/rEAKOUC4hAqs48KYlTV
        iZsgI5mBw+wmZ1Pmwb5FeAM=
X-Google-Smtp-Source: APXvYqwZjkqHi0IWZYgQS/yv8ZAQz+xxniSvgOV2ig8Ro0xeeUrvv7zjZg9uIj7SBWZiGDoYzdBYvw==
X-Received: by 2002:a17:90a:930f:: with SMTP id p15mr20497612pjo.2.1577377301564;
        Thu, 26 Dec 2019 08:21:41 -0800 (PST)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id s24sm11098063pjp.17.2019.12.26.08.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Dec 2019 08:21:41 -0800 (PST)
Received: by masabert (Postfix, from userid 1000)
        id D60F420123E; Fri, 27 Dec 2019 01:21:39 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] Doc: x86: Fix a typo in mm.rst
Date:   Fri, 27 Dec 2019 01:21:38 +0900
Message-Id: <20191226162138.17601-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.24.1.590.gb02fd2accad4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a spelling typo in mm.rst.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/x86/x86_64/mm.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/x86/x86_64/mm.rst b/Documentation/x86/x86_64/mm.rst
index 267fc4808945..e5053404a1ae 100644
--- a/Documentation/x86/x86_64/mm.rst
+++ b/Documentation/x86/x86_64/mm.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-================
-Memory Managment
-================
+=================
+Memory Management
+=================
 
 Complete virtual memory map with 4-level page tables
 ====================================================
-- 
2.24.1.590.gb02fd2accad4

