Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6B6C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3F62075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfG1Xhc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 19:37:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43460 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfG1Xhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:37:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id c19so40732900lfm.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 16:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8rxfba6tlD0hwZ133j08GN9B4ltnDc1brl6g+eS6jPo=;
        b=eo8XsKggOCdzahQaaqWKeSuvoWhbFAlUxA3OD+8iAe8xGs3RWwCpHzIQYger2YfMty
         ibucUkPzH4f8n5htIk7lGo3+l1QOzE8/N5eBjoeOEWkgNh8gH7HATogpGrLQt+w55AjP
         99/li4XrVL8v3oEwFW+pBHnhmuybcSivCszSeHoimGoISmg2yo+/Wj5scS5WCbkF19Pt
         U5d1FCE0vDe3wsD7Uz+PBTIPzzCtXqtRfBMWQ8K8CZwOcfn3dvSTR7pO05A/KF/oe4gE
         K+ulk+h8UXKRmwHg0C9UyA8t+qJPzbMGM+OI5RzuX3KtVR2htWygMHhURS8EdSQfSSJY
         AVaQ==
X-Gm-Message-State: APjAAAXyIViJBMKphcAGjajRL4E4EOqN9mACusugRUz5zgyzW+D0dqgt
        aDV4ycr2XuMc9BGdu24UCEDZvsaoNiumVALUM5L7NQ==
X-Google-Smtp-Source: APXvYqwB/Un4Offk206axKqX7V6yGtZYX78kh0XP6BqxKzNmjLSW52saNZfXtacg4JiTpxQuhZ5MqVXE/YYk0cqPjYM=
X-Received: by 2002:a19:48c5:: with SMTP id v188mr49040248lfa.69.1564357049901;
 Sun, 28 Jul 2019 16:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190728232706.7396-1-mcroce@redhat.com> <763dd408-7ac0-436c-d952-1decff5c696e@embeddedor.com>
In-Reply-To: <763dd408-7ac0-436c-d952-1decff5c696e@embeddedor.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 29 Jul 2019 01:36:53 +0200
Message-ID: <CAGnkfhx1r_wE9d9DLKYznhFw43bYWx5A23MnLy9X4T_bZAmjKA@mail.gmail.com>
Subject: Re: [PATCH] arm64: hw_breakpoint: mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feel free di discard the patch then.
What compiler are you using? I' using gcc version 8.3.0 (Ubuntu/Linaro
8.3.0-6ubuntu1)

On Mon, Jul 29, 2019 at 1:34 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi Matteo,
>
> I sent a patch for this some minutes ago:
>
> https://lore.kernel.org/patchwork/patch/1106585/
>
> It seems there are more warnings in that file than the ones you are
> addressing.
>
> Thanks
> --
> Gustavo
>
> On 7/28/19 6:27 PM, Matteo Croce wrote:
> > Mark switch cases where we are expecting to fall through,
> > fixes the following warning:
> >
> >   CC      arch/arm64/kernel/hw_breakpoint.o
> > arch/arm64/kernel/hw_breakpoint.c: In function ‘hw_breakpoint_arch_parse’:
> > arch/arm64/kernel/hw_breakpoint.c:540:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >     if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
> >        ^
> > arch/arm64/kernel/hw_breakpoint.c:542:3: note: here
> >    case 2:
> >    ^~~~
> > arch/arm64/kernel/hw_breakpoint.c:544:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >     if (hw->ctrl.len == ARM_BREAKPOINT_LEN_2)
> >        ^
> > arch/arm64/kernel/hw_breakpoint.c:546:3: note: here
> >    default:
> >    ^~~~~~~
> >
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> > ---
> >  arch/arm64/kernel/hw_breakpoint.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> > index dceb84520948..7d846985b133 100644
> > --- a/arch/arm64/kernel/hw_breakpoint.c
> > +++ b/arch/arm64/kernel/hw_breakpoint.c
> > @@ -539,10 +539,12 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
> >                       /* Allow single byte watchpoint. */
> >                       if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
> >                               break;
> > +                     /* fallthrough */
> >               case 2:
> >                       /* Allow halfword watchpoints and breakpoints. */
> >                       if (hw->ctrl.len == ARM_BREAKPOINT_LEN_2)
> >                               break;
> > +                     /* fallthrough */
> >               default:
> >                       return -EINVAL;
> >               }
> >



-- 
Matteo Croce
per aspera ad upstream
