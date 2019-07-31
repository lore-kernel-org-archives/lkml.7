Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F83CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FAD206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvG+kKfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfGaM7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:59:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33207 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfGaM7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:59:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so1257719wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=UHokkzAc/BHSQpP0N8CHU9+T2r4PD1VOrusy9rsCPdk=;
        b=YvG+kKfrSQr68acz8OPVS0qAA1UB9fLPVyF5opD76FBXK2Dt2ZI+52p3bFTlmLxU+8
         K/TthexgGdI+1m0Dn6TSYfLUSM8XXDfw949tbpoXsruiiN+wLUtmFMHBvlgTeldIJYIf
         5WSz5nP9KsWuO1kYdvZH6Z00y7LgrkFiXwYnzNhcVIdHsJNUz3liQb8BAxXUgY9gPmMY
         7jfwT+PlFIghmi+tFNuvlKnn9TRdJ2uvI1rhLwbk/1AunMBquW1ODcCfFz3dYqWPn1+/
         tPBi3Rh4z2XcqqZL2c9cu9VMW26EyI2IWLPxxPKlyFZxOKT5QVpPj4NfE0Hy2Hd4BRRw
         NSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=UHokkzAc/BHSQpP0N8CHU9+T2r4PD1VOrusy9rsCPdk=;
        b=s7rG7F1mhC303Gjj5+9Adtl5dBsD5N0GnqMg7gCYRU6LA2gplly5RXZKdUboN35Z9A
         jj+CX2tMIN0GFd5qeTWxE2WjlBMR9OfsLGQT+etM5VQ2c9Y8PpUXRJviwn0KpoiCcuas
         04DF9tIlrFeDHpJtD0KaJ6cKF0KqQfpV2NRNTK00Av6rzstbgdtbtqoJRmYMM8BE8ylG
         OESzRGbv440sEKXfq6I57vtVXL5AvNTnKmBIPKZ/VfnaFCsy1BlOE1VNojfB3W9KqYZA
         tlfteKHIdEs5wium/Cr56hKg0Ql6Oi5jje5ahvlBc0ATFLGCQkfd+/Z7oj8TBkHRXBUQ
         Nxcw==
X-Gm-Message-State: APjAAAVl4EYRmNqXsz0pxVT+4+h3JAUcOhutYugLlUvSlRlEkJVextTY
        BNJnmyEUTl+/OHTPXMzPWi+mL+N2+Xg=
X-Google-Smtp-Source: APXvYqzNIHVkEV3KFiYgheqOvVsXkKqscO5Ka5qSVtlkGwhyePakivYlEZwBW+B/unlE82bdNLMWQw==
X-Received: by 2002:a05:600c:240e:: with SMTP id 14mr5376907wmp.30.1564577943955;
        Wed, 31 Jul 2019 05:59:03 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c6sm69247800wma.25.2019.07.31.05.59.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:59:03 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH v3 0/7] habanalabs: support info queries by multiple processes
Date:   Wed, 31 Jul 2019 15:58:54 +0300
Message-Id: <20190731125901.20709-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 introduces a few fixes and changes the control char device's minor
number to be 1 above that of the main device.

Original text:

Today, the driver allows only a single user application (the deep-learning
application) to perform queries of the device's stats, information, idle
state and more.

This is a serious limitation in data centers, where there are
multiple system/monitorining applications that want to continuously
retrieve that information, while allowing the deep-learning application to
perform work on the device.

This patch-set allows unlimited number of user applications to perform
the above queries (by calling the INFO IOCTL), while the deep-learning
application is running.

This is done by creating an additional char device per ASIC, that is
dedicated to information retrieval only (allows only to call the INFO
IOCTL). This method will maintain backward compatibility with existing
userspace applications.

- Patches 1-4 makes small improvements to existing code.
- Patch 5 removes the accounting of the number of open file-descriptors
  and replace it with tracking of the driver's internal file private data
  strcuture.
- Patch 6 is a pre-requisite to creating the two char devices
- Patch 7 introduce the additional char device

Thanks,
Oded

Oded Gabbay (7):
  habanalabs: add handle field to context structure
  habanalabs: kill user process after CS rollback
  habanalabs: show the process context dram usage
  habanalabs: rename user_ctx as compute_ctx
  habanalabs: maintain a list of file private data objects
  habanalabs: change device_setup_cdev() to be more generic
  habanalabs: create two char devices per ASIC

 drivers/misc/habanalabs/context.c          |  38 +--
 drivers/misc/habanalabs/debugfs.c          |   4 +-
 drivers/misc/habanalabs/device.c           | 255 ++++++++++++---------
 drivers/misc/habanalabs/goya/goya_hwmgr.c  |  25 +-
 drivers/misc/habanalabs/habanalabs.h       |  49 ++--
 drivers/misc/habanalabs/habanalabs_drv.c   | 165 ++++++++-----
 drivers/misc/habanalabs/habanalabs_ioctl.c | 104 ++++++---
 7 files changed, 403 insertions(+), 237 deletions(-)

-- 
2.17.1

