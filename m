Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F272C2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F314120409
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="jjvcrGPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfLDTgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:36:21 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40935 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbfLDTgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:36:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id y5so489641lfy.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 11:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=8YzffI6BTbDDQcKipmBH3epvQxf1I8mA0zvypaeoYk0=;
        b=jjvcrGPCuHTHOGJJrH8U0Iyx3nsiiJlWtNPChRrPmX8N5u9p2MMFCXAOFPLEY8M4gs
         RPtpg7yVp62/m5iFVQ01HaJPE6lPmyWLHI0C+LYBjNe1+MmgJseGa85LoFRhZXBGVwv1
         IdyOohDBo/audQdOUMqjm7q3eJld7sprvONff0oMmdTq/d/cTSI761ZhBXPKrqrdmCXJ
         eyGbAgMD7fpi/wUB2Dgu5U2MjpFfuN5SXsEkFHuxRD1mx1MOAYSxBjIjM7g82faeE/+A
         iwwhT+PtByDqNf6hghXKTDPZxrEl30mrp8gkdTyKOyTqQ6RMveZrGCGRpBoWeKbp2TPQ
         dAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=8YzffI6BTbDDQcKipmBH3epvQxf1I8mA0zvypaeoYk0=;
        b=ZvS7SEBtCCZIZWOIrkRpzdxWyznsR6UjXKmExOh6ZPJltQtpc9rt1adqBvX0HFdPm5
         ezrrwX54lgz2yBWPm01WhbCHeAcc73ONrA1lu0gQgPQL/CXf7exrKc1weBNRoxZLWRX0
         ncRgnFO5yB88pk0rd/FEXQ2JJSKmn6Ym2QKwKHkpqduaUqHIn7V0K7Nlc2kayYk9swSS
         bPLn+KgPDWejIDerEv7xl9wjHQJUf93IJek0klm+Px2wBsEJcP9WxWTZ/aGoAAbe+EOW
         5QCs6fuDVnLUIjbipwUNlRIfV8rJr2J1eefqdPb626X/PCtHXaRSCuhyIrNdnBUq4Xr6
         Fehw==
X-Gm-Message-State: APjAAAV7xPjuJRX9Cp+29HRDMV2JJivO5dGDObrqoIDx2mqiss9UvuFy
        J9/bF+3yS8Xo9A6EoIGqq0pQBw==
X-Google-Smtp-Source: APXvYqzyT+LlrXJABBe8zZizq0/fO5fzzGnRLyqd7XLv6psgjGcvazOPITeCmnZQiQ/QgOw7b3YOLQ==
X-Received: by 2002:ac2:5473:: with SMTP id e19mr3155384lfn.108.1575488178400;
        Wed, 04 Dec 2019 11:36:18 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 140sm1872100lfk.78.2019.12.04.11.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:36:17 -0800 (PST)
Date:   Wed, 4 Dec 2019 11:35:44 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/tls: Fix return values for setsockopt
Message-ID: <20191204113544.2d537bf7@cakuba.netronome.com>
In-Reply-To: <CA+FuTSdcDW1oJU=BK-rifxm1n4kh0tkj0qQQfOGSoUOkkBKrFg@mail.gmail.com>
References: <20191203224458.24338-1-vvidic@valentin-vidic.from.hr>
        <20191203145535.5a416ef3@cakuba.netronome.com>
        <CA+FuTSdcDW1oJU=BK-rifxm1n4kh0tkj0qQQfOGSoUOkkBKrFg@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(there is a v2, in case you missed)

On Wed, 4 Dec 2019 14:22:55 -0500, Willem de Bruijn wrote:
> On Tue, Dec 3, 2019 at 6:08 PM Jakub Kicinski wrote:
> > On Tue,  3 Dec 2019 23:44:58 +0100, Valentin Vidic wrote:  
> > > ENOTSUPP is not available in userspace:
> > >
> > >   setsockopt failed, 524, Unknown error 524
> > >
> > > Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>  
> >
> > I'm not 100% clear on whether we can change the return codes after they
> > had been exposed to user space for numerous releases..  
> 
> This has also come up in the context of SO_ZEROCOPY in the past. In my
> opinion the answer is no. A quick grep | wc -l in net/ shows 99
> matches for this error code. Only a fraction of those probably make it
> to userspace, but definitely more than this single case.
> 
> If anything, it may be time to define it in uapi?

No opinion but FWIW I'm toying with some CI for netdev, I've added a
check for use of ENOTSUPP, apparently checkpatch already sniffs out
uses of ENOSYS, so seems appropriate to add this one.

> > But if we can - please fix the tools/testing/selftests/net/tls.c test
> > as well, because it expects ENOTSUPP.  
> 
> Even if changing the error code, EOPNOTSUPP is arguably a better
> replacement. The request itself is valid. Also considering forward
> compatibility.

For the case TLS version case?
