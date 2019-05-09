Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D4EC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18055217D8
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VyVSCgse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfEIRTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:19:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46695 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfEIRTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:19:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id y11so1638904pfm.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BRvqwUI0uZFzpl2BLIYqh6OYcksWnrEnofgk6bb9Vto=;
        b=VyVSCgseyO03qDb0Fz1SCSG/lnngZMXkixXOzRxFqXJD/h0EX67ov2xnjFfy+lWQ0X
         S+uOzxaltej7fzX+aqD+8LbJCQ5NecCkh9+oGCwZNBZcQ7R75E5Sf1/5EOalr4TgnmZl
         /786ewakOMgLR3843zA46SKj3D44SpGU02G2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BRvqwUI0uZFzpl2BLIYqh6OYcksWnrEnofgk6bb9Vto=;
        b=jtBR363NwPA+wrsRWNao+cXOFwzlCuOt99g2vdOPmQ0mPUuqml21gBgPJFKNt89Gl0
         0aL1k8/KLOqOqHUb0ae6w3jdPNzJY3gjBbKUVTRdgfcTbQKub9liPHziSAB22TjuNOvE
         5C+m6sHwg/ldbpMtlVDzaf2Aj4qmIgPaj/HorHgfAH0D4EshL1nuPSJS+nYIwd4uPdlz
         BdYMTfpAdAymB83/8Hdgz2//VgfibZmADB8Szv6ucGe07I7p1LNffDDVKutQ14Gm5j9K
         2yy+ALuPOyLejLqrNYJGXRRVele7kRe/YgIewCvSn8J10e21Bm/CYW1SJrtufThwmpK/
         mO8w==
X-Gm-Message-State: APjAAAVHlwlAVu89yCcW5RIJGXcI2uLFoiwcDoZtTKk0GYl5hK06I1MW
        GYAmy0btBPgfN/kU2lk7tBiRyA==
X-Google-Smtp-Source: APXvYqz6fK1TLtsbjm9UyeEYNG6YhCRI6vIP/1JMtdlyGlEUhuCoW1xJwlVwyohLTxLaHl9DJsNSSA==
X-Received: by 2002:aa7:98c6:: with SMTP id e6mr6850845pfm.191.1557422381114;
        Thu, 09 May 2019 10:19:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k26sm3675274pfi.136.2019.05.09.10.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 10:19:40 -0700 (PDT)
Date:   Thu, 9 May 2019 10:19:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] lkdtm fixes for next
Message-ID: <201905091017.DA22A3E0C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull these lkdtm fixes for next. If possible, it'd be nice to get
these into v5.2 (they're small fixes), but I'm fine if they have to wait.
I meant to send these earlier, but got distracted by other things.

Thanks!

-Kees

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/lkdtm-next

for you to fetch changes up to 24cccab42c4199c6daa0a6981e6f6a1ffb0b5a09:

  lkdtm/bugs: Adjust recursion test to avoid elision (2019-04-07 10:38:31 -0700)

----------------------------------------------------------------
lkdtm: various fixes

- Move KERNEL_DS test to non-canonical range
- Make stack exhaustion test more robust

----------------------------------------------------------------
Kees Cook (2):
      lkdtm/usercopy: Moves the KERNEL_DS test to non-canonical
      lkdtm/bugs: Adjust recursion test to avoid elision

 drivers/misc/lkdtm/bugs.c     | 23 +++++++++++++++++------
 drivers/misc/lkdtm/core.c     |  6 +++---
 drivers/misc/lkdtm/lkdtm.h    |  2 +-
 drivers/misc/lkdtm/usercopy.c | 10 ++++++----
 4 files changed, 27 insertions(+), 14 deletions(-)

-- 
Kees Cook
