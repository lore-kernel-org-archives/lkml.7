Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD8AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A062075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyHjsdZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfCKNuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:50:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44382 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKNuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:50:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id b20so4060247edw.11;
        Mon, 11 Mar 2019 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iMzmxseIEor4W0Mlxh3NSGrXk6R/HrgYuHji6ua3eYs=;
        b=RyHjsdZnUBnIiu/hrilLerZkzIUWf5iIHuYgd+UNM0fQlrBkbOtRtyEn1FnjtFJPuU
         +TREejkaG4JKeSzU3eVdG3+SH7RA65l+UZpwTBoJJHIG42Rq1GjI3Be0hV8VUXNVcJu7
         7X97K0FdGF1JdRl57R+HpIgR2za8p92b8pmlEtb40AWRoogA4WRNw5e4uxd1CNTzrUlu
         UaLbF/iY016qavjgQ5OFIlDbeK4Hw6kmgiIUX4E/WP3jPgfzAWSD0LhTkoGAcbBnuFMi
         V2tdwGMh4iYM/xXj/rXGgZt9cvVYmumcRiwgRVgDYBGt7xWdW8BVmDJ5/z9KDGafZq/v
         WGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iMzmxseIEor4W0Mlxh3NSGrXk6R/HrgYuHji6ua3eYs=;
        b=ZMlbdJtK18hHY7Mb/FU2SjoMTnBcTdqSyeswhFbCuu8/09FE5ReTtKWqIsfmiMzdVL
         NBgmMEFexcOOI/WkgFtCxueZ6RINsoFk/c+IcorFv/HouachGvw6TMtCC3I7zwUmY/Zg
         KevX+DraaNwq6DoX+zw+oGwgcsOn7p6JoOBITd2Vt/uP+8k9Ive+KfpsOWGN6h1ibLaS
         FaDdS7iXVIOgwg7bnNQe2h6LcOXq3LTNB287ii3dMosUl2ItromZpnsyVkNiEJdfjA1h
         wo/r8UMXaWL+V5jsz1BZYElB+cs8k4COERvXYOtS/BjuFp9rSXo1gALCN31YaPLVIh4D
         yk0g==
X-Gm-Message-State: APjAAAURD8sWFzK9OP8dZUN+GjltELu5cekYU8nJ+bSohd7PMfqA0ehe
        2SsC4kEc1ou9FHLayjdJ1IU=
X-Google-Smtp-Source: APXvYqw2w76Wp1JDHYpppn16AhJtXufj6P3YLY/GJeQM/kWbFZODZ+9tjhduedOv3thrCMTUOmuDvA==
X-Received: by 2002:a50:b16c:: with SMTP id l41mr44619875edd.209.1552312207620;
        Mon, 11 Mar 2019 06:50:07 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id x36sm4709359eda.94.2019.03.11.06.50.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 06:50:06 -0700 (PDT)
Date:   Mon, 11 Mar 2019 06:50:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] iio: common: ssp_sensors: Initialize calculated_time in
 ssp_common_process_data
Message-ID: <20190311135004.GA11528@archlinux-ryzen>
References: <20190307214546.9624-1-natechancellor@gmail.com>
 <CAKwvOdkeVmcoD7WusKE83MmRjX+h73rnHDY=Rn_a7LXsULPsrw@mail.gmail.com>
 <20190310093738.72c1019b@archlinux>
 <CAK8P3a3X1FbFPxOW54AtqeJgOTvjtnLwzVNCv+x-439Df_cEPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3X1FbFPxOW54AtqeJgOTvjtnLwzVNCv+x-439Df_cEPw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 12:10:18PM +0100, Arnd Bergmann wrote:
> On Sun, Mar 10, 2019 at 10:37 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Thu, 7 Mar 2019 16:35:26 -0800 Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > On Thu, Mar 7, 2019 at 1:46 PM Nathan Chancellor <natechancellor@gmail.com> wrote:
> > > >
> > > > When building with -Wsometimes-uninitialized, Clang warns:
> > > >
> > > > drivers/iio/common/ssp_sensors/ssp_iio.c:95:6: warning: variable
> > > > 'calculated_time' is used uninitialized whenever 'if' condition is false
> > > > [-Wsometimes-uninitialized]
> > > >
> > > > While it isn't wrong, this will never be a problem because
> > > > iio_push_to_buffers_with_timestamp only uses calculated_time
> > > > on the same condition that it is assigned (when scan_timestamp
> > > > is not zero). While iio_push_to_buffers_with_timestamp is marked
> > > > as inline, Clang does inlining in the optimization stage, which
> > > > happens after the semantic analysis phase (plus inline is merely
> > > > a hint to the compiler).
> > > >
> > > > Fix this by just zero initializing calculated_time.
> > > >
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/394
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > >
> > > Knowing that the same invariant holds across function boundaries to
> > > protect access of unitialized values and thus undefined behavior
> > > sounds tricky to diagnose accurately.  Thanks for the patch.
> > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Applied to the togreg branch of iio.git and pushed out as testing
> > for the autobuilders to play with it.
> >
> > Note this is going to be a while before it hits mainline but as
> > it is a false (if reasonable!) warning I'm not going to rush
> > it in as a fix.
> 
> I think it's actually a correct warning, it just doesn't trigger
> on gcc because of a known gcc bug.
> 
> I'm not sure however why I don't see the warning with clang-8
> on my local build. Is this something I have to enable
> separately?
> 
>        Arnd

Yes, -Wsometimes-uninitialized is not on by default because
-Wuninitialized is disabled. You can either pass it via KCFLAGS or
modify scripts/Makefile.extrawarn, which is the eventual goal because
Clang can catch things that GCC can't:

https://github.com/ClangBuiltLinux/linux/issues/381

Cheers,
Nathan
