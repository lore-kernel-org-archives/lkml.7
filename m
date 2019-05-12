Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D6BC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 20:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA72021019
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 20:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cnbyhlvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfELUQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 16:16:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33918 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfELUQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 16:16:09 -0400
Received: by mail-lf1-f65.google.com with SMTP id v18so7502104lfi.1;
        Sun, 12 May 2019 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ShPsfgNxAyDNGvYH09X9UbQVn099K4SJecdsrvSXfY=;
        b=CnbyhlvqQdcF2qVjzfnZntJnhwGqVkvbl3RUiSWoDZDwMuAd1rHKuxEHCytyMj3A/4
         +KDfVHgDmttslDE4dih8Kk7Z/t4YxS0pjthJ+OnH+pDTfBg6vwUoSSHZII93HGXjgcv3
         SGIEy8KH8CwXvbBlCNPLusLP9Fcu9iA8dmndncESTTp1TKs+f4/S3RTfLLqlarQvUm0G
         y1jvofju5PK0CZUwcvCwzXlcLYrqGYeHekKfG/W1dD/BPzQmvdSE3yhTJ0QErWQHKjz0
         jk1BuH/CXdM7r1f7DeDjJOwVPnY3abKQTQdqfRUSrFDeXdoskztiUA22WM5mNO4lQlrq
         Ma5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ShPsfgNxAyDNGvYH09X9UbQVn099K4SJecdsrvSXfY=;
        b=eorXcU95qoJkxFZtA6kZE6cKCAhAUBIOEt7yWtRYvPyyINf53WBxynRU0YN9oSjG/Z
         WL8+0MdYvYrQfs8TS4Fx3gXgTolWzS0TeU5vqdkXFAn8nGTipQTdKmVqhO9tkTCDQbZy
         2SBP5qjUdNcTdUes0joNcwni/+1FfqTX2vVYOeVz9AdoLWxvGskNZ5fdZUIu9n2rHStB
         vZf4BijMIOZxB+xNBDOH+dDnimN0CyAPAuiioLA09KCswkI1X+nPBN7UIvRAwfS9KCVG
         b7+r6eCq+LwT8O6y+G60yzk1G/pGGlAislGjNGvKpVJh3Dg8eAle7Txa8yiGmn02nU8U
         NzKQ==
X-Gm-Message-State: APjAAAUGkRvEoTBytq5+0wgUL6Xi01cim1f5K+rqb1J1jJ7afXf96bTu
        93dWHNWvZgV9DcCdLeeETys=
X-Google-Smtp-Source: APXvYqySBhro9od/qFdiyoXY+fJGuZw99bk+6QDRW4pLh0oT89rRwf17mWP+ZV4EW2cujQAJ4LbBdw==
X-Received: by 2002:a19:29c4:: with SMTP id p187mr11561576lfp.69.1557692166774;
        Sun, 12 May 2019 13:16:06 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id w20sm2360533ljd.39.2019.05.12.13.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 13:16:06 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v5 0/4] media: v4l2-subdev: Verify arguments in v4l2_subdev_call()
Date:   Sun, 12 May 2019 22:15:47 +0200
Message-Id: <20190512201551.18724-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correctness of format type (try or active) and pad ID parameters passed
to subdevice operation callbacks is now verified only for IOCTL calls.
However, those callbacks are also used by drivers, e.g., V4L2 host
interfaces.
    
Since both subdev_do_ioctl() and drivers are using v4l2_subdev_call()
macro while calling subdevice operations, move those parameter checks
from subdev_do_ioctl() to v4l2_subdev_call().  Also, add check for
non-NULL pointers, including pad config if V4L2_SUBDEV_FORMAT_tRY is
requested.  Since invalid arguments generally mean bugs, be noisy about
them.

Having that done, we can avoid taking care of those checks inside
drivers.

Janusz Krzysztofik (4):
  media: v4l2-subdev: Verify arguments in v4l2_subdev_call()
  media: v4l2-subdev: WARN_ON invalid v4l2_subdev_call() arguments
  media: v4l2-subdev: Verify v4l2_subdev_call() pointer arguments
  media: v4l2-subdev: Verify v4l2_subdev_call() pad config argument

 drivers/media/v4l2-core/v4l2-subdev.c | 257 +++++++++++++++++---------
 include/media/v4l2-subdev.h           |   6 +
 2 files changed, 179 insertions(+), 84 deletions(-)

Changelog:
v4->v5:
- a few coding style and code formatting changes,
- require CONFIG_MEDIA_CONTROLLER, not CONFIG_VIDEO_V4L2_SUBDEV_API,
  for a valid pad ID check,
- perform pad ID check only if at least one pad is configured so
  drivers which don't configure pads are not affected if built with
  CONFIG_MEDIA_CONTROLLER defined,
- issue kernel warnings on invalid parameters (new patch - 2/4),
- validate pointers before using them (new patch - 3/4).

v3->v4:
- fix 'struct' keyword missing from patch 2/2,
- fix checkpatch reported style issue in patch 2/2
Sorry for that.

v2->v3:
- add patch 2/2 with pad config check,
- adjust continuation line alignments in patch 1/2 to match those
  used in 2/2.

v1->v2:
- replace the horrible macro with a structure of wrapper functions;
  inspired by Hans' and Sakari's comments - thanks!

-- 
2.21.0

