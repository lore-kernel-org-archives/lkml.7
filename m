Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBF4C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7612171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eyhVxxo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfDLSC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:02:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41858 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfDLSC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:02:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so5553086pgs.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=S+H4OZ/XxRElDLqv3IW/VMLs9qpYjEmorStnxnx/F4Y=;
        b=eyhVxxo1dKssj7vGt0KmlMi87MjvK2GDOC5vfU5whsJKeom/a2LaJNYwnkYhyHop21
         YbxAidjVfLdicVm0lsHOarTJNePejS2UY3+eM5ROyxDylX4I40KuNGt6dBzrpEuS/bAo
         CeU5HUMFBHAA5NPMI8lfMPde13IPcvY2EgvtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=S+H4OZ/XxRElDLqv3IW/VMLs9qpYjEmorStnxnx/F4Y=;
        b=O8pHDfACPogETiUESDVskqwpy4gDl8XTJTFUMlxJdBcu644E9DebT+YvUn6RSOScKo
         4WvHYB5vcfthvk9wBFpiyOYziCoeVSRdTUTs+IASS3PyoZDxiIVypVi07jas0zTup02W
         Ax2sH7dhmD5vN/5eMG+KUxNIRS1ZVPiwV96oMwHcaRhRT6lI18zobB3HkrNFyYfB7IvC
         jai0fa2QkIwMvUrPgNT7YMMmk4L4Al0eObHx8fpTTy7t89o4QNTrJ/Y4LBuq/hIIk3wr
         KB2jEYPKnniQU/AUgJp0lEHVhsu3gWb1LuWcYtLrGtnQtU7axX+FlqE7B3uXsyy7ip1a
         dw+g==
X-Gm-Message-State: APjAAAVOIuEifqKQxICUXaJkXyZnX5hQy2OedSoYF5/F8dmeU3Z/tttq
        XmUuvFbH01p5KWw2YtJgFA9A6w==
X-Google-Smtp-Source: APXvYqy6XIB4V6b5SYJngjhgqRFGiAB+cNvpjz2//g7Hrl4xUmISqdzEjHjWAqq/zAPIf2dpm9Rwbg==
X-Received: by 2002:a63:c84c:: with SMTP id l12mr54921891pgi.287.1555092176367;
        Fri, 12 Apr 2019 11:02:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v1sm68363079pff.81.2019.04.12.11.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 11:02:55 -0700 (PDT)
Date:   Fri, 12 Apr 2019 11:02:55 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] clk: rockchip: rk3288: Limit use of USB PHY clock to USB
Message-ID: <20190412180255.GW112750@google.com>
References: <20190411175917.173566-1-mka@chromium.org>
 <3787637.WUkDPpUsF8@diego>
 <20190412001657.GV112750@google.com>
 <2029012.W0xZ3ly3fY@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2029012.W0xZ3ly3fY@diego>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 11:30:37AM +0200, Heiko Stübner wrote:
> Am Freitag, 12. April 2019, 02:16:57 CEST schrieb Matthias Kaehlcke:
> > Hi Heiko,
> > 
> > On Thu, Apr 11, 2019 at 09:03:07PM +0200, Heiko Stübner wrote:
> > > Hi Matthias,
> > > 
> > > Am Donnerstag, 11. April 2019, 19:59:17 CEST schrieb Matthias Kaehlcke:
> > > > The USB PHY clock can be configured as (grand) parent of uart0_sclk and
> > > > sclk_gpu. It has been observed that UART0 doesn't work reliably in high
> > > > speed mode with the PHY clock as input when certain USB devices are
> > > > plugged to the USB HOST1 port (see https://crrev.com/c/320543).
> > > > 
> > > > Prefix the name of the PHY clock with a '.' in the non-USB muxes to
> > > > effectively remove the clock as input from these muxes.
> > > > 
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > ---
> > > >  drivers/clk/rockchip/clk-rk3288.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> > > > index 5a67b7869960..677bc5485201 100644
> > > > --- a/drivers/clk/rockchip/clk-rk3288.c
> > > > +++ b/drivers/clk/rockchip/clk-rk3288.c
> > > > @@ -200,8 +200,8 @@ PNAME(mux_aclk_cpu_src_p)	= { "cpll_aclk_cpu", "gpll_aclk_cpu" };
> > > >  PNAME(mux_pll_src_cpll_gpll_p)		= { "cpll", "gpll" };
> > > >  PNAME(mux_pll_src_npll_cpll_gpll_p)	= { "npll", "cpll", "gpll" };
> > > >  PNAME(mux_pll_src_cpll_gpll_npll_p)	= { "cpll", "gpll", "npll" };
> > > > -PNAME(mux_pll_src_cpll_gpll_usb480m_p)	= { "cpll", "gpll", "usbphy480m_src" };
> > > > -PNAME(mux_pll_src_cpll_gll_usb_npll_p)	= { "cpll", "gpll", "usbphy480m_src", "npll" };
> > > > +PNAME(mux_pll_src_cpll_gpll_usb480m_p)	= { "cpll", "gpll", ".usbphy480m_src" };
> > > > +PNAME(mux_pll_src_cpll_gll_usb_npll_p)	= { "cpll", "gpll", ".usbphy480m_src", "npll" };
> > > 
> > > In general I like to have things like the clock-tree described fully
> > > and let the kernel handle correct sourcing ... but:
> > > 
> > > As you write this seems like a systemic problem when just connecting
> > > random peripherals can create unstable clock source frequencies,
> > > so I tend to agree here ... but:
> > > 
> > > Can we please find a more "talking" name for this ... because as with the
> > > above someone will find the "." and submit a fix for it ;-) .
> > > 
> > > So just name it "unstable_dummy" or so?
> > 
> > I looked for some common pattern, but couldn't find one. I liked the
> > '.' since it leaves the name of the clock mostly intact, just hiding
> > it (similar to a leading '.' in a Linux file system). But I agree that
> > it might not be expressive enough. I still like the idea to keep the
> > clock name around for reference, maybe we could name it
> > "unstable:usbphy480m_src" or similar. If you don't object I'll send a
> > patch with this some time tomorrow.
> 
> I've just adapted the patch to use the new parent-name you suggested
> and applied it for 5.2 So no need to resend :-) .

Pefect, thanks!

I don't see the patch in the git.kernel.org repo (nor
https://lore.kernel.org/patchwork/patch/1060781/), looks like the push
is still pending.

Cheers

Matthias
