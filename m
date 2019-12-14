Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C80C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 13:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D21B2073D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 13:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr6rgJs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLNNb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 08:31:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38518 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfLNNb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 08:31:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so1775483wrh.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 05:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=l51Ta7pswUE/WHfcSh54+r2023eG+xMv9kR+J1h6YMI=;
        b=Vr6rgJs7Iw1RQ1XQ67qmHCazAOq/K6HGDUdetl2P3SLvbNTfZ/97mIhZ1TSjhNPlIT
         NNOZKjdfjJAE2coGAybU/MJyvbFtLoO3MZdvPd2pl2I8VyoHrJtsWRjKEJL0mEGRuhmW
         VW4TeunSBftQRuzqnE2SbmbR53mFmAMBA2Si7WVLV4uKI0af82hd6zN0XkAQUuewkFT9
         jNZX+6+CGhM6AfkhMmDXIClFfBKj0O1uBsSEqfv3ATQdLfifzTtNQuO8kAKcHEw7Ft3p
         eh+0Dpq7fxCLlrpagdZGs00DmKtvZDcR62bEh+3kgGe65/mU8iqcNbEWG1NZvWVUH9Kd
         JB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=l51Ta7pswUE/WHfcSh54+r2023eG+xMv9kR+J1h6YMI=;
        b=qGkS5OvHVJagJTW5LbxfTp2murcvySP/mqV2/m+9B4vF8YTad7c0sc2cKYSFh0w1Tc
         cb/hbQyBUC6wNHQgJzNYTHzxkzHU/RTrOm2W+2iTXaEG5uaD+k5UVRIhjps8J/+0ne4S
         oez8lq47EX/yLm/ixnKqYj7wYVB39sI+iBS8HslxR070ihDteBSJAzciKt6d3CivUi5U
         Db8y/zMLfbaVxdZKbF49nF5YxMeis4BjYC3UOtWlQfyMUGrjPavBUgdqjK+uC4f9TQRu
         A++6a/T3cODZbb2e2WixYh8ypyE0wDEfHfa9TvaPN03oWcnD80A0YYsHtgoTu6BbwgSa
         tQ8Q==
X-Gm-Message-State: APjAAAWwjmZgWM1DawUBucAlBy5uJGaYw99M/vqDgSnUabQMHFC1/Aym
        HpC4mgYxWx2u+uxV0UXzyvKSCP/Tl8OUWQ==
X-Google-Smtp-Source: APXvYqycHJBXApLF+OF7XzpyhD77o0xp7Uke5x8s16/QEXW6/aHVzn9eiIZyMXe3SQOAwxB98FmDpA==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr19566826wrh.371.1576330317337;
        Sat, 14 Dec 2019 05:31:57 -0800 (PST)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id k8sm14151234wrl.3.2019.12.14.05.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Dec 2019 05:31:56 -0800 (PST)
Date:   Sat, 14 Dec 2019 15:31:54 +0200
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.5-rc2/3
Message-ID: <20191214133154.GA8663@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is habanalabs fixes pull request for 5.5-rc2/3.
It contains two minor fixes, nothing too exciting.

Thanks,
Oded

The following changes since commit 16981742717b04644a41052570fb502682a315d2:

  binder: fix incorrect calculation for num_valid (2019-12-14 09:10:47 +0100)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-12-14

for you to fetch changes up to 68a1fdf2451f38b4ada0607eb6e1303f8a02e0b7:

  habanalabs: remove variable 'val' set but not used (2019-12-14 15:12:21 +0200)

----------------------------------------------------------------
This tag contains the following fixes:

- change dev_err to dev_err_ratelimited in hl_cs_wait_ioctl() as this can
  be called by the user multiple times and can spam the kernel log.

- Eliminate GCC warnings by removing unused variables.

----------------------------------------------------------------
Chen Wandun (1):
      habanalabs: remove variable 'val' set but not used

Oded Gabbay (1):
      habanalabs: rate limit error msg on waiting for CS

 drivers/misc/habanalabs/command_submission.c |  5 +++--
 drivers/misc/habanalabs/context.c            |  2 +-
 drivers/misc/habanalabs/goya/goya.c          | 15 +++++++--------
 3 files changed, 11 insertions(+), 11 deletions(-)
