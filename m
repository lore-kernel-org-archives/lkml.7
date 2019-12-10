Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D14DC04E30
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1410206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BqPM+szU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfLJAcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 19:32:04 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:33479 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfLJAcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 19:32:03 -0500
Received: by mail-pg1-f177.google.com with SMTP id 6so7982647pgk.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 16:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8evBcz4lmmsnelwBpdcYncDfyag5sO5/iQnS/q4ZdNE=;
        b=BqPM+szUPCtHdlyak+LwpzgEOtKX16NXvlBrqw1oVUryWfUXIp90VOF1E3XkoVSLjL
         v43BwyV/WnDbyLBsEZMyFSgvd8sh7K15AHZDwGGW9fVSBDAMrcJfF4lspFglA1wMfeNw
         Qwfz05tPp/L9QkOyXdxyRhCYxNV9FKbcWrf3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8evBcz4lmmsnelwBpdcYncDfyag5sO5/iQnS/q4ZdNE=;
        b=qR90coV0qUF4UJaax/S25N7+eLHvLxjkg8odr9rm8XnfvYdN8hqC+pTBJ8m/2oXcds
         S0GZBUFJUduImZO4WkU0eE4WnfTgNj7QATRp+8rytpEvOoBOxFYAJxs/lgyp9FcEBQYG
         Ub196Lv8T4t1ecgwIGr19yLYMnVjIWUzSB2pk78yJLbHo85pbnFFE93G8zhEWUY3BxMV
         S23dAl31xGVS3YWltqXEAeqoz9T2L+k8wWsqgS+d6BkTWgrhjTruBmFrPUDqiNGWjSiK
         Ic/i09q73K8kYzVuGa4V0Yzp0bnJotY/+TTY7Sy5nClIeemBZ772OpLHcMZiQ8wO7/Cw
         ADjQ==
X-Gm-Message-State: APjAAAX7SM0zSR3G/CvnVMObV6DTjaok1Q/Mu9H/mfdiR9FMpLZF8BTV
        h3wvmNNR21/4vREcXkYbpuLpXQ==
X-Google-Smtp-Source: APXvYqy4D9BE4heIvg/4fO4ARmu8vxDMpm3JJunhQwLtFR2lpNylP9ta2onTMh67OOu6CvvoPTIJWg==
X-Received: by 2002:a62:a117:: with SMTP id b23mr33014552pff.174.1575937923008;
        Mon, 09 Dec 2019 16:32:03 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id m45sm461387pje.32.2019.12.09.16.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 16:32:02 -0800 (PST)
Date:   Mon, 9 Dec 2019 16:32:01 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/1] ARM: dts: rockchip: Add brcm bluetooth for
 rk3288-veyron
Message-ID: <20191210003201.GR228856@google.com>
References: <20191127223909.253873-1-abhishekpandit@chromium.org>
 <20191127223909.253873-2-abhishekpandit@chromium.org>
 <61639BAF-5AA0-4264-906F-E24E2A30088D@holtmann.org>
 <1788857.Va9C3Z3akr@diego>
 <CAD=FV=Xdrw1FC=DktQ8HjdEJcCKvdA3sx78gg-rn8=bBq=WrEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Xdrw1FC=DktQ8HjdEJcCKvdA3sx78gg-rn8=bBq=WrEw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 03:56:14PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Sun, Dec 8, 2019 at 4:03 PM Heiko Stübner <heiko@sntech.de> wrote:
> >
> > Am Montag, 9. Dezember 2019, 00:48:31 CET schrieb Marcel Holtmann:
> > > > This enables the Broadcom uart bluetooth driver on uart0 and gives it
> > > > ownership of its gpios. In order to use this, you must enable the
> > > > following kconfig options:
> > > > - CONFIG_BT_HCIUART_BCM
> > > > - CONFIG_SERIAL_DEV
> > > >
> > > > This is applicable to rk3288-veyron series boards that use the bcm43540
> > > > wifi+bt chips.
> > > >
> > > > As part of this change, also refactor the pinctrl across the various
> > > > boards. All the boards using broadcom bluetooth shouldn't touch the
> > > > bt_dev_wake pin.
> > >
> > > so have these changes being merged?
> >
> > not yet
> >
> > Doug wanted to give a Reviewed-by, once the underlying bluetooth
> > changes got merged - not sure what the status is though.
> 
> I have been out for the last week and am a bit backlogged.
> 
> I notice that this landed in our 4.19 kernel with +Matthias's
> Reviewed-by at <https://crrev.com/c/1772261>.  I don't feel any need
> to re-review this myself if Matthias has taken a final look on it, so
> unless he knows a reason why it shouldn't land then I'd say go ahead
> and land it.

Sorry, should have replied here in the first place. The changes look
good to me.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
