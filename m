Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C50C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1325218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4CdTHFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404052AbfISP7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:59:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46581 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389202AbfISP7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:59:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so3621989wrv.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=t4l++S4hF6P8PdO79QhgLXPON7MjSt7ouoLCNwiJpJg=;
        b=F4CdTHFjZxUt8+INXMeeRWoumVtisViAzOwRflTU9kvMiHyDabFnDQ3g228R7HGKC9
         SkD5VMzaqvFxhaIuz4dtDIV0Ela2QvMnt4UXuify3H8c6BLiiBTlZSPqYceZxaiMijZp
         Sr35/oirvAFsUAYvglvvZ8a6r16RFKSn2OCREVJMYvGzpmdd/nbD/ZWx7xNEHeVJHvLQ
         gmGHmcM9ybbyMnpETsdTAthw9Auy8q3biUes0SMc2o44CayItCYfM5PBaU722k4tPaog
         b+bmqL/lNicO/Ox1NiUDOCgRO0FC9UCgl1yfgf1FHMZ456wz4/C6NwV7HUVQWWQaVS93
         ARzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=t4l++S4hF6P8PdO79QhgLXPON7MjSt7ouoLCNwiJpJg=;
        b=TlI9RKXhfRJPRrrSjZeV2vKMmRf3hWQO+iBaXXv7AvLVGlIx6GfzVR0POHKQcohDvC
         bsiNPMtNXxepRrReiKQWHyZtSK7FZGNdYD4fkNRXWslG7WafLVfrRa2idLSox4P52k5m
         gIzqu57WjHd9sBXMnrSj+z5KWNp0K/Yom0huuY60yuxSgNquT4eIL0VjyPR3MJN4TYwU
         2wLTizamBhIbMd5kaxTer191Amas/sB6SLP5Bgis58DiCFBnnJZ7OuX3Qk7IbpuEY/MI
         TW9HgExB/pZSHZ2XmewC4SMSRy5xdoPiZJCCaTkKp2YR40Q+0mAPxJbgYrOeHrmLOMdq
         /aFQ==
X-Gm-Message-State: APjAAAWp22zD4Tqsnme3Uh1Hw63pnXk57xs8jCOphwXF+g8xZMz9TNDM
        h6VEJ41xe+5svwypJKAtbwI6CQ==
X-Google-Smtp-Source: APXvYqwonJMSwv8yPpEA9KIPb82xmRvY7XME/rlZ9wteq/qlF+4+Z+p5n1GVjXevybM6SxJSYJz6ug==
X-Received: by 2002:adf:f812:: with SMTP id s18mr3373407wrp.32.1568908788727;
        Thu, 19 Sep 2019 08:59:48 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v11sm15117085wrv.54.2019.09.19.08.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 08:59:48 -0700 (PDT)
Date:   Thu, 19 Sep 2019 16:59:46 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Nadav Amit <namit@vmware.com>
Subject: [GIT PULL] kgdb changes v5.4-rc1
Message-ID: <20190919155946.htzamn3s3ovw7ujh@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.4-rc1

for you to fetch changes up to d8a050f5a3e8242242df6430d5980c142350e461:

  kgdb: fix comment regarding static function (2019-09-03 11:19:41 +0100)

----------------------------------------------------------------
kgdb patches for 5.4-rc1

It has been a quiet dev cycle for kgdb. There has been some good stuff
for kdb on the mailing list but unfortunately the patches caused a
couple of problems with the kdb pager so I had to drop those and they
will have to wait for next time!

That just leaves us with just a couple of very tiny clean ups for now:

 * Fix a broken comment
 * Use str_has_prefix() for the grep "pipe" in kdb

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Chuhong Yuan (1):
      kdb: Replace strncmp with str_has_prefix

Nadav Amit (1):
      kgdb: fix comment regarding static function

 kernel/debug/debug_core.c   | 5 +----
 kernel/debug/kdb/kdb_main.c | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)
