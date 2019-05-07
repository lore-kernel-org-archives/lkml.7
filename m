Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C566AC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967CE205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FdE5v5Nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfEGQZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:25:47 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40603 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEGQZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:25:47 -0400
Received: by mail-vs1-f65.google.com with SMTP id c24so3887948vsp.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZBHeLaF7S92v0l4QxOY+7+a7SVFf3e4IMU1a/EyhZU=;
        b=FdE5v5Nkjtfn+/19+R0Pk3wYCQgRQYC24hOLprsBD12gsCEw/431JDUAphm0qonEL4
         VRGScFvxEPxHEa4donrqLG9WEjBuCQEQw2IunnnzXAJctRb0o9c7zeZc9oktalXGCDgP
         Y9xq30nQkr7eKpuXyjdiYOywWimZcvZ86oVD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZBHeLaF7S92v0l4QxOY+7+a7SVFf3e4IMU1a/EyhZU=;
        b=mxc4q5qRgVxcZuOx4hGY7tSNjz+R46rXlUfMJci5ueMxmW7USe0BURek62Aafw8ZxL
         6+IfQrnypfAGBabWiQCImhcgwSbBA+H/ORx3Qe3jLtY2MdzhSaY0IMMaCFgJELzD7OGG
         98W3g0v56qDGpe2ucbk5W45CudsXoh1wVdte5B1rOdjrjuCeRhhhXxdqwwwQJ9JAwcMe
         MFxClXij8wWJYqCiK6w0Bt2my43LIr3RyAWsOsJYD7SS3v+N0L6J2sm4IsSBRQZ4EboH
         u/L+MTCZriXyo2xeS0t+zYhh+ZpRBUif42zSIkSOKipBN4RGl3UHfbA1HlJ0jZlklZSH
         0PvQ==
X-Gm-Message-State: APjAAAUBY2IXaJ81tDWoz8oe0w8IKQybvtzCKLkOlAMKZugcWT5L5UpI
        vBCIaDsLWDwpYvHFWz2brNidJRWRoeo=
X-Google-Smtp-Source: APXvYqwkXbJRKX83mISCzpuj9WufjzeJTCYEZ+p6qB3ka9Dn1dFKthozcDyu/4gSjE+1svPw3y34wQ==
X-Received: by 2002:a67:bc1a:: with SMTP id t26mr15883794vsn.23.1557246345971;
        Tue, 07 May 2019 09:25:45 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id w136sm1002845vkw.18.2019.05.07.09.25.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 09:25:44 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id v7so3945501ual.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:25:43 -0700 (PDT)
X-Received: by 2002:ab0:2692:: with SMTP id t18mr17168546uao.106.1557246342369;
 Tue, 07 May 2019 09:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190503174730.245762-1-dianders@chromium.org> <CA+ASDXOkHxYumCBv-T0gxTjdMVTu-c=33Lk-0TUgJ3WGUn2DVQ@mail.gmail.com>
In-Reply-To: <CA+ASDXOkHxYumCBv-T0gxTjdMVTu-c=33Lk-0TUgJ3WGUn2DVQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 May 2019 09:25:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UKTDFwq3PSdpPmShRcOtZaH1mU=2H-ynoG4VooV=rKVQ@mail.gmail.com>
Message-ID: <CAD=FV=UKTDFwq3PSdpPmShRcOtZaH1mU=2H-ynoG4VooV=rKVQ@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Improve backward compatibility with older Chromebooks
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 6, 2019 at 2:40 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Fri, May 3, 2019 at 10:48 AM Douglas Anderson <dianders@chromium.org> wrote:
> > When you try to run an upstream kernel on an old ARM-based Chromebook
> > you'll find that console-ramoops doesn't work.
>
> Ooh, nice! I still get annoyed by old depthcharge firmware. It's
> almost as if we should have gotten an upstream binding approved before
> baking it into firmware...
>
> > --- a/fs/pstore/ram.c
> > +++ b/fs/pstore/ram.c
>
> > @@ -703,6 +704,23 @@ static int ramoops_parse_dt(struct platform_device *pdev,
> >
> >  #undef parse_size
> >
> > +       /*
> > +        * Some old Chromebooks relied on the kernel setting the console_size
> > +        * and pmsg_size to the record size since that's what the downstream
> > +        * kernel did.  These same Chromebooks had "ramoops" straight under
> > +        * the root node which isn't according to the upstream bindings.
>
> The last part of the sentence technically isn't true -- the original
> bindings (notably, with no DT maintainer Reviewed-by) didn't specify
> where such a node should be found:
>
> 35da60941e44 pstore/ram: add Device Tree bindings
>
> so child-of-root used to be a valid location. But anyway, this code is
> just part of a heuristic for "old DT" (where later bindings clarified
> this), so it still seems valid.

I agree that it was unclear in the past, but it is true that being
under the root node is not according to the _current_ upstream
bindings, right?  ;-)


> >  Let's
> > +        * make those old Chromebooks work by detecting this and mimicing the
>
> s/mimicing/mimicking/

Kees: if you want me to spin with this typo fix then please let me
know.  Otherwise I'll assume it's less work for you to just fix it
yourself when applying.

-Doug
