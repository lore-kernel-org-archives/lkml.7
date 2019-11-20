Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA29C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B437520679
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574279182;
	bh=tZQSoUnx2LoVHeYv7nqGaX2nxJr97Y1u3Rtx9/9nYNM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YLRjOBkpYlrwJVwu9bGBiNxeMyh1hStzC/RtqKY/PceglpQOn/X0ckCJHa5UFc2NG
	 tykVidNGeaktQKoSkjIPAVim1rWTslNuev1XS4J0T83wAQbd0E4G8fU9w/ZdPF+KZC
	 X9nDuQkyQNHIG2W7P0IAPOvH2AkW3DCnnyahYwd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfKTTqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:46:21 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46035 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfKTTqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:46:19 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so492846lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 11:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4GCAZq/uEGcflB5X2TUEKapPXWlMYkV/UtTnBsKpco=;
        b=RxrnU9Zdl4qfrpzjYpyaAwAzY3XG/Ry8sSMBDTALfDbrJKNq6lonVJs86WghdReGSb
         q45rbMINZQcSQBcg70Nq9j+IAHEwqOnSBqakByyWfvUAPcN9Z19YUXtPjvRykksd/JQX
         uKQsqv/rx+Vm2XY+DmpAjU7u8YtknBJEgq1hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4GCAZq/uEGcflB5X2TUEKapPXWlMYkV/UtTnBsKpco=;
        b=dhV2wPcxY1X3didyb0P5SgjYaYHVM8cVLkDPHf7TlWo0oN0JETGRTsUZ9Gu+maOHim
         9PBGax9vu/+n0PfMdN/r4uNwRUUR/xIuE8pyV4J0mPgFBGhh+UAprGGLXdY2eKMAiP+h
         +6xXryMtM9kw/ioROov8CQ73/wCuzXUDEBHHaPow6/QmaQQ9zIG2Ia8rwLEipuASrkZd
         iwnd9QqII4wwIEAsnuD5xFJ7YxqeRRDN7H2vRiVFTsEZiJrXeP1490sSrconos7JymT1
         aZZaNVvWGN4nh1URVFYuuCPsSNuk9oRWxw9cZ1C79dJiMOaLjHKuXwkCmcQQuQDJJ0Lg
         uF7g==
X-Gm-Message-State: APjAAAUQoSPFU4f7QdaR1wOKXc7ZuqVtbUP9P3sODe+rj6aRnLcGTMOD
        SqNpqbX3NGSd4W6WVgeMCj3m5jMET84=
X-Google-Smtp-Source: APXvYqyV41oziTLd2/JhApZkipoS7Mx/Uzi11QsHJsiZ2nChLAC0xjN5l6LVAVWz3fIXnHLkLL2fwg==
X-Received: by 2002:a19:f811:: with SMTP id a17mr4334491lff.132.1574279176168;
        Wed, 20 Nov 2019 11:46:16 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 30sm68551ljw.29.2019.11.20.11.46.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 11:46:15 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id y19so509158lfl.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 11:46:15 -0800 (PST)
X-Received: by 2002:a19:4949:: with SMTP id l9mr4313293lfj.52.1574279174744;
 Wed, 20 Nov 2019 11:46:14 -0800 (PST)
MIME-Version: 1.0
References: <CAJKzgVtzD7ULwCDVRSLMCmGJNaMqvx+jVO619t3xuv2oiEsPMQ@mail.gmail.com>
 <20191119095708.GB21113@dhcp22.suse.cz> <201911201032.67566C6BF@keescook>
In-Reply-To: <201911201032.67566C6BF@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Nov 2019 11:45:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjw=fg5WznKfA+NQP78h8qDkF=t3CzH96fACAfULza_hQ@mail.gmail.com>
Message-ID: <CAHk-=wjw=fg5WznKfA+NQP78h8qDkF=t3CzH96fACAfULza_hQ@mail.gmail.com>
Subject: Re: Suggested Patch is not working for 22851 Bugzilla issue
To:     Kees Cook <keescook@chromium.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Bala S <balas2380@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 10:39 AM Kees Cook <keescook@chromium.org> wrote:
> Yes, as Michal mentions, there were legitimate binaries that expected to
> overlap mappings

I'm not sure they were really overlapping as much as "the ELF sections
were in a bad order and we don't do the whole "optimize loading"
thing.

It's one of those things that *might* be fixed by first creating a
"simplified/combined map of the ELF sections", and them using mmap()
on that simplified one. But that code is nasty and hairy.

             Linus
