Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D36C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF1220828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WshX47/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfCZB3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:29:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36636 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfCZB3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:29:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so8544296ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 18:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZ35Xy4PU+zip7eaXREZBPw60SejgCioJq+S9y11G9s=;
        b=WshX47/Z+cdQzSCCEyS+1jX7/hTLehuupOb5hPro32oqcKVgXVmmAwkPfoooxd3Fgb
         KrRuVdjN610h4f3Bd5broUTEkZYNocPB/9FBkU5icxzENeSMcdgvJ7h1EpUiwrbtvN7V
         QJB6tBRmoJpZG5t4ASA4SKaf26J7WNy9NsaPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZ35Xy4PU+zip7eaXREZBPw60SejgCioJq+S9y11G9s=;
        b=C2WSu9YmCIgYB81U+FW8T7dZr3ipJwko+nf73Sy+OmCMMhE8vWo1JYHE0jWFcmAEze
         NqPPjn04Qbl01vtBo3VuD2a3svENJ5A/R176y5s/xBi2/Y1IlSA4owr1M5yijuycTI++
         5SgdTwnOsODmBVYsXrnUgB1Jjwk/9qfMh/RjLaa0JBfFFaiqTjylc788+ML6qu1+97jW
         vo4f1IHTewLvi04QLbrUhCejqig2JjUMGUZt4QNGFzo1g0Bl6LX9oV6m7osQyji4XMD9
         s0D8sTXb1ryAffR9MkTFyd/tmirhtdi+ITuLBRNZ73B2hFs9bnkuHlRyA/W0cmsO9gJx
         6syw==
X-Gm-Message-State: APjAAAXiqffyWb/S/ukBZb+YHj7favwlYR2cnww4hlc93Gr7RcpMMGEs
        JG9aDvVheI6RpsK2KLxZFnQwX5Kkyss=
X-Google-Smtp-Source: APXvYqz2W6avdW6A4UY/+Tf6Jm0V5woLouDlB3Yp1HSSLSENL0QJ0Kstvuf4LNN6fIulvpkKg8PMJw==
X-Received: by 2002:a2e:8089:: with SMTP id i9mr14393593ljg.137.1553563753098;
        Mon, 25 Mar 2019 18:29:13 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id q67sm764066lje.41.2019.03.25.18.29.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 18:29:11 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 10so7417560lfr.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 18:29:10 -0700 (PDT)
X-Received: by 2002:ac2:569b:: with SMTP id 27mr14789802lfr.24.1553563750269;
 Mon, 25 Mar 2019 18:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214730.6545-1-valleau@chromium.org> <44e151af-b6c4-d0af-3ef1-a5632d079915@kernel.org>
 <CA+ASDXMcnEfZzTjDGsDbZxX2Xknv6dt3H-3kN79WdKFzif2zsA@mail.gmail.com>
 <caee30e2-ddc4-0076-907e-558dbcfe7c52@kernel.org> <CA+ASDXOzTkXk_JtBDa4zkMhy3NyWv7Wn1i6YYtwRdeF8j_c2nA@mail.gmail.com>
 <23918a77-2694-fdae-4300-0882c7c940cf@kernel.org> <CA+ASDXOEkG36W-6rONqDntzChtq65=cQh6JVyjWhftBykXVTbw@mail.gmail.com>
 <20190326001353.GA4315@kroah.com> <CA+ASDXMR_HPSnAWRGYV_fDq6kSR7WdgTq3pgW9VaTwA7fA7=qA@mail.gmail.com>
 <20190326005509.GA32180@kroah.com>
In-Reply-To: <20190326005509.GA32180@kroah.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 25 Mar 2019 18:28:58 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM7eGvvSSP8SM+hH+mNbhaFXLw+h0Ra0friKmChqdr6PQ@mail.gmail.com>
Message-ID: <CA+ASDXM7eGvvSSP8SM+hH+mNbhaFXLw+h0Ra0friKmChqdr6PQ@mail.gmail.com>
Subject: Re: [PATCH] tools: usb: usbip: adding support for older kernel versions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     shuah <shuah@kernel.org>, David Valleau <valleau@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 5:55 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> To be honest, with the USB3 support added to usbip, no one noticed that
> things broke, and the fact that it took 4 years to notice implies that
> maybe it wasn't that big of a deal as no one used this.

Again, the last breaking change (USB3 support) was in v4.13 (2017 Sept
release date). One of the other changes was a security fix and went to
-stable, so I could imagine fewer people being upset.

> But, as you
> show, that assumption was not correct, so if we can fix things, we
> should.

Well, we "can" -- it's not too hard to parse the header to figure out
which version is in use -- but it's a bit ugly (see $subject patch). I
wonder if some of that should just be discarded and we give up on
sufficiently old kernels, since it's not immediately clear to me
whether David's patching to account for commit 0775a9cbc694 ("usbip:
vhci extension: modifications to vhci driver") is correct. (I'm not
that intimately familiar with usbip.)

> Did that help?

Yes, thanks. I was mostly hoping you weren't trying to say "vhci /
usbip are toys and shouldn't be treated seriously."

I think I mostly agree with what you're saying, and I don't think we
should place a lot of undue burden on maintaining old compatibility
for too many years, especially on stuff that wasn't very well thought
out in the first place. But I think it's a valid forward-looking goal
to avoid doing this sort of stuff again with no good reason.

Brian
