Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302E9ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0525E20650
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Th5jluCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfJNIk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:40:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35400 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730441AbfJNIk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:40:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id w2so15192546qkf.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 01:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IhvMgu+8NRfvEZVb3Yd23S2a/QiDqpj2U4nfhQK8p70=;
        b=Th5jluCNF1AqA4Lmism3or3iqXiMLxK3B8SFAH5bLBqH2mPs1ExBwv5S0QkrrphtKi
         VS8p1xrBgbfRWx8rnjsMdNwYNqrLa2WbZiUcHGJIavZr2J/kcpUfggxoY3iOYKsQDqNj
         wMAC4roRoOzURYr1iD3g4EHF3JFImDgkiSSX50tBPr6gV1kSnf8cTM74Qsmfjk79yfez
         kO7vjmdZZuyRkqIEhtzTeGavSuxKhoTAXsmKI9DNFm1c/3ar2mWOp5XTjuMmQfROmrJ3
         bgU4FB2Jyv5yWRaQUzp6tww+ZcpQlTUFIfTddmdgkHqGyb6z8wbQ5Ibh5yY37045dM86
         THrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=IhvMgu+8NRfvEZVb3Yd23S2a/QiDqpj2U4nfhQK8p70=;
        b=Woq0ueXaSLhUV1Eo2ovl755LpZlQ7QMhUsgGcaKCOsDpWWAy1fzgL7geBEXY+KQNQm
         kNflt8vVVwQ59/B54Fu16uHGqYIPwB3T27mELXMtDlH5h7x0/dRS79zodp4wGntk74qk
         PlbCxrDdeGwhcVi/EgmWf9mhTjsy2YJZgOZq+2821oCFteFfPZNvP0nG5U3sa2vLKjPR
         FyuuncK2MzDMHgK9LUWTH9Pf9qV/rzrK5zq9+rzDOPXSTxodCEusc/ILf3wutPWSy8UW
         kiLL0pHk+mfyEHtAIs4P/SGc5CVt+ep24Kmb2tPlfHtRU45Dww0F3ote2PV+Aw9vMSfC
         yp4A==
X-Gm-Message-State: APjAAAXSQvi5lrAxUq+onnOxcvXXlD/htHbJzxbK9I7zCDMA+9TFwlKD
        mlP5228B6F/Dg7EShMH5oKwRaMOlwpikEVKFAI4Law==
X-Google-Smtp-Source: APXvYqwsTpDlD2jgQ1dZB1tf0r2BelRbilPeisNVUn1E05ezkvRAeY/XyIlTdCmoXFYUBCy+xVzEaYTA0TkMqcLWPgE=
X-Received: by 2002:a05:620a:6b6:: with SMTP id i22mr27778578qkh.256.1571042454774;
 Mon, 14 Oct 2019 01:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <000001d5824d$c8b2a060$5a17e120$@codeaurora.org>
In-Reply-To: <000001d5824d$c8b2a060$5a17e120$@codeaurora.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Oct 2019 10:40:43 +0200
Message-ID: <CACT4Y+aAicvQ1FYyOVbhJy62F4U6R_PXr+myNghFh8PZixfYLQ@mail.gmail.com>
Subject: Re: KCSAN Support on ARM64 Kernel
To:     sgrover@codeaurora.org, Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <willdeacon@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 7:11 AM <sgrover@codeaurora.org> wrote:
>
> Hi Dmitry,
>
> I am from Qualcomm Linux Security Team, just going through KCSAN and foun=
d that there was a thread for arm64 support (https://lkml.org/lkml/2019/9/2=
0/804).
>
> Can you please tell me if KCSAN is supported on ARM64 now? Can I just reb=
ase the KCSAN branch on top of our let=E2=80=99s say android mainline kerne=
l, enable the config and run syzkaller on that for finding race conditions?
>
> It would be very helpful if you reply, we want to setup this for finding =
issues on our proprietary modules that are not part of kernel mainline.
>
> Regards,
>
> Sachin Grover

+more people re KCSAN on ARM64
