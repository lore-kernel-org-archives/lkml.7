Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5531C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D411208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVP3PUMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392030AbfFLOhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:37:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40393 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfFLOhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:37:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so6796810wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VplAio+sVK07Pjxzj2QfGPoBuAFyvNhZScCOrRSlmOg=;
        b=nVP3PUMAQmhGKeeuGgz8Msy+BotU4EfAKloaSSbTZS/04Dv1nuQy5HM0flUpAJLf63
         hCvO2BkTA/nIGw0uvr+0sO0iOkzgeqVQiOyCzm7Vt0Gnn45NZzOEqpcP/JB3mA/A2l8d
         XYlGjAQ2GlDNrEWBXb0IWGfTXw2N9a8dlCkI4jO0DddDbtBEULqP80gmxATKN+RYXHfE
         jIQ2aanTGu4ukWHT2RpirFhCZgua9zVcBffn3W8f9ZFIqjICLfpDVP/6OXMjYPO4p32p
         QQIPBhP89gQidkHFDWA4pOyE29eGsMUDqsGh6YArjEFESsrizbL0wnGiS0im0p8NI3PV
         zTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VplAio+sVK07Pjxzj2QfGPoBuAFyvNhZScCOrRSlmOg=;
        b=fjZIvc26QNQCi263mfidKOIPRQDRtFk6tWy6TeFeDPAPvodsaY12Z/D9tjgICiktt8
         R92K1Ktk8uO5fcay0vh1NAZR86VZsFaEfRn5ircN2X4C8a4y/sT6R+ZagKVqG4Yine67
         ovbzWiSAcaCCGn6DevQU8apo01pyq16PvBdbgXmSz0uq5MV4/t+NPTdYJENydhX0hrq0
         GxStoGA2IO4vdGCoLO7UWOTD3s6uFFiC7WYAv7qwVh4GTnER8VCvCpawmkFpWaScq87x
         ljwp9ta1lHeAdj//tuPO7TTpvqcu88nm6O/MoUbgudK67zpnxqEHqz3vBzfNmZwNVpfC
         WVlQ==
X-Gm-Message-State: APjAAAVEAiF2/0I6o3F+I9Q/X3ObDF73/b7inZG+ZJX7cPNBC5zkGUqe
        I+lsjSZvn05l8yv4ccj6FmO5ew==
X-Google-Smtp-Source: APXvYqyXpn/hJQn+QAdkpG+PAOIVfZytwEwBa6XdlVWbIPJzEymxH5QfmHeEMsWdDJ8I8TFh442WNg==
X-Received: by 2002:a1c:a541:: with SMTP id o62mr3196842wme.84.1560350238120;
        Wed, 12 Jun 2019 07:37:18 -0700 (PDT)
Received: from dell ([185.80.132.160])
        by smtp.gmail.com with ESMTPSA id j7sm24764543wru.54.2019.06.12.07.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 07:37:17 -0700 (PDT)
Date:   Wed, 12 Jun 2019 15:37:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        benjamin.tissoires@redhat.com, jikos@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, agross@kernel.org, david.brown@linaro.org,
        hdegoede@redhat.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] HID: quirks: Refactor ELAN 400 and 401 handling
Message-ID: <20190612143715.GC4660@dell>
References: <20190606161055.47089-1-jeffrey.l.hugo@gmail.com>
 <20190606161322.47192-1-jeffrey.l.hugo@gmail.com>
 <20190612003507.GG143729@dtor-ws>
 <2282f3e1-e76a-4fe7-d447-51d9a4bee2de@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2282f3e1-e76a-4fe7-d447-51d9a4bee2de@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019, Jeffrey Hugo wrote:

> On 6/11/2019 6:35 PM, Dmitry Torokhov wrote:
> > On Thu, Jun 06, 2019 at 09:13:22AM -0700, Jeffrey Hugo wrote:
> > > There needs to be coordination between hid-quirks and the elan_i2c driver
> > > about which devices are handled by what drivers.  Currently, both use
> > > whitelists, which results in valid devices being unhandled by default,
> > > when they should not be rejected by hid-quirks.  This is quickly becoming
> > > an issue.
> > > 
> > > Since elan_i2c has a maintained whitelist of what devices it will handle,
> > > use that to implement a blacklist in hid-quirks so that only the devices
> > > that need to be handled by elan_i2c get rejected by hid-quirks, and
> > > everything else is handled by default.  The downside is the whitelist and
> > > blacklist need to be kept in sync.
> > > 
> > > Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> > > ---
> > >   drivers/hid/hid-quirks.c | 78 ++++++++++++++++++++++++++++++++++------
> > >   1 file changed, 67 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> > > index e5ca6fe2ca57..edebd0700e3d 100644
> > > --- a/drivers/hid/hid-quirks.c
> > > +++ b/drivers/hid/hid-quirks.c
> > > @@ -912,8 +912,66 @@ static const struct hid_device_id hid_mouse_ignore_list[] = {
> > >   	{ }
> > >   };
> > > +/*
> > > + * List of device names that elan_i2c is handling and HID should ignore.  Must
> > > + * be kept in sync with elan_i2c
> > > + */
> > > +static const char *hid_elan_i2c_ignore[] = {
> > 
> > If this is a copy of elan whitelist, then, if we do not want to bother
> > with sharing it in object form (as a elan-i2c-ids module), can we at
> > least move it into include/linux/input/elan-i2c-ids.h and consume from
> > hid-quirks.c?
> 
> I can put it in a shared header file, however elan-i2c and hid-quirks
> would need to be updated in the same change to prevent a breakage, but
> that would seem to violate a concern Benjamin brought up in v4 given
> that elan-i2c is maintained in your input tree, and hid-quirks is
> maintained in his hid tree.
> 
> Are you ok with the elan-i2c changes going through Benjamin's hid tree?

We co-ordinate cross-subsystem merges all the time.  That is never a
reason to not do the 'right thing (tm)'.  If this information can be
held in a single, central place, without the need for constant
re-alignment, I'm all for it.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
