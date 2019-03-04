Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FFFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7911120643
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fTXRWN1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfCDR1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:27:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33586 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDR1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:27:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so3501557pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 09:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=g/OF5maSA7Ijo+jA+fmh7mzobo83Ai+aqF4UR671AgQ=;
        b=fTXRWN1NYo+rX0TaZYV8VvBxRLQuk5qA3EMTrM6Piu5+OcuQpOwgATKV9AX2p4CgaR
         x8dMUM5YXLNgDGvP3TV59g1NYe/ZSfZLb85C1o0hbXl0lOjzOrj0SSqGagH4KnlaPthS
         Pn9Q9np2e68p+xuNrZz03dn4hGO88QVqr9J0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=g/OF5maSA7Ijo+jA+fmh7mzobo83Ai+aqF4UR671AgQ=;
        b=XogzAxJeCdnx3Gj/S8sxiGlUFR5FqeBecpYJTSZWSEUmyhRccKUytHJSkWGxDNaLA3
         4VlWzohcWmhkFLx8DFYA6prPVTpRIugu9HsBAQwbT1jqTqRctVk1F0ItjtZsxxX1hQly
         oGucUO/fmlrHLVA0RwdJQ3DxTy9FqfxVItmta7B4glQjk5mj/zEvLzdtyBe8bhTBniTJ
         PNQiuyqV4lfRofAKEgGlkOjnVvl22g/6TFKB1/EgEdExcda29mbF1fsHwSWioIH3pIYi
         jeewitqHOS7TChAJ3rTq8UIl7P0MFaK1Ok80uvDeIqZJEyK88Pj4+Hfoz/RXcKgOCdk8
         IXUw==
X-Gm-Message-State: APjAAAWKljQ/vU35vKJmWSkZDbdLUBbrnoERiuahv3BYZn5kGvQJCkcB
        jmLlAIFsaqZV+Bi6xPSUWVnx/lKLx6g=
X-Google-Smtp-Source: APXvYqz8XiQ7HiBHQ+VfxAs+JMiz9iEXqwvrWTSubHvJt5Rvs7EmAmxk0P/VVCG0zMyuYF4FEwa5aQ==
X-Received: by 2002:a17:902:284b:: with SMTP id e69mr20802659plb.11.1551720473790;
        Mon, 04 Mar 2019 09:27:53 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q7sm14555060pfa.119.2019.03.04.09.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 09:27:52 -0800 (PST)
Date:   Mon, 4 Mar 2019 09:27:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Yue Hu <huyue2@yulong.com>
Subject: [GIT PULL] pstore updates for v5.1-rc1
Message-ID: <20190304172751.GA5887@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these pstore changes for v5.1-rc1. These are some small
cleanups mostly in the ramoops backend.

Thanks!

-Kees

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.1-rc1

for you to fetch changes up to 93ee4b7d9f0632690713aee604c49e298e634094:

  pstore/ram: Avoid needless alloc during header write (2019-02-12 13:45:53 -0800)

----------------------------------------------------------------
pstore cleanups

- Remove some needless memory allocations (Yue Hu, Kees Cook)
- Add zero-length checks to avoid no-op calls (Yue Hu)

----------------------------------------------------------------
Kees Cook (1):
      pstore/ram: Avoid needless alloc during header write

Yue Hu (4):
      pstore/ram: Replace dummy_data heap memory with stack memory
      pstore: Avoid writing records with zero size
      pstore/ram: Move initialization earlier
      pstore/ram: Add kmsg hlen zero check to ramoops_pstore_write()

 fs/pstore/platform.c |  3 +++
 fs/pstore/ram.c      | 64 ++++++++++++++++++++++++----------------------------
 2 files changed, 32 insertions(+), 35 deletions(-)

-- 
Kees Cook
