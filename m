Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C132EC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94ACA207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ziI1PEzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388919AbfJCUhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:37:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51401 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387407AbfJCUhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:37:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so3364666wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63ds3t73ZrLj3HbV7qUiVgBUuKHqGbWcEjyWgIzskeE=;
        b=ziI1PEzAwuBD/3nwpmQYYXYslTYque2zlEKkMbUyCSw6dlHNV7kB9VAwWgpRurXKN7
         mcDYAmcUhP4bsEqTOLOp0AbA///bwWtKdAP/Z4MthfJQ7kRwHGtBp/lb5UwXguNCgPoQ
         XmUHs1ODk2abTw3MeluecZg+IkWrkJz2mOg6Bqe57LEJevWeEp5tbIi/eMMHn8HSabf2
         YW0j13DLGMF/JF9q0OleDgrOgI+RugOdwOC8B6IAI1lj+J99cQtrssH0cvuTSLNOtufV
         TygGCxlOyWqws2dM4Ux9YWbSh8RVGOp0uKQ7MXo2dt9pqR5oK7lRKvzZmCkPE4o9i2d/
         uo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63ds3t73ZrLj3HbV7qUiVgBUuKHqGbWcEjyWgIzskeE=;
        b=pqBhxzulcfu0n4kjhSJ5+bEsN9DL5Hp++k5VIZMHs08AVwK/J761BYeIQHgVIJG7Y/
         6T93MtFtITkZBozsXNCWALH2vLl7P+NxSyJ3kgxIh79jCayI56nMOzmMp/ka2ynwig2M
         IBNPu9K/1uGdsOMFt9lJ4g2ITgy1O47kghG79zVWFLiHGPl6CvzvwywMBs500HrYMKzK
         O1+l+jHGDVunPRyBcVBnndn1ExDqWwqmeLBkdHA3FGCtntVUxd8qGyBYbY+dEZNCrjj4
         ozIcjbMAurXOHidSfYyZ+OZLB2ACjczW2GMvu8SmXqQ9Fzo8L5qfu9vZRlHPhybjA9LW
         AVpw==
X-Gm-Message-State: APjAAAUXSS+xrlEzIGt31+/pD3BK4jiGdl93xe1cejE6kKjAN0x8Hgfx
        8sFqyY1qEbV22RtvYTw6OXVmc9WRmJTbd8XxagzMtg==
X-Google-Smtp-Source: APXvYqzVrVcXrzwTGscDiiPv6l+aU2YRfAhMTVv5NfavOPgIBNOF2oVCTqQSyYHsCIQ6dv7jqQDIQMnq8Lmtfdlg0qI=
X-Received: by 2002:a1c:9988:: with SMTP id b130mr8527379wme.164.1570135036923;
 Thu, 03 Oct 2019 13:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191002231617.3670-1-john.stultz@linaro.org> <20191002231617.3670-3-john.stultz@linaro.org>
 <2e369349-41f6-bd15-2829-fa886f209b39@redhat.com>
In-Reply-To: <2e369349-41f6-bd15-2829-fa886f209b39@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 3 Oct 2019 13:37:04 -0700
Message-ID: <CALAqxLVcQ7yZuJCUEqGmvqcz5u0Gd=xJzqLbmiXKR+LJrOhvMQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] usb: roles: Add usb role switch notifier.
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 2:25 AM Hans de Goede <hdegoede@redhat.com> wrote:
> On 03-10-2019 01:16, John Stultz wrote:
> > From: Yu Chen <chenyu56@huawei.com>
> >
> > This patch adds notifier for drivers want to be informed of the usb role
> > switch.
>
> I do not see any patches in this series actually using this new
> notifier.
>
> Maybe it is best to drop this patch until we actually have in-kernel
> users of this new API show up ?

Fair point. I'm sort of taking a larger patchset and trying to break
it up into more easily reviewable chunks, but I guess here I mis-cut.

The user is the hikey960 gpio hub driver here:
  https://git.linaro.org/people/john.stultz/android-dev.git/commit/?id=b06158a2d3eb00c914f12c76c93695e92d9af00f

I'll resubmit again later with that patch included.

thanks
-john
