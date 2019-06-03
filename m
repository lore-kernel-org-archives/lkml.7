Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56565C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD6825A57
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SV84aIFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfFCPXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:23:51 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40835 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfFCPXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:23:50 -0400
Received: by mail-vs1-f68.google.com with SMTP id c24so11486842vsp.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9judtLYfqHwUB7Dzm0O97CSTyEDxQ+ofDcdysxtxnb0=;
        b=SV84aIFwcxu5sQtz4Nc3vAuL8WayY9YwJpMXI/qPu6GbsJQr18rz8h9V7oHkhg0GP1
         xUP5txmTn1J8KStVFrf36YIhS03wm6GWKebOIreLtqeKZnZKA6k4NX9vKIl8vnHuI74D
         owyyEzL8cEjPTrp2WzUX3qTKDJdOlkpxMU7I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9judtLYfqHwUB7Dzm0O97CSTyEDxQ+ofDcdysxtxnb0=;
        b=eLmcphjLbDBk5HDE8p8udUlEzT8lO/TN47wFdv84tBBjWfS2xevzB2tyG5lXHFSBmS
         3ZIEsalULyiV9ELRl9Qs68YI6UJ0j76jjoG/EYhFnvvc0zQMLhwiEcyGudau3SDPafbO
         b49dbM14mzmCM4nqbma4HrSqt65XEGfFS+xxo24Mx82AnPXwB5+HGGhPTU1u9CfkO0GS
         dryPynCVsT6HNUlMarVbgl25XzsUI7DfTb8yMiiCHfcxMjHwLYdECNl7CdUUTUprJJEj
         VwshyEZFfscoJYV3FsT3TyYjUZ8cATBlA8Vl/nCvrzWt9NGX83DULbzFTh1Vco8J+rtJ
         EY4w==
X-Gm-Message-State: APjAAAVqUMO8tDkVILVYNZ4ptyGWmqUtLFyQh0qIs05V7L1aIcGeMNPL
        emixMsEvtBr2G52JI256etJHKFVSXAs=
X-Google-Smtp-Source: APXvYqy3OJhHRZXUUNPTCKyVpaDh0QZ2W0rZ7rQlU8oWiG+uYS3/2n13WYf93Ee95DxVfgIZFPirIA==
X-Received: by 2002:a67:ff8b:: with SMTP id v11mr13125737vsq.88.1559575429834;
        Mon, 03 Jun 2019 08:23:49 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id b7sm7735530uae.14.2019.06.03.08.23.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 08:23:48 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id z11so11466486vsq.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 08:23:47 -0700 (PDT)
X-Received: by 2002:a67:1cc2:: with SMTP id c185mr12704099vsc.20.1559575427301;
 Mon, 03 Jun 2019 08:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190507234857.81414-1-dianders@chromium.org> <79ca5499-6b7d-fe55-2030-283f5cfb1d27@rock-chips.com>
 <82480aa5-ab2e-11c5-8dd5-c395f72fc6e7@ti.com> <CAD=FV=Us1WyEqYDqVSuA+QPCDU7ceMEwwaWKtLz9ZNBFD0E7NQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Us1WyEqYDqVSuA+QPCDU7ceMEwwaWKtLz9ZNBFD0E7NQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 3 Jun 2019 08:23:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XfxT+GB=WvuGm68SaUWhSg7vS5AjQ-sv9e5wdKN7sFjQ@mail.gmail.com>
Message-ID: <CAD=FV=XfxT+GB=WvuGm68SaUWhSg7vS5AjQ-sv9e5wdKN7sFjQ@mail.gmail.com>
Subject: Re: [PATCH] phy: rockchip-dp: Avoid power leak by leaving the PHY
 power on
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Caesar Wang <wxt@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Lin Huang <hl@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Derek Basehore <dbasehore@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "nickey.yang (nickey.yang@rock-chips.com)" 
        <nickey.yang@rock-chips.com>, wzz <wzz@rock-chips.com>,
        Huang Jiachai <hjc@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 3, 2019 at 8:22 AM Doug Anderson <dianders@chromium.org> wrote:
> > Can someone in Rockchip try to find the root-cause of the issue? Keeping the
> > PHY off shouldn't increase power draw.
>
> It sounded like Chris already answered this, though?  Basically things

Doh!  Don't know why I said Chris when it was clearly Caesar that
answered.  Sorry Caesar!

-Doug
