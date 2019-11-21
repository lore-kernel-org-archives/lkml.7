Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A04C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A58206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVMsuoTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfKUXl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:41:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42403 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfKUXl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:41:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so6493979wrf.9;
        Thu, 21 Nov 2019 15:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pxac2gjvB3glHAzQ3VWzQMcHTiYDtnpxlq6kTZbB4+g=;
        b=bVMsuoTYT3l3u4dKC1kQUfMuGPSu9V59pYf0Z6THKJutOO+T4ARAj45rzh23i/LFPo
         CGzxJSNogHO1iN+GENwSGrX8FBMh1HlbB+qWeu+uxAPUr9XrPFaOmUYi9azpuxLk4OQA
         RWBWkC2/DpbviaYHU/x44e/KVjJ2ZDVpZu6rGxKAjNMg417HXBOIQYRr4O+rRzb6shxm
         BR+6QeQHjlAkdP4l+nbq0nV7C3Mx59wZkoke59ua4S3+/+pa3XdF++d1rHnTzISUjXTJ
         Dubcbczs4mr83Q6JZ+zhczytUDlbRZNQelv4s1Aw/GSKbQUh2WJcDZXqY/+qUN2XlSUI
         Navw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pxac2gjvB3glHAzQ3VWzQMcHTiYDtnpxlq6kTZbB4+g=;
        b=YE/Yc3OVOKF6aml/zHZlQ54YLI1HUXwK/ctjrRsmRpeQrw6KbhWmn+AFCrrZBju6wu
         5h3fLiVRa5p1PAcQfQsGGYy+sljXTO6gOvCShm9vpLLKsX2amUPTY6uzgUMravdCPhvB
         o3O/ILnriLpJrdkn24dznUVYRBPhB+gACR6JCtaRQ/EokjDLxGSDa/qqD6L0z03n1nnu
         xHPHhIuIwoTMt8MLmCxegg6a1FaRc1fZW30UOExiRfNzt0fbdFG8L6FpuhfeSFnmImuM
         6Kjpy8NSEQ3YkGUSw3ZlBDmjFQxTOv7gKl0bDEp6mX5JTxvmW3UU0OrGcMdAoX4cKKmL
         p1fw==
X-Gm-Message-State: APjAAAVBLMmhFjWc7HujmkKlkgTrYRPTOamLhvwX8vAOybNxHgNHbXI3
        adkDGBGk0mVg+qPQ5kB5/mk=
X-Google-Smtp-Source: APXvYqwmcH4X8ObVPyILzqCvBJI6hE2KtSvN2G51p6D7c8GRteZ1IRdTt2gKhdNGNds9qQ2ZF2fckQ==
X-Received: by 2002:adf:ed48:: with SMTP id u8mr13719315wro.28.1574379712150;
        Thu, 21 Nov 2019 15:41:52 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:5015:4c4c:42e9:e517])
        by smtp.gmail.com with ESMTPSA id l10sm5894420wrg.90.2019.11.21.15.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 15:41:51 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net, will@kernel.org, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 0/7] docs: Update ko_KR translations
Date:   Fri, 22 Nov 2019 00:41:18 +0100
Message-Id: <20191121234125.28032-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains updates of Korean translation documents and a fix
of original document.

First 4 patches update the Korean translation of memory-barriers.txt.
Fifth patch fixes a broken section reference in the original
memory-barriers.txt.

Sixth and seventh patches update the Korean translation of howto.rst.

*** BLURB HERE ***

SeongJae Park (7):
  docs/memory-barriers.txt/kokr: Rewrite "KERNEL I/O BARRIER EFFECTS"
    section
  Documentation/kokr: Kill all references to mmiowb()
  docs/memory-barriers.txt/kokr: Fix style, spacing and grammar in I/O
    section
  docs/memory-barriers.txt/kokr: Update I/O section to be clearer about
    CPU vs thread
  docs/memory-barriers.txt: Remove remaining references to mmiowb()
  Documentation/translation: Use Korean for Korean translation title
  Documentation/process/howto/kokr: Update for 4.x -> 5.x versioning

 Documentation/memory-barriers.txt             |  11 +-
 Documentation/translations/ko_KR/howto.rst    |  56 +++--
 Documentation/translations/ko_KR/index.rst    |   4 +-
 .../translations/ko_KR/memory-barriers.txt    | 227 +++++++-----------
 4 files changed, 119 insertions(+), 179 deletions(-)

-- 
2.17.2

