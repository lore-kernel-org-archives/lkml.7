Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B7CC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DB120657
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIstnD45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFWNut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:50:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50748 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFWNus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:50:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so10327706wmf.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 06:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zpwiXk85jpT08Y6ZBMcJ/wyE7pImTcgVQKw9N3i4sSU=;
        b=pIstnD45O0Rbt6O7+GyPNJBPgVAt5/dwQalEToNACvICunCyRTvK8hIi90C5WVKjC6
         xLmOlz4McRUgtNMbo2kHV94uRb4YT7Uoe6+iHtZ06CGQoixxDx5LWye1yh1H6WC4n20U
         XhpMONoeVVseUwUdydycfbl1QLyOtpDArxQaDkIohmrurjF+YlIYbo/1aM0jgT8r64Rf
         IHRtz2m3Dw3yXSndzBRZZ1T7MwMF1N3RHBCCLp56pY5Y2u5NIEhW5Gwtr63S1ATui8Sr
         E6eHx8b2rLr8NvkUugyHZU0WQSwYlSAD+hybLfP+JDrB190a1AqSxTvIIKSumJ6LZ7B8
         vPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zpwiXk85jpT08Y6ZBMcJ/wyE7pImTcgVQKw9N3i4sSU=;
        b=ga1MF8mnT30dthQ7aKt8WvAryZA0W1bvt8RM2zdcRZwQ5xwpa59ig+HJgvOQCl0j1A
         G2FZA4TWDprugLzoBHw5mHC3y91eS20q9HTuPZQlArejRMVD6Nb/A/lZlMvmEeHywN19
         sfFazkgtm4E9rdxXYG3ryvuK2cnfCi2/HuMiTitvCBnqeMPCuYt8I4WXG3qWgymheZlz
         7G88pN31+0qSIXJcVQ3/2v952MawG8PKhsLPbOutp0hfclVwWytjRtLK8EYNP9TqpfDw
         D3B88/37nsf1n71ItmYNgOyoPSMpj/Bil7Zi4nck0bO7koFfroBpIKqn8ehiFvT6jvKQ
         XV7w==
X-Gm-Message-State: APjAAAWCFBnymTwTCbp/xDWprTwzJfdCx+Tj0zdAn7W2rGHJLRA1V26A
        Zgx9Fz2PjBef+UNHOVmU7EU=
X-Google-Smtp-Source: APXvYqwXmn6kr1SRfH2fCMSytgNX6EiiGjtIWgPn87uzKD9/DS/oxvW4zlGNVhfB7+QquenCWiXuAQ==
X-Received: by 2002:a7b:c84c:: with SMTP id c12mr11651885wml.70.1561297846416;
        Sun, 23 Jun 2019 06:50:46 -0700 (PDT)
Received: from gmail.com (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id p26sm20617422wrp.58.2019.06.23.06.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Jun 2019 06:50:45 -0700 (PDT)
Date:   Sun, 23 Jun 2019 15:50:38 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Robin van der Gracht <robin@protonic.nl>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v5.2-rc7
Message-ID: <20190623135038.GA29791@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A cleanup that was in -next for several weeks (before I added
an Ack). It is late in the cycle, so pick it up if you feel
like it!

Cheers,
Miguel

The following changes since commit 9e0babf2c06c73cda2c0cd37a1653d823adb40ec:

  Linux 5.2-rc5 (2019-06-16 08:49:45 -1000)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.2-rc7

for you to fetch changes up to f4bb1f895aa07dfcb96169192ff7c9154620df87:

  auxdisplay/ht16k33.c: Convert to use vm_map_pages_zero() (2019-06-20 15:06:24 +0200)

----------------------------------------------------------------
A cleanup for two drivers in auxdisplay:

  - Convert to use vm_map_pages_zero()
    From Souptick Joarder

----------------------------------------------------------------
Souptick Joarder (2):
      auxdisplay/cfag12864bfb.c: Convert to use vm_map_pages_zero()
      auxdisplay/ht16k33.c: Convert to use vm_map_pages_zero()

 drivers/auxdisplay/cfag12864bfb.c | 5 +++--
 drivers/auxdisplay/ht16k33.c      | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)
