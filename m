Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D6FC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1176F20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559928063;
	bh=iiHnfuhDgsegutLu9eSwGicxPI6KmhYK1/zRTdWv3yE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=z6wNJnCo7H9UzogIAEfp/vjm9syQlRP6B1kOgxQZtoN65lqlgVRdrAeEQCVr985J1
	 4/luqd0q3Q+okjPUoKGFD7uMmJoO+p9RmzMJow6C9FBhzBoNag94hrF7WdNHDP1gej
	 iVh22X8eWXbDJFgN622oOnNARIUgXcc6cuHQO7EE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbfFGRVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:21:02 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:43984 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbfFGRVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:21:02 -0400
Received: by mail-lf1-f49.google.com with SMTP id j29so2190076lfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 10:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4D91HzfNlEzUNnFN7tLM07Lh/kR1e806a5ZjRrM9eYA=;
        b=Nd9RRPFRO2C5Q5+TuDI+2EliAG0BEJiHbUEtvqa2sciOCFIdPA9T6u5w8lx+m0b/zA
         WlO74VC2uvGEdDbUcOenUGd0uBMJdkZw9gz+WcfFKOwn4ICV7YHHfpfwNL+3ffsQMQGD
         IOa0Rnt4fVjhNTjZMvJnDHc2t1GFUqxdR+WKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4D91HzfNlEzUNnFN7tLM07Lh/kR1e806a5ZjRrM9eYA=;
        b=SrTfIfSOPMffz/FtQgH9Ju4We6s2MxQa0VqFo/Yk+wyor+zeACj8GtoDF8I1Epyq18
         UQwMWtqetdhpPpnR1q9Ky1l0TgubrGCr6Xej0zTWoF8JAKzVUHWqzUeN9J0Qpg2Aa4BV
         5ApJjeXPwc5JosV0Aaj5s3G0H/bGvAU4WvHmNcB8GPxfXirbemiS2ErNBwQSJ/Tfbw8Z
         t6YajxYQm3dvuMCG81NlU0/Qq9u83VhO9lwZZImndkY52/7l16FSDla3VRaV5TyygJuj
         fu5JRJp1z6AZRufqdQuEp4ZKO2Q2dF6IuO46HiDFWNLnVVIpopuWs7OeyYdgJGQdHPgj
         LSCA==
X-Gm-Message-State: APjAAAXk8mQ2mCYlHVeJwmvzAFLzWPg+sHCVvaIqyyNTY/WA0VlGvASp
        i3j/VUnYokaWHX62qAbrxTwf7M0Glio=
X-Google-Smtp-Source: APXvYqx9rtJHbA9x81c3sjXdEF6M+/rESn2AVmH+MPKVh79vlnJlEha4QL4HPho+ghQZ6AkeeOY7Sg==
X-Received: by 2002:a19:3f16:: with SMTP id m22mr26619604lfa.104.1559928059933;
        Fri, 07 Jun 2019 10:20:59 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id n7sm503889lfi.68.2019.06.07.10.20.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 10:20:59 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 16so2391628ljv.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 10:20:59 -0700 (PDT)
X-Received: by 2002:a2e:4246:: with SMTP id p67mr28756012lja.44.1559928058812;
 Fri, 07 Jun 2019 10:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tx_2-ANvU3CsasrHkaJsyRV+NxP1AoM0ZSu8teht3FuEg@mail.gmail.com>
In-Reply-To: <CAPM=9tx_2-ANvU3CsasrHkaJsyRV+NxP1AoM0ZSu8teht3FuEg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 10:20:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOGPPO6owAcRiBd0KJpmjH-C83-=_N6QeQzyiCW4kb0w@mail.gmail.com>
Message-ID: <CAHk-=wgOGPPO6owAcRiBd0KJpmjH-C83-=_N6QeQzyiCW4kb0w@mail.gmail.com>
Subject: Re: [git pull] drm fixes for v5.2-rc4 (v2)
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 12:24 AM Dave Airlie <airlied@gmail.com> wrote:
>
> I sent this out earlier, but I forgot the subject, and then Ben asked
> about some nouveau firmware fixes.

Well, the first one at least had the address to pull from, and the diffstat.

The second one has the subject, and mentions nouveau, but doesn't
actually have the tag name or the expected diffstat and shortlog.

Third time is the charm?

                   Linus
