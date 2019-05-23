Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014CFC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAB721019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BrT/LmvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfEWCv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 22:51:26 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37906 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbfEWCv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 22:51:26 -0400
Received: by mail-pg1-f180.google.com with SMTP id v11so2310043pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 19:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eelYOl+auCZwPeaiF2iZqxUedYahMzn49UDx8OOb2N8=;
        b=BrT/LmvVnhqjaKLk/W1wvw0WfcNXPvWG0i0rFsiMvmJpNRkOSM5XIMzQrTEyryQqNg
         RS8iiVSCimgKdPtY9di7vvJXbDUGY8aW4/uDwh9dw6FgZaxXDgrOXbV2BJW4Pv52ZS0A
         eRK1jYeKKSnZhbMeqtbVAPScLf/iDf23GCJdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eelYOl+auCZwPeaiF2iZqxUedYahMzn49UDx8OOb2N8=;
        b=RdsgR0lmGIEIg49GXSBOSrmw0oU6az4QK4skd0CeXkkDixcmnQCzyMN8v4Aj1prwao
         GifaL9CivJttAaNkITvaZdLdB6APABtAm7oSn3gz2j1a79yfi05jbHpskExDv9UUkAWi
         P9BuAabgUsielbcDqThAJDn2MbFlydAA5XP9RK7PpKNbQILXnnFx6EfgR0UwpnfpJ634
         lqripeBzXRUDbBc9VLqnJBWQmcwY+ay/pzUdvCH/kMvsRathwS5UWR91Qje+FOBI4ztH
         AFoZNkBrLI5WqGe9kq3IX/lB9aaY6o3jHrJHpZmzDTPIalXecEsKuet4KfnTjFqA+q9S
         cjlg==
X-Gm-Message-State: APjAAAXR0Dr8VaAawQCeBVO2kz8MjQguR13mNr8KTdE+P+HUJKPYo0Q3
        IRZVafin5diUFNPvt2ql1zEsDA==
X-Google-Smtp-Source: APXvYqyryGsGQdDT/y24ZM5GRt90QMDl4IIoLoKgwlwT7BtX21xYS/KWrf+aebtyaSorYCB4oWXgrQ==
X-Received: by 2002:a65:52c3:: with SMTP id z3mr41505682pgp.56.1558579885890;
        Wed, 22 May 2019 19:51:25 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q19sm42812174pff.96.2019.05.22.19.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 19:51:24 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 0/3] fs: add partial file read support
Date:   Wed, 22 May 2019 19:51:10 -0700
Message-Id: <20190523025113.4605-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds partial file read support to the kernel via
kernel_pread_file functions.  request_firmware_into_buf function
enhanced to allow partial file read support and single qcom driver
using existing function updated.
Change to core kernel file support allows new drivers to read partial
file to memory as necessary in memory constrained systems.

Scott Branden (3):
  fs: introduce kernel_pread_file* support
  firmware: add offset to request_firmware_into_buf
  soc: qcom: mdt_loader: add offset to request_firmware_into_buf

 drivers/base/firmware_loader/firmware.h |  5 ++
 drivers/base/firmware_loader/main.c     | 49 +++++++++++-----
 drivers/soc/qcom/mdt_loader.c           |  7 ++-
 fs/exec.c                               | 77 +++++++++++++++++++------
 include/linux/firmware.h                |  8 ++-
 include/linux/fs.h                      | 15 +++++
 6 files changed, 125 insertions(+), 36 deletions(-)

-- 
2.17.1

