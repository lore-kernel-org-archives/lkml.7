Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5C3ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABB6214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MVySzTdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfJKNgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:36:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40975 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbfJKNgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:36:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id r2so7050234lfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W3mkaQtz/EVWMeltP+joTbw4vbppxsJsoSSQJ3ZRvuQ=;
        b=MVySzTdSAwO2C1fF9Cur6SWzvOrt4vAf12/lvx2Ruxg2g9PD6c2Fxr0zcffaoT7rke
         M9kXMLtFPjC2kKIOnqDTcT2OjV9ubrMwOKQ7FBpUmImtduxxPW9qDJCR+FOqrrE9B1Kp
         /hU9191gbbLAyLxtBFPbWjsLJ6EDTGvSojtpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W3mkaQtz/EVWMeltP+joTbw4vbppxsJsoSSQJ3ZRvuQ=;
        b=JyHau3WQ467z7ximHsNgNk0Ad2yNc/Bdau2pKBni2zZzP8l1vf34JSvGztmzkDay2C
         Gcg5kQAZSfrfcnbC/7rEzUkyUQZyFtIbHS4HsZl6W0GOOFx9xeTr42xcFCIkBo2Fsv3I
         Kq/NhhgDxaczSFxfWtWBRjZtLkJJsxiQlgNRW5w/g0JmEODENsfvyTQyD/tocMIt4J4U
         xPdHW9hiMPv0bPGpKCp27sSFfbAWyn+PQJceT5/M4JRHZk3Vt7w9/+q0qBth1uCcaTEQ
         AsgKURk9amJsWWgpj2Rzzs0q7kK6CYoaoeIxIi9r47JM0KxqZGl/MWbeUFadC1c0rmnY
         j8aQ==
X-Gm-Message-State: APjAAAWtwuq0NHZwo8S41Qs3roW3urdcs2D+vyJERfW+t9h4kJiSUqTw
        kVNZVqSk1l/sbM9RI2KXI4Xiam23Qgbw4w==
X-Google-Smtp-Source: APXvYqxNVQrS7htu/G0aK87vPbdBBZ83DQ/pPtgm1XzWzBJmNcJmFOHamgR8tm/CBKAsMnjgqQ6smg==
X-Received: by 2002:a19:4f0e:: with SMTP id d14mr8687182lfb.177.1570800981788;
        Fri, 11 Oct 2019 06:36:21 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id g10sm2010311lfb.76.2019.10.11.06.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 06:36:21 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 0/1] printf: add support for printing symbolic error names
Date:   Fri, 11 Oct 2019 15:36:16 +0200
Message-Id: <20191011133617.9963-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917065959.5560-1-linux@rasmusvillemoes.dk>
References: <20190917065959.5560-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bit much for under the ---, so a separate cover letter for
this single patch.

v4: Dropped Uwe's ack since it's changed quite a bit. Change
errcode->errname as suggested by Petr. Make it 'default y if PRINTK'
so it's available in the common case, while those who have gone to
great lengths to shave their kernel to the bare minimum are not
affected.

Also require the caller to use %pe instead of printing all ERR_PTRs
symbolically. I can see some value in having the call site explicitly
indicate that they're printing an ERR_PTR (i.e., having the %pe), but
I also still believe it would make sense to print ordinary %p,
ERR_PTR() symbolically instead of as a random hash value that's not
stable across reboots. But in the interest of getting this in, I'll
leave that for now. It's easy enough to do later by just changing the
"case 'e'" to do a break (with an updated comment), then do an
IS_ERR() check after the switch.

Something I've glossed over in previous versions, and nobody has
commented on, is that I produced "ENOSPC" while the 'fallback' would
print "-28" (i.e., there's no minus in the symbolic case). I don't
care much either way, but here I've tried to show how I'd do it if we
want the minus also in the symbolic case. At first, I tried just using
the standard idiom

  if (buf < end)
    *buf = '-';
  buf++;

followed by string(sym, ...). However, that doesn't work very well if
one wants to honour field width - for that to work, the whole string
including - must come from the errname() lookup and be handled by
string(). The simplest seemed to be to just unconditionally prefix all
strings with "-" when building the tables, and then change errname()
back to supporting both positive and negative error numbers.

As I said, I don't care much either way, so if somebody thinks this is
too complicated and would prefer just printing "ENOSPC" (because
really the minus doesn't offer much except that it's perhaps easier to
recognize for a kernel developer) just speak up.

I've also given some thought to Petr's suggestion of how to improve
the handling of ERR_PTRs that are accidentally passed to
%p<something-that-would-dereference-it>. But I'll do that as a
separate series on top - for now I think this should go into -next if
nobody complains loudly.

Rasmus Villemoes (1):
  printf: add support for printing symbolic error names

 Documentation/core-api/printk-formats.rst |  12 ++
 include/linux/errname.h                   |  16 ++
 lib/Kconfig.debug                         |   9 +
 lib/Makefile                              |   1 +
 lib/errname.c                             | 222 ++++++++++++++++++++++
 lib/test_printf.c                         |  24 +++
 lib/vsprintf.c                            |  27 +++
 7 files changed, 311 insertions(+)
 create mode 100644 include/linux/errname.h
 create mode 100644 lib/errname.c

-- 
2.20.1

