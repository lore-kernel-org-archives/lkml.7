Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44120C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2444B21670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395019AbfIFQAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:00:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38243 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfIFQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:00:36 -0400
Received: by mail-qk1-f195.google.com with SMTP id x5so6082095qkh.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 09:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ES4SaHURAaJC01GAaptDev9SfTdpvqyq6m4yX4fQcB8=;
        b=VXwqctCfDR+6l2dQ+0vcQB16a0N6tJqPs19kOPRxudsB91+TLVdI0k8GAZH/WfCFx6
         tqO9t7VPmhMq3jIznqzmZgrwg4btKdDVGoyy2F9BCVHO94yjoonCifqiY+CiRRFsUEOS
         KyHVntxUwpeb2Beho8TlUxCERaVc1Nw5aiylqqYlB7TbAB92MQSM/Ig8tlUzCGLXMspt
         VhL1/tv43/sz0RU3GOycUS4Dq35I0w/fvMHsyRTVQz8xVG5Dws2XzWPz1nglcI6rKWZ1
         ShKdYb+gtBW567ZXNhHbUFKuIgV6HmHBdNE8kAlxqK0Y0OxPPWi7E5P3V29kap3fIkuZ
         /6/Q==
X-Gm-Message-State: APjAAAWcrGAqG8xj5fEdYCVQzdzJIQfyrPuzgrKN8tgnh1NThtMJk/A6
        HWYqvGW11rglllAnLzT0cICG+EfkO5Nbg5gaj64=
X-Google-Smtp-Source: APXvYqz3LSRyVLYYD4QDIyXNudChhzjqkuMLsRlKHB4VakqREofKG/STxaa6LfsgS6WjUsYS6TRljEVwYTs6CmUAbq0=
X-Received: by 2002:a37:4b0d:: with SMTP id y13mr9297353qka.3.1567785635669;
 Fri, 06 Sep 2019 09:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190906153948.2160342-1-arnd@arndb.de> <7abad95e-ea47-c068-d91c-ba503f2530b9@citrix.com>
In-Reply-To: <7abad95e-ea47-c068-d91c-ba503f2530b9@citrix.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Sep 2019 18:00:19 +0200
Message-ID: <CAK8P3a1qkMLW_Wnn-N0seUw4N5bPwTU7Dy7CwOWxzS6NTnTmiQ@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH] ARM: xen: unexport HYPERVISOR_platform_op function
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Denis Efremov <efremov@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 5:55 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 06/09/2019 16:39, Arnd Bergmann wrote:
> > HYPERVISOR_platform_op() is an inline function and should not
> > be exported. Since commit 15bfc2348d54 ("modpost: check for
> > static EXPORT_SYMBOL* functions"), this causes a warning:
> >
> > WARNING: "HYPERVISOR_platform_op" [vmlinux] is a static EXPORT_SYMBOL_GPL
> >
> > Remove the extraneous export.
> >
> > Fixes: 15bfc2348d54 ("modpost: check for static EXPORT_SYMBOL* functions")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Something is wonky.  That symbol is (/ really ought to be) in the
> hypercall page and most definitely not inline.
>
> Which tree is that changeset from?  I can't find the SHA.

This is from linux-next, I think from the kbuild tree.

       Arnd
