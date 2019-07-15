Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE30C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC723206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563215892;
	bh=zL4CAXDJIBOne6/mWtSrpBEjvksI5WqZ7J5qU6ZZjjk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MD53+Ko2r11y8jqwj6uomhUVpaSVRV7DKZojdZTTwDVx9fcteh3KfyXwf0dvsB44e
	 H0TWjqVvF7OVjD5d4s0PmmDq99Ytuz3E+BmjytLfaSnAh3oNtbRfWQ3dUksDIBnDx6
	 rdqGTnTqBbdDklQDafuO+c8kiA7rqw9WdHdXcimc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfGOSiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 14:38:11 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:40259 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbfGOSiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:38:10 -0400
Received: by mail-lf1-f43.google.com with SMTP id b17so11734360lff.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 11:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Df/Yx/4+nCeEeOKf1uVvrrlXDNI2FBEEjRZW46mr8Bc=;
        b=PTL1nlF48G2tEQXY/Fs49JRstAULEghq3sqmvSB88fxjgt/mTefVpWKJ/dfeDx+Csy
         UFzqAMISngDRHnbeO82HN05He3V7Wtr08QNjlTbsj1Oit8nCa+5LtO4pw/DYBi7Tmtzh
         d93fJIWcQzwyJxWTyH1KBtFt8sOQQ2qz30SJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Df/Yx/4+nCeEeOKf1uVvrrlXDNI2FBEEjRZW46mr8Bc=;
        b=rkibwsTSoFv0Rc4odCDHsmlotb2fySMyFKJ0rLitxB3US8kyrj4zpYlt4sGqvgmDLw
         xtRokSOLYj0oAD+d8bMq6ngMcdt0zGNTSsVzY8ON6yG5a2D3trZzLU8YbhOJW8AdneD1
         jCXuh9RbULW7D5IaYP+EGCSDRmelTgZqLdVb+tAH0+17+5PVglIeUmdxY8/vM40mpjw7
         BClpDFEd391N3VBMinCZbx/1KzabkIMe0rpfPMJP4uaoUz7sJrYl14G90nOtNbxYqQBV
         Lp7vQw21LMfchTnq9U/cEWVF/wx4uEPZ5hucPVWy1PiG89m4Ffit9hStlIeZFCOYvgGt
         AnCw==
X-Gm-Message-State: APjAAAV/qaH9u4Hv/m/wb5w8Gqd/6F6V7todQpw200gRcacEV86af5sG
        fDt7C+dyt6r5C2JX4Y0Ib1sviBA8jNI=
X-Google-Smtp-Source: APXvYqw5QygJNcJ8aD4u4M/CJ3IhBzFQnPcj8GpAcSBCjNPMpkNA8CZu9JLzH+qRiSo7VzD1lLo6lw==
X-Received: by 2002:ac2:5442:: with SMTP id d2mr12661928lfn.70.1563215888391;
        Mon, 15 Jul 2019 11:38:08 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id t63sm3252886lje.65.2019.07.15.11.38.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 11:38:07 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 16so17281310ljv.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 11:38:07 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr15258415ljj.156.1563215887270;
 Mon, 15 Jul 2019 11:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9twvwhm318btWy_WkQxOcpRCzjpok52R8zPQxQrnQ8QzwQ@mail.gmail.com>
 <CAHk-=wjC3VX5hSeGRA1SCLjT+hewPbbG4vSJPFK7iy26z4QAyw@mail.gmail.com>
 <CAHk-=wiD6a189CXj-ugRzCxA9r1+siSCA0eP_eoZ_bk_bLTRMw@mail.gmail.com> <CAPM=9tx9N=qDnt8sn6dMw4BmfPwh-qNPGXDg5FA5fh5hKmooEA@mail.gmail.com>
In-Reply-To: <CAPM=9tx9N=qDnt8sn6dMw4BmfPwh-qNPGXDg5FA5fh5hKmooEA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jul 2019 11:37:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5CBo_1Q8MCF9iVVY1yqUS=sVCE8qA4wXw--QxzAqzNA@mail.gmail.com>
Message-ID: <CAHk-=wg5CBo_1Q8MCF9iVVY1yqUS=sVCE8qA4wXw--QxzAqzNA@mail.gmail.com>
Subject: Re: drm pull for v5.3-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 11:29 AM Dave Airlie <airlied@gmail.com> wrote:
>
> Not that I want to defend that code, but the mm patch that conflicts
> already shows that removing the token is fine as nobody needs or
> requires it. So the fixup patch in my tree was just a bridge to that patch,
> which reduces conflicts. Rip the token out of the new API, pass it as NULL
> to the old API until the mm patch is merged against it which drops the
> token from the old API.

Well, to me the "old" API looks like a new one too, since it's that
"struct page_range_apply" thing.

But I can appreciate that it makes for minimal patch to avoid
conflicts with other patches. It just doesn't look very sensible
stand-alone afaik.

I might be missing something.

But that last patch is more of a detail - it wouldn't even exist if it
wasn't for the earlier mm patches, and those are the ones that make me
go more than "Whaa?" so it's not like this is really all that big of
an issue. More of just a note I made while looking through the mm
parts.

                 Linus
