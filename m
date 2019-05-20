Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1622DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E2A206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZDuGf+wI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfETR5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:57:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37652 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfETR5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:57:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id r10so13837465otd.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l37zIVlCi4dbNDMGaFWNQ6h6zOWM8mlC8MVadX95qhk=;
        b=ZDuGf+wIJRM3SUZGnB5R5xtdCvh6zDqkd2hQEQlMJrnwn1aNAweMHsf9xJTipnH5Xm
         JZf3UZvTYWJlvaaVC3pYVCAC/YPgsGT0hFI1XlBBBwmfxPsN2niZv35FfsxOzbIDe8sL
         1oYbID6Y9SrEv12zWHhdJyfiOGNfn2VcH3VoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l37zIVlCi4dbNDMGaFWNQ6h6zOWM8mlC8MVadX95qhk=;
        b=XtSnN99RgWUG3WvqeiHBu6hGWA3PpOpEM7qDBz3dNiVWBScWpAEPsO0++lJP6PJ7o3
         eOOynxNIm7mOmVvc4OqRfLYl4VHqGR9w4Bjv/qe2uBvsPqB/W0WF/+GmZi9XS2JMg4C8
         asg76/i8TTOwTP5ezi//y/3W6utRVTEKdirzEZjzINpDhcgfuQ011TUGeklPPWtya9aY
         N9UmX7u0jnQpVMgiNTo6pt/Mk+hbKSlqtqa3iqHWdUtMOvA0RR0NH7Kc6oX/ERZ9e0af
         29Wc+UGmdpIN7hjt48b8f0IiNeTv7FuKKGDPnJ4gJIrcg4tJcrTeOjPqmNRNxt5LZZXm
         b15Q==
X-Gm-Message-State: APjAAAUZJHMUhqRp+8cFrepFk1wxeR7kBNdlpBZcSbE167Jg5Kojv084
        InAVzna/II/dByU7mXt+BX9OGgp8v87TGQ==
X-Google-Smtp-Source: APXvYqydfdSGXmjzNbRKhoR8E5GQe4fgJdwRQGWRzyIIb7FqjID4OOlwRo+l4kWTOe3vQgZihYUF3g==
X-Received: by 2002:a9d:7a59:: with SMTP id z25mr16146422otm.77.1558375071377;
        Mon, 20 May 2019 10:57:51 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id e184sm367658oia.28.2019.05.20.10.57.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 10:57:49 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id r136so10689270oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:57:49 -0700 (PDT)
X-Received: by 2002:a1f:a410:: with SMTP id n16mr8477054vke.73.1558375068277;
 Mon, 20 May 2019 10:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190516225941.170355-3-dianders@chromium.org> <201905201037.p3rNy0yX%lkp@intel.com>
In-Reply-To: <201905201037.p3rNy0yX%lkp@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 May 2019 10:57:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VOPAufL=u5iRCpO=Rdg--goZJ3jxM1znzyEXMTVBTFJg@mail.gmail.com>
Message-ID: <CAD=FV=VOPAufL=u5iRCpO=Rdg--goZJ3jxM1znzyEXMTVBTFJg@mail.gmail.com>
Subject: Re: [REPOST PATCH v2 2/3] USB: dwc2: Don't turn off the usbphy in
 suspend if wakeup is enabled
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        William Wu <william.wu@rock-chips.com>,
        linux-usb@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>, Chris <zyw@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Julius Werner <jwerner@chromium.org>,
        Dinh Nguyen <dinguyen@opensource.altera.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 19, 2019 at 7:08 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Douglas,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on balbi-usb/next]
> [also build test ERROR on v5.2-rc1 next-20190517]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Douglas-Anderson/Documentation-dt-bindings-Add-snps-need-phy-for-wake-for-dwc2-USB/20190520-033119
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git next
> config: x86_64-randconfig-h0-05191510 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    ld: drivers/usb/dwc2/platform.o: in function `dwc2_can_poweroff_phy':
> >> drivers/usb/dwc2/platform.c:545: undefined reference to `usb_wakeup_enabled_descendants'

Thank you.  Fixed in v3:

https://lkml.kernel.org/r/20190520175605.2405-1-dianders@chromium.org

-Doug
