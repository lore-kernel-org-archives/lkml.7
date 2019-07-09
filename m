Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B675CC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86463216FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Djoi1z+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfGIGt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:49:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39204 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGIGt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:49:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so19658034wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 23:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Nb0pkc+k4Qz3CzHqObu3Bzh+hOHM655Cn2712+LoHC0=;
        b=Djoi1z+OJdSQcbc/LHWSmwd9/9O9pkUGvPL14F6N7LW+l0FNebr+OsMd06cuG1vmiq
         9pmmo5vgmdUxRkJ/ClYyBf8TXiMy45EGTo8PjW1nO5ACH5Nlswhavg1yZP2f1sB/6Jt+
         bLiVFFTFIwWIYSFgwBCk4pMUiUgXnPOn+YFGc2ujMYz+xBJkxJn9NuZV5Aw4R4Rdvrj4
         xsHkHQ8G3CD0OJjE+Cr+HjCIKVjIUAVeUOjGWWlAF/WrAEP9Ymvqb6I3xRcGp3nhdQp9
         0HQ2MXRlz4O1ffK9GMUfoJx+7rBFQJQ/e4EB2xbgCcw8VLKhe+FWoVe/B3h1EXh1PG1w
         TZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Nb0pkc+k4Qz3CzHqObu3Bzh+hOHM655Cn2712+LoHC0=;
        b=TfSDVWZTgl1LjhT0UHsoyeeLfdYsWcXHbUPaMekCxixV8qRfaeoth1B4BSkdUJDd4M
         xISWD2ADf/Qh8KBcFst25jC3rW+mVwF2Yg1ka5X2J/QxSnngcH6pAZ7UGVBVRa+zHxE/
         bZWRcArEU6Y+9f2Ozxsebbg43va5kDGVc9cbdDjqqngrepnHENfsWFjV3xNKqfPbF2xt
         FytUrZLGapqcuzGkEmcEOMtB0/0I5PYoUOS9tsVp6nErNwN/RpTSsXpVEOCQkh2AF4a8
         8lE742WIdPIwK05jSKoJTGS++1N7WawBBAbx20AjzHDDGfO9KaU/LJ5dcF5q6yhssAWf
         hUww==
X-Gm-Message-State: APjAAAVAVEGRLWjema5TVLpqkwwedlb6kBq1Scl9H8lEQaUxPXO+WYGN
        aDd8fneDUTo1byMGt88vlJk=
X-Google-Smtp-Source: APXvYqxbWBP22Hj6gv+5vEr97/SBM8AtFOB6BACIXVuXsQzH0yNmZQ/xlOJZPUbpeE4pwgOrMQHNug==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr21977289wrm.218.1562654994345;
        Mon, 08 Jul 2019 23:49:54 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id n3sm10904758wrt.31.2019.07.08.23.49.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 23:49:53 -0700 (PDT)
Date:   Mon, 8 Jul 2019 23:49:52 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] powerpc: slightly improve cache helpers
Message-ID: <20190709064952.GA40851@archlinux-threadripper>
References: <c6ff2faba7fbb56a7f5b5f08cd3453f89fc0aaf4.1557480165.git.christophe.leroy@c-s.fr>
 <45hnfp6SlLz9sP0@ozlabs.org>
 <20190708191416.GA21442@archlinux-threadripper>
 <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 07:04:43AM +0200, Christophe Leroy wrote:
> 
> 
> Le 08/07/2019 à 21:14, Nathan Chancellor a écrit :
> > On Mon, Jul 08, 2019 at 11:19:30AM +1000, Michael Ellerman wrote:
> > > On Fri, 2019-05-10 at 09:24:48 UTC, Christophe Leroy wrote:
> > > > Cache instructions (dcbz, dcbi, dcbf and dcbst) take two registers
> > > > that are summed to obtain the target address. Using 'Z' constraint
> > > > and '%y0' argument gives GCC the opportunity to use both registers
> > > > instead of only one with the second being forced to 0.
> > > > 
> > > > Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
> > > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > > 
> > > Applied to powerpc next, thanks.
> > > 
> > > https://git.kernel.org/powerpc/c/6c5875843b87c3adea2beade9d1b8b3d4523900a
> > > 
> > > cheers
> > 
> > This patch causes a regression with clang:
> 
> Is that a Clang bug ?

No idea, it happens with clang-8 and clang-9 though (pretty sure there
were fixes for PowerPC in clang-8 so something before it probably won't
work but I haven't tried).

> 
> Do you have a disassembly of the code both with and without this patch in
> order to compare ?

I can give you whatever disassembly you want (or I can upload the raw
files if that is easier).

Cheers,
Nathan

> 
> Segher, any idea ?
> 
> Christophe
> 
> > 
> > https://travis-ci.com/ClangBuiltLinux/continuous-integration/jobs/213944668
> > 
> > I've attached my local bisect/build log.
> > 
> > Cheers,
> > Nathan
> > 
