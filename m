Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB41C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 15:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E550F2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 15:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573400589;
	bh=3a18qqUhBkW4PUQrLLv6spd9GebwORwUzuDmnem1nKM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=mkoN0Pf8v8VoVtbYr0OMGqgDu0jnMrMpVx95EoxklJdWTrQaiI5UV2I6URCLMrGha
	 jvljAvYVtZFRhf9W6INNDDMaI3rPyojAP0fI8NG99ymlB4ReXI4/GwIr9tiKd6BUVG
	 /anNbkjDvaNRY7s41fe/FURRFsdspHbiztguU2pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfKJPnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 10:43:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfKJPnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 10:43:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF2DC206DF;
        Sun, 10 Nov 2019 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573400586;
        bh=3a18qqUhBkW4PUQrLLv6spd9GebwORwUzuDmnem1nKM=;
        h=Date:From:To:Cc:Subject:From;
        b=d7SbenSMIfm1D3v+SGjJLM4088aYrJ0ywZnwkcbd8xKmwyWXWkxhLUUchiDY07ewe
         dq3oMlCmycemAxLRf6CTmYB39aL2VRZcskUaNiATvMce1WMKen5R3xUsc8d+fv/o1w
         9zQePStnoBj75c5jFbWtDxr7+riAjcqfuO6dsn0Y=
Date:   Sun, 10 Nov 2019 16:43:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] IIO fixes / Staging driver for 5.4-rc7
Message-ID: <20191110154303.GA2867499@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.4-rc7

for you to fetch changes up to e39fcaef7ed993950af74a584f8246022b551971:

  staging: Fix error return code in vboxsf_fill_super() (2019-11-07 16:29:18 +0100)

----------------------------------------------------------------
IIO fixes / Staging driver for 5.4-rc7

Here is a mix of a number of IIO driver fixes for 5.4-rc7, and a whole
new staging driver.

The IIO fixes resolve some reported issues, all are tiny.

The staging driver addition is the vboxsf filesystem, which is the
VirtualBox guest shared folder code.  Hans has been trying to get
filesystem reviewers to review the code for many months now, and
Christoph finally said to just merge it in staging now as it is
stand-alone and the filesystem people can review it easier over time
that way.
I know it's late for this big of an addition, but it is stand-alone.

The code has been in linux-next for a while, long enough to pick up a
few tiny fixes for it already so people are looking at it.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexandru Ardelean (1):
      iio: imu: adis16480: make sure provided frequency is positive

Andreas Klinger (1):
      iio: srf04: fix wrong limitation in distance measuring

Colin Ian King (1):
      staging: vboxsf: fix dereference of pointer dentry before it is null checked

Fabrice Gasnier (1):
      iio: adc: stm32-adc: fix stopping dma

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.4b' of https://git.kernel.org/.../jic23/iio into staging-linus

Hans de Goede (1):
      staging: Add VirtualBox guest shared folder (vboxsf) support

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_mpu6050: fix no data on MPU6050

Wei Yongjun (1):
      staging: Fix error return code in vboxsf_fill_super()

YueHaibing (1):
      staging: vboxsf: Remove unused including <linux/version.h>

 MAINTAINERS                                |   6 +
 drivers/iio/adc/stm32-adc.c                |   4 +-
 drivers/iio/imu/adis16480.c                |   5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |   9 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |   2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c |  15 +-
 drivers/iio/proximity/srf04.c              |  29 +-
 drivers/staging/Kconfig                    |   2 +
 drivers/staging/Makefile                   |   1 +
 drivers/staging/vboxsf/Kconfig             |  10 +
 drivers/staging/vboxsf/Makefile            |   5 +
 drivers/staging/vboxsf/TODO                |   7 +
 drivers/staging/vboxsf/dir.c               | 418 +++++++++++++
 drivers/staging/vboxsf/file.c              | 370 ++++++++++++
 drivers/staging/vboxsf/shfl_hostintf.h     | 901 +++++++++++++++++++++++++++++
 drivers/staging/vboxsf/super.c             | 501 ++++++++++++++++
 drivers/staging/vboxsf/utils.c             | 551 ++++++++++++++++++
 drivers/staging/vboxsf/vboxsf_wrappers.c   | 371 ++++++++++++
 drivers/staging/vboxsf/vfsmod.h            | 137 +++++
 19 files changed, 3324 insertions(+), 20 deletions(-)
 create mode 100644 drivers/staging/vboxsf/Kconfig
 create mode 100644 drivers/staging/vboxsf/Makefile
 create mode 100644 drivers/staging/vboxsf/TODO
 create mode 100644 drivers/staging/vboxsf/dir.c
 create mode 100644 drivers/staging/vboxsf/file.c
 create mode 100644 drivers/staging/vboxsf/shfl_hostintf.h
 create mode 100644 drivers/staging/vboxsf/super.c
 create mode 100644 drivers/staging/vboxsf/utils.c
 create mode 100644 drivers/staging/vboxsf/vboxsf_wrappers.c
 create mode 100644 drivers/staging/vboxsf/vfsmod.h
