Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210CAC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51AD2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/7UlikJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405026AbfHIDyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 23:54:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46494 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbfHIDyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 23:54:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3so7949252pgt.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 20:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to;
        bh=iuvsbUVR3JGHE/UbU0VbPCmgBNC5gqV92hG0GhCg0Zw=;
        b=A/7UlikJ1Ngdzc+LR6NvKkjsDJInRqrQv8W+m3osg3RxSKOBuV8fp6Wzwf2AeDNnVR
         3oqczfprfuIGug1gTkQDbRF+aIyyFet+luhK9LIpWqnwuzFK5pbmB+AJ05Oi1DaX4IYn
         cd8tYwPmCUvtEkkJ3ceTyZaFJXuywvZZ2ImWsfl7Uc3kRSykgZjHS2oxwwwPHgC8qT79
         QQUBSSEoCQ2DdBgVZZRjTct7uiuJ8MobJDlHUrO4NXi17NBhvHEBie3g4pQllKHopkjR
         EufZPn3jx3J5RsK6G4+hyqGF+qtBxRWw/AVV/IpMMyfcMqgfDqDenmkahPYNmJfN+27H
         wpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuvsbUVR3JGHE/UbU0VbPCmgBNC5gqV92hG0GhCg0Zw=;
        b=ZInoVydqQEcYUIQlPWYg6mVgJCQYN+z2EVmku6wjGGjBnR4g2YTTFNn/0ibeKHsVnG
         5GQETYpBz8lvaEWbc15umG6vP6a22ikIBP1ZASiwo9//VUNifIhVqEEv1jDPBK4LKeWF
         akZzgrSJkuFMdY9wYvjtN/kByqHgYfZ6ANL8J5RvbTj9uv9q3hvAcCJ2538X0znhlpxS
         8l9nIq/N6jX/0FKYZrDJ1PcvEVRsw69/zR0UXGrXBtN10NuGNojJOU/G9Itk2wfUantZ
         pUxvZiNJ2FwBRonPZOs+wxIyANEKYVIGcdfCuoxg4eRNCnXpFk0WTYjgQsQqGAg4MQcd
         MOSg==
X-Gm-Message-State: APjAAAWR/6qYN8BEyg7EyRg2ztNatv+gcU0VEjl01jvl5u7Gxmh4RPDf
        y3tVa8NfW8qNZWMC+U7/uOdcMWNz
X-Google-Smtp-Source: APXvYqyTT/pzbeWFDLzTsJvpktAXByh3AOCdU86Zmvw8vqoP+WkS5kxgL+Mqj4c6j6/Jhag9gD7fwQ==
X-Received: by 2002:a65:60cd:: with SMTP id r13mr16103908pgv.315.1565322872123;
        Thu, 08 Aug 2019 20:54:32 -0700 (PDT)
Received: from localhost (c-73-189-176-234.hsd1.ca.comcast.net. [73.189.176.234])
        by smtp.gmail.com with ESMTPSA id h1sm125718786pfg.55.2019.08.08.20.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 20:54:31 -0700 (PDT)
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     toshi.kani@hpe.com, fei1.li@intel.com,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Subject: [PATCH 0/3] x86/mtrr, pat: make PAT independent from MTRR
Date:   Thu,  8 Aug 2019 20:54:17 -0700
Message-Id: <cover.1565300606.git.isaku.yamahata@gmail.com>
X-Mailer: git-send-email 2.17.1
Reply-To: isaku.yamahata@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make PAT(Page Attribute Table) independent from
MTRR(Memory Type Range Register).
Some environments (mainly virtual ones) support only PAT, but not MTRR
because PAT replaces MTRR.
It's tricky and no gain to support both MTRR and PAT except compatibility.
So some VM technologies don't support MTRR, but only PAT.
This patch series makes PAT available on such environments without MTRR.

patch 1 and 2 are only preparation. no logic change, function rename
(mtrr_ => mtrr_pat_ which is commonly used by both MTRR and PAT) and
moving functions out from mtrr specific files to a common file.
patch 3 is an essential patch which makes PAT independent from MTRR.

Isaku Yamahata (3):
  x86/mtrr: split common funcs from mtrr.c
  x86/mtrr: split common funcs from generic.c
  x86/mtrr, pat: make PAT independent from MTRR

 arch/x86/Kconfig                      |   1 -
 arch/x86/include/asm/mtrr.h           |  37 ++-
 arch/x86/include/asm/pat.h            |   2 +
 arch/x86/kernel/cpu/common.c          |   2 +-
 arch/x86/kernel/cpu/mtrr/Makefile     |   2 +-
 arch/x86/kernel/cpu/mtrr/generic.c    | 116 +--------
 arch/x86/kernel/cpu/mtrr/mtrr.c       | 211 +----------------
 arch/x86/kernel/cpu/mtrr/mtrr.h       |   8 +-
 arch/x86/kernel/cpu/mtrr/rendezvous.c | 324 ++++++++++++++++++++++++++
 arch/x86/kernel/setup.c               |   4 +-
 arch/x86/kernel/smpboot.c             |   8 +-
 arch/x86/mm/Makefile                  |   3 +
 arch/x86/mm/pat.c                     |  99 +++++++-
 arch/x86/power/cpu.c                  |   2 +-
 14 files changed, 479 insertions(+), 340 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/mtrr/rendezvous.c

-- 
2.17.1

