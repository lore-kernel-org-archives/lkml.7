Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0489C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15E2206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK4raKtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfG2MzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:55:07 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44714 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfG2MzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:55:06 -0400
Received: by mail-wr1-f47.google.com with SMTP id p17so61713005wrf.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 05:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ask52yMrxg3+BZwH/EDl+YFtG+EtdZHkbyhOFcPUSxI=;
        b=IK4raKtTw//uQf2ciytsputPqanE7eX6K+OS0rN9f2qRqmZc5dyUJIVbLRpMwOPGf6
         2vtvJX82OZ52JSSzmpE0WOa0vm8FLORpdv9qU8vc3lcDxkoxe0yjA72vO11Y9/nDNO7G
         gRq2vGvikYrzJ/6Nd5JQwqJBqxwo/SJo01phA4+BsqWsFtSs5C/wcarIgltA2d4QyP+u
         kUDiq7bFhvSXSxY3m2JBvWU8enoqx/QadyLMa4Hn2qOfBy6L91uKoQczwVyvBJr3Q4pj
         Zioe/vSLdnsYSdm3YlyTTQhogeT40v3DVFwRDAOjvEXnZyv9G1FsqncQIVjGfZPBrWCP
         TvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ask52yMrxg3+BZwH/EDl+YFtG+EtdZHkbyhOFcPUSxI=;
        b=TH0+7hyy6r+EIhpJlUDGK6vrECQg4fbFsnyN6jVtZXXkIV1u4lTHvxrKvB/pKK5QC7
         aAIRddXK40JFHVLMNBtE/V+WrsLyaVxQK/h2bpGzAFPbm5cxhTX3vUQzji2VE4CMqcbc
         REJkhC/JQZXar4V6QwUh26AVziULpF47wH3CLoO2xjWiydj8QmTwnpoErcbdGebchElG
         rpDZKp8UIPX5UXM+1Cfx/mZtT1wrkt7Pw+hFSc1p25qNtNKxOV3vwnkgQpolmp3aVDNT
         Iv7RjZvtkOdbxZJKajfA/IVqyEixnxB4VlodbCKLwIPul2hDTqYuM3M9llY9VwWxi57M
         WTig==
X-Gm-Message-State: APjAAAUjq9P0CSVgofxOXUN4iEC1CWXRGBAdRRV6ltzVDz+0WO2i5Lac
        i0bHledK6Hu7ms8psiSat+uLJcJk8VI=
X-Google-Smtp-Source: APXvYqzcfUZuttd0e//ZYUywNvfXBcOhPHTpTVVX2UbeStuGT7dKy0iS4GHJOxntM6MVU1y8L/M/NQ==
X-Received: by 2002:adf:ea87:: with SMTP id s7mr122512870wrm.24.1564404904452;
        Mon, 29 Jul 2019 05:55:04 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id i6sm53521907wrv.47.2019.07.29.05.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 05:55:03 -0700 (PDT)
Date:   Mon, 29 Jul 2019 15:55:02 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.3-rc3
Message-ID: <20190729125502.GA2969@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is habanalabs fixes pull request for 5.3-rc3. 
It contains two important fixes for BE architecture.

Thanks,
Oded

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-07-29

for you to fetch changes up to 2aa4e410795cb94b6577fe0e251b5f5226499310:

  habanalabs: fix host memory polling in BE architecture (2019-07-29 11:40:25 +0300)

----------------------------------------------------------------
This tag contains two fixes when running in BE architecture:

- Fix for F/W download. The F/W is in LE so use a function that doesn't
  do bytw-swapping.

- Fix for polling on host memory locations that are written by the device.
  The device always works in LE, so we need to do byte-swap when polling
  on those locations.

----------------------------------------------------------------
Ben Segal (2):
      habanalabs: fix F/W download in BE architecture
      habanalabs: fix host memory polling in BE architecture

 drivers/misc/habanalabs/command_submission.c |  2 +-
 drivers/misc/habanalabs/firmware_if.c        | 22 ++++------------------
 drivers/misc/habanalabs/goya/goya.c          |  5 +++--
 drivers/misc/habanalabs/habanalabs.h         | 16 ++++++++++++++--
 4 files changed, 22 insertions(+), 23 deletions(-)
