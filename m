Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEFAC46460
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAAA20818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OJlfMUFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfEPSdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:33:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37358 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfEPSdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:33:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id g3so2287706pfi.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CMlWNXfPwLOEGidca8EwjtL/G7K01/lWskyq0JQp7Po=;
        b=OJlfMUFm+sYikoezqBPoEqI7bWkVQTIqogHDa6Dj1pUQipCT4q3qJIicLQxIOCRBj+
         FI/AGzliYjQFp0YP0RXMuqkZRBGv93YmodMCpxr9bpEKGpczRXG2HmMB6EyExChLipHs
         xMk6hI498cUJXjBOyL5arF5E4J+FMUd7SrD8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CMlWNXfPwLOEGidca8EwjtL/G7K01/lWskyq0JQp7Po=;
        b=TJr8ffZEWm1sZpW5tuwXM3qtPyxJPh0Qce+1y3y6ACjmPTVEjouM64iXUAaf2nhfpM
         wjFO6dELdf2rolHhc1BSlx8zlw8irAsgH+SDznAfAuvdRqUabZnrOOCfRwFW4KeF2l8L
         yGo2pZgwGhqGh7Rswl2frmMAWVfRRLKLR0rjPITQIYg4J7jq2gHvcKUb5XicidH6Je5g
         fGMII26r1G/+yuLb9MrXVtH2Rpjeil1ZqwT2a0N0PsAqHnY+pdELuZHK31S8oUQ+CHft
         wwt4vbhpF5Ep+impZxc+NXv4yefsa6Ws+5mIJp+U4Oaq1i1MSw+FFnd4bd7u5qnTG3Qw
         +yMg==
X-Gm-Message-State: APjAAAXhUoxs3HSgQ7K37GtBS6GSKlUT4mqg22N1tcfPX+M20Ya1Wkxy
        Co+CY0pa/nZqL++NKg9OpFqABA==
X-Google-Smtp-Source: APXvYqxP772DhWABXNrxRmQR2JXgNUzAJCCUljaciwHF+kqiljZJgJB8K8UTqV6vF4M4xE9gCcLLkw==
X-Received: by 2002:a62:65c1:: with SMTP id z184mr36323550pfb.130.1558031603699;
        Thu, 16 May 2019 11:33:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 135sm11511052pfb.97.2019.05.16.11.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 11:33:22 -0700 (PDT)
Date:   Thu, 16 May 2019 11:33:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5] proc/sysctl: add shared variables for range check
Message-ID: <201905161132.CC4C2F3@keescook>
References: <20190430180111.10688-1-mcroce@redhat.com>
 <CAGXu5jJG1D6YvTaSY3hpB8_APmwe=rGn8FkyAfCGuQZ3O2j1Yg@mail.gmail.com>
 <CAGnkfhyjmpPAjQFpm-w3v0kMWTKRHTq5v6w0m9KScN2a7bMgeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGnkfhyjmpPAjQFpm-w3v0kMWTKRHTq5v6w0m9KScN2a7bMgeg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 06:09:53PM +0200, Matteo Croce wrote:
> On Tue, Apr 30, 2019 at 8:14 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Apr 30, 2019 at 11:01 AM Matteo Croce <mcroce@redhat.com> wrote:
> > >
> > > In the sysctl code the proc_dointvec_minmax() function is often used to
> > > validate the user supplied value between an allowed range. This function
> > > uses the extra1 and extra2 members from struct ctl_table as minimum and
> > > maximum allowed value.
> > >
> [...]
> > >
> > > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> >
> > --
> > Kees Cook
> 
> Hi all,
> 
> just a ping about this patch. Any tought, suggestion, concern or criticism?

Andrew, does this look okay to pick up after -rc2 for -next?

-- 
Kees Cook
