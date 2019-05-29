Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28364C28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4F222CEB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfE2N5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:57:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32860 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfE2N5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:57:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id y17so2182322lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 06:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbTz9QfJWMgyv4fipzRBw0f6ydNdnq7zYT3VxBkO7bw=;
        b=it/+scwZRNqk3BIUV2qDMTpdIRPz1/xnNmQPf8Lx/5XAHT+ma5DD8LJlS7niJdC6zM
         bei2D8bZh0lknFB29jIEwnoSZFL3UCV9RJQXIXGFjSZ8mX6MJLh7qjFkqgUhWjWh4aGw
         plgUAbH+Nyk+/TZMtOsnl8oCl1hYlzfA/O4rMWIwckrSPDsawOvPcEO5Lu1qbXkVwPdw
         JfcRePInhC8Xee6CpLNgiIKljSiihSTOF3SHo/2RYxN3z0K4mcIHe5tYLZH49ZGLFMwp
         +MdOlorJhwLjYMtX7/6jRvclCdfSxi5l5aGa23W57anUVI8U9D03jZGGJGSFRifgwxnt
         zQ/g==
X-Gm-Message-State: APjAAAUjHsP0EYg9osM60qOVzKrW3Habpz8Y7oWPJrEIl9P8v6mB80jk
        G6NI7cpVjpTiRDRTwjVZZo6H0YOKs0ebeBiSqwCgtA==
X-Google-Smtp-Source: APXvYqwxIUsHkLRgSJSLy8LjELq/d72ul/11f5DuEiFmWUrLMbiojVDYC1h6xg985fY5/zaanPScjCxocfbQUwPS8yM=
X-Received: by 2002:ac2:429a:: with SMTP id m26mr3191323lfh.152.1559138229226;
 Wed, 29 May 2019 06:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190528235844.19360-1-mcroce@redhat.com>
In-Reply-To: <20190528235844.19360-1-mcroce@redhat.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 29 May 2019 15:56:33 +0200
Message-ID: <CAGnkfhxP0+WAaj4Kip+vuCphp7WnHUGJJMaEtj2xjUrnY253Zg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: avoid indirect calls in L4 checksum calculation
To:     netdev <netdev@vger.kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 1:58 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> Commit 283c16a2dfd3 ("indirect call wrappers: helpers to speed-up
> indirect calls of builtin") introduces some macros to avoid doing
> indirect calls.
>
> Use these helpers to remove two indirect calls in the L4 checksum
> calculation for devices which don't have hardware support for it.
>
> As a test I generate packets with pktgen out to a dummy interface
> with HW checksumming disabled, to have the checksum calculated in
> every sent packet.
> The packet rate measured with an i7-6700K CPU and a single pktgen
> thread raised from 6143 to 6608 Kpps, an increase by 7.5%
>
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

I found a build error with CONFIG_LIBCRC32C=m:

ld: net/core/skbuff.o: in function `sctp_csum_update':
skbuff.c:(.text+0x2640): undefined reference to `crc32c'
ld: net/core/skbuff.o: in function `__skb_checksum':
(.text+0x2aba): undefined reference to `crc32c'
ld: (.text+0x2cf9): undefined reference to `crc32c'

I have two possible solutions for this:
- use INDIRECT_CALL_1 and leave the SCTP callback called by an indirect pointer
- use IS_BUILTIN(CONFIG_LIBCRC32C) around the sctp_csum_combine usage

I'm more toward the first one, which will also avoid the
net/sctp/checksum.h inclusion.

-- 
Matteo Croce
per aspera ad upstream
