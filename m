Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44CCC4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 16:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7573C21882
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 16:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pOEzBynT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438012AbfIUQ7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 12:59:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39006 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407792AbfIUQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 12:59:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so5577318pgi.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1Vsw/Kwe855ZOEjTjZQRqZEGEiYIH5SmCcRItz4Mfv4=;
        b=pOEzBynTl9ocsWqj1CBoXBE6ScW1nZf0Vc/2KXzL9kXrfb/K2Ie0vffyry8GzDtE0y
         XxkOG7Wg5S3Z04+jAMlJP5tpS8WINW45hMu10S3crXMhN3Gws+tyhQxBJqp4bs6Y+FSU
         Sp3u8YK7jdWZ3j9kPcMTMVsr8azIF57tWhTpmZdt7W7ca4xUHZZIjxg3vh+UCIN+WqyP
         +YKX15wRBDDiH62CYn6BQEn73PclHZd+U5m8av2OYIIVrkX6cXJ9D0jYUwxo3fz5veSB
         i7XPBdtr8G7fdBlVm++IGqathaqln0pfp3u+SLGK8gcWg+0y8I3SykJ5H2xveHEF8ryK
         mz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1Vsw/Kwe855ZOEjTjZQRqZEGEiYIH5SmCcRItz4Mfv4=;
        b=sPJgs8JmGMtE/0dUgbLh8aoJo8e5a3NGP4RQwWSJrX2h8vttG0UJd7cuPARpqDOkYb
         OB/43vhY8o1ihZxkB5ER8B3sZRJ1k8dD6hkdTwO1gzpp0sMk66RktXq22PiKHC9tJp17
         9sZ7gb9A0TydOxbtC559VPbFUoz7icP880h4NMqVfGSsk6vW4PICtcIEEQmIbuKw5hNI
         iWTIBT1raKiVjPLsl9eEjmwL7k9n6tlpEGoqyvjC02gnU0i1mkOVm0PtlvBq04Hr8dAK
         uf/VA56RmMjPPMOR8oCC0IkTrY24r4dOXd9mEQiuGxbIRbRj0vG8rIyIS/ZxlmGM9HCG
         5RBA==
X-Gm-Message-State: APjAAAXxvh0GCO1L+7iQbjyneghdXzz5tjv+oNejLyGqD55gpFK+4gAd
        2C9+OdSFAZXnSO+HByeiTfX6ZA==
X-Google-Smtp-Source: APXvYqwYam/FZK0CRDEIWbaGDLMeC0qB74nO9A1eZI87p4s8Pwp0HAxwUWbDqfAZXcfL0ecSG1sHQQ==
X-Received: by 2002:a62:aa0d:: with SMTP id e13mr24471756pff.4.1569085155428;
        Sat, 21 Sep 2019 09:59:15 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k15sm35036pfa.65.2019.09.21.09.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 09:59:14 -0700 (PDT)
Date:   Sat, 21 Sep 2019 09:59:12 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [GIT PULL] rpmsg updates for v5.4
Message-ID: <20190921165912.GB6693@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc tags/rpmsg-v5.4

for you to fetch changes up to 9fe69a725e238ac279027f0132e50617a63b847d:

  rpmsg: glink-smem: Name the edge based on parent remoteproc (2019-09-17 15:33:31 -0700)

----------------------------------------------------------------
rpmsg updates for v5.4

This contains updates to make the rpmsg sample driver more useful, fixes
the naming of GLINK devices to avoid naming collisions and a few minor
bug fixes.  It also updates MAINTAINERS to reflect the move to
kernel.org.

----------------------------------------------------------------
Bjorn Andersson (1):
      rpmsg: glink-smem: Name the edge based on parent remoteproc

Gustavo A. R. Silva (1):
      rpmsg: glink: Use struct_size() helper

Pierre-Louis Bossart (2):
      rpmsg: core: fix comments
      MAINTAINERS: rpmsg: fix git tree location

Suman Anna (3):
      samples/rpmsg: Replace print_hex_dump() with print_hex_dump_debug()
      samples/rpmsg: Introduce a module parameter for message count
      rpmsg: virtio_rpmsg_bus: replace "%p" with "%pK"

 MAINTAINERS                         |  2 +-
 drivers/rpmsg/qcom_glink_native.c   |  2 +-
 drivers/rpmsg/qcom_glink_smem.c     |  2 +-
 drivers/rpmsg/rpmsg_core.c          |  8 ++++----
 drivers/rpmsg/rpmsg_internal.h      |  5 +++--
 drivers/rpmsg/virtio_rpmsg_bus.c    |  2 +-
 samples/rpmsg/rpmsg_client_sample.c | 10 ++++++----
 7 files changed, 17 insertions(+), 14 deletions(-)
