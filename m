Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ADAC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B942087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="TIMNqvAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfD0Ksh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 06:48:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46447 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfD0Ksg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 06:48:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id s24so4776999otk.13
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 03:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++lyK0/Przr4xnl8qGUSG2Yro7NLg7scLarfR5uNBzI=;
        b=TIMNqvAxeGkJ99uzPJLiugrlM6P6HgYUKE9pbhj0Imnf0AMj22kGUQvNUozJiZ7LyC
         fNN9WQIBeLQtbYGeOGissBVOCkhHCVCmSX6/XOATF3BlZwpOf54yYwCBEg6XCZ7ELoLo
         8/XyUSH/P1a9ErNAlCpUXtmOPruEOq6UE8KfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++lyK0/Przr4xnl8qGUSG2Yro7NLg7scLarfR5uNBzI=;
        b=qRyRovxlRU0vubhPFtyeJpCRCLOjWaRRqRrASnMXtbk9vTcpWYwW5mFGDSHJgQbzq5
         hwHXHWUlGlMK7NKDDlP6mK0+lITxYV+v+Xd0+4GkcYZMhYXoobL1/7EGZsNdjPn3hjzK
         V8iPz2anUBE7jQAEslpboHxk61USTjz9BqMqz4LYQaZ9BG2/aWPkpsZbrnzlLiWv4RBn
         MxPWCwFpdBun1UsDHFccFJlxusaQskxYW9FLwaIIHDtw6XnMmxAB2tkUUYrzNzmUeUYW
         uCt6HOwvsA7qFsUk24PTPbcjuDWdRMmiam6TnqAsjwUHzsIo40P/aFfUtU0qnJLEvLXj
         XLQQ==
X-Gm-Message-State: APjAAAUpRDilKWg2iiNC/U2x5osrahiWyBRFUxj7yfmt5DUoIrV6EyFo
        Z+aTuWgoFWqNU84FL5t9s9HY/B1zMSsNLnR6jJremA==
X-Google-Smtp-Source: APXvYqwD6+8uJPrc9C2GzFz6q8rAoafejRRSqHxtRlKBsAslu2z72AIfRUrptUK0dcZzzOmJlnmcgdNmKmMIZnzH1kk=
X-Received: by 2002:a9d:4d91:: with SMTP id u17mr26660488otk.356.1556362115983;
 Sat, 27 Apr 2019 03:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190426154848.23490-1-alban@kinvolk.io> <20190426140323.4edf1127@cakuba.netronome.com>
In-Reply-To: <20190426140323.4edf1127@cakuba.netronome.com>
From:   Alban Crequy <alban@kinvolk.io>
Date:   Sat, 27 Apr 2019 12:48:25 +0200
Message-ID: <CADZs7q7O9TL5wXFBq_SgAdNCkzO=3tyLnF1_chthX3jao=PKqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: sock ops: add netns ino and dev in
 bpf context
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alban Crequy <alban.crequy@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Iago_L=C3=B3pez_Galeiras?= <iago@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:03 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Fri, 26 Apr 2019 17:48:45 +0200, Alban Crequy wrote:
> > In the unlikely case where network namespaces are not compiled in
> > (CONFIG_NET_NS=n), the verifier will not allow access to ->netns_*.
>
> Naive question - why return an error?  init_net should always be there,
> no?

True for netns_dev. However, without CONFIG_NET_NS, we cannot access netns_ino:

(struct sock_common).possible_net_t.(struct net *):

typedef struct {
#ifdef CONFIG_NET_NS
        struct net *net;
#endif
} possible_net_t;

And I don't think it would make much sense to allow access to
netns_dev but not netns_ino.
