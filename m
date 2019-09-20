Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D015C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBBC207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRC/bCyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbfITOTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:19:11 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:39367 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387778AbfITOTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:19:10 -0400
Received: by mail-ot1-f41.google.com with SMTP id s22so6320318otr.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=g3oaDqbgzggwPivHDVLZWW42Zmh9QYBbWFwvRIUuPVY=;
        b=dRC/bCyN0tevx36b1thR/vkPXJ4Ot0YA4qvripWUgW5TuKlI7aoY0IbhkQvjZr8DcL
         qgpJkd7OZFT9bmcWWbZL1S8yzjaMYm/FaowP0BATF7I8iIXeJkuyEhl0x223NcS+5cGv
         /U1EuIBrp8mzyOMlk2tPCUuu01GgcQzPD8jrQHINqsh9ZRhJ4Kf9iptFu0Zb07usQB+c
         4qE9VaVP9ZpgTS/H1JXkvW4R7KvxhHYlo/ovkRF4nS+KobHA+D73tZKXMBYs5Ye6ZFGy
         9UIO0kQMZ92qBGjSB+WLcroyeTvOyTIueOVJxpD1MFVDXTugmW1gZjKIK4ZD3hCyfIfM
         MtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=g3oaDqbgzggwPivHDVLZWW42Zmh9QYBbWFwvRIUuPVY=;
        b=S5pNJwlN/Fxkmtr6FTOruhYz4mQ1v1pLmtHL3gewoCZFqOmcistVM2Mq48AGDnCdXW
         nBhKRVO1wgGIiCsDOBfXbSHkqDTedDnvk1BJynLnRIzeRxeBpDGVzHylEUixv04a2d9i
         CKo6sqD+WjyPEc99kpVczuE8kJf05pGpNFGZh+R7SVXuklkCiU/j8HZnlR5JcylLXwKk
         1tWgis0nyrqgrrIQhgHD7tlF5YQZBX+I2fFT+K9KefBG9f4a9WZUoqLCjmxhOwz1KUBa
         GEyRqLFaDsoxY4U9l7Rp/1yyd43f/xYTdkEgrpeoPhlx4iGO3wL80DjaAOssawFbswww
         z/Pg==
X-Gm-Message-State: APjAAAVnX1V3xi0eiN2D/EbrsYM7n6oW+eFqCTL5rb1z3YmTY5IJdQIM
        TtudQDSseLV7u974T1dnTw/guMTKBHJio2jyBToi3w==
X-Google-Smtp-Source: APXvYqwU4kLJdTb8y/29KhEiEDF/lWw7e/AxoNpPCrwPgbRGewcYh6WokNuwr+5RnqKHkpxdyNcR75BY6YKOy8BmDuw=
X-Received: by 2002:a9d:774b:: with SMTP id t11mr178617otl.2.1568989149028;
 Fri, 20 Sep 2019 07:19:09 -0700 (PDT)
MIME-Version: 1.0
From:   Marco Elver <elver@google.com>
Date:   Fri, 20 Sep 2019 16:18:57 +0200
Message-ID: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
Subject: Kernel Concurrency Sanitizer (KCSAN)
To:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>, paulmck@linux.ibm.com,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Will Deacon <willdeacon@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        stern@rowland.harvard.edu, akiyks@gmail.com, npiggin@gmail.com,
        boqun.feng@gmail.com, dlustig@nvidia.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We would like to share a new data-race detector for the Linux kernel:
Kernel Concurrency Sanitizer (KCSAN) --
https://github.com/google/ktsan/wiki/KCSAN  (Details:
https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)

To those of you who we mentioned at LPC that we're working on a
watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
renamed it to KCSAN to avoid confusion with KTSAN).
[1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf

In the coming weeks we're planning to:
* Set up a syzkaller instance.
* Share the dashboard so that you can see the races that are found.
* Attempt to send fixes for some races upstream (if you find that the
kcsan-with-fixes branch contains an important fix, please feel free to
point it out and we'll prioritize that).

There are a few open questions:
* The big one: most of the reported races are due to unmarked
accesses; prioritization or pruning of races to focus initial efforts
to fix races might be required. Comments on how best to proceed are
welcome. We're aware that these are issues that have recently received
attention in the context of the LKMM
(https://lwn.net/Articles/793253/).
* How/when to upstream KCSAN?

Feel free to test and send feedback.

Thanks,
-- Marco
