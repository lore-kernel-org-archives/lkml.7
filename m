Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E12EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B081218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWM/bbCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfCUP2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:28:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56086 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCUP2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:28:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so2821142wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 08:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NketD5QHGAePu6DWiMQMC/Ch64UhtDAuA2z5/84Wybk=;
        b=JWM/bbCbk4ArAWzes0yjuShsBY7wwBRrVvA2IuXYXap4NY0TbjxNqoEVuAioCO2A84
         eD4hvEnN46WHCfEnL1M8TZkkHc+no8qA8VxwomhTTubrValYX/tyrqR9hXxsDQWtVd05
         67NHdLRI0NNUuETns2IxDjX2Jurz4HR7KHwnbavZ698JDzt42o0kqSGRvxUMAid346+m
         fvti8wZMEP7fvKBmYOqg6GDz3q74Vb8nXPuFx9oqUXmLBVYekS5fSEFS5hGjOMtl/94f
         bBZGiMdo8TZSG+kEpv7t8ejNJvc/3woS/ctT9hM6TAi/TroUFCOznl/fQngnAv6zF1N/
         bMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NketD5QHGAePu6DWiMQMC/Ch64UhtDAuA2z5/84Wybk=;
        b=Hy38O9GPdGhuG/AOd5u3QD8rJtqfU0QXbIqWnP6hmtVrIwJ3z5FciU2Yg/bsy/YsNn
         gpGzQdakMuzfw/8WFK/VDbPdb11esOtsubAoAhEKhiiz0LfweSnwVYoUeHsyyMPJ6yiu
         ZkuJcywMOJr2r0qnaku71ITX0r8ATwi9y7NoiieRGDaCwEOcAlHQk6jeSIN9SdAsQGrV
         CiFmU0rOYZ1Fozs4Gq5JAaTRFNksFK3ZiYe/Yw/uYDRtd/lJ4BcAH3EdY/iogFeX9cWt
         SxqfrTaYbZj2cn+e7V5+3OjuephfE58FGD3vdska4CJx6pOazV1FbvvkSMtbPN0D/M8c
         +oSA==
X-Gm-Message-State: APjAAAW8ErA8ER4sh7AwSQQwQ/kVz2cvuNgcPo+0Nm5qxI+lRhemmDeo
        E87FxSaM3PHjbSUPeQ2UdG2VNT+K
X-Google-Smtp-Source: APXvYqwfrLynmj0FHxlZaz3aJILg68z76jqjJXdT3Q6ATg+bCfMS8hnVz7/R8WqBqZIDz+Jm17ytkA==
X-Received: by 2002:a1c:ed03:: with SMTP id l3mr3005873wmh.28.1553182098712;
        Thu, 21 Mar 2019 08:28:18 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id w8sm7454067wmc.0.2019.03.21.08.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 08:28:17 -0700 (PDT)
Date:   Thu, 21 Mar 2019 17:28:16 +0200
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.1 rc2/3
Message-ID: <20190321152816.GA1381@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

A couple of important fixes for habanalabs driver:

- Fix host crash upon resume after suspend
- Fix MMU related bugs which result in user's jobs getting stuck
- Fix race between user context cleanup and hard-reset which results in
  host crash
- Fix sparse warning

Thanks,
Oded

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-03-21

for you to fetch changes up to 2198b040b98cfbed62716692a34eb971e0383f93:

  habanalabs: cast to expected type (2019-03-03 10:23:29 +0200)

----------------------------------------------------------------
Oded Gabbay (3):
      habanalabs: perform accounting for active CS
      habanalabs: prevent host crash during suspend/resume
      habanalabs: cast to expected type

Omer Shpigelman (4):
      habanalabs: fix MMU number of pages calculation
      habanalabs: fix bug when mapping very large memory area
      habanalabs: complete user context cleanup before hard reset
      habanalabs: fix mapping with page size bigger than 4KB

 drivers/misc/habanalabs/command_submission.c |  6 +++
 drivers/misc/habanalabs/debugfs.c            |  7 +--
 drivers/misc/habanalabs/device.c             | 71 ++++++++++++++++++++++++++--
 drivers/misc/habanalabs/goya/goya.c          | 65 +------------------------
 drivers/misc/habanalabs/habanalabs.h         | 21 ++++----
 drivers/misc/habanalabs/hw_queue.c           |  5 +-
 drivers/misc/habanalabs/memory.c             | 38 ++++++++-------
 drivers/misc/habanalabs/mmu.c                |  6 ++-
 8 files changed, 117 insertions(+), 102 deletions(-)
