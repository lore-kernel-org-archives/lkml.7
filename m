Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E96C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34995216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568639937;
	bh=GOmpw//erw4DKsV4qShfxBarB/2rXG7ktAJ49mrIltQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=F2Ys6qNysBGeEkb908edNdmQiRweOoVRmhq3zimwSXT3xZfF4+r98sJKZR1fGGIZF
	 RXgc3juPz0DXpFy/ECSF2x1C/Q4/ExVfkQ+b4EVX4EfTD+uqjs5B/ShJFmY5JoK+QR
	 yYTpwTlnwXcwI2DWAYj+vOS7ACCxkjZL6VHu3dEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbfIPNS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:18:56 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:44038 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733105AbfIPNSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:18:55 -0400
Received: by mail-wr1-f52.google.com with SMTP id i18so8167258wru.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2UjmY9rQe9c6bwok0NbrzQjI7nAkH8a7C/0EtpJRrqo=;
        b=vAh0UUx26wfOL6zETX/Z56YLN9fSkfjyjzZGfbDB/8/JfxbaNn7UUhc0Y91vGXudRm
         xsTdZyN7OnLqm5b9X0uFi4anHiPb/UHyPatTZcdvc7ytuGGLOQ+i7cXxst9CROGWUEdV
         1LUR8eJFzRcRl3rd7F9Lrmz5SgouXpXgXwiPgaMYCuH16tmq009alDw6pfA23F6LZr6s
         RCV0rHUfm2Acxpswzor76SrP8lBwXcU1jed3jml+IZCgYqCwNEIrSZLNiPXmLS3TWHPG
         aaMWIBt+00XCA7ROn/+kz96zj0PrHxE+Wjw5hIxvl2Llrnea4KzVsJVjyvuYFEgGL0pP
         Htwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=2UjmY9rQe9c6bwok0NbrzQjI7nAkH8a7C/0EtpJRrqo=;
        b=PJQ5WXg1ts1wxTUFukdEF8nnUURQqU6TZ2iN1hEmnxPLhcMiB1yOI0EZ6xs6auSJQv
         q6jFBWpAzmob9mX+fLbwOcdAiMeF6NGAS6uNoktUQhMKpUTCV7wWFf2gtpqRDI7C8Qvm
         6/WEBhNJJhprL4In+XANZrE0bDzTnhjtgTWDf7zrahtig9gBF1VIU971yXgrSeKHZLlT
         kLm1IFOxIOXH6+IfeBw27yR2fVYPP0SIPolW7ekgwUFEFLIWo3chhKqKDxiD/ud+ttE/
         uhoZYROBPKAz3v95de3FGhQL2PNX+xvuRcUlv/G9UOTVMDp4/jUNtzkY8lzCV/zncWZM
         sxZw==
X-Gm-Message-State: APjAAAVJXKXUuQCeJrLW1TNnG31UhsidD82cVZjE3U93PSvgwseRQ4f4
        +ry1GwC+PAvKgkL/tiLuRyo=
X-Google-Smtp-Source: APXvYqwPbwlTRcQT5EVWrmEwVXvvVsrq6wFGoUUIw+FtFOsiYY3ufHtkSqbNTlFft4tUkSTU5KgMqQ==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr12351460wrs.125.1568639934144;
        Mon, 16 Sep 2019 06:18:54 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f3sm12642603wmh.9.2019.09.16.06.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 06:18:53 -0700 (PDT)
Date:   Mon, 16 Sep 2019 15:18:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/hyperv changes for v5.4
Message-ID: <20190916131851.GA27870@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-hyperv-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-hyperv-for-linus

   # HEAD: 83527ef7abf7c02c33a90b00f0954db35415adbd drivers: hv: vmbus: Replace page definition with Hyper-V specific one

Misc updates related to page size abstractions within the HyperV code, in 
preparation for future features.

 Thanks,

	Ingo

------------------>
Maya Nakamura (3):
      x86/hyperv: Create and use Hyper-V page definitions
      x86/hyperv: Add functions to allocate/deallocate page for Hyper-V
      drivers: hv: vmbus: Replace page definition with Hyper-V specific one


 arch/x86/hyperv/hv_init.c          | 14 ++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h | 12 +++++++++++-
 arch/x86/include/asm/mshyperv.h    |  5 ++++-
 drivers/hv/hyperv_vmbus.h          |  8 ++++----
 4 files changed, 33 insertions(+), 6 deletions(-)

