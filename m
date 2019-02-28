Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDB2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B134C20854
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3iLEpVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733228AbfB1S7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:59:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40701 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731915AbfB1S7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:59:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id h1so10155997pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 10:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r52IwKxcJ2RGsUIV/p4ftIO1s6BzYhWv7Ch2Y/DlkMU=;
        b=E3iLEpVA/88UNZ9/eRBTDkaLx3d6WCvsSkwr9iqiS7I9O/1h6LGLHc1BGJMhkazbu6
         lHgz1dWVJWWRovSD7Yx6aOl/t7Fe9ndmzSs8bT14/h8RsznUNxXREFNDmmj1MalYrVC/
         Pa1zu0MiI/GhYGJMnnuGGpbZWgFCsaIDsRDRHo0K/4qxu12A43MPWuDR8HTQOZ1G+YO8
         vhYL6zOYFrvPI00Z2efK3f1jtWMt9X370g1TiWpaTpMZlHHsoP7APf6of6JGPHM6Z8xZ
         X1CtmyOPbsbcKqMogDLvfa/jlGsN3jQext+SRynKPhXK87V1wPrYq21pWU31VAIrGLcS
         WFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=r52IwKxcJ2RGsUIV/p4ftIO1s6BzYhWv7Ch2Y/DlkMU=;
        b=DkzNvp0vDiiWbzAoIDpVxwkM3Opsrihh9jbLIkf7Dpx3zjf26eP6lSMwKgJc7k78+N
         eiHWaurYXNZm+cL0UcmgJAH0odcrEaXz4uYXnH7TlTMrY6CqKMqhqCLXfNKSHvWwI29S
         w3SL0yllsrBImgRzrCkXACUUuxqIBRchbcA2FBBIX5qd30EP0XwBnWZ3HZhlzQGmE2TY
         7ipTQCUoAQ2iXUjtFd0VvXajTP7Uq0j+otFHUOfA0njLjfj/hzxVcd8kkB/Y6q6umXiZ
         5/1MkLEIdOzCX9yRqTf4YEfRjPnsXdNvNYnsuzcF+Fnmb2YN+Hre1vfjmO+Q0AQuAGFl
         GVNw==
X-Gm-Message-State: APjAAAWO9a5mFNIFheDKsFXtT1VTnYgZ9Ls9W/gStFgIBMxmDouj2txZ
        BrAUM4O8OpxbqoMO/06Jy5g=
X-Google-Smtp-Source: APXvYqyfxiaeAgFNbQrsiowCO7K6yKmfEEuShK3d3qkAgcKhPeALzWla4DQOMjbwJ6R3o7jfrWn+cQ==
X-Received: by 2002:a65:4c01:: with SMTP id u1mr675214pgq.116.1551380371828;
        Thu, 28 Feb 2019 10:59:31 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e123sm23284582pgc.14.2019.02.28.10.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 10:59:30 -0800 (PST)
Date:   Thu, 28 Feb 2019 10:59:29 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Claudiu Zissulescu <claudiu.zissulescu@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARCv2: Add explcit unaligned access support (and ability
 to disable too)
Message-ID: <20190228185929.GA9842@roeck-us.net>
References: <20190228174742.GA18868@roeck-us.net>
 <C2D7FE5348E1B147BCA15975FBA2307501464380DE@US01WEMBX2.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501464380DE@US01WEMBX2.internal.synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 06:12:33PM +0000, Vineet Gupta wrote:
> On 2/28/19 9:47 AM, Guenter Roeck wrote:
> > On Wed, Jan 30, 2019 at 07:32:41PM +0300, Eugeniy Paltsev wrote:
> >> As of today we enable unaligned access unconditionally on ARCv2.
> >> Do this under a Kconfig option to allow disable it for test, benchmarking
> >> etc. Also while at it
> >>
> >>   - Select HAVE_EFFICIENT_UNALIGNED_ACCESS
> >>   - Although gcc defaults to unaligned access (since GNU 2018.03), add the
> >>     right toggles for enabling or disabling as appropriate
> >>   - update bootlog to prints both HW feature status (exists, enabled/disabled)
> >>     and SW status (used / not used).
> >>   - wire up the relaxed memcpy for unaligned access
> >>
> >> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> >> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> >> [vgupta: squashed patches, handle gcc -mno-unaligned-access quick]
> > Hi,
> >
> > with my brand-new gcc-8.3.0, built from upstream gcc, this patch
> > results in
> >
> > arch/arc/kernel/setup.c: In function 'arc_cpu_mumbojumbo.constprop':
> > include/linux/compiler.h:348:38: error:
> > 	call to '__compiletime_assert_326' declared with attribute error: gcc doesn't support -mno-unaligned-access
> 
> Sorry it broke ur build - but it did catch a deficiency in compiler as intended -
> yay !
> 
> > when trying to build allnoconfig or tinyconfig. I get the same results
> > with gcc-8.2.0.
> 
> Unaligned access code gen was enabled by default in 7.x actually, but us OS folks
> were late to find that which led to the recent patch to disable it which was
> broken in gcc.
> Claudiu fixed gcc promptly but that patch didn't make it to upstream, which I've
> posted now.
> 
> http://lists.infradead.org/pipermail/linux-snps-arc/2019-February/005522.html
> 
> > Do I need some special compiler configuration flag when building the
> > arcv2 toolchain ? Or am I simply out of luck for using upstream gcc ?
> 
> Once the patch hits mainline you could use that. In the mean time I'll back out
> the "detector" as it might trip other people too.
> 

Can you possibly use $(cc-option,-mno-unaligned-access), or would that
defeat the purpose ?

> Many Thx for your testing service.

My pleasure.

Thanks,
Guenter
