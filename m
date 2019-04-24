Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C011C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064F920835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za8P31ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388574AbfDXTAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:00:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39538 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfDXTAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:00:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id k45so16901209edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gd3IcxJmoTUqYFAc0VF5eFAXOJMNpKkDyUNbT0Bvna0=;
        b=Za8P31ae0e/ZudJS98vg59UY9P7SI2MiMa3Ge3dotEobGvaeHSkfraE5j1b+Yr+HSb
         2rz+uwg+qBRN0fU+I2uPwLpTf4dv8eGpTNarNeL/78DBHHQZFX7zKbb9XdiEZ+tg3XlI
         TX5HGkIH6ZFlGAo2+DIcZcUqnHMNc0oRKWM3dbaOMA7H676t3iJ/wudOCUkznL9amaYK
         7LerDFvUHkPrEIGyMmHLCmC//RnfWWCRN2x3zE7DL3lLW2EHjxJBtoW9d2B08d9jePXu
         UHIgq7JZ6KtjQnU31Fe+qLiOEr3fBWvvcjW9MMUk8fM2priEZAX2wTsYGknmPeKyn8PD
         C6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gd3IcxJmoTUqYFAc0VF5eFAXOJMNpKkDyUNbT0Bvna0=;
        b=NmKzE1R89s1pr3sNFPAVdDUZo6DbhexOUbWB3ufq+XhLuHlZXbX8Gp3hE0xwMLkS7N
         s8vnMlcrCQN8a0zxHPPlAEkDoJpD9lua1O5Grf7zhOWT6qj2eh8I42zxIvgkq8nwQAfQ
         DVJMdyRMG7BPwQztQZFLIY0YzXz3h46KZB3o+rxO25dKEFFiDNgNlgirioUL/8qBcFqq
         pXBFRPGmCb9kF6dl/DOdAxUy7cyPnhJkiitncNI8tFTL/X3+SEjwPxMcbPZnrot3iz4n
         Q84C3FU6JRtPVsaT4a8FYZSa+i6BUai7XPUhZNsRgb4yfrrEFA7NIvEqc+Il5F5zfKAB
         I/pA==
X-Gm-Message-State: APjAAAX2vKw0Cpj+SH/bFvQgZPu/RC0lkRy90854G55Bu1KW1vnOrr77
        S/UiAUEjdkqUTJfFdMqNmaQ=
X-Google-Smtp-Source: APXvYqwABSeYRN0HH576yZ+EHAEVblvmAzPCw4rVBNSTPf8uqqphi0KtKVeHcNhN1lgtpEx30jEoqw==
X-Received: by 2002:a17:906:4911:: with SMTP id b17mr1551104ejq.144.1556132407652;
        Wed, 24 Apr 2019 12:00:07 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id p11sm163876eju.23.2019.04.24.12.00.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 12:00:06 -0700 (PDT)
Date:   Wed, 24 Apr 2019 12:00:05 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] thunderbolt: Make priority unsigned in struct tb_path
Message-ID: <20190424190005.GA9406@archlinux-i9>
References: <20190424183413.13854-1-natechancellor@gmail.com>
 <CAKwvOdkHiBhFsgEvLrr6oD84GKetDFV2b=n1DYDewCUyHWf7oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkHiBhFsgEvLrr6oD84GKetDFV2b=n1DYDewCUyHWf7oA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:49:37AM -0700, Nick Desaulniers wrote:
> On Wed, Apr 24, 2019 at 11:34 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > drivers/thunderbolt/tunnel.c:504:17: warning: implicit truncation from
> > 'int' to bit-field changes value from 5 to -3
> > [-Wbitfield-constant-conversion]
> >         path->priority = 5;
> >                        ^ ~
> > 1 warning generated.
> >
> > The priority member in struct tb_path is only ever assigned a positive
> > number:
> >
> > $ rg -n priority drivers/thunderbolt/path.c
> > drivers/thunderbolt/tunnel.c:99:        path->priority = 3;
> > drivers/thunderbolt/tunnel.c:308:       path->priority = 2;
> > drivers/thunderbolt/tunnel.c:323:       path->priority = 1;
> > drivers/thunderbolt/tunnel.c:504:       path->priority = 5;
> 
> LGTM.  Looks like drivers/thunderbolt/tb_regs.h also defines it as u32
> (no change needed here).
> Triple checking it's uses, looks like it gets assigned:
> drivers/thunderbolt/path.c#L492:
> hop.priority = path->priority;
> hop is an instance of a struct tb_regs_hop, which is the definition I
> was looking at above.  LGTM thanks Nathan!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the review!

> 
> >
> > Furthmore, that value is only assigned to an unsigned integer in

Although apparently I can't spell... should be "Furthermore".

> > tb_path_activate (the priority member in struct tb_regs_hop).
> >
> > Fixes: 44242d6c9703 ("thunderbolt: Add support for DMA tunnels")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/454
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/thunderbolt/tb.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> > index 15d225dcb403..b12c8f33d89c 100644
> > --- a/drivers/thunderbolt/tb.h
> > +++ b/drivers/thunderbolt/tb.h
> > @@ -225,7 +225,7 @@ struct tb_path {
> >         enum tb_path_port ingress_fc_enable;
> >         enum tb_path_port egress_fc_enable;
> >
> > -       int priority:3;
> > +       unsigned int priority:3;
> >         int weight:4;
> >         bool drop_packages;
> >         bool activated;
> > --
> > 2.21.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
