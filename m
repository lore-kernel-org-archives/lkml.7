Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1671C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06B72087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/4HYzda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfHLGTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 02:19:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45313 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHLGTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 02:19:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id q12so13266750wrj.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 23:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cXuEfz6dTLuH7k4JZkqkTjgK1i8dsH88adMzdKQ1sTc=;
        b=R/4HYzdastzBW74NMy+sUW5qb3ISPh71xP4ZduZf6UWIMLAbGLhIUZ250/4laxSZfl
         uUZ8sZd9vvrvet2alOQCk6D9W5sUdBeQ5eJ9/LUN6lYoXzQGI+ePTdxWZF+OFC/6nRk3
         oYvtxAcuz7as6kOT85NsUgLdZ7sjC0NqZTze6V9/8GgvAyw/VTY76nshzViFM80jx9wf
         FdsdGYEZs00yUKTIdOYKZDJ8EyK4NIKeSEFssI6qUHNVYtGzEVXehZSBPR+oN1QIT8Rn
         2BWnFB7w1vhfX2t8AaHDHHO0SqGvPCywHVL8pLAwxc+j1E7dsJ1UFD17W/07aGrzIe3G
         WbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cXuEfz6dTLuH7k4JZkqkTjgK1i8dsH88adMzdKQ1sTc=;
        b=av7zdAUwDqY/oxVQYAqeXGLHKRg0cAMlfF+4V7cDAztwLOdjOFRY9bRUAtboFhXdIO
         383m0N3E81Z4y4NFzDwfqEgFDCvpK704QVJlAQulrL+9RxgnDXIELV/sW8s11MEfQBti
         wjBl0aJfZQ11zliBCTZVD+CcasJCxAyDENL+bG+1wHA433Zo8Tz2JkRkedprNmpQlUxt
         u//E/d7ztqjpkNiW33SEN1UHXUxUhVsB5e3q1tvakb30M+mVKnxVAeAZpfuxEmz151eV
         yeStmcwuWzJ2xJWSvK30/Eh7mpke03bhihvLWlP10e3DkiIZ0qyj1eyjelFPEekqxaYW
         gW1Q==
X-Gm-Message-State: APjAAAVwomE6XZtJwVUZbYXvQ+YF1dvm4Pu7rc+nXiZtp/tX9JrvbZRg
        ywYLsNir6v22umnsQizC1pZOtJbRbos=
X-Google-Smtp-Source: APXvYqx54CVqhDVPGxTi37PynpBJVCNcwZHegQUdr0PCtVMLeUoz6YdJ/YuNJv8pcMzjkEimW3KTOw==
X-Received: by 2002:adf:dcc6:: with SMTP id x6mr38995179wrm.322.1565590767686;
        Sun, 11 Aug 2019 23:19:27 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id 24sm9501633wmf.10.2019.08.11.23.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Aug 2019 23:19:27 -0700 (PDT)
Date:   Mon, 12 Aug 2019 09:19:25 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.3-rc5
Message-ID: <20190812061925.GA19050@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is habanalabs fixes pull request for 5.3-rc5. It is a bit larger than
what I would like at this stage but it contains four very important fixes
when running on s390 architecture. With these fixes the driver has been
validated as fully functional on s390 (which is BE).

In addition, it contain two more fixes for minor bugs. Specific details
of the fixes are in the attached tag.

Thanks,
Oded

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-08-12

for you to fetch changes up to b421d83a3947369fd5718824aecfaebe1efbf7ed:

  habanalabs: fix device IRQ unmasking for BE host (2019-08-12 09:01:10 +0300)

----------------------------------------------------------------
This tag contains a couple of important fixes:

- Four fixes when running on s390 architecture (BE). With these fixes, the
  driver is fully functional on Big-endian architectures. The fixes
  include:

  - Validation/Patching of user packets
  - Completion queue handling
  - Internal H/W queues submission
  - Device IRQ unmasking operation

- Fix to double free in an error path to avoid kernel corruption

- Fix to DRAM usage accounting when a user process is terminated
  forcefully.

----------------------------------------------------------------
Ben Segal (3):
      habanalabs: fix endianness handling for packets from user
      habanalabs: fix completion queue handling when host is BE
      habanalabs: fix device IRQ unmasking for BE host

Oded Gabbay (1):
      habanalabs: fix endianness handling for internal QMAN submission

Tomer Tayar (2):
      habanalabs: Avoid double free in error flow
      habanalabs: fix DRAM usage accounting on context tear down

 drivers/misc/habanalabs/device.c                   |  5 +-
 drivers/misc/habanalabs/goya/goya.c                | 72 ++++++++++++++--------
 drivers/misc/habanalabs/goya/goyaP.h               |  2 +-
 drivers/misc/habanalabs/habanalabs.h               |  9 ++-
 drivers/misc/habanalabs/hw_queue.c                 | 14 ++---
 .../misc/habanalabs/include/goya/goya_packets.h    | 13 ++++
 drivers/misc/habanalabs/irq.c                      | 27 ++++----
 drivers/misc/habanalabs/memory.c                   |  2 +
 8 files changed, 90 insertions(+), 54 deletions(-)
