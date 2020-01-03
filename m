Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D85FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6545020656
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dManOXxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgACXxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 18:53:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36725 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgACXxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 18:53:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so43899183wru.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 15:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dz/v20Hft+ZxPT9oFbtS2gq/bqz6agzFQsRm4OWF9jI=;
        b=dManOXxGrlMaiJ/ynRgu1yCFdEcpD/AOSQkNls79QUWBWSYjqzY2BKe0B0CrbI6idm
         /dTj664fZOcZ3w0IhkkGvGKo0ZgQ5ovhCuxPUi0qIp8QbhJLqznWHjkdBBukcve8aOSq
         D6Arnnq/Btsydx/BvYbkVW+yAtU/2+76NlCYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dz/v20Hft+ZxPT9oFbtS2gq/bqz6agzFQsRm4OWF9jI=;
        b=W/KV2iG25RLsMkFWmy2v5MwaxJQFntjftYm5p0WQmEgrlojFYGl1mRhMrAhKYp5GFu
         qpAp4zl8pDcNxSvdk7z2HAFDT2SjIs8yVeY/WaAbF0wkzLaasnk0NBJCMlACVrqt5lZB
         9Jr1rCBYL0VIjhBmHxYa5chxTbaeu51mR/Vh5gRnI2/8L2ekHvYA04RbHQ8gU/g7Ukfx
         eAqhsIC7twQurSfLCNXQTrtXPP1coKUaLEBONJ5v191eiVW9cQWh/Vt3nLs/3jmJV8Mj
         tHvTBgaBEfwvJo80QcvKEvLYz2punKGE0ueMuKWHDEQIPah1TwKdyz7fSa8I/TwhqwLp
         2WDw==
X-Gm-Message-State: APjAAAUh4CksmVM2eLYYySHWqLSiuGuU9e3GzElxrBYnj5tnvfr7gvdn
        HQVYrHXN6Z41w9rkgxbDzkkwJg==
X-Google-Smtp-Source: APXvYqyy67BT7vikizrc7raGZc5Z2eAyOslGHtOakkXofnQQZkbJeV/hbYbJMF/rPU0jTVIAfDRp1g==
X-Received: by 2002:adf:fac1:: with SMTP id a1mr87185425wrs.376.1578095579772;
        Fri, 03 Jan 2020 15:52:59 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id n14sm13436895wmi.26.2020.01.03.15.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 15:52:59 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Sat, 4 Jan 2020 00:53:13 +0100
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v1 06/13] bpf: lsm: Init Hooks and create files
 in securityfs
Message-ID: <20200103235313.GA23199@chromium.org>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <20191220154208.15895-7-kpsingh@chromium.org>
 <CAEf4BzZ+wMTjghpr4=e5AY9xeFjvm-Rc+JooJzJstBW1r73z4A@mail.gmail.com>
 <20191230153711.GD70684@google.com>
 <201912301119.B475C474@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912301119.B475C474@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-Dez 11:20, Kees Cook wrote:
> On Mon, Dec 30, 2019 at 04:37:11PM +0100, KP Singh wrote:
> > On 23-Dec 22:28, Andrii Nakryiko wrote:
> > > On Fri, Dec 20, 2019 at 7:43 AM KP Singh <kpsingh@chromium.org> wrote:
> > > [...]
> > 
> > Good catch! You're right. These macros will not be there in v2 as
> > we move to using trampolines based callbacks.
> 
> Speaking of which -- is the BPF trampoline code correctly designed to be
> W^X?

Thanks for pointing this out!

I don't think this is the case as of now.

The dispatcher logic and the tracing programs allocate one page where
one half of it is used for the active trampoline and the other half is
used as a staging area for a future replacement. I sent a patch as an
attempt to fix this:

   https://lore.kernel.org/bpf/20200103234725.22846-1-kpsingh@chromium.org/T/#u

- KP

> 
> -- 
> Kees Cook
