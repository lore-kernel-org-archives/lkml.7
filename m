Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3F4C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 20:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C9121655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 20:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gpBmxAFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgABUzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 15:55:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39817 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABUzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 15:55:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id 77so58548404oty.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 12:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=FC+3ECJPVf1PQMuQzI/vPybo2wIB8iKB3SbvaslcqQw=;
        b=gpBmxAFhnbb6+BqKlrGXr9yYGgZlvyk7ed2gwQlcp+iwPOHBIR71HN/4w9cMSltK9H
         Hn7xvuly2kCKh7jku2eHhL+YosE6gZ6OT9hKNVTX8+7KDxmxnBJqCHiJKaymvGMibR3R
         9s1DBvsZ6n7tua6j1E3znL6pXbhzZ8CDrsJHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FC+3ECJPVf1PQMuQzI/vPybo2wIB8iKB3SbvaslcqQw=;
        b=mZ/dhBeOgKRDA7xsBMBDEt1RBX9XzdBaNirAHjwitDsCzsPJ7q8nHyELC0WVOmI5cW
         l8RV0AyoPY4BjMEx3zJgcMhOtJbCIRHphrSgBhRdmo8zyfsZZGa6IOjR69b67zG/7ZER
         Wyg+Y0Y+qM8Q6I6OKEZYsyJ+ZBdPoAimTB9/pGgeiuBNrVLW/2kThT4ssyakVMwf6Anu
         ufDBkGJO/ikhT//DjAzBTKW3BIDqRLZL0CNGCIM7E+tX24nD9ULU7xRpixEApG4R4lVC
         rzuacUijN+IREdxeFNkCLQOM2av4QLRgvV8QmedvI+Cvf643aW0kgJs0CzRbhQdUpWJN
         WKXg==
X-Gm-Message-State: APjAAAVFqVhNyCwAXN8E280CqkXQC7v4WhgCCh76irU+bsrsWrupB4Of
        ZJZBqz/BqztEd2oRf7IDwmQGH64Bv8I=
X-Google-Smtp-Source: APXvYqyRH+ydEoKu5X6agonlYM5uqH/0mjPZ/ps0OIJYwq3j+z9O7+Rax5LipSq9Vr1n3WYFaathOQ==
X-Received: by 2002:a9d:68cb:: with SMTP id i11mr89413290oto.210.1577998510871;
        Thu, 02 Jan 2020 12:55:10 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n16sm19725224otk.25.2020.01.02.12.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 12:55:09 -0800 (PST)
Date:   Thu, 2 Jan 2020 12:55:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Aleksandr Yashkin <a.yashkin@inango-systems.com>,
        Ariel Gilman <a.gilman@inango-systems.com>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Nikolay Merinov <n.merinov@inango-systems.com>
Subject: [GIT PULL] pstore fixes for v5.5-rc5
Message-ID: <202001021254.2F43E8A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these two pstore fixes for v5.5-rc5.

Thanks!

-Kees

The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.5-rc5

for you to fetch changes up to 9e5f1c19800b808a37fb9815a26d382132c26c3d:

  pstore/ram: Write new dumps to start of recycled zones (2020-01-02 12:30:50 -0800)

----------------------------------------------------------------
pstore bug fixes

- always reset circular buffer state when writing new dump (Aleksandr Yashkin)
- fix rare error-path memory leak (Kees Cook)

----------------------------------------------------------------
Aleksandr Yashkin (1):
      pstore/ram: Write new dumps to start of recycled zones

Kees Cook (1):
      pstore/ram: Fix error-path memory leak in persistent_ram_new() callers

 fs/pstore/ram.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
Kees Cook
