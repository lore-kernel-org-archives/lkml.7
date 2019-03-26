Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF57FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6A620830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsYUoL/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfCZINk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:13:40 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:46781 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfCZINj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:13:39 -0400
Received: by mail-wr1-f43.google.com with SMTP id o1so13117597wrs.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 01:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UjgzbLz8IMIeYsYsKD1/mExdPucWK63oSxes3DTmJ6k=;
        b=AsYUoL/YcJRZ8JgucUf0rmbTQ/kpOfYp2a1NSiDOtp/kO8yQ4uaN36R1tMUMBSvMpc
         bYe9qnbvRT6mlLCIk/b4Npnk0zDIILjsvlOT/jGaYfoDxBFQj0HZpZcCY2Zvl2cuR9Ol
         uMMt9ZuHWfsDgy5JsnuACjCX/AxU5vGCh6oqygCOc6oZ5fk9WxGPrkQP9lBRqLAOmVo9
         Yh/G4dQOsoyNP3WyYtgp8toEpegPy0qS1kGRzlioyc5TTV3tJJqOchdS27v48uNkNBDs
         /8Lyx2CuFY0fKSXRt6KpJ7jZoYLOKJZyeEFkvNBh7vCVXMkFKt2zHbiZpsI3rg1PhBhC
         mQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UjgzbLz8IMIeYsYsKD1/mExdPucWK63oSxes3DTmJ6k=;
        b=Yhq3HKmwB6E9baSD4qNmOF4MyNYQRDe4odF7F3akf9VNy1WvBE0BFDl6FGP7/QfaNb
         BOl789b9fGW7nKDFnqjmwIKp54MnndvjAhiazicCvxGsMCvqPoN2a0KfCwh7M3iGH/7m
         dRgy0fB4mpWtPAEgH2ZYfrStQQC6d2BW7FcqleKqdTimeKp7P9fjNXngP6CqJex5gyPE
         YOr/umTy38BX8XYyj39GdXH3c3uF2gmUjMxjGrx8dLQLz7vbGD5zEy2OM10dErIP+8+K
         Eb9tI6TZluEz3YXagoeqOqt2zk4fghzwixqKqWw4YPhTDOGPABlKdP6YEZDmpUQ5ipLQ
         lDew==
X-Gm-Message-State: APjAAAWsSkUXOcZIjd6Acy1jYVUVJQenpzblhqkKFQvSgIuSnWHkvFXb
        rhdl+XEyU8oY/GcjHaQie2dGi61+
X-Google-Smtp-Source: APXvYqx8rjRTjQ5/BS0Fuf3tMTv8F/bBGWeMeehgtVP/dE9wSlMw4mob7BMbTx5+CQjQ6VCi9PMT6g==
X-Received: by 2002:adf:f10c:: with SMTP id r12mr18107278wro.216.1553588017749;
        Tue, 26 Mar 2019 01:13:37 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id 3sm24895767wrk.68.2019.03.26.01.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 01:13:37 -0700 (PDT)
Date:   Tue, 26 Mar 2019 10:13:35 +0200
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull v2] habanalabs fixes for 5.1-rc3
Message-ID: <20190326081335.GA4175@ogabbay-VM>
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

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-03-26

for you to fetch changes up to 7c22278edd0a931c565a8511dfc1bc57ffbb9166:

  habanalabs: cast to expected type (2019-03-03 10:23:29 +0200)

----------------------------------------------------------------
The following bug fixes are included in this tag:

- Fix host crash upon resume after suspend
- Fix MMU related bugs which result in user's jobs getting stuck
- Fix race between user context cleanup and hard-reset which results in
  host crash
- Fix sparse warning

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
