Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1503FC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 15:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E215020856
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 15:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rh/FqlVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfGFPC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 11:02:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33430 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfGFPC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 11:02:58 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so10309553iog.0;
        Sat, 06 Jul 2019 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=boVbp9ZUpDsf//+FdnJqiUZCUcTK245wDcHd7jIjrpY=;
        b=rh/FqlVekhxhsGpxulSZ7913KgIi6gqoFF4i/RNbOKBumEHd/qP8oFyX+UMcwSBJ/K
         eJbwXN4Ov/ueoIt4Oyi19u68UVz6gWVl32e1YjWfUsFB+HhwINCxXsiVdhbRDT3gbdiG
         5ibSk2q5E+W34FIfKzIclMIaC9eqyeGf8flkt1UTZCjuuU8xyABLpmZVy9kQW38Wcd47
         gAN4OKTn4B+qQpI+Fdb0r7ze2FAi8FFmV7f4mtLyNxY5j9rWNMTHzsbte1amZOAaiclM
         2DjSHrq+GVNYO2PJo+dpnRZ5GGJt2TrAWtORL250xGp3SE0C7nVC/Ze8vY2ybOEgpvg+
         BqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=boVbp9ZUpDsf//+FdnJqiUZCUcTK245wDcHd7jIjrpY=;
        b=fYMW63wembzSsVmxR1Qp9N40c3unn6d74J4+2hs8Z82IfJx1tRGkmXaMUsjZiljgqh
         +/OvIBhgqjHaM1gkHDtaDC+0NXe3FfXX+bqVNVp3PsjaA8+uAUHU0czdW2Onl2nU3ZQi
         Qb2u5hWWuVk077GHGu3Ep1wUFyx5lEfv2YlyLZY02KBZEUWycqqK+DMFm1DFuRjxlz6q
         D3BwT+1ROFbuCLn8ypVcSF99VqoEOQkm9AbQvHB0V3Yl3apABl6IN0S1Dai/n0gXiw5G
         eBoLtj3Hd1ec9SQAOWKNHCOpsXVdFaZA/hHXH5gQv5fFF1SmSDgns66CJzU+xOgp81Tl
         A/Uw==
X-Gm-Message-State: APjAAAWEPXzlvpVZUFCJ/ZXOQyiXoY+aGQkDzrc3M+TkiOq6RQ+zUMVP
        sSA4c7zhE7ZwYS53yZtFpQFLe4RQfHtn/+DbiwQ=
X-Google-Smtp-Source: APXvYqy2UcPtMHw6LxYEegmwXcbc6qsKnlfXOceq6+ohw3DYNqy1gXgyu+nij430oPjMdmSFDPXMk206/IR43gK04QA=
X-Received: by 2002:a02:b710:: with SMTP id g16mr10876342jam.88.1562425378023;
 Sat, 06 Jul 2019 08:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com> <HJktY5gtjje4zNNpxEQx_tBd_TRDsjz0-7kL29cMNXFvB_t6KSgOHHXFQef04GQFqCi1Ie3oZFh9DS9_m-70pJtnunZ2XS0UlGxXwK9UcYo=@protonmail.ch>
In-Reply-To: <HJktY5gtjje4zNNpxEQx_tBd_TRDsjz0-7kL29cMNXFvB_t6KSgOHHXFQef04GQFqCi1Ie3oZFh9DS9_m-70pJtnunZ2XS0UlGxXwK9UcYo=@protonmail.ch>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Sat, 6 Jul 2019 17:02:46 +0200
Message-ID: <CAJHCu1LVk-3XwZCF=iQzZfbJR0eDn-0VOaipOthYeqknT6VzKQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] S.A.R.A. a new stacked LSM
To:     Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You are right. I just forgot to remove that paragraph from the cover letter.
My bad.
Thank you for noticing that :)

Il giorno sab 6 lug 2019 alle ore 16:33 Jordan Glover
<Golden_Miller83@protonmail.ch> ha scritto:
>
> On Saturday, July 6, 2019 10:54 AM, Salvatore Mesoraca <s.mesoraca16@gmail.com> wrote:
>
> > S.A.R.A. is meant to be stacked but it needs cred blobs and the procattr
> > interface, so I temporarily implemented those parts in a way that won't
> > be acceptable for upstream, but it works for now. I know that there
> > is some ongoing work to make cred blobs and procattr stackable, as soon
> > as the new interfaces will be available I'll reimplement the involved
> > parts.
>
> I thought all stacking pieces for minor LSM were merged in Linux 5.1.
> Is there still something missing or is this comment out-fo-date?
>
> Jordan
