Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E9CC76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3447A208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563401118;
	bh=3SS3ZLtLSu7gtrL15oiYWACVwVNMXw0g0apJkvClaJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XcqI/FTu2rW8NVSGn306KsQkZlHeNN9cWYLLSbATeQjJAT6rwr9x9iaFgc0hyn7yx
	 r1/6mD8gTUNpi6jdNygeBjZMvizA1/SDJB3AgjOw2EfROxJ3MTIkSJ2St9lEDKGzLX
	 kMeyYGfy8ShzH5fnuyX0iNmbUMfyCZP8Xgo+03ZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfGQWFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:05:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37998 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfGQWFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:05:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id h28so17607538lfj.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YSDBsvNUqnUp/t7kjQNVbtVYe15sAK39prvQBCJ8iQY=;
        b=g84+xOg5RI1fWUeKUBJwojGU94tRjD8iZnr7jFeKgSFJWGDE5P+hiJZ/fByUC7X2Ud
         Qp+qvIYxZtjYMQm2/OAIJKIyXJb/8NX7XJR0SU91SEDjU6fmhg1H4carPg11uTh9RG8E
         J486BoqJAuMyOcptmKjQRPSZoDYh89CS+IIos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSDBsvNUqnUp/t7kjQNVbtVYe15sAK39prvQBCJ8iQY=;
        b=m5NPKmN5uUMXvpAg6gLmEQfLu6kI7698u5kmtpPjVh+jHSjVVaIcK485Ct6wMkwvbp
         inhGixLI+D7KG4q/fayAKZt66KNu7OdFuSIRw2pRfjtDpBOXxQlv+Lg8CzTvw/ZaS8RR
         G9GO9xVww86ORCmuI+MEsL9T9NPaNuL+zgJL3lPaW+wa8rzT/hDWJnfcT/EM7U9WaCVF
         fuc8uIGXGzh04Dbf3qyXetqtCnG5ksMs3fsM9eurlBtazQ+//tWFeyZKfqNFCL5xPzsv
         j4vLTZZcDyIV1dfRpVIr4OqncqMRmm6BYgcit/lMXzcI7pxmKYH0nuWy652AvPBgoK14
         Km6g==
X-Gm-Message-State: APjAAAW/7s6v+nYv2I5UOPcWx8YleAYSKmG7iICsbDsIf1ft1nn2l2Fq
        qrGGQrZPTGHNkl6kLT1EFkcpD2Ttams=
X-Google-Smtp-Source: APXvYqwjtC/IMidK2jDIXfbEl9+mNamc61dZdh90H05cmMD/w6BF3U4wLpTcL9+MlANOr70x6BpAoQ==
X-Received: by 2002:a05:6512:288:: with SMTP id j8mr20705817lfp.181.1563401113849;
        Wed, 17 Jul 2019 15:05:13 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id k4sm4712642ljg.59.2019.07.17.15.05.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 15:05:13 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id v24so25236354ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 15:05:12 -0700 (PDT)
X-Received: by 2002:a2e:9192:: with SMTP id f18mr21972538ljg.52.1563401112629;
 Wed, 17 Jul 2019 15:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190625143715.1689-1-hch@lst.de> <20190625143715.1689-10-hch@lst.de>
 <20190717215956.GA30369@altlinux.org>
In-Reply-To: <20190717215956.GA30369@altlinux.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Jul 2019 15:04:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whj_+tYSRcDsw7mDGrkmyU9tAk-a53XK271wYtDqYRzig@mail.gmail.com>
Message-ID: <CAHk-=whj_+tYSRcDsw7mDGrkmyU9tAk-a53XK271wYtDqYRzig@mail.gmail.com>
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anatoly Pugachev <matorola@gmail.com>,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 2:59 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> So this ended up as commit 7b9afb86b6328f10dc2cad9223d7def12d60e505
> (thanks to Anatoly for bisecting) and introduced a regression:
> futex.test from the strace test suite now causes an Oops on sparc64
> in futex syscall.

Can you post the oops here in the same thread too? Maybe it's already
posted somewhere else, but I can't seem to find anything likely on
lkml at least..

On x86-64, it obviously just causes the (expected) EFAULT error from
the futex call.

Somebody with access to sparc64 probably needs to debug this, but
having the exact oops wouldn't hurt...

             Linus
