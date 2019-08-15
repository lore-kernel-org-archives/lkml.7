Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59001C3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286BE2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lKumc5s3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbfHOU0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:26:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41451 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731800AbfHOU0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:26:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id m24so3323768ljg.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 13:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMu2C04ftY81TYFCnc8lXX04zGDDGOcRI0zFGGiMOC0=;
        b=lKumc5s3VZUto1TE0iTCoHL9TAw+ySrWt4qf38RzqlZOcyiAiHQ3yabZ1IX6Mb/ilK
         vdH98kxp4z3xxBRqOFO8Ligh5CG7U1ddsStwqBCkgBoU+bv4ICOpIWoQMyOEo5D1l7A/
         wdiZ49xHK3w2p3ZZSJivn2hJZ/j+dfn10VKHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMu2C04ftY81TYFCnc8lXX04zGDDGOcRI0zFGGiMOC0=;
        b=UVk2ch4RpB2qRHUuWovUr0gy1OydN9LQXWBLAO/1u7WWiZDK1Je5n38ZhwlwtVpKGq
         6nGLKLYtYzpOMZBQwCBxrWEU2WanyXrBfXUujlnEUm1TJ+Ee3M8GZ7G7kx1j3ioQEIv1
         r9ccsc39iiOwy8hXo4PaWC4+3m/C+GiavyUBa98JpvAgQ0ZAmNjHiHdHovU7RAZRPuJ1
         qmHHSvR9a345+Acc9vZK0WOWN9ogGLE9xneSEG6fixiOM4KxJwoFvHSBCJOnyIkl5GMd
         2aZ5LDwwvUfvmfwvIbESGXFhDt7NX6kB3v3LAFUrincglLDQVWWO5IL5nU68PkzaELZC
         JapQ==
X-Gm-Message-State: APjAAAVjnIbJHk+fRTp3pHV8AetpQ77ojS7aHva0Ds6dqVtdT++I40f0
        VdIJRUrruCXlBV9BXwmn7xws4fIKn3w=
X-Google-Smtp-Source: APXvYqw0WQPcuZ7Ra40qG66paPYM8M3IeSTHK2ScU2XRHpwtab9EDSSAgcfFUUIbEJo6ousa0vTGXg==
X-Received: by 2002:a2e:9bc1:: with SMTP id w1mr3532203ljj.168.1565900759835;
        Thu, 15 Aug 2019 13:25:59 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id o3sm602878lfb.40.2019.08.15.13.25.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 13:25:58 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id x3so2518314lfn.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 13:25:58 -0700 (PDT)
X-Received: by 2002:a19:ed11:: with SMTP id y17mr3283567lfy.141.1565900757828;
 Thu, 15 Aug 2019 13:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190709161550.GA8703@infradead.org> <20190710083825.7115-1-jian-hong@endlessm.com>
In-Reply-To: <20190710083825.7115-1-jian-hong@endlessm.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 15 Aug 2019 13:25:46 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOgCHzAfyQDAGhkFZMO4UaXfrnpkN9a95jzfQY_L+EbAg@mail.gmail.com>
Message-ID: <CA+ASDXOgCHzAfyQDAGhkFZMO4UaXfrnpkN9a95jzfQY_L+EbAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rtw88: pci: Rearrange the memory usage for skb in
 RX ISR
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux@endlessm.com, Daniel Drake <drake@endlessm.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I realize this already is merged, and it had some previous review
comments that led to the decisions in this patch, but I'd still like
to ask here, where I think I'm reaching the relevant parties:

On Wed, Jul 10, 2019 at 1:43 AM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
...
> This patch allocates a new, data-sized skb first in RX ISR. After
> copying the data in, we pass it to the upper layers. However, if skb
> allocation fails, we effectively drop the frame. In both cases, the
> original, full size ring skb is reused.
>
> In addition, by fixing the kernel crash, the RX routine should now
> generally behave better under low memory conditions.
>
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=204053
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> Cc: <stable@vger.kernel.org>
> ---
> v2:
>  - Allocate new data-sized skb and put data into it, then pass it to
>    mac80211. Reuse the original skb in RX ring by DMA sync.

Is it really wise to force an extra memcpy() for *every* delivery?
Isn't there some other strategy that could be used to properly handle
low-memory scenarios while still passing the original buffer up to
higher layers most of the time? Or is it really so bad to keep
re-allocating RTK_PCI_RX_BUF_SIZE (>8KB) of contiguous memory, to
re-fill the RX ring? And if that is so bad, can we reduce the
requirement for contiguous memory instead? (e.g., keep with smaller
buffers, and perform aggregation / scatter-gather only for frames that
are really larger?)

Anyway, that's mostly a long-term thought, as this patch is good for
fixing the important memory errors, even if it's not necessarily the
ideal solution.

Regards,
Brian
