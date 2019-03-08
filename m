Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E54C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B553D20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bOwH6x1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfCHSLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:11:08 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55825 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfCHSLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:11:08 -0500
Received: by mail-it1-f196.google.com with SMTP id z131so22190225itf.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I/RIyMDMRA04S5aWWs16loHMHZpbVLTau9LoHCVoJXg=;
        b=bOwH6x1mXCOglpDerBKJdjMvFlc8js+6BAwO4ufcxbuWmq/kIHsPUeb+lOI1lEfz0p
         +HhAnfWJNLo2lWKwMugMjoErMMlk+ZlmVR8wcb6lhb0U7NXzW1r1MHym2XghNcJuDQIT
         /blZQIvdtfskttjGrZM1j/vydZMFJSzYGtOvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/RIyMDMRA04S5aWWs16loHMHZpbVLTau9LoHCVoJXg=;
        b=q8hxPp71kdLboOrcumllvH8un0NPDdOeGi3NF23kTifnoEiwkbYfEPGeW4ycjOmRuG
         Vxk5geD9uJuCr7w3M81XDai8Mg5cfP4VNfsmo2O6ExoWrsHhjvvsCTDkHAA4LXgV+gEq
         oWHvmHih7O4zVm9TdgJW55s6B8R0KUOIJhJ7RbKwUIezzHR02zbFBQ/ZSUSgXrOGQmBB
         UK2sUrmpFWkv9+XXfbD26wtB+I8lleYVGd6fv4eQk4hA4ltOxED0wTdC6ZbgrZJgIkDF
         NfQd8O2ILPL9Az0XllHNkKFlzcp/Ln3ck8d42ESN79EUzx1eYLFYryOA+AkkWWlD0ymA
         v9CQ==
X-Gm-Message-State: APjAAAWKtHiF7Yj/snUQ3OSfVn5Lkkbw5mpAHdr4ktSmO7r+y9KfhYqo
        A11CSpRPG5jV5cJfPClm+rWuHOjQJkoKi/u5oIiQlg==
X-Google-Smtp-Source: APXvYqxvaL0XRmaN2gznZ2QlHIBIem7DGWb8BII6djXynu6dHTTnwqLJQ5R95D92iQi2sQlpWEVHlClsO7Eu24+T8yI=
X-Received: by 2002:a05:6638:1a4:: with SMTP id b4mr11413661jaq.81.1552068667566;
 Fri, 08 Mar 2019 10:11:07 -0800 (PST)
MIME-Version: 1.0
References: <20190220233658.986-1-eric@anholt.net> <CAApk1dVubN7ME6GNuedGmF4V1qnH_JYnSEvFffAzwsMFaZNmgg@mail.gmail.com>
 <87o96l71im.fsf@anholt.net>
In-Reply-To: <87o96l71im.fsf@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Fri, 8 Mar 2019 18:10:56 +0000
Message-ID: <CAApk1dW8Du3C-7dz5UPQuRTk=NvQHW33q+Sia_nmm2n3JaN_mQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/v3d: Add support for V3D v4.2.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019 at 16:51, Eric Anholt <eric@anholt.net> wrote:
>
> Dave Emett <david.emett@broadcom.com> writes:
>
> > Sorry, a few things I thought of after sending the Reviewed-by email...
> >
> >> +       v3d->reset = devm_reset_control_get_exclusive(dev, NULL);
> >> +       if (IS_ERR(v3d->reset)) {
> >> +               ret = PTR_ERR(v3d->reset);
> >> +
> >> +               if (ret == -EPROBE_DEFER)
> >> +                       goto dev_free;
> > Might be preferable to make this explicitly check against the
> > not-found error code (whatever that is)? As in if (not found)
> > <fallback to bridge> else <return error code>. Similarly...
>
> You won't have both a bridge and an external reset controller in the DT,
> so I'm not clear on what functional change you're looking for.  You're
> just concerned about what the return code from this function is?
> -EPROBE_DEFER is the only one that matters from a probe, really.

I don't think it matters here. I just figured it should probably be
done the same way as the IRQ.

> >> +       if (platform_get_irq(v3d->pdev, 1) < 0) {
> > This should probably explicitly check for not-found rather than any
> > error. As-is, we might silently go down the single-interrupt-line path
> > on a platform with 2 interrupt lines if platform_get_irq(v3d->pdev, 1)
> > hits some other error.
>
> If I do the -EPROBE_DEFER check here, will that be good enough for you?

If that's the only other error we can get then sure. It wasn't clear
to me what errors might be returned from platform_get_irq.
