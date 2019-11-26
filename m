Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DCBC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7531F2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oBQUwAxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfKZQ3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:29:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39833 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfKZQ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:29:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id x28so9435881pfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 08:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cti69LXQYlxjH1hcVp0rOavAITI77gvcwbc4nx5LA1Q=;
        b=oBQUwAxQNj1m1n2QbNKXS0feZVmXDWCPnEuFAtUehHXUYbDtJVwp075zNt+R3SebqZ
         lzimW6Me4uZlwM/r/jwQP2m/PxMpGaZ746ddu5AHFJKOQVthy2ghNXShP519aK08Ekfx
         lsXjDp08iLVNkMQ/yIxRbBKvuH9mhhFWueyGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cti69LXQYlxjH1hcVp0rOavAITI77gvcwbc4nx5LA1Q=;
        b=Crf8M9RV/kkYBsmS9TSUB8YZhwSF1dZ5xtw59Esm1R1Xo3PxjXpJScL1mE/uoGuCCs
         Ooqu6/oKJcT2M0BtgArw9BPRUfQDbrMdjWUnXk4ekdMNhkROSScHgyMlX5P2krwmmT3M
         81WPHY1S95zVDz6fDCG/V/HFqsP2Dvx33bWQGPW8whB/+3CqKxqimwLZHZeW2NFS6GOf
         Mv/7F5lUktMNjygycknKlJfUB0yaMD+6GVjRK5lv6x7/INoRthkeTm9HSj03U4/3ooOM
         ZYGwwof2mO4QXUUNb2zaJpdpYvBDuljSb/432X5Blg//qFwtHAbHMDO0fzfBMx/s4vIH
         jXHA==
X-Gm-Message-State: APjAAAVs/WJOPaxbntvCkndqHRM9ELBz0+hxbN8S5+7W9q/V5oMcz26G
        aaHLuxFXe/itTJFf85AJUQH9ql/bi5U=
X-Google-Smtp-Source: APXvYqxf7Qp3ZlZE0AMl7r0nTr2LwFOoDLk8ldo1+vuLrh9BeK/YOG5+aMEPFaVd3UUWMQH5/0/lIQ==
X-Received: by 2002:a62:ee0c:: with SMTP id e12mr43428174pfi.38.1574785744608;
        Tue, 26 Nov 2019 08:29:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3sm13190478pgl.15.2019.11.26.08.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 08:29:03 -0800 (PST)
Date:   Tue, 26 Nov 2019 08:29:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [GIT PULL] pstore update for v5.5-rc1
Message-ID: <201911260828.9090F0A258@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this tiny pstore update for v5.5-rc1. It contains a single
fix for a missing "static". :)

Thanks!

-Kees

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.5-rc1

for you to fetch changes up to 8d82cee2f8aa8b9bc806907ecd9e1494c6e8526b:

  pstore: Make pstore_choose_compression() static (2019-10-29 09:43:03 -0700)

----------------------------------------------------------------
pstore bug fix

- add missing "static" (Ben Dooks)

----------------------------------------------------------------
Ben Dooks (Codethink) (1):
      pstore: Make pstore_choose_compression() static

 fs/pstore/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Kees Cook
