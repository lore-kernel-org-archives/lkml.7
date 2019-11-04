Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9128FCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1A0214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edyirGAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfKDQ1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:27:23 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38489 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfKDQ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:27:23 -0500
Received: by mail-qk1-f193.google.com with SMTP id e2so18186786qkn.5;
        Mon, 04 Nov 2019 08:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i66A6pPwTuTMjG+BVvr5dEhi3nTPOcjA9Wo5ZsbJLGM=;
        b=edyirGAknSCqx5G4/iS96ij1SqLsJ0hUWva5SoYDegi94n9vAlQGl6WeDQsMsqLmdR
         Hdyv9IHi3ioK/LAziTLpIkEUEdNLNkFJ+JDUyKuDELyaneQ0mZYSIPOe2agJTXhYHXpr
         49CVNgvsHr6kVqrlSMzvm6Fevr2YrSDwx3zemhUAKWDTbkB4+D2YFlBBr+pAv+6BZzAN
         njyOJpnDKFKP9yWSU9MHsO3xa9fvadxcp0wYDvF+vigu8oRuxRhiwKXhS7ZdkoaVxMHo
         kz3wUH372tIDoWR4c3EnywJXVFhzWydTwCz6mHvhyuKNpudVws+R5x04xfujAbaf5tHa
         2LFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i66A6pPwTuTMjG+BVvr5dEhi3nTPOcjA9Wo5ZsbJLGM=;
        b=sOAc1hqWW596uqkkO4pWKlvBdP2GFvj4tcrDdOUFZP2lNMKnsGDsQ06oXvDe3LzjTC
         cGLFD2Cwx743LqDe6QIf23pDj+p2GG66OW5STqb44mvHWuhUBlYqTUkbmEsJ8063nWBj
         /C97iTe86FZZALfdBBJA2RolTVIlFP/BIaCqRg+wcYvV8EAdyMca/wlVj1a7NBWrKpt6
         4AI6s3RmQK//dlW8PxNIkKaxGrIR39utpmfOluw4VxlgsY1FbYtHUpSng8HfQH9/aa96
         U/DHqrn0LiC1RXMwlJY1S99eYIPIqr6bX0YsIJ0y5FUolB3iU6fPsZPfINQIa2sHqzak
         I1Sw==
X-Gm-Message-State: APjAAAXbFf78QaDdvNOAW3jQW8g25FzAlh6iXBMOLeN+O9+Uv0EbAH8G
        0KAnVPo0GcnjIV73lx39EWE=
X-Google-Smtp-Source: APXvYqxrJvftoKqL0O6y4FTfX/xET+DHn8QnlmX1K0Zw72my2+nr0x1RCsvGOrIJKDXM6DyDtmS8yQ==
X-Received: by 2002:a37:9c52:: with SMTP id f79mr5479121qke.163.1572884841910;
        Mon, 04 Nov 2019 08:27:21 -0800 (PST)
Received: from localhost.localdomain ([187.106.44.83])
        by smtp.gmail.com with ESMTPSA id i14sm8876562qke.102.2019.11.04.08.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 08:27:21 -0800 (PST)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, manasi.d.navare@intel.com,
        rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH VKMS v3] drm/doc: Add VKMS module description and use to "Testing and Validation"
Date:   Mon,  4 Nov 2019 13:27:05 -0300
Message-Id: <20191104162705.19735-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a description on VKMS module and the cases in which it should be used.
There's a brief explanation on how to set it and use it in a VM, along with
an example of running an igt-test.

Changes since V3:
 Rodrigo:
 - Change the log message to imperative
 - Fix some bad spelling/writing
 - Add a blank line before enumeration

Changes since V2:
 Andre:
 - Avoid repetition of words in the same sentence;
 - Make the explanation on 'setting the kernel' shorter, eliminate the
   'make menuconfig' command;
 - Add tab on enumeration to have one line per item;
 - Clarify from each machine igt-tests commands should be ran on.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---

Tested the patch using 'make htmldocs' to make sure the output .html is
correct.

Hi DRM-community,
this is my first (of many, I hope)  patch in this subsystem. I hope to have
a lot of learning (and fun :)) working with you guys.
I'm starting by documenting the VKMS driver in "Userland interfaces", if I
have been inaccurate in my description or if I misunderstood some concept,
please let me know.
---
 Documentation/gpu/drm-uapi.rst | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 94f90521f58c..8271c1e240b7 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -285,6 +285,43 @@ run-tests.sh is a wrapper around piglit that will execute the tests matching
 the -t options. A report in HTML format will be available in
 ./results/html/index.html. Results can be compared with piglit.
 
+Using VKMS to test DRM API
+--------------------------
+
+VKMS is a software-only model of a KMS driver that is useful for testing
+and for running compositors. VKMS aims to enable a virtual display without
+the need for a hardware display capability. These characteristics made VKMS
+a perfect tool for validating the DRM core behavior and also support the
+compositor developer. VKMS makes it possible to test DRM functions in a
+virtual machine without display, simplifying the validation of some of the
+core changes.
+
+To Validate changes in DRM API with VKMS, start setting the kernel: make
+sure to enable VKMS module; compile the kernel with the VKMS enabled and
+install it in the target machine. VKMS can be run in a Virtual Machine
+(QEMU, virtme or similar). It's recommended the use of KVM with the minimum
+of 1GB of RAM and four cores.
+
+It's possible to run the IGT-tests in a VM in two ways:
+
+	1. Use IGT inside a VM
+	2. Use IGT from the host machine and write the results in a shared directory.
+
+As follow, there is an example of using a VM with a shared directory with
+the host machine to run igt-tests. As an example it's used virtme::
+
+	$ virtme-run --rwdir /path/for/shared_dir --kdir=path/for/kernel/directory --mods=auto
+
+Run the igt-tests in the guest machine, as example it's ran the 'kms_flip'
+tests::
+
+	$ /path/for/igt-gpu-tools/scripts/run-tests.sh -p -s -t "kms_flip.*" -v
+
+In this example, instead of build the igt_runner, Piglit is used
+(-p option); it's created html summary of the tests results and it's saved
+in the folder "igt-gpu-tools/results"; it's executed only the igt-tests
+matching the -t option.
+
 Display CRC Support
 -------------------
 
-- 
2.20.1

