Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC26C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF392075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwcj/QcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfECHgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 03:36:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38801 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfECHgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:36:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id k16so6512654wrn.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 00:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1BLLiPvUOt1iZqaseuUXd2b5ZjZ67+3GM7+fGjS9KpI=;
        b=lwcj/QcH2MbPsJdIkJyCLM6BEUmkP1J004mf82p00X4hRYQQLe45XzVUT+s4Y/+uok
         DfEVqUgi7uUNnvE7lbIzhz9IjkIAxJgTFGnY8VsYC3XLeV2R+RI0Ep9tZ4cmV4iDP0rX
         8AXE/0OBuoTbyj9w7hoUev0iN+Xv3wwFgrGI5ES1e2PMDTL3bHgHvW6nEQlXzh8iqJ9X
         hkSRCvwKOv9jPuC+zL7Y070hAVUDlRYHPn7cNA9qIZmyo/6DY/3HauYrpgJTrKEmAu1h
         gdwwnIFFAgzm9cYNcbtmaS2C9q9evmvD64TWQO5k6YdEEIV6jH4/eeMuADL1hy5V87fh
         mqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1BLLiPvUOt1iZqaseuUXd2b5ZjZ67+3GM7+fGjS9KpI=;
        b=bNz6nmpgyIQcUULT++eeUou4R5uS5tLyORvn+xpCixsMY3NcaY4A1eLKUmoDgq8gLL
         1LRTknBobwUETpFF9WL8d2Onssp0CHkecWfjC/3XkhMO/qpWv2DQheprbe0ESFEAFKKt
         JXTuvznhe7Cr3Cv08wLubaue1CwOvhl9nWGaM38S4mbVRjJj6cTIVQuPwy245ld+/5vD
         /URbwAgfBL/4azTOXNtT55Jj+uOXF6dJXFKy8zPYoKLLAI8l+CZiMBg7xiMfG6lY2ooG
         s5v1iHD4QF58c9WxX3sKx1h23MJ+wSupsLzrJ8QG2iXZy0cBdSEIwGa/FWSmc+5Kd9UX
         7+gw==
X-Gm-Message-State: APjAAAWudoXXOOx9CroHkqlR03qsCMU/G+8Dn8QCHpWSHrOc2hL+bLj5
        Uwx2Co4eAmxGube9Mqs+1aNO7y/2
X-Google-Smtp-Source: APXvYqz3tfY5Hk89rr1I6GUyXFRhJzD47oLG9XpfZpE0r/lg+O2uQwk1TDPvX6HwODvVNx9+zycIqA==
X-Received: by 2002:a5d:5545:: with SMTP id g5mr5930270wrw.146.1556868983032;
        Fri, 03 May 2019 00:36:23 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id p17sm1712037wrg.92.2019.05.03.00.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 00:36:22 -0700 (PDT)
Date:   Fri, 3 May 2019 10:36:21 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs next second pull for 5.2
Message-ID: <20190503073621.GA6992@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is the second pull request of habanalabs driver for kernel 5.2.

As the tag describes, all of the changes are either bug fixes or simple
re-factoring of existing code, so they should all be relatively low-risk.

Thanks,
Oded

The following changes since commit 78e6427b4e7b017951785982f7f97cf64e2d624b:

  coresight: funnel: Support static funnel (2019-05-02 19:12:21 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-05-03

for you to fetch changes up to 9f832fda79eb6e4f8ebde8d77eb442b95bf6b08a:

  habanalabs: Update CPU DMA memory label name (2019-05-02 15:37:19 +0300)

----------------------------------------------------------------
This tag contains further changes for kernel 5.2.

The changes are either bug fixes or simple re-factoring of existing code.
The notable changes are:

- Add missing fields in the bmon structure that is passed in the debug
  IOCTL when the user wants to configure the bus monitor.

- Use the dedicated device-CPU accessible memory pool for all host memory
  allocations that are accessible directly by the embedded CPU. This is
  needed to enforce certain restrictions we have due to the embedded CPU's
  architecture.

- Manipulate DMA addresses only inside ASIC-specific files. This is needed
  to better support future ASICs code.

Other minor changes include:

- Move pr_fmt() to c files to avoid dependency in include order.

- Remove call to CS parsing function for workloads that originates from
  the driver and remove dead code as a result from this change.

- Update names of structure members and labels to better reflect their
  usage.

- When moving the dram PCI bar aperture, return the old aperture address
  range instead of error code. This will allow us to restore the old
  address range in a simpler fashion.

----------------------------------------------------------------
Dalit Ben Zoor (4):
      habanalabs: remove call to cs_parser()
      habanalabs: remove redundant member from parser struct
      habanalabs: remove condition that is always true
      habanalabs: increase timeout if working with simulator

Oded Gabbay (6):
      habanalabs: re-factor goya_parse_cb_no_ext_queue()
      uapi/habanalabs: add missing fields in bmon params
      habanalabs: use ASIC functions interface for rreg/wreg
      habanalabs: rename restore to ctx_switch when appropriate
      habanalabs: return old dram bar address upon change
      habanalabs: rename functions to improve code readability

Tomer Tayar (5):
      habanalabs: Cancel pr_fmt() definition dependency on includes order
      habanalabs: Use single pool for CPU accessible host memory
      habanalabs: Manipulate DMA addresses in ASIC functions
      habanalabs: Update CPU DMA pool label name
      habanalabs: Update CPU DMA memory label name

 drivers/misc/habanalabs/command_buffer.c      |   6 +-
 drivers/misc/habanalabs/command_submission.c  |  17 +-
 drivers/misc/habanalabs/context.c             |   4 +-
 drivers/misc/habanalabs/device.c              |  16 +-
 drivers/misc/habanalabs/firmware_if.c         |   7 +-
 drivers/misc/habanalabs/goya/goya.c           | 347 +++++++++++++-------------
 drivers/misc/habanalabs/goya/goyaP.h          |  40 ++-
 drivers/misc/habanalabs/goya/goya_coresight.c |  16 +-
 drivers/misc/habanalabs/habanalabs.h          | 116 +++++----
 drivers/misc/habanalabs/habanalabs_drv.c      |   2 +
 drivers/misc/habanalabs/hw_queue.c            |  46 ++--
 drivers/misc/habanalabs/include/armcp_if.h    |   8 -
 drivers/misc/habanalabs/irq.c                 |  14 +-
 drivers/misc/habanalabs/memory.c              |   4 -
 drivers/misc/habanalabs/pci.c                 |  16 +-
 include/uapi/misc/habanalabs.h                |   9 +-
 16 files changed, 368 insertions(+), 300 deletions(-)
