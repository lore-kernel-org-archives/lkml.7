Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F56FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6522063F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Zem8lppq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfC3AJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:09:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44590 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730154AbfC3AJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:09:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id w5so4399420qtb.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 17:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=leIGanSXBnqJfF07apwhnkUTykJVkb/IhCS7r9eNUPs=;
        b=Zem8lppqqQWxSaHSGmqmV2HHajEJN8Y63+snvsZlPEaUdl74cT8C+UmIEwV3uZyQAT
         uxEmxzwpNayUv2VxXNoLn4WupWidxRsZeh/115awtXn1A7YhaQXIuwo8fv2J9+4Bwgtm
         wYTgE18qqYvzaaWk8bG+7Tcs81qmuptZmOL0xNdd3hQw4+VYg5Kw71DWVF/uPzGGmaNL
         9LjxB0ZNYqE8eUmuSi69uqy7dMSGrtmGT2eCtBdQJd5PsXG8iASgGMVSEzbCT8+IJt9V
         vc/YUc3B75iz3TCh+A4jxjDKLVSDJpqSUyO5qWOeYtNGTc97ZRf9Nco6j4dN0aIB3fvM
         9RSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=leIGanSXBnqJfF07apwhnkUTykJVkb/IhCS7r9eNUPs=;
        b=qzYkpMD/O3NcmVYkMItiQrXOGN36Ty5RYxBVToFwonCA87dnxOfLCElf0yZlmpOtQX
         9OINSyFghJrrS/cJye1oAzOi3MWTAnbMHPrUYf+HJcwgmN08MwqxsWuiahcU40+cbyNs
         tcqFoI/9ntTEIn2HBWvFzdzNstpWBAuWKJqtWFRojpRqQp4N53foKMFtagXKw1Q+QEo7
         r+3sZcwkq84xslbyFZKT6NZKyPVzzikurT8ii5aZevGpg8pW0zl86Jmpovqg5GofeHoX
         LQzaGns8GZiLnWRQXmMUyySRi2CpVrJKNgWALWvtlbF8mZorVF3BE/xXNHZ8K9n4hTZY
         xbHQ==
X-Gm-Message-State: APjAAAXtrpy8kpNIh/PGyzOrdbJ4M9yazKhgE04RKEUvZsWtu/o/YLCb
        Jn7BzzP5fATCas5tPJ5z1Vtt0A==
X-Google-Smtp-Source: APXvYqx4NzMJvfhCUCi40+01p3Pt7pCYi123hPJofR5qOZNX8VtyTGRoQT+10Q1lfYFeZuGY3SXprA==
X-Received: by 2002:ac8:38f5:: with SMTP id g50mr43595848qtc.119.1553904546326;
        Fri, 29 Mar 2019 17:09:06 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i63sm1996757qkd.82.2019.03.29.17.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 17:09:05 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     peterz@infradead.org, tglx@linutronix.de
Cc:     ard.biesheuvel@linaro.org, yamada.masahiro@socionext.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com,
        alexei.starovoitov@gmail.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH 0/3] locking/static_key: improve rate limited labels
Date:   Fri, 29 Mar 2019 17:08:51 -0700
Message-Id: <20190330000854.30142-1-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This will be used to fix the static branch disabling in the TLS
code.  The net/tls/ code should be using the deferred static
branch type, because unprivileged users can flip the branch
on and off quite easily with CONFIG_TLS_DEVICE=y.

Second of all we shouldn't take the jump label locks from
the RX path, when the socket is destroyed.  This can be avoided
with some slight code refactoring in deferred static_key as
it already runs from a workqueue.

This the series (and a simple tls patch which makes use of it)
applied opening 0.5M TLS connections to localhost (just calling
setsockopt, no data exchange) goes down from 37.9s to 12.4s.

Jakub Kicinski (3):
  locking/static_key: add support for deferred static branches
  locking/static_key: factor out the fast path of static_key_slow_dec()
  locking/static_key: don't take sleeping locks in
    __static_key_slow_dec_deferred()

 include/linux/jump_label_ratelimit.h | 64 ++++++++++++++++++++++++++--
 kernel/jump_label.c                  | 64 +++++++++++++++-------------
 2 files changed, 95 insertions(+), 33 deletions(-)

-- 
2.21.0

