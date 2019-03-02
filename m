Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDD4C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 15:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D7E20857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 15:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FT7xEuaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfCBPnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 10:43:43 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43928 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfCBPnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 10:43:43 -0500
Received: by mail-ua1-f65.google.com with SMTP id g1so658180uae.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 07:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbJjxwxOlfJ3iaGGg9xeY6Ddwu/l4z5tJPWN/qYSwE0=;
        b=FT7xEuaa1OFYuO9BfHNTFSoK544uvygXdgTReUnuvoa+53+RkUd5s0BYLAJ5OK6vhE
         PNZEFU01htCD3GlKY7q/u5WBNGk7Qh5MaYYg8ZdzE8zK3DW9UXFsUpYODY6C8ur71PvG
         WKPkljS0MBvWeW343LmuGB7+fA+P8gKBGuWyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbJjxwxOlfJ3iaGGg9xeY6Ddwu/l4z5tJPWN/qYSwE0=;
        b=SWp6BSf04KOaVR//slwKuFrIyQQB96ecJEu5Xs1cElq/u6hAPFVXPQniXqNV92aXYR
         g60rhLzSvm0l0T5y9c8AiBmjNdtCq4+h6Qf/gIbcYAN0Btck/rmEq9g8qnPCc/XXpn9n
         6ErR8csdRNLmZnCiODgAUforKP2C2vqcnVJGRdTPDHWe10J/XN31c1W2+hHIFm7CbXvl
         pCOvDDkySpfkiCkKyHfcJWtr7bt/pHOTc6uLyxulXIvPoQhUjfwgO3me9cZX0mDPWZTB
         fpsnDGlucSFr+iFafOWMK3WsJZ8jwwrQ2VDwbxwXpuXMTwbI+b5vYr2hJtxE1OeHLPuy
         kr7A==
X-Gm-Message-State: APjAAAUJQNha//B7NsjB60UKi14LG3rmdOowpiM/bLi06i5+IOyrNpDL
        OoywYXlBts0DXyYzj+9hMHeYoxI7dlw=
X-Google-Smtp-Source: APXvYqzP+MBjRISVSry2nB6Mj+hhOKYTpBcTFAcq3848/sRjqBE0leYXd5tiZ2vCMrv4nhrFx1TnxQ==
X-Received: by 2002:a67:f409:: with SMTP id p9mr5458959vsn.213.1551541420770;
        Sat, 02 Mar 2019 07:43:40 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 62sm328560vkj.23.2019.03.02.07.43.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 07:43:39 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id c5so666861uaq.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 07:43:38 -0800 (PST)
X-Received: by 2002:a67:fe97:: with SMTP id b23mr5668281vsr.66.1551541418513;
 Sat, 02 Mar 2019 07:43:38 -0800 (PST)
MIME-Version: 1.0
References: <20190212180441.15340-1-keescook@chromium.org> <20190212180441.15340-2-keescook@chromium.org>
 <CAK8P3a2xC3OVckPnweSjor3AH5LpSzichKxAjkAcgXDtCf0QmQ@mail.gmail.com> <CAKv+Gu_+GZ8Ut0nN+za+V48Eo6O27P_go3Dk1rDe1Wederad1Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu_+GZ8Ut0nN+za+V48Eo6O27P_go3Dk1rDe1Wederad1Q@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 2 Mar 2019 07:43:24 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLwEh-_v_aVm35hSqbX3QzdFOy_AwEa4mmKM8JmWtiKGA@mail.gmail.com>
Message-ID: <CAGXu5jLwEh-_v_aVm35hSqbX3QzdFOy_AwEa4mmKM8JmWtiKGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gcc-plugins: structleak: Generalize to all variable types
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Emese Revfy <re.emese@gmail.com>,
        Alexander Popov <alex.popov@linux.com>,
        Laura Abbott <labbott@redhat.com>,
        Jann Horn <jannh@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 1:05 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 28 Feb 2019 at 21:27, Arnd Bergmann <arnd@arndb.de> wrote:
> > I get similar results with asan-stack=1 but without your plugin, only
> > the combination of the two has the explosive stack size growth.

I can look more closely, but I'm not sure it's entirely worth it:
these two may not make sense to build at the same time. (e.g. the
use-after-scope config was disallowed to work with this plugin.)

> > I can help analyze this further, but maybe you can have a look first,
> > there might be something obvious when you read the input to the
> > plugin.
> >
>
> Is this before or after use-after-scope was disabled entirely?

I was wondering the same thing, but I assumed it didn't matter: it
wasn't possible to use both before it was entirely disabled.

-- 
Kees Cook
