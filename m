Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559A6C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B83820665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563212298;
	bh=Yu3Ac70/VGgiljrcu0iSXBljEQMCtbZ+fpbxDwdwAb4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TcWT+GKk32UmqMiG0EN85W253uIUJE5ia1dLIlFtlR9uxmwY89y+8PidrgBV+NUBH
	 Zg7aCDo7221FsoRFpECI/2OviRJ3JpEEaugKaRDNW4OeRBxlgkz+5o59eja69iwV/C
	 2DqTVnaDnnjuw/V+x+T8loPkO7dXlV/zA5dNYiR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbfGORiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:38:17 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:36677 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731574AbfGORiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:38:16 -0400
Received: by mail-lj1-f173.google.com with SMTP id i21so17128360ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6yNHPalLHo3z6IzaHCO2qZtNfkK2KJ2qqTjNmniu54=;
        b=BMTEzJWxu5YNZrJEeeLrPq3cQEjHlHqr5u1wTXl6opOudhFi4mrDX8+E2dclQMKPL7
         VnVp9+95dZdzFQPT/3ycgygH4u55U41uLPhkUO4rag68ecl9FwOHBK5kttZVDCz/dO+V
         GjZwH8J5cuRxjRMcDIk3PXkECfVKdthlQme/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6yNHPalLHo3z6IzaHCO2qZtNfkK2KJ2qqTjNmniu54=;
        b=QjHQtf58Ho/BX7Y+NpHh/DBLHXV+xq4dwqIXvj8x0MivBoLBXt7xfi4JP0iE8ocazg
         g/yUVuKPV7geg6uxg+Z+q0xojVCRZxOgJ7c9v/+BUfldImrlCGvpJivHxuhy8Sh8U2gp
         xWmdkQ7bxROdKDQXUPyOuqW3dDdbdYlZyHDVEwlfSjpAP+VwzOICksoCpu1EcozkuO9R
         8vhdQ3evBYG6ypfVJMF5nY99VOcznTSZAXRlbOOIpXINxiylsUZbW3IYq3wLmwDDJJ1l
         GvozbRE5bBouN6DJW/X0Ds+Mfo0+acwq27bdS8vKPBWNJwAgIyTR3w9XkC6e/I2gGNLA
         kx1Q==
X-Gm-Message-State: APjAAAWRrJvUaP28QQCovUS5cV94T4s4IvmrqfyV0pyphlNPqRmRgseb
        ZA+09CeY0XrQwb33ZP7VajHY4wiwOas=
X-Google-Smtp-Source: APXvYqzCD4HcaERDWg1ekYGk3rtg8BNRieWqv1VMGooWdlSOOn8SeY/gH6zWwEG70eXHG1YrZ751PA==
X-Received: by 2002:a2e:2993:: with SMTP id p19mr14359446ljp.202.1563212293722;
        Mon, 15 Jul 2019 10:38:13 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id v4sm3247705lji.103.2019.07.15.10.38.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:38:12 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id h10so17130135ljg.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 10:38:12 -0700 (PDT)
X-Received: by 2002:a2e:9192:: with SMTP id f18mr14594812ljg.52.1563212292312;
 Mon, 15 Jul 2019 10:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9twvwhm318btWy_WkQxOcpRCzjpok52R8zPQxQrnQ8QzwQ@mail.gmail.com>
In-Reply-To: <CAPM=9twvwhm318btWy_WkQxOcpRCzjpok52R8zPQxQrnQ8QzwQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jul 2019 10:37:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjC3VX5hSeGRA1SCLjT+hewPbbG4vSJPFK7iy26z4QAyw@mail.gmail.com>
Message-ID: <CAHk-=wjC3VX5hSeGRA1SCLjT+hewPbbG4vSJPFK7iy26z4QAyw@mail.gmail.com>
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

On Mon, Jul 15, 2019 at 12:08 AM Dave Airlie <airlied@gmail.com> wrote:
>
> VMware had some mm helpers go in via my tree (looking back I'm not
> sure Thomas really secured enough acks on these, but I'm going with it
> for now until I get push back).

Yeah, this is the kind of completely unacceptable stuff that I was
_afraid_ I'd get from the hmm tree, but didn't.

It's not just "mm helpers". It's core changes like changing how
do_page_mkwrite() works. With not a single ack or review from any of
the VM people.

Maybe that commit is fine. But there's a whole slew of questionable
core VM changes there, and absolutely none of them look obvious, and
none of them hack acks from any of the VM people.

The hmm tree looked like good cleanups that largely removed broken code.

This looks like it *adds* broken code, or at least adds code that had
absolutely no real review outside of vmware.

I'm not pulling this. Why did you merge it into your tree, when
apparently you were aware of how questionable it is judging by the drm
pull request.

                 Linus
