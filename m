Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DE6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF372147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJ4k1uj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfCMOvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:51:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39340 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfCMOvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:51:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id p8so2337120wrq.6;
        Wed, 13 Mar 2019 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HSS0O1ANak0RsHWyy1ydNEu4ZCUlv4/+Jg05eGnpWWQ=;
        b=JJ4k1uj8TySPyan+UgB/s4so0LRFvKdGOpAsVbJrgxhNecQg7iBXERd+z32BxboC0/
         wFcSPYBFQkUWVj/942eKnUkbsBzCwWYO7gQO7VYs+zYnj7j3YTV/ry7Vn+OH9y/KvZoN
         3DWprAvU7iUDRmKeM9e5RXoZxlCjep3mpwQxcXWfdONVmamGy0EuK0F5ytxTtXEjQB4D
         tRsepAF2j/7GQNdbVjvWthxm1CifRWsdu2z4hGClGi55opVfP0t5AgB+wxOCvNccazWH
         eaN/eGSDn79Qa1n9i+sJ4egNbrDHXELIxywANA7IUDpMAP57KQDq3QX7HYb5yEJEWzfK
         lkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HSS0O1ANak0RsHWyy1ydNEu4ZCUlv4/+Jg05eGnpWWQ=;
        b=Tv7ejlDqDP7a8UTEDY3R1hFi6VaX9vKClWdCNypaCz5uXtxe/0r13dOTtYHrDta7oZ
         HnKCvnIApJLUDIuhE9wite5F61cxrgfzsjNqA/Ht0zRGs5Im+gOnMFZUhB91ccNdrwx1
         c6ZsQdKSyhqIfSDmrHkaIO558IaN3wBEbVD7JOtTis8SLiCKFpxkn35d8dPQviBVXjey
         f2YagxBe6OpCTONmWJ0HzRVfmv920m8kM3knot0q9Kj8kjRLBCvxZd7pBUiLYMMqdeBF
         eh3Rpp+RDomMFsPytByn2HDYlnXiakHfTHhepPpFbRB/fwjjsYu5aBm2AciR9FHqPkID
         EoNw==
X-Gm-Message-State: APjAAAXBwyFtDAFlS74I4BsL12Nd2rW163/06ETqFlZ2Pla5y7CZCaSB
        3XYSmbqQcXJ1NSN7/61z3aA=
X-Google-Smtp-Source: APXvYqxMY7voKM38JJmmX1JZEllAKnLY/nMH5fxSh2ViWIct8Q8py4BR+PPETECIGual1XTacflQsg==
X-Received: by 2002:a5d:6948:: with SMTP id r8mr5130227wrw.255.1552488680276;
        Wed, 13 Mar 2019 07:51:20 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id o14sm13171784wrp.34.2019.03.13.07.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 07:51:19 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.1-rc1
Date:   Wed, 13 Mar 2019 15:51:18 +0100
Message-Id: <20190313145118.21818-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.1-rc1

for you to fetch changes up to d7d96312fe108d0df50898d212770b0a5b2d491e:

  pwm: atmel: Remove useless symbolic definitions (2019-03-04 12:52:49 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.1-rc1

The changes for this cycle are across the board. The bulk of it is
cleanups, but there's also new device support in some drivers as well as
more conversions to the atomic API.

----------------------------------------------------------------
Claudiu Beznea (5):
      pwm: atmel: Add struct atmel_pwm_data
      pwm: atmel: Add support for controllers with 32 bit counters
      pwm: atmel: Rename objects of type atmel_pwm_data
      pwm: atmel: Add PWM binding for SAM9X60
      pwm: atmel: Add support for SAM9X60's PWM controller

Dan Carpenter (1):
      pwm: imx: Signedness bug in imx_pwm_get_state()

Jitao Shi (1):
      pwm: Add MediaTek MT8183 display PWM driver support

Mathieu Othacehe (3):
      pwm: hibvt: Use individual struct per of-data
      dt-bindings: pwm: hibvt: Add hi3559v100 support
      pwm: hibvt: Add hi3559v100 support

Sheetal Tigadoli (1):
      pwm: bcm-kona: Update macros to remove braces around numbers

Thierry Reding (1):
      pwm: atmel: Remove useless symbolic definitions

Uwe Kleine-König (8):
      pwm: Don't use memcmp() to compare state variables
      pwm: Drop per-chip dbg_show callback
      pwm: Rearrange structures to group members by purpose
      pwm: imx: Remove if block where the condition is always wrong
      pwm: imx: Set driver data earlier simplifying the end of ->probe()
      pwm: imx: Don't print an error on -EPROBE_DEFER
      pwm: imx: Split into two drivers
      pwm: imx27: Only enable the clocks once in .get_state()

Yoshihiro Shimoda (4):
      pwm: rcar: Add support "atomic" API
      pwm: rcar: Use "atomic" API on rcar_pwm_resume()
      pwm: rcar: Remove legacy APIs
      pwm: rcar: Improve calculation of divider

 .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
 .../devicetree/bindings/pwm/pwm-hibvt.txt          |   2 +
 drivers/pwm/Kconfig                                |  17 +-
 drivers/pwm/Makefile                               |   3 +-
 drivers/pwm/core.c                                 |  10 +-
 drivers/pwm/pwm-atmel.c                            | 111 ++++++----
 drivers/pwm/pwm-bcm-kona.c                         |  16 +-
 drivers/pwm/pwm-hibvt.c                            |  44 +++-
 drivers/pwm/pwm-imx1.c                             | 199 ++++++++++++++++++
 drivers/pwm/{pwm-imx.c => pwm-imx27.c}             | 224 ++++++---------------
 drivers/pwm/pwm-mtk-disp.c                         |  11 +
 drivers/pwm/pwm-rcar.c                             |  99 +++++----
 include/linux/pwm.h                                |  37 ++--
 13 files changed, 474 insertions(+), 300 deletions(-)
 create mode 100644 drivers/pwm/pwm-imx1.c
 rename drivers/pwm/{pwm-imx.c => pwm-imx27.c} (59%)
