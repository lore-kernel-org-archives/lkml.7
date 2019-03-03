Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10518C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2438206DD
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551644495;
	bh=GoROjpRh/Ksk+FqUK1F/i4B6Syaz5p+jJN11iVnBl2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=khB9XmM5VBf4uWypPQ/zCcDE2wJngsKrwweOcq0yvW10kx+Lq20Hvtd2qkbya7PFx
	 KqL8wJXOZvjTg19xi28+XghNQswGXgbjrOi0JKfPbstQ9lX+KZed8CFL4IZJKmYzWE
	 92NXe6OIMt5WJDim+BxrnJoQFrSJE/r42J1FgFak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfCCUVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:21:34 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:41013 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfCCUVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:21:34 -0500
Received: by mail-lj1-f172.google.com with SMTP id z25so2482139ljk.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 12:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZVuktvhuSYUOMCCpWsMBFzskA8alavFEwkh2F2AGgU=;
        b=MyRfEZn5zPECVVQ4P2qTbo4jlBiX1Vgo9P9JN0qWK5mrfqIIgWTQ6Vx70siSFZMlqI
         JMKW60zyHs9IMDp1n0H4V3CpPVxOg0a9XDsA4fd53HarYGCeT0wXcppcKGLxEsyWaa0o
         5KKhmrkvIXOnjRrs8PaqeiYrUKFYTlWbGuskg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZVuktvhuSYUOMCCpWsMBFzskA8alavFEwkh2F2AGgU=;
        b=YeguxbxIxge7ztg7d7o5Ean+idQQKwrpBpqy7MKvp3S3/VQ+i4jeVQQF1OtMJ1Vztw
         5TmSdRzyHMMebrkJjLSSqOggfx6BMh0KLYxtEFpgI0BXC8ZNEqawAT2RS0zkIQgySicJ
         wHOKVElTdGNBMO0sXAZM2eZutJRPl6iRhWxOFV/VgioCtkVBbaM3durDFJbpN+Ea0GCa
         SpI0kKAqkcZ+huhoYA0v7AHhO9dw87MYCmtte4LsT/TczJO+tap+bjcJe961WjHUSIb+
         vNGlc3lA7eyW8I4DDqQSPzTEJTp2Tb8K3Yok4XiyTmuimj5TEmyO2R18WwYcDTIZOUKw
         NjCw==
X-Gm-Message-State: APjAAAWni9BcInaglpFDQbEDbSWXAESdVYxg8GYrflPh9cxW+M/RGY8G
        L9XYPs9QYz95O4JhXTp0l4kwq/5CLaY=
X-Google-Smtp-Source: APXvYqyT5bR1FxcA0nD9CkCsMg3umet/OuY1npF2e/CeLPhI4mf+VD7LtN5DKbYieilKQN5508pHXw==
X-Received: by 2002:a2e:408:: with SMTP id 8mr8621212lje.15.1551644491708;
        Sun, 03 Mar 2019 12:21:31 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id a18sm1140561lfj.35.2019.03.03.12.21.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 12:21:30 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id d24so2467709ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 12:21:30 -0800 (PST)
X-Received: by 2002:a2e:208a:: with SMTP id g10mr8730168lji.135.1551644490408;
 Sun, 03 Mar 2019 12:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20190303034249.GO2217@ZenIV.linux.org.uk>
In-Reply-To: <20190303034249.GO2217@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Mar 2019 12:21:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgerH+Pkav6RqdH4rBJZRwLLD5kqZbJzB8LFhia_xoknw@mail.gmail.com>
Message-ID: <CAHk-=wgerH+Pkav6RqdH4rBJZRwLLD5kqZbJzB8LFhia_xoknw@mail.gmail.com>
Subject: Re: [git pull] vfs.git fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 7:43 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Assorted fixes that sat in -next for a while, all over the
> place.

Is this for the merge window or _very_ late fixes for 5.0?

One of the commits doesn't look appropriate for this (very late) stage
of the rc series: "cgroup: saner refcounting for cgroup_root" seems to
be a pure cleanup, and not one that matters for subsequent fixes.

And the string length one looks sane, but not exactly critical.

I'm getting the feeling that this is for the merge window, but wanted to verify.

                   Linus
