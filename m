Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0EAC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8E32063F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TElvV3A0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfHNJei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:34:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47016 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfHNJeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:34:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3so15596843pgt.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 02:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sBTOwsLej+6SFYj/3oga2SYDOf+AJErrS9OoJV4ZWCU=;
        b=TElvV3A0gQCRT1a910QA7MFN/a1b31NtBoBXka4GAvmJ3MVna7Jt6D4nJzrRjgdEKw
         XRkVbqFo2fDsGYnUlXYggJAZU785xmfMO6PeC9mp5qJU/zGIodHmLX5KIWQRfQdEmEur
         rpppwemvPjaht8s0Xt6UEaL0NrD+8jkW33TEFS7g89UGbJD26mifLAV/tQM89xrw3LBa
         YNhwzwDNCAplVTx/csnMz6MT0jaunsd44v0nJdxWz4Ib3uqtN9YFf0BAqNe4vjokvNh0
         4WA2/5vps95maWoq0Twr0nt1BSvmfO11vFEeaD9E/CBl2v6Pmc5IdDvZZfj80P88/hcQ
         vlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sBTOwsLej+6SFYj/3oga2SYDOf+AJErrS9OoJV4ZWCU=;
        b=Rh/KpV5+3sIeo7k476VOKoOM+Z+fCZci3E4dcP/Z2cnHdees6Txr1KdhSHsVWQx9U5
         U5wPi5Z4Psg4SCuu0KtNH+oYUXIzsVkgovHhqq6C4jTEeiC2VANE35AAvnC2uYGmmBSR
         w7hojmtVjtS/LLmtFjlS81ryVYjYSeC+54Dv1bqq1SgnAFAG9Iz861FtPcbcq8LKSUH7
         JBW0ChwoJU410HWssB02A/5zWcpB1Blu9xNOmG7BRi3BZvGfjWyignvNv3Zeg+aZP+d7
         jVUbW9vgaDiXvBPBak4oYPxw0OlnC3tuVfm0p42R06k2/n5DastNnV6vdjD4/84HUz10
         pCiQ==
X-Gm-Message-State: APjAAAUJSHVFRsedP9BLb6xVnZoU8A0zY39W5wX+SofmLDMSL+jAHVcq
        D6Rj+8TgQFbrHXdRQR+Lc/Yu/w==
X-Google-Smtp-Source: APXvYqxBKQBXXvtbDIcv7Ji3oexdy3WJHcNNpEfE7+lnnEx60GiC/pfFtalLge7Hblo4oisAHfOamA==
X-Received: by 2002:a17:90a:4c:: with SMTP id 12mr6099188pjb.40.1565775276670;
        Wed, 14 Aug 2019 02:34:36 -0700 (PDT)
Received: from localhost.localdomain ([193.187.117.228])
        by smtp.gmail.com with ESMTPSA id v12sm3419815pjk.13.2019.08.14.02.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Aug 2019 02:34:35 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 0/2] A General Accelerator Framework, WarpDrive
Date:   Wed, 14 Aug 2019 17:34:23 +0800
Message-Id: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*WarpDrive* is a general accelerator framework for the user application to
access the hardware without going through the kernel in data path.

WarpDrive is the name for the whole framework. The component in kernel
is called uacce, meaning "Unified/User-space-access-intended Accelerator
Framework". It makes use of the capability of IOMMU to maintain a
unified virtual address space between the hardware and the process.

WarpDrive is intended to be used with Jean Philippe Brucker's SVA
patchset[1], which enables IO side page fault and PASID support. 
We have keep verifying with Jean's sva/current [2]
We also keep verifying with Eric's SMMUv3 Nested Stage patch [3]

This series and related zip & qm driver as well as dummy driver for qemu test:
https://github.com/Linaro/linux-kernel-warpdrive/tree/5.3-rc1-warpdrive-v1
zip driver already been upstreamed.
zip supporting uacce will be the next step.

The library and user application:
https://github.com/Linaro/warpdrive/tree/wdprd-v1-current

Change History:
v4 changed from V3
1. Rebase to 5.3-rc1
2. Build on iommu interface
3. Verifying with Jean's sva and Eric's nested mode iommu.
4. User library has developed a lot: support zlib, openssl etc.
5. Move to misc first

V3 changed from V2:
https://lkml.org/lkml/2018/11/12/1951
1. Build uacce from original IOMMU interface. V2 is built on VFIO.
   But the VFIO way locking the user memory in place will not
   work properly if the process fork a child. Because the
   copy-on-write strategy will make the parent process lost its
   page. This is not acceptable to accelerator user.
2. The kernel component is renamed to uacce from sdmdev accordingly
3. Document is updated for the new design. The Static Shared
   Virtual Memory concept is introduced to replace the User
	Memory Sharing concept.
4. Rebase to the lastest kernel (4.20.0-rc1)
5. As an RFC, this version is tested only with "test-to-pass"
   test case and not tested with Jean's SVA patch.

V2 changed from V1:
https://lwn.net/Articles/763990/
1. Change kernel framework name from SPIMDEV (Share Parent IOMMU
   Mdev) to SDMDEV (Share Domain Mdev).
2. Allocate Hardware Resource when a new mdev is created (While
   it is allocated when the mdev is openned)
3. Unmap pages from the shared domain when the sdmdev iommu group is
   detached. (This procedure is necessary, but missed in V1)
4. Update document accordingly.
5. Rebase to the latest kernel (4.19.0-rc1)

References:
[1] http://jpbrucker.net/sva/
[2] http://www.linux-arm.org/git?p=linux-jpb.git;a=shortlog;h=refs/heads/sva/current
[3] https://github.com/eauger/linux/tree/v5.3.0-rc0-2stage-v9

Kenneth Lee (2):
  uacce: Add documents for WarpDrive/uacce
  uacce: add uacce module

 Documentation/misc-devices/warpdrive.rst |  351 +++++++++
 drivers/misc/Kconfig                     |    1 +
 drivers/misc/Makefile                    |    1 +
 drivers/misc/uacce/Kconfig               |   13 +
 drivers/misc/uacce/Makefile              |    2 +
 drivers/misc/uacce/uacce.c               | 1186 ++++++++++++++++++++++++++++++
 include/linux/uacce.h                    |  109 +++
 include/uapi/misc/uacce.h                |   44 ++
 8 files changed, 1707 insertions(+)
 create mode 100644 Documentation/misc-devices/warpdrive.rst
 create mode 100644 drivers/misc/uacce/Kconfig
 create mode 100644 drivers/misc/uacce/Makefile
 create mode 100644 drivers/misc/uacce/uacce.c
 create mode 100644 include/linux/uacce.h
 create mode 100644 include/uapi/misc/uacce.h

-- 
2.7.4

