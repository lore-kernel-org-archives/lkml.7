Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BB5C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881B3206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PY5Y+hA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfL3TUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:20:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43539 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3TUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:20:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so10962834oth.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 11:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R2HUGNP1cgOAxLXKvlAf83qqvmp0LxZQcufLQgEdsSk=;
        b=PY5Y+hA+W0jSa/dQ/V6VYLCqV4AT5UTQYa/uE4RAwjVpydp7EBzIhqRGAY878mMDoN
         FHEaoDv3IAjYCnvd9HjkLIn3r6sFuOEkicnZT8ougvvck33aYYn/XTuQVKWU8PlFODAj
         3x4ttGGQfDQLwU/9UX1Ht2WkvfJSLQPfQYkRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R2HUGNP1cgOAxLXKvlAf83qqvmp0LxZQcufLQgEdsSk=;
        b=szPtp/YjAR2YIf47IcHCsRUqTCC+617zCKvngFIFp10gSzzWgRLOqiSK2cElY4OX7O
         tdULDY5b3ZpoSlNRUBWbz2K2rAVPw/FcZ6UhmVx0EOAhdSBzoa9ZOkHP/cfOjAqK6bcg
         OKjJdePbRb9WkaKpXaGav63o0KIlvGlpYxkit12+/w+Ll6xs+Zc9z66HZF/XdorEnOhG
         AQcP1nDaZO7ZTEcxW9WhcIaFCcDwuKfHcIoMhemd1ME6GIbb+4HSZcK0dkR31cxsGIRU
         /asGKkjT0IwMwFqs/RzoS+2rAOh/i5tgOtsRySvUqg+n5/cU6MP7e8O6mURSNAVRnKfL
         a4Kg==
X-Gm-Message-State: APjAAAVq4cJA7WT/zzr6Zj2Caitfyb/uodO0FjeR/XtPkVt1oRNHrAi2
        9RviZFe/kuNdh4WIAzsDitedDQ==
X-Google-Smtp-Source: APXvYqxU4Rafz9V1wbvaC2DEXCwxWLwK/+lXqX/YBMc6nhISNgTL6bIGnejZYe7KiLdWaMYtrkPCNw==
X-Received: by 2002:a05:6830:2116:: with SMTP id i22mr79234563otc.0.1577733642201;
        Mon, 30 Dec 2019 11:20:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u75sm9985380oie.15.2019.12.30.11.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 11:20:41 -0800 (PST)
Date:   Mon, 30 Dec 2019 11:20:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
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
Message-ID: <201912301119.B475C474@keescook>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <20191220154208.15895-7-kpsingh@chromium.org>
 <CAEf4BzZ+wMTjghpr4=e5AY9xeFjvm-Rc+JooJzJstBW1r73z4A@mail.gmail.com>
 <20191230153711.GD70684@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230153711.GD70684@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 04:37:11PM +0100, KP Singh wrote:
> On 23-Dec 22:28, Andrii Nakryiko wrote:
> > On Fri, Dec 20, 2019 at 7:43 AM KP Singh <kpsingh@chromium.org> wrote:
> > [...]
> 
> Good catch! You're right. These macros will not be there in v2 as
> we move to using trampolines based callbacks.

Speaking of which -- is the BPF trampoline code correctly designed to be
W^X?

-- 
Kees Cook
