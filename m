Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB315C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9092175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWkxArrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbfEXRx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:53:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39351 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfEXRx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:53:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so5985253wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/v7rO2riDcOGiIUFO4drw/u2pyOBxp849lgEWGaPgNI=;
        b=iWkxArrmodDcPGTK65Lkp/FDdZXihxS4Qn6aZoemVO+smwByoaL9bGeaZ7huplqcvy
         RUmgFnBwmPhHSDW7pR8+KMAyM9zDw56KH7PC7Os2qMJpBJXinjzmuIfI7z+wKYp8HmlW
         6r3GMBeXuP24YtSKRKFkpCwnprbX/9YBhFPnur7aXxtP7oJ8tQLX1sQXVgJxrnnDg3Ox
         th3fP495EaUQllXFgUBod5q/UoeyU7kV5VVuJiZijbFRbw8rgJjxGvi+sd3nmu6FCooJ
         BMjy8WBMIlnLjmIyE5d+3ab7CVMnCrSfvDp37LFZ1CsxzpFWQIyPn45osBuqIj3lAaL9
         637A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/v7rO2riDcOGiIUFO4drw/u2pyOBxp849lgEWGaPgNI=;
        b=aScal7RdbTTnuVz4q8Xeh3Yps0uqw9vYs6IYCPeTfIXMm8vPWhgPyrrUpSJ2qPTvp9
         U7pJVUEmFHJk6W8xL5ZgCTM4TqXvT8a3ivBO6k6oETrgxqeEnx7Jf5fkPqp1gfe0E8/E
         4qrQYUOUF1eFsVLRexIrogLOcqjI9F/rAK9aVvHBic8A2TMDTwwq3K9tDLNE54JzMQpH
         Y+DcS7h28XwWXcwRVYiPAdRfthHB3Bdg+Yej7POX0VfIb7Y5hfd4IICsD98KGToP4uHK
         0isnlmHxFmm6YvKSEdP4r1p9Why5Drbn8goB2hwbzFk0zy4J522tI9dREid0EuFcyd2N
         WStw==
X-Gm-Message-State: APjAAAXRV1P+B0rnHmCx1tq06lMB/A+J8pLR1/c65a/PR/j/zXM4G0VR
        gkdEaeJSfktSKz7060gmtIqrXJu1
X-Google-Smtp-Source: APXvYqwD0TvNBL+yXWrFSw0JZb+RatKnrMJtB3tEpjVrSKSQmAN230zH+lhqIUbyuiziN9cbENXZyw==
X-Received: by 2002:a1c:1f44:: with SMTP id f65mr780201wmf.177.1558720407211;
        Fri, 24 May 2019 10:53:27 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id x187sm3244490wmb.33.2019.05.24.10.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 10:53:26 -0700 (PDT)
Date:   Fri, 24 May 2019 20:53:24 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.2-rc2/3
Message-ID: <20190524175324.GA3024@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is the pull request containing fixes for 5.2-rc2/3.

It supersedes the pull request from 12/5, so you can discard that pull
request, as I see you didn't merge it anyway.

It contains 3 fixes and 1 change to a new IOCTL that was introduced to
kernel 5.2 in the previous pull requests.

See the tag comment for more details.

Thanks,
Oded

The following changes since commit b0576f9ecb5c51e9932531d23c447b2739261841:

  misc: sgi-xp: Properly initialize buf in xpc_get_rsvd_page_pa (2019-05-24 19:00:54 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-05-24

for you to fetch changes up to 0dfda3cf06aac2f339442ee5934a38566619c059:

  habanalabs: Avoid using a non-initialized MMU cache mutex (2019-05-24 20:38:04 +0300)

----------------------------------------------------------------
This tag contains the following fixes:

- Halt debug engines when user process closes the FD. We can't allow the
  device to issue transactions for a user which doesn't exists anymore.

- Fix various security holes in debugfs API.

- Add a new opcode to the DEBUG IOCTL API. The opcode is designed
  for setting the device into and out of debug mode. Although not a fix
  per-se, because this is a new IOCTL which is upstreamed in kernel 5.2, I
  think this is justified at this point because we won't be able to change
  the API later.

- Fix a bug where the code used an un-initialized mutex

----------------------------------------------------------------
Jann Horn (1):
      habanalabs: fix debugfs code

Oded Gabbay (1):
      uapi/habanalabs: add opcode for enable/disable device debug mode

Omer Shpigelman (1):
      habanalabs: halt debug engines on user process close

Tomer Tayar (1):
      habanalabs: Avoid using a non-initialized MMU cache mutex

 drivers/misc/habanalabs/context.c             |  6 +++
 drivers/misc/habanalabs/debugfs.c             | 60 ++++++++-------------------
 drivers/misc/habanalabs/device.c              |  2 +
 drivers/misc/habanalabs/goya/goya.c           |  3 +-
 drivers/misc/habanalabs/goya/goyaP.h          |  1 +
 drivers/misc/habanalabs/goya/goya_coresight.c | 17 ++++++++
 drivers/misc/habanalabs/habanalabs.h          |  2 +
 drivers/misc/habanalabs/mmu.c                 |  8 +---
 include/uapi/misc/habanalabs.h                | 22 +++++++++-
 9 files changed, 69 insertions(+), 52 deletions(-)
