Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C80C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5EE2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ND70qTrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfKKI6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:58:25 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:38503 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKI6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:58:25 -0500
Received: by mail-qt1-f178.google.com with SMTP id p20so14899277qtq.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 00:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=O2TkzP7dnTydhiSG2HDTMvBwwAeeTQFK8/4YvS8vxU4=;
        b=ND70qTrZs90snFYmzHRxLqUPDdK5fBwLwQ1q5N9jQPzOqhtNBobdIlAA8oKNvZvNTT
         YSuZSM7FdYQmeZZ4RwnWoGMS+FCPtUxXhhrpCjrxWVhghHBeqFYy4EsFgUbeJX9Ks2bw
         oG1TZvF0BT/VHVOcQLH73JI6b01CRwxr+3i2CeJh26+yEZZzIiHbGQXtD2IshhF8D1Co
         oMnje9NLLxEd4LQeMiBuAKYFfPCH7UiKtRlTDtnVaXLbJj7Oe5PBAgtx/qr1NjzfqD9i
         NvfM47fV0+t903wIgBNFftg6Uz46QpFD8pydmX3d/bhgO1bddfOFT80qb0CA3ql8oxe7
         S/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=O2TkzP7dnTydhiSG2HDTMvBwwAeeTQFK8/4YvS8vxU4=;
        b=FilxA5Wnglq/imBe+bjGGtkzIw86IkgN2bl1npNOHGE79Uo2nbtoEOAIS5DmCTZoI7
         65kmq5hS5pSsW/Q3cjL02BaIf3pSIiLaSkxuUOFnhlm7brqw34+xjXOjxpVSQPvFT1k7
         9xLq4Znr5Fazfcr3xt/vfZ5FvYAsTnxXw+tU+rpYV5VCNEIcBAaf2R01+Rj0fi1gsNQk
         In29JrWQxqjzG2VY3LHuPleZcAbxR9gs//orlHJG9xaDpU9p/HuYoeMFbarp86YkPhOS
         WFicMdAd1OYj0mWu/y++w797V+7g56XqqpT02JAHyNnLIjBbidlgib8+VmpIOhWrvwgC
         uD0A==
X-Gm-Message-State: APjAAAXRiwlitm9dwyzEW9WHGzDoRbecC3wF/qBuS4jdWyJ9NqqM+H7J
        rhUKcMbPZ5UwzaYlgR5Ikfv/WX7Zw5rzwai7At234JOO
X-Google-Smtp-Source: APXvYqxeEdEAHkyNxVwh5oM7oLIyZ2EWniy34LgM2HwwypXHRwpuXPIZJ2pJCi/9ion3hterx/b35tCgBXDgw5WH1c0=
X-Received: by 2002:aed:3924:: with SMTP id l33mr24987844qte.6.1573462703978;
 Mon, 11 Nov 2019 00:58:23 -0800 (PST)
MIME-Version: 1.0
From:   Adeel Sharif <madeel.sharif@googlemail.com>
Date:   Mon, 11 Nov 2019 09:58:13 +0100
Message-ID: <CABT=TjHHXBYo3jN3r5YRZhkZFzjhkqF-SXcvVYVtYYjE639n9A@mail.gmail.com>
Subject: Unix domain sockets missing error codes
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We are a group of people working on making Linux safe for everyone. In
hope of doing that I started testing the system caalls. The one I am
currently working on is send/write.

If send() is used to send datagrams on unix socket and the receiver
has stopped receiving, but still connected, there is a high
possibility that Linux kernel could eat up the whole system memory.
Although there is a system wide limit on write memory from wmem_max
parameter but this is sometimes also increased to system memory size
in order to avoid packet drops.

After having a look in the kernel implementation of
unix_dgram_sendmsg() it is obvious that user buffers are copied into
kernel socket buffers and they are queued to a linked list. This list
is growing without any limits. Although there is a qlen parameter but
it is never used to impose a limit on it. Could we perhaps impose a
limit on it and return an error with errcode EQUEUE_FULL or something
instead?

I don't know who is the maintainer of unix sockets. If someone knows
please let me know and I will discuss with him further.

Thank You.
