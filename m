Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB36CCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 04:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6D9217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 04:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYOl9Xry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfKAE1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 00:27:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36026 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfKAE1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 00:27:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id y10so4716603qto.3;
        Thu, 31 Oct 2019 21:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HpS7M3wugMxRqvwJlP7zk8Xh32CVSZbs51QsUAEIzfw=;
        b=eYOl9Xry51JB4XOdcoO0HKnLb5V3OO+fyyZXo3Gyk4O17pxoDfoSvQUCR7XNoasLmn
         1JpmLWlUEimCevap83AXVIUpMM4tmRf7BrH/H9HZPBHebQwP4EUXbC7Mpu/iAUjg9bx4
         K/Gnk0D2Xoe4iTxrsIsps+Z1VX4K2XAEJQe1EY4qUmWUkm2MDrHWhRSkW90OsfNKH+at
         djFMIo9+Ypc0/PLBXNAydL8HRDa6ovC53rdB2Yv+9dgU30Jc9nGMQ7WSDhRJ/YdLkB8p
         3j//UCXEPr/yf2jxd3nXQKS5QarHMHlwIztXZJv9pIM9MK5iHpry0oPwBnaUJMvVUwNU
         kw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HpS7M3wugMxRqvwJlP7zk8Xh32CVSZbs51QsUAEIzfw=;
        b=N91QzoSS/abK2ji31eRuffUFElvEa2Oq/4PV3xIchIlOf/IynP0YR+INXpmLpab37I
         Rcsgb2HNJ39Ik3nfApTtrtt9UkHbzO3UJkuysLEVBIfsm/l8YFlpOFFTTXalItUXO/z5
         AefvspVkQqDbrVzsFzxk6JvuzMzN4xrDR/F7d4ZmCn7Z0ttZhIztAlOw/9TtWY4puehC
         Fvb5f1m0pcExu2TlR7sJUxF5hmOFREEbMiSmTCbf5PfORWKo8B8EcZgRHCSRFpH/643l
         9y3fx96AubvKNP/sJ4/ubUm95EWE29RvjrWDU9V1YPw2xZNqwg2vb7+R5MFRU0CA7T93
         oymw==
X-Gm-Message-State: APjAAAXMvcAK7l9+lECUU+/GD6WbzNY+lDoC6dHMmSf3dLD46scYKcNe
        Acdbmm9h2kIbhdkLEW5+zOs=
X-Google-Smtp-Source: APXvYqzDwJYaREOSe2o21TAZV4qBy7f/mE8kw3SqL1wNgJYXEuC0QZxtcJYWENR6LVI7cPRVcn6ENw==
X-Received: by 2002:aed:24af:: with SMTP id t44mr1230263qtc.135.1572582435878;
        Thu, 31 Oct 2019 21:27:15 -0700 (PDT)
Received: from localhost.localdomain ([187.106.44.83])
        by smtp.gmail.com with ESMTPSA id w24sm3719838qta.44.2019.10.31.21.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 21:27:15 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, manasi.d.navare@intel.com,
        rodrigosiqueiramelo@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH] drm/doc: Adding VKMS module description and use to "Testing and Validation"
Date:   Fri,  1 Nov 2019 01:27:06 -0300
Message-Id: <20191101042706.2602-1-gabrielabittencourt00@gmail.com>
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

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

---

Hi DRM-community,
this is my first (of many, I hope)  patch in this subsystem. I hope to have
a lot of learning (and fun :)) working with you guys.
I'm starting by documenting the VKMS driver in "Userland interfaces", if I
have been inaccurate in my description or if I misunderstood some concept,
please let me know.
---
 Documentation/gpu/drm-uapi.rst | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 94f90521f58c..7d6c86b7af76 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -285,6 +285,44 @@ run-tests.sh is a wrapper around piglit that will execute the tests matching
 the -t options. A report in HTML format will be available in
 ./results/html/index.html. Results can be compared with piglit.
 
+Using VKMS to test DRM API
+--------------------------
+
+VKMS is a software-only model of a KMS driver that is useful for testing
+and for running compositors. VKMS aims to enable a virtual display without
+the need for a hardware display capability. These characteristics made VKMS
+a perfect tool for validating the DRM core behavior and also support the
+compositor developer. VKMS helps us to test DRM core function in a virtual
+machine, which makes it easy to test some of the core changes.
+
+To Validate changes in DRM API with VKMS, start setting the kernel. The
+VKMS module is not enabled by defaut, so enable it in the menuconfig::
+
+	$ make menuconfig
+
+Compile the kernel with the VKMS enabled and install it in the target
+machine. VKMS can be run in a Virtual Machine (QEMU, virtme or similar).
+It's recommended the use of KVM with the minimum of 1GB of RAM and four
+cores.
+
+It's possible to run the IGT-tests in a VM in two ways:
+1. Use IGT inside a VM
+2. Use IGT from the host machine and write the results in a shared directory.
+
+As follow, there is an example of using a VM with a shared directory with
+the host machine to run igt-tests. As example it's used virtme::
+
+	$ virtme-run --rwdir /path/for/shared_dir --kdir=path/for/kernel/directory --mods=auto
+
+Run the igt-tests, as example it's ran the 'kms_flip' tests::
+
+	$ /path/for/igt-gpu-tools/scripts/run-tests.sh -p -s -t "kms_flip.*" -v
+
+In this example instead of build the igt_runner it's used Piglit
+(-p option); it's created html summary of the tests results and it's saved
+in the folder "igt-gpu-tools/results"; it's executed only the igt-tests
+matching the -t option.
+
 Display CRC Support
 -------------------
 
-- 
2.20.1

