Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07227C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DD021670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Om8Lq5NK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfIDJ1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:27:55 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55174 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfIDJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XKThuSbZFfZ7pl95l1VPO0wQKRiG+nLbFF9OeGTjtYM=; b=Om8Lq5NKTbiEdTpux26a7qCk5
        dZ5tJGlG6PK6Luh2tvZO7cMaOJLPmYev9eKKaC+piAWTYRoP3tQBsAX1v0z0Rmmf6HCqVQAkuV80k
        f9MovrDB/BdqRql6wDTRmwUw4C0xwquaK5wQ98nhINmsPydabgyv424kYP72LLxUYR/NFlWMA+5VY
        p9ygB+RVjjh9ozvrDrk/c83hko1T+Krs2RxUAUfeFFukYaxNLm/NHyAnrKbfhgsLJkyFZ4pfG+ZxA
        EzXEF67V3Av318bsLe0fW/7CVPA0qtAMOVbSUl4lU4N80WT/8hmoVpi0tao6OabLx64hmsNOLxnj7
        cqhKedPvQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39512)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i5RZb-0003Yi-2F; Wed, 04 Sep 2019 10:27:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i5RZP-0004Q3-GU; Wed, 04 Sep 2019 10:27:19 +0100
Date:   Wed, 4 Sep 2019 10:27:19 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Cheng-yi Chiang <cychiang@chromium.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, tzungbi@chromium.org,
        kuninori.morimoto.gx@renesas.com,
        Xing Zheng <zhengxing@rock-chips.com>, cain.cai@rock-chips.com,
        David Airlie <airlied@linux.ie>, sam@ravnborg.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Doug Anderson <dianders@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        =?utf-8?B?6JSh5p6r?= <eddie.cai@rock-chips.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Yakir Yang <ykk@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-rockchip@lists.infradead.org,
        Dylan Reid <dgreid@chromium.org>, kuankuan.y@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm: bridge/dw_hdmi: add audio sample channel status
 setting
Message-ID: <20190904092719.GJ13294@shell.armlinux.org.uk>
References: <20190903055103.134764-1-cychiang@chromium.org>
 <e1c3483c-baa6-c726-e547-fadf40d259f4@baylibre.com>
 <CAFv8NwKHZM+zTu7GF_J0Xk6hubA2JK4cCsdhsDPOGk=3rnbCZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFv8NwKHZM+zTu7GF_J0Xk6hubA2JK4cCsdhsDPOGk=3rnbCZw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 05:09:29PM +0800, Cheng-yi Chiang wrote:
> Hi,
> 
> On Tue, Sep 3, 2019 at 5:53 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >
> > Hi,
> >
> > On 03/09/2019 07:51, Cheng-Yi Chiang wrote:
> > > From: Yakir Yang <ykk@rock-chips.com>
> > >
> > > When transmitting IEC60985 linear PCM audio, we configure the
> > > Audio Sample Channel Status information of all the channel
> > > status bits in the IEC60958 frame.
> > > Refer to 60958-3 page 10 for frequency, original frequency, and
> > > wordlength setting.
> > >
> > > This fix the issue that audio does not come out on some monitors
> > > (e.g. LG 22CV241)
> > >
> > > Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> > > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > ---
> > >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 59 +++++++++++++++++++++++
> > >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h | 20 ++++++++
> > >  2 files changed, 79 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > index bd65d0479683..34d46e25d610 100644
> > > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > @@ -582,6 +582,63 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk)
> > >       return n;
> > >  }
> > >
> > > +static void hdmi_set_schnl(struct dw_hdmi *hdmi)
> > > +{
> > > +     u8 aud_schnl_samplerate;
> > > +     u8 aud_schnl_8;
> > > +
> > > +     /* These registers are on RK3288 using version 2.0a. */
> > > +     if (hdmi->version != 0x200a)
> > > +             return;
> >
> > Are these limited to the 2.0a version *in* RK3288, or 2.0a version on all
> > SoCs ?
> >
> 
> In the original patch by Yakir,
> 
> https://lore.kernel.org/patchwork/patch/539653/   (sorry, I should
> have added this link in the "after the cut" note)
> 
> The fix is limited to version 2.0.
> Since I am only testing on RK3288 with 2.0a, I change the check to 2.0a only.
> I can not test 2.0a version on other SoCs.
> The databook I have at hand is 2.0a (not specific to RK3288) so I
> think all 2.0a should have this register.
> 
> As for other version like version 1.3 on iMX6, there is no such
> register, as stated by Russell
> 
> http://lkml.iu.edu/hypermail/linux/kernel/1501.3/06268.html.

It's likely more to do with how the IP is configured rather than the
version.  The big difference between dw-hdmi used in iMX6 and elsewhere
is that iMX6 uses a built-in AHB audio interface and not I2S.  Elsewhere
uses I2S.

I2S does not have the capability to convey channel status information
(which is required by HDMI).  With AHB, it is encoded into the data in
memory.

So, I think this setup should be done in the I2S driver and not in the
core driver.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
