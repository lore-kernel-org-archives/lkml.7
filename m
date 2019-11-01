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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42500CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EEF21835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlT/KZar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfKAPnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:43:25 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:44652 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfKAPnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:43:24 -0400
Received: by mail-qt1-f169.google.com with SMTP id o11so8348655qtr.11;
        Fri, 01 Nov 2019 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKb52YVkC3NELqTeZJC/gLeC/MBsFUU9iPpUF2C2Ctk=;
        b=qlT/KZarrFEp/Vnhmhph+guCGCHV7SshaXo3+RJO9shLG9iR94hGhXTWTGw7+42HGo
         je3+Jxw/mgd7h1ChfIIKu8tgIcUZT3dgUf5Fyy66Z8LBQLP0/x6YskKOfYZRbNLIh9oA
         EfLKI+YZHWcL7UAugyujZmjZSFaTWH3bzDSJM5cqgDwFnju7LTd3nRUdptKcd9Teti3G
         uv67e9d1dRoVYjkAA9wCmyVW2toDPAZBajo0fbX1drYJkbuTqYePZEpZhCRGsmj+LDlo
         7H49tQUuxFpcOX4Uo+YG/En9fD1rhSceVpQ1IdxIhbpid+4aKYs5MOEmySkTKYB73mNh
         FCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKb52YVkC3NELqTeZJC/gLeC/MBsFUU9iPpUF2C2Ctk=;
        b=tRhNIYVSJXJdBf3iwroJL6/LbxdYUU7fD518TgwRORK9B40D2zXMBompp9jxlql2xy
         Xy4pCiRzVqLlWTprkhAu0lJXQWTaP6F0GKdWKzz7tW5chIdBmkPwmeWQIAdwtwMvntK0
         UwdH8unamb3EytTD4d2zgBBOGRqNkghuZl8T5qQUM/dzdvCGG0DUYX2n4o3SkximK27s
         1P+phuxXTQGrBL6TsWfvoiNpyqFRKNsx0kQqZilZajFIPh4Dp0DUiATPThdOM/hjzjx3
         cPEjQ1X/IV7ugPSSNsxWd7EsrptI+47McVifAFPDJJ6LTcKbVVvKAE4yig6cda4Nk69X
         c9Jg==
X-Gm-Message-State: APjAAAWZBdXo2ftDFoeDvibZ+/4/xRPS5/nCYQgTy/bZGAJzqryhZgKb
        hBZEKcSzdzZ3CjgnmU4+cXY=
X-Google-Smtp-Source: APXvYqyFJAM4q5ecaSSq30Ntjp+yMEhkErlOeuccAqPYTwS2MUKCEWlFOLUtIJsL/9o67Wxd50pH6g==
X-Received: by 2002:ad4:58a9:: with SMTP id ea9mr10756512qvb.179.1572623003347;
        Fri, 01 Nov 2019 08:43:23 -0700 (PDT)
Received: from GBdebian.ic.unicamp.br (wifi-177-220-84-14.wifi.ic.unicamp.br. [177.220.84.14])
        by smtp.gmail.com with ESMTPSA id x38sm4879243qtc.64.2019.11.01.08.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 08:43:22 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, manasi.d.navare@intel.com,
        rodrigosiqueiramelo@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH v2] drm/doc: Adding VKMS module description and use to "Testing and Validation"
Date:   Fri,  1 Nov 2019 12:43:14 -0300
Message-Id: <20191101154314.25435-1-gabrielabittencourt00@gmail.com>
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

Changes in v2:
- Avoid repetition of words in the same sentence;
- Make the explanation on 'setting the kernel' shorter, eliminate the
'make menuconfig' command;
- Add tab on enumeration to have one line per item;
- Clarify from each machine igt-tests commands should be ran on.

Tested the patch using 'make htmldocs' to make sure the output .html is
correct.

Hi DRM-community,
this is my first (of many, I hope)  patch in this subsystem. I hope to have
a lot of learning (and fun :)) working with you guys.
I'm starting by documenting the VKMS driver in "Userland interfaces", if I
have been inaccurate in my description or if I misunderstood some concept,
please let me know.
---
 Documentation/gpu/drm-uapi.rst | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 94f90521f58c..1586cbba05d0 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -285,6 +285,42 @@ run-tests.sh is a wrapper around piglit that will execute the tests matching
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
+virtual machine without display, simplifing the validation of some of the
+core changes.
+
+To Validate changes in DRM API with VKMS, start setting the kernel: make
+sure to enable VKMS module; compile the kernel with the VKMS enabled and
+install it in the target machine. VKMS can be run in a Virtual Machine
+(QEMU, virtme or similar). It's recommended the use of KVM with the minimum
+of 1GB of RAM and four cores.
+
+It's possible to run the IGT-tests in a VM in two ways:
+	1. Use IGT inside a VM
+	2. Use IGT from the host machine and write the results in a shared directory.
+
+As follow, there is an example of using a VM with a shared directory with
+the host machine to run igt-tests. As example it's used virtme::
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

