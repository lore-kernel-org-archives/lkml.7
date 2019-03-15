Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0308C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CAF21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="d9lMe1M8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfCOU0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:26:13 -0400
Received: from mail-yw1-f42.google.com ([209.85.161.42]:44044 "EHLO
        mail-yw1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfCOU0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:26:13 -0400
Received: by mail-yw1-f42.google.com with SMTP id c4so8281711ywa.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=imglNq7US/IlKgwEpDczslE8BUnl4ZUnjr04nClPZgs=;
        b=d9lMe1M8J1GgEEar/zSDxTOne7m5EmeP/irLj4ZiGz8pErm06dtTvZCOcCLOjsnsNB
         rheseUhDoUbCyx5duGweJDzQUbdljJupN/t0ApzEVQWmKZAJPM/dxufjqlTgnZDqjitI
         WFUBlP1Ax6ERN3O165Vhp2AFXZ6GMYbmZnvL63+iyoDdI0N6R4INUOWnzcCJHTZvWns1
         mw6YoZXqBqzF+FREaem2nYZ52mL4/PW82TItRmL85Y0QPQLxzkY+LDZH1MYryvH729+p
         SRehS/3/MSC5C1SUBGohSW5dMK+efqkj5D281SdPpuex2N0Vg9jzTKF+2o3x4rYbzEJ4
         Qc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=imglNq7US/IlKgwEpDczslE8BUnl4ZUnjr04nClPZgs=;
        b=s8YOcBfmIOnqJWSjyNm1hv6Q713vohTOpZYakrzJ7+e/pYL+S4ZGjtiyzyra4DDgzl
         tRzKG3msSubOemcxt3nQn5SgcBgtea8qgg1GC+Sn435flINqqrRmdQeL+aANK0WzN3kM
         vWmOl150sPROFev8HFZ1/77l7gOX9mhVvrGWPmfkJGDJAtkgLzCbl+lo65A68rajHi63
         W4kb5JcIp7ZA3LI27N1hQm7a+TLyxFZQNt0MLZZdk9ebisDswWFAsnVMpl/4VnK/D4xy
         AYaAnnIxSbwHqbDx9tp+iIpQKYif64YY1FLuXvZ/AhAt+5sXqVAa/6PIG3SH0F/uT0R3
         o+Sw==
X-Gm-Message-State: APjAAAUSzGhP5zz+WLvHXxju5w+UHl2/TUkid9UD4UMn7mvn/E5xdmEX
        4qlKrc/Ky5nWWrY/SlUe5hho2fKREpV0cw==
X-Google-Smtp-Source: APXvYqzYGLkheXwHSSoZQYxEMthVRvOjwOr7kFMDJsTu/UoosiCivM4JQTxwwho8ISgFd7bS9+zZ6w==
X-Received: by 2002:a25:d601:: with SMTP id n1mr4632836ybg.342.1552681571918;
        Fri, 15 Mar 2019 13:26:11 -0700 (PDT)
Received: from graymalkin (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id p17sm1077905ywg.27.2019.03.15.13.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 13:26:11 -0700 (PDT)
From:   Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@graymalkin.kudzu.us>
Received: by graymalkin (sSMTP sendmail emulation); Fri, 15 Mar 2019 16:26:09 -0400
Date:   Fri, 15 Mar 2019 16:26:09 -0400
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: [GIT PULL] NTB bug fixes for v5.1
Message-ID: <20190315202609.GA30826@graymalkin.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here are a few NTB fixes for v5.1.  While the tag is new, the patches
have been in my tree (and thus linux-next) for weeks now.  Please
consider pulling them.

Thanks,
Jon



The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.1

for you to fetch changes up to ebb09b33c60c46fd4f7ffa0af9e693eebe765d1b:

  NTB: add new parameter to peer_db_addr() db_bit and db_data (2019-02-13 11:03:18 -0500)

----------------------------------------------------------------
Fixes for switchtec debugability and mapping table entries, NTB
transport improvements, and a reworking of the peer_db_addr to all for
better abstraction

----------------------------------------------------------------
Joey Zhang (1):
      NTB: ntb_transport: Free MWs in ntb_transport_link_cleanup()

Leonid Ravich (1):
      NTB: add new parameter to peer_db_addr() db_bit and db_data

Logan Gunthorpe (1):
      NTB: ntb_transport: Ensure the destination buffer is mapped for TX DMA

Paul Selles (2):
      ntb_hw_switchtec: debug print 64bit aligned crosslink BAR Numbers
      ntb_hw_switchtec: Added support of >=4G memory windows

Wesley Sheng (1):
      ntb_hw_switchtec: NT req id mapping table register entry number should be 512

 drivers/ntb/hw/intel/ntb_hw_gen1.c     | 25 +++++++++++++++++++------
 drivers/ntb/hw/intel/ntb_hw_gen1.h     |  5 +++--
 drivers/ntb/hw/intel/ntb_hw_gen3.c     | 33 ++++++++++++++++++++++++++++++++-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 20 ++++++++++++++++----
 drivers/ntb/ntb_transport.c            | 31 +++++++++++++++++++++++++++++--
 include/linux/ntb.h                    | 10 +++++++---
 include/linux/switchtec.h              | 10 +++++++---
 7 files changed, 113 insertions(+), 21 deletions(-)
