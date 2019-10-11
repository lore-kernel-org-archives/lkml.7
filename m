Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4095ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7FA2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570827671;
	bh=knd0f8yCPR6Ky+R1X+NQQa8VVFtwb+8x5S62C5Kz22U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=D7tt27XAuvOw1X77YmX4GvoVQO0Wi1iwxIUphnFtkVEnMlfpZn/Wvr6GbS7wV15gc
	 vXgkMbmn49h1+7eNNTuZnitknqBlavFZoBkD2EVmBgiz2BZwrB1R9Rztz+HUQqzjLz
	 Xm2DCK0HTDYF3R59ktHNb3s1UeySpPRqGf0uQUvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfJKVBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 17:01:10 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38252 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfJKVBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 17:01:10 -0400
Received: by mail-lf1-f67.google.com with SMTP id u28so7963869lfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKr4WHC3iR8iedd+96HoEDT1mA0iwz01QLINNBDqvTA=;
        b=AjD32CNEE5D2mrL1SxTGTAcIg8rDu5TsWXuC3JWTpw/d7RSutnwDdzYzC2ZDXXNEQs
         xbRUdI2G9Bdey7J+lF7C19PmyyR/h7paQAvoZ3B7DeLBGHQM7JosujRghPkyJaObtcaK
         WflPEvqjO32pHzc6ziczhzVrcfZHPdGY8qVxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKr4WHC3iR8iedd+96HoEDT1mA0iwz01QLINNBDqvTA=;
        b=b/wkBp/C2puFguauhSrijKqB/oOVnh6JpTSSClehXwACWXgBcx5zuqyOSZgGSWtOGU
         DGBINUDO8Wob+l5rjttZf5RkvrIzuJaQYUAgOENvvThUaj3z6hUHoSMe/US7zw+8CD3V
         /t6OpVnT5B5E8Wo4YtNASaa+O0aZQUvB/2JQI1Mi3KF3zCN5lKYiL4DFG5UqMfw9OQTy
         EcOMHL3UlSZ+xaUK/wKdQyBgzFrC+j5BM6r9A8CmNDTq5pBeXcJQsrLRSZA9PnDZfrEp
         4cLoAV0fHN5g1wePskifcgH70HgmwBuxgL1GmS1JlM2lAje9U1YeVS1N3/8q6mPl0PqK
         D/3A==
X-Gm-Message-State: APjAAAUIdbI6emQGsUQDN8FmllpXfZ1DwiykSYPtja7ZFFipVUSusaT7
        Pt96IB06bb5ja2MA46zbKS5c3bpgJu8=
X-Google-Smtp-Source: APXvYqyUJq4kNQ1rkSv0F/jM4l60TOuRCOkvhq5Yn0M7gQTO7CoedIbraY+9db1/LIWlOoJx1UUd2w==
X-Received: by 2002:ac2:4578:: with SMTP id k24mr9565269lfm.84.1570827668198;
        Fri, 11 Oct 2019 14:01:08 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id t25sm2139056ljj.93.2019.10.11.14.01.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 14:01:07 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id y127so7984084lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 14:01:07 -0700 (PDT)
X-Received: by 2002:ac2:5924:: with SMTP id v4mr9785397lfi.29.1570827666846;
 Fri, 11 Oct 2019 14:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191011135458.7399da44@gandalf.local.home> <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
 <20191011162518.2f8c99ca@gandalf.local.home> <20191011165455.32666d53@gandalf.local.home>
In-Reply-To: <20191011165455.32666d53@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Oct 2019 14:00:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGtEDhwJab7+tQzmjDssynBruRvgj9NJY2bzNrVzw+0Q@mail.gmail.com>
Message-ID: <CAHk-=wiGtEDhwJab7+tQzmjDssynBruRvgj9NJY2bzNrVzw+0Q@mail.gmail.com>
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

On Fri, Oct 11, 2019 at 1:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I guess I can keep it this way. Thoughts?

That looks fine to me. I'm still not sure you actually need to do all
this, but it doesn't look _wrong_.

That said, I still do think that if things are locked down from the
very get-go, tracefs_create_file() shouldn't even create the files.

That's mostly an independent thing from the "what about if they exists
and things got locked down afterwards", though.

I do wonder about the whole "well, if you started tracing before
locking things down, don't you want to see the end results"?

             Linus
