Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9494CC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6319B20643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1oHo0r9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfDSTEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:04:42 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:41022 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbfDSTEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:04:39 -0400
Received: by mail-pl1-f180.google.com with SMTP id d1so2972486plj.8;
        Fri, 19 Apr 2019 12:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3kKrgDx6p2/hDPCEa9tDMKLuCUU6fRQv9eTEmPdhp28=;
        b=o1oHo0r9qYAwSFf+1xJ4tzUzE78oR7SPpN8soWSbzX5tXNoxMvwUOthYqBWnobZbQY
         gUxHaG/S+wnvV6LhIYY0qo92kQfdyBaBWfdOOMnOKCg26rrDoiGW3p+irMjKiT7cd0PB
         M95Y7B7nEGIVdlmk4RQzTlv2JgvAaIl4WG+w8Ug3OCVpVpxqvv/LaaBkAnpZQ0mvm9w7
         +AfwNNmJUO7pk37/CffmUuIr2W7q87wBEjXbyLqPnNUkulunCC/y7laf+6lwA/u+oEiC
         qs8Jqa65TDe+7oJGCQ7Z5Q6gXzyEb6SpvrQDfgYAgxw/kc7mjageDhul82CTvKiZzLy4
         XncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3kKrgDx6p2/hDPCEa9tDMKLuCUU6fRQv9eTEmPdhp28=;
        b=d+9yS7tb4Fd0Bb+DkSmlmYDfeGeVU0a9qaSnPoHhJM/LcSqzsKTdeKxeezw6AaUVfH
         Lqiq8NU2eKS5g8zoYTU8onfNpOZqqeFs3ELeTx6j+Tb4ilF19ZoXItbgsXoGZ8HazI8W
         l6uiRuIoJ3UajGn2IzcTxU/8+7euldwgKKXmhUQPRDyeGCkMRQB9FzESiQY19baqNbdi
         uObsS8XLSWXS/bJHTLSmxk5qSup5AF8gDFVwJ60NO9ctfDK2MkApiyK5H2WRIsCsL7Xx
         lSLCJUbRhdro3Qxn9TF0TujbaFICTLNQHYcZiNL+B0RBR3IC66Sb1/CLOwzk/Yot2LkO
         qXdA==
X-Gm-Message-State: APjAAAUtWpodhEKNszVF02E1nqwYudVhfo7dMOt3QYCL4BQdcJyyNWd8
        RFL6vh5vosVilRjSYkpR7kOTCQCC+tQ=
X-Google-Smtp-Source: APXvYqyXm0f+pD//CSmJA1jXiRPYSXxBkgrN0isFq0AMhwdRbEEFYOO4FZNUgrb26auw+VaMoAFPgg==
X-Received: by 2002:a17:902:2beb:: with SMTP id l98mr2263077plb.331.1555659124659;
        Fri, 19 Apr 2019 00:32:04 -0700 (PDT)
Received: from localhost ([61.199.190.18])
        by smtp.gmail.com with ESMTPSA id v3sm891284pgr.28.2019.04.19.00.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 00:32:03 -0700 (PDT)
Date:   Fri, 19 Apr 2019 07:31:57 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.1-rc5
Message-ID: <20190419073157.epllrynbv5ww4a7r@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- several new key mappings for HID

- a host of new ACPI IDs used to identify Elan touchpads in Lenovo
  laptops

Changelog:
---------

Anson Huang (1):
      Input: snvs_pwrkey - initialize necessary driver data before enabling IRQ

Dmitry Torokhov (7):
      Input: document meanings of KEY_SCREEN and KEY_ZOOM
      [media] doc-rst: switch to new names for Full Screen/Aspect keys
      HID: input: fix mapping of aspect ratio key
      HID: input: add mapping for Expose/Overview key
      HID: input: add mapping for keyboard Brightness Up/Down/Toggle keys
      HID: input: add mapping for "Full Screen" key
      HID: input: add mapping for "Toggle Display" key

KT Liao (1):
      Input: elan_i2c - add hardware ID for multiple Lenovo laptops

Diffstat:
--------

 Documentation/media/uapi/rc/rc-tables.rst |  4 ++--
 drivers/hid/hid-input.c                   | 17 ++++++++++++++++-
 drivers/input/keyboard/snvs_pwrkey.c      |  6 +++---
 drivers/input/mouse/elan_i2c_core.c       | 25 +++++++++++++++++++++++++
 include/uapi/linux/input-event-codes.h    |  6 ++++--
 5 files changed, 50 insertions(+), 8 deletions(-)

Thanks.


-- 
Dmitry
