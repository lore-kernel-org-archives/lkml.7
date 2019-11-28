Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C911C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BE2216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDGFiIy+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfK1J01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:26:27 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38863 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfK1J01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:26:27 -0500
Received: by mail-qv1-f65.google.com with SMTP id t5so3226310qvs.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 01:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=EYL7j0Mm27S+63h8xLbGirLx+NHU86XCrWOZ+2K/4Xc=;
        b=HDGFiIy+G8cYwJisuhiM+Qq03ACUM3YqFOv6jjN5fNsgKahlF0A8QBmoNtpA1+XUvT
         5UCV3GKbXwe8zJZiVACjCAmZ8VqiIMvcoUHwSPAmhf7N0l8VJA/d2sdQfTXp7/BRZf4k
         G6qdIcD/jcXzJL/K6eTi+0Up+UYUl9HlBinet8BMbbv9fO06RvFbwsk8HzlEdeOgeaec
         6HNAiPYCQnXCTnqQNwR0RYIOghH2B+2ouoclFDuQVYQiYUtq8T5+EqfCoIH8aqW6wlm0
         GMEy7UbzCw3J4DDaiIipeinsPh50vDbCf1EZNl44FVSklSDeCqso6yvKNtfbU7voaRnL
         ys5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EYL7j0Mm27S+63h8xLbGirLx+NHU86XCrWOZ+2K/4Xc=;
        b=UmeLFjjYT5Qo99opKEedEahzGyNrvjO/gDUNhcBmjeiPf2BveCRcQgQ3AzMOPgBwIt
         vIBtllLKZR9yX2TjF9c1ZY59Z2ZKT9cSDAJl7ZyyBNOVu8viGcjpvAivrX833RK9POjs
         +hURw+T9Y+PlyfV3v4YIQSCZRatvpmXeFRrfsA2I0MO8H1hZmfTHyNVcSyHr1agTiTm/
         gDBqAP/xz0pUCLPeId5hfyvzU7vdO0Xme71uhhLcbiaRZ7oeJeLMJXMoCDa7owHx0zX/
         3lfQ5Qnq9bE2/0exP7YxpBgJ3eKTxIf66s0zyHom70a0+AqY/+NOzhG6WEPh2FBLzXCK
         2rng==
X-Gm-Message-State: APjAAAVaLnDZnj56DxW1QMzvqi5gDSk/cEKOKm+/J/oPxPMtIdErm/g+
        Qgu0wNyDbtbZoRUHl+cs3GtHE0lWgvVhwcuy7HuEj/NQJaM=
X-Google-Smtp-Source: APXvYqwCjIiayotA1rzK34jxTsaSQw2ajaLc2OQwPJQALzbNQ0h1taq32b/qrfsKsQUHc1X1eA9SESnWkSzgBNjUpWY=
X-Received: by 2002:a0c:d64e:: with SMTP id e14mr6925505qvj.35.1574933186344;
 Thu, 28 Nov 2019 01:26:26 -0800 (PST)
MIME-Version: 1.0
From:   Greentime Hu <green.hu@gmail.com>
Date:   Thu, 28 Nov 2019 17:25:49 +0800
Message-ID: <CAEbi=3ccGpiujBnHb6hJhXwqR-q_XW8eW6=qgEQbQcPDffjqCA@mail.gmail.com>
Subject: [GIT PULL] nds32 patches for 5.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Nickhu <nickhu@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit af42d3466bdc8f39806b26f593604fdc54140bcb:

  Linux 5.4-rc8 (2019-11-17 14:47:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git
tags/nds32-for-linus-5.5-rc1

for you to fetch changes up to a7f96fce201c4969178c8709a49e005d9792186b:

  MAINTAINERS: add nds32 maintainer (2019-11-21 17:46:33 +0800)

----------------------------------------------------------------
nds32 patches for 5.5-rc1

Here is the nds32 patchset based on 5.4-rc8
Contained in here are
1. code clean up
2. add a nds32 maintainer

----------------------------------------------------------------
Greentime Hu (1):
      MAINTAINERS: add nds32 maintainer

Krzysztof Wilczynski (1):
      nds32: Move static keyword to the front of declaration

Masahiro Yamada (1):
      nds32: remove unneeded clean-files for DTB

Masanari Iida (1):
      nds32: Fix typo in Kconfig.cpu

 MAINTAINERS                        | 1 +
 arch/nds32/Kconfig.cpu             | 8 ++++----
 arch/nds32/boot/dts/Makefile       | 2 --
 arch/nds32/kernel/perf_event_cpu.c | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)
