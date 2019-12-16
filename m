Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E531C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059B020726
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXv6nwlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLPQKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:10:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36105 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfLPQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:10:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so428758wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 08:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wBlvcCO8Ml/H3509NAX+qSULZon7Go2sxTKRNZ2ctvE=;
        b=cXv6nwlv5pmdDWI5Y7fvYBC08HVao0ujeoZ+7ojLX6RoCDn8hreHedCs3lAgk0Gk/1
         UHW3JvpWt+pi/gzHwcOvv05kCPRivGFMzcHyMcYP0x35zcal9iIdwDatmGkcF5fcQ6Xs
         VBY8rQawpt+crj27oTb9ERdm/cu8IMc5iKJWzLYMu/ROqZaWhXSo/iSTzLK5L6+T7kz5
         vzU8CftoZwUEP4SDSneANgLgQ8v1+lwSWYMjy/hIOtryfimxrX1odtPyTx0+4bqQNFEa
         2eJkifCe0okcSE/VE71ZqbBTpPzP8FFPc+tXIK6kL8zAPr47XlZAkzPidGzT3wtnFD9/
         D4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wBlvcCO8Ml/H3509NAX+qSULZon7Go2sxTKRNZ2ctvE=;
        b=WpFkNK1Hbb4757Hfl6NpsOw6d3L7l22CrPTOKWDuLXn1u8SfGo9C33SbzOIlaNq/sh
         GkVQr3tlOv7LI0sMJ9hRa4dYjksClxSFBO0dF60qN11jR/35qDzJdb2nGIxpPML5gUYi
         CL0jzxKr1l22NjU7qsnekckOzpkX0D35Is8wtBzNuGsOBdg7hJXMDIkZmNXAinwxK+g4
         n0x8PX7cCovmkk2qbnlwXN8xwBS/szzOCRqRt8tcbq929KrYwja8kbhuFZtuqvLtCoPk
         KzXNVsa8i3Xh183oI1VpeDxTjsYP/8hNCeRoPDpBuANIPvCKnl4shBGgHk7ykB4yy/cH
         L6Sg==
X-Gm-Message-State: APjAAAWmf4jOAMkqS5CfL4Y7qwmQp8kTPo9BeI8/31mMguaR61qEV10Q
        LwjKibotb+zdLSPXedgb59JqiQ==
X-Google-Smtp-Source: APXvYqx5XSE4BmIOlkRofxhble/1rYpcYC58fzYcnPbCJdxQ+lw+Sz3KW8autUMHTKtkQigKTBxOnQ==
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr30755356wrn.280.1576512617135;
        Mon, 16 Dec 2019 08:10:17 -0800 (PST)
Received: from dell ([185.17.149.202])
        by smtp.gmail.com with ESMTPSA id f1sm21916406wro.85.2019.12.16.08.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 08:10:16 -0800 (PST)
Date:   Mon, 16 Dec 2019 16:10:15 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 0/5] drm/i915/dsi: Control panel and backlight enable
 GPIOs from VBT
Message-ID: <20191216161015.GM2369@dell>
References: <20191215163810.52356-1-hdegoede@redhat.com>
 <20191216121840.GS32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191216121840.GS32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019, Andy Shevchenko wrote:

> On Sun, Dec 15, 2019 at 05:38:05PM +0100, Hans de Goede wrote:
> > Hi All,
> > 
> > This is a new (completely rewritten) version of my patches to make the
> > i915 code control the SoC panel- and backlight-enable GPIOs on Bay Trail
> > devices when the VBT indicates that the SoC should be used for backlight
> > control. This fixes the panel not lighting up on various devices when
> > booted with a HDMI monitor connected, in which case the firmware skips
> > initializing the panel as it inits the HDMI instead.
> > 
> > This series has been tested on; and fixes this issue on; the following models:
> > 
> > Peaq C1010
> > Point of View MOBII TAB-P800W
> > Point of View MOBII TAB-P1005W
> > Terra Pad 1061
> > Thundersoft TST178
> > Yours Y8W81
> > 
> > Linus, this series starts with the already discussed pinctrl change to
> > export the function to unregister a pinctrl-map. We can either merge this
> > through drm-intel, or you could pick it up and then provide an immutable
> > branch with it for merging into drm-intel-next. Which option do you prefer?
> > 
> > Lee, I know you don't like this, but unfortunately this series introcudes
> > some (other) changes to drivers/mfd/intel_soc_pmic_core.c. The GPIO subsys
> > allows only one mapping-table per consumer, so in hindsight adding the code
> > which adds the mapping for the PMIC panel-enable pin to the PMIC mfd driver
> > was a mistake, as the PMIC code is a provider where as mapping-tables are
> > per consumer. The 4th patch fixes this by moving the mapping-table to the
> > i915 code, so that we can also add mappings for some of the pins on the SoC
> > itself. Since this whole series makes change to the i915 code I plan to
> > merge this mfd change to the drm-intel tree.
> 
> FWIW, Lee, I believe there will be no (significant) changes in the driver Hans
> touched. For the record it seems only Hans is touching drivers for old Intel
> platforms (such as Baytrail and Cherryview).

More exceptions, yay!

Again, in *this* case, it's probably fine.  What I want to know is;
what happens when it's not fine?  What happens when you or someone
else starts changing MFD and DRM on more active files?  Then I will
have to insist on an immutable branch.  So it would be better for the
DRM tree to be able to handle that use-case sooner rather than later,
regardless of who has the most churn.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
