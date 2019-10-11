Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3C9ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D5621835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570818052;
	bh=wMDEsltzULFcANZjZoQLiL8tYBb0zmiQz+OvrPFe7aw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OVwUhGkPVzSIXPm2DIpJei5jy3aBfLDvefFSEF/KxAAkgmZqHBaRkyyIr2nhMTj5M
	 lJSC6ZdIslTvkJYuK5mWllmQn8mpKd+j3XT0a6lR9ZBJ42oIPVBIcohjqi7tNJ6elL
	 5IcSY0BEX/HT2iDQbMXT2bHOQsW//r2TS7afV6uM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfJKSUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:20:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46582 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbfJKSUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:20:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so7655612lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 11:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtOmkJTgWRCiTrhHWdgBsH5ShPsUcHo7wVkWA6GbOWw=;
        b=EJ30jg4up9E+EQq6XyhxqytCcLcjMUfxQCZiv0SKtis+tP16d1Y2taYObSlT7PNzA1
         LGvyUzk0LpW338viCdWts370M1zgQU++Pz96/cPXXnweOuhIbBFPJd8E204RnpU17teD
         QyB1KSmlKzHIBlccl6i4fb67lW6F+y5JeJUAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtOmkJTgWRCiTrhHWdgBsH5ShPsUcHo7wVkWA6GbOWw=;
        b=KlebYj/G12Di8IvYgbpEKDUPxwp6XTrC1S/tlALk0IyjaF7FQ88BrjcoEo/KhKpbdu
         +wxlPwulUPJVcc1KQJjn0Td8b/coGiwd68128iGz2wJwVO28531DWG75S01x0qGqapb4
         Ffx/awhYCUInVyeyjIO9TI7DLmp/YrEmYaE+IsE9qxL44+S6lzdy1bTehDn7Qd7ImlZg
         YcgAu4bihW+KK78nZsOBqv3gKAlwz64LIk+NBez/TqGbqihknW6CzbtZyp0yzXrHfVFm
         qBc6oKdH4nqV7HAYm6nySqfMtmfB4Zv/3ymngRt1GgGidoYGB+Y1xCg4A9PCvMjpData
         TF6g==
X-Gm-Message-State: APjAAAWKRuDiKrTilQHB4yb7etGmiqfgEJcHxBEcBzGR/eV5YH4XZQtJ
        Q22CZrtaRkzP/RDL1iTKY+soS7ua04o=
X-Google-Smtp-Source: APXvYqwYd5DP7VR1dMWLhwgPNlwDedI+MsBV+8Y3wr3UkGSdJ2UTTFrPffEPfXVOET2oRov1IwJ8Kg==
X-Received: by 2002:ac2:4d05:: with SMTP id r5mr9357659lfi.26.1570818047503;
        Fri, 11 Oct 2019 11:20:47 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id t24sm2110815lfq.13.2019.10.11.11.20.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 11:20:46 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id v24so10753096ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 11:20:46 -0700 (PDT)
X-Received: by 2002:a2e:8315:: with SMTP id a21mr598855ljh.133.1570818045940;
 Fri, 11 Oct 2019 11:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191011135458.7399da44@gandalf.local.home>
In-Reply-To: <20191011135458.7399da44@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Oct 2019 11:20:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
Message-ID: <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
Subject: Re: [PATCH] tracefs: Do not allocate and free proxy_ops for lockdown
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 10:55 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I bisected this down to the addition of the proxy_ops into tracefs for
> lockdown. It appears that the allocation of the proxy_ops and then freeing
> it in the destroy_inode callback, is causing havoc with the memory system.
> Reading the documentation about destroy_inode, I'm not sure that this is the
> proper way to handle allocating and then freeing the fops of the inode.

What is happening is that *because* it has a "destroy_inode()"
callback, it now expects destroy_inode to not just free free the proxy
ops, but to also schedule the inode itself for freeing.

Which that tracefs)destroy_inode() doesn't do.

So the inode never gets free'd at all - and you eventually run out of
memory due to the inode leak.

The trivial fix would be to instead use the "free_inode()" callback
(which is called after the required RCU grace period) and then free
the proxy op there _and_ call free_inode_nonrcu() too.

But I think your patch to not need a proxy op allocation at all is
probably better.

That said, I think the _best_ option would be to just getting rid of
the proxy fops _entirely_, and just make the (very few)
tracefs_create_file() cases do that LOCKDOWN_TRACEFS in their open in
the first place.

The proxy_fops was a hacky attempt to make the patch smaller. Your
"just wrap all ops" thing now made the patch bigger than just doing
the lockdown thing in all the callers.

In fact, many of them use tracing_open_generic(). And others - like
subsystem_open() already call tracing_open_generic() as part of their
open.

So from a quick glance, just making tracing_open_generic() do the
lockdown testing will take care of most cases.  Add a few other cases
to fill up the whole set, and your'e done.

Willing to do that instead?

                Linus
