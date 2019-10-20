Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2421CA9EA9
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 05:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA617222C2
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 05:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJi8/6+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfJTFw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 01:52:58 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35934 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfJTFw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 01:52:57 -0400
Received: by mail-wr1-f51.google.com with SMTP id w18so9697324wrt.3;
        Sat, 19 Oct 2019 22:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=51TklpCVmpWzv8/2EcsxOdE6xXoYYK++w+3ck6sGq7g=;
        b=sJi8/6+EPXDLkFwM84PDzxNA+xm/Ty4OLsEENxPDWuFLSe6Q0NpSWlMUiamI2quZHb
         QzqxmXKuEHPbdVFNCl0m/57mbcREyxdyo0vB+W+2RWSpDjNvQFsLrNfv4OzmwtsxgXDG
         9Xw5z/G7Gl0wzF3x/mhNzIrcai5ZYPq3vxNHWteLj2igr+OCPCCds43IDPuXqe1P6JSp
         +BR7+k31QxCk+elV8cgZWQJE1iYqq4tIn1PS9dV8VV21YevDhSwcYTsXyMh/NtD353Hm
         +pbftBm+DMYlO4H8I3L4JLCPrCkt1PdBmTLi0sbfy94PW2DqZpFrCUApyV6oTf0pBZf9
         ls6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=51TklpCVmpWzv8/2EcsxOdE6xXoYYK++w+3ck6sGq7g=;
        b=CHV9FH4bbw95H/L8/OpS30Nwej838e+/iiuyZBSGh1uq66A4AYpnd2xk5Ioh9WwqBR
         7Cl4KSENuTkscNFmMoMjMgSuOQoKYTTMkct5XoSOOk1guwURCcCLdlw5Hg+gdEfnc2G7
         FzaXkWaETQGAL1jaya+Jz7MDDgPeNQG4oZVecUgM8JC2cedRUJXMQ6P3gnuDSxYKaV7p
         u1mZ17ZlZCAjeX9/XLtslf5MwoYa+DWN+SEriCAVoPf3PEhhjCVJQPy5ZdErYzUJy6U1
         m5jpzSKsusK8hHqE4pChmM1BEigeYh/y7nE1d7ohROoNrAClnT8gRng9+7tVf1l0S1lm
         Dhvg==
X-Gm-Message-State: APjAAAV1Rug2YTV5o+welT+P+LTY95RWAvI9fTlXgRt9FFcHJU/r7U5H
        pD8kSmAh9mrLZ0DBVicI0zc=
X-Google-Smtp-Source: APXvYqzT7vAv/SjZ4jxekx/DUQnVMu+sCN6LLI8uruB8JJJ5aEqCJhSP422smgKO0FpK9ZmuJZWuBw==
X-Received: by 2002:a5d:4142:: with SMTP id c2mr13624286wrq.208.1571550775205;
        Sat, 19 Oct 2019 22:52:55 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40ac:ce00:9cfc:63f1:4c41:b934])
        by smtp.gmail.com with ESMTPSA id u7sm1283982wre.59.2019.10.19.22.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Oct 2019 22:52:54 -0700 (PDT)
Date:   Sun, 20 Oct 2019 07:52:53 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: sparse: __pure declaration only
Message-ID: <20191020055252.2ymxfrskpodxhuxs@ltop.local>
References: <09d824ac-5371-830e-466d-7f78ccdae065@codethink.co.uk>
 <CAHk-=wiYQ=F5H-uwQvj4eMS3xREmqE6tPuDVVLVML02xaThqVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiYQ=F5H-uwQvj4eMS3xREmqE6tPuDVVLVML02xaThqVQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 08:31:48AM -0700, Linus Torvalds wrote:
> On Fri, Oct 18, 2019 at 4:15 AM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> >
> > is this a valid warning? if not, should sparse be ignoring these.
> 
> It's technically valid, but maybe it's not useful.
> 
> If we make sure that any pure bits from a declaration always make it
> into the definition, then I suspect that the "was not declared"
> warning (if the definition is non-static and seen without a
> declaration) is sufficient.
> 
> Of course, sparse doesn't actually _care_ about "pure" in the
> definition, only in the use, so right now it doesn't even make any
> difference to sparse whether the definition has the "pure" or not.
> It's only when the function is used that the "pure" matters (it makes
> the call instruction be CSE'd like any other random instruction).

Yes, for 'pure' it doesn't matter much but it's a problem anyway.
For example with 'static':

$ cat file.c
static void foo(void);
void foo(void) { }

$ sparse file.c
file.c:2:6: warning: symbol 'foo' was not declared. Should it be static?

Which is kinda absurd: foo() was declared and was even declared static.
But the definition is a different symbol than its declaration (OK) which
doesn't 'inherit' the declaration's specifier/modifier/attributes.
It's on my to-be-fixed list for a long time but ..

-- Luc
