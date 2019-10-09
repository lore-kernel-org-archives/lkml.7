Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99960ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E7B20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVg5Ak5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbfJIRq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:46:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33896 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730503AbfJIRq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:46:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id k7so1409409pll.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MbE7z5W7ioIBLheoArWEi8ACV7BI03I7k7Tq4Oesang=;
        b=VVg5Ak5KU1xSdk0RBsT3k0A4/vZQLLZOjy/FBt3gQ5jOMQmJVTn7aaf515emr9ZUt6
         1HvIUeVU69kiIViKNdtj8vfctwpfq1Vv8naEzK0IzBYPHxg+/LoO8zoiUbjDfEXBRRue
         lAEY7AgLOYiX5wEadnk5EwphSPpfWp/tRmg7d8yEb3NZUiAdCP5f8p7lyKp5uZQm48ud
         qe2hlsiQYcW6PpWnf+VR7emr+ISqUhHf0r0k0CFOdxtfXWfFbfDtJNwAvBy3zmFcF/nc
         dgUzRn2CdPipSVV+D/pOUdjPm3SbmCgWNy14iG3Q7M/6jRb0kbWHaeTK4NcSJh4TqGN8
         I+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MbE7z5W7ioIBLheoArWEi8ACV7BI03I7k7Tq4Oesang=;
        b=T2M3bbuQgU7xMs3BcrFapjhEFzFaNcZLwJF0oYpFjdESQwgLf9to2GSRhkzE0b2lC8
         nT0LyXQcMeef8vXPTD+uGk/l7paxzOpmDlvgmEz70Oaf4smOTM4iq2NSO/+h3SI0Nb4A
         r7arITZSPUcxLB/TyBITH3cURmgtIOLP4x0MNP3MV5UjCRDURgtOiepOUpGC6FjIGogL
         7UHOuOVReCOF6ykms45UqoeLOE08jX1Q++0Y4vxeUYT0FBIsxzol5R3zEN7h47Jv7ZLr
         uHHCeUAqPc4NFE8vU+v7szM/MIckUf1R/pLr81pyaP6wIDkuUzDSUnCaZbK3MdrehpHg
         3GEg==
X-Gm-Message-State: APjAAAWtdDWMXkAR6o83XKfthyK5XoMrs9ZR83wBN/qMPllrYVF8g57C
        fbbgPXD48RgQ4/ryKPquiXSmOUaLUYM=
X-Google-Smtp-Source: APXvYqyvJU3vtruPnm2JedhdKvdF79YReSOkeMwZ4oW7uVcC2P2GKRZ7nSzCMKTocy+KCK8j1h4Gnw==
X-Received: by 2002:a17:902:209:: with SMTP id 9mr4621032plc.25.1570643186201;
        Wed, 09 Oct 2019 10:46:26 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a21sm2927273pfi.0.2019.10.09.10.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:46:25 -0700 (PDT)
Date:   Wed, 9 Oct 2019 10:46:22 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: Re: [PATCH v2 0/2] Avoid regmap debugfs collisions in qcom llcc
 driver
Message-ID: <20191009174622.GN6390@tuxbook-pro>
References: <20191008234505.222991-1-swboyd@chromium.org>
 <20191008235504.GN63675@minitux>
 <5d9d3ed4.1c69fb81.5a936.2b18@mx.google.com>
 <CAE=gft6SmWH3-Td-mZZPn-3=EzwexEdYTR00z5NCP-X1sspihA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft6SmWH3-Td-mZZPn-3=EzwexEdYTR00z5NCP-X1sspihA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09 Oct 09:01 PDT 2019, Evan Green wrote:

> On Tue, Oct 8, 2019 at 6:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Bjorn Andersson (2019-10-08 16:55:04)
> > > On Tue 08 Oct 16:45 PDT 2019, Stephen Boyd wrote:
> > > >     @@ drivers/soc/qcom/llcc-slice.c
> > > >
> > > >       static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
> > > >
> > > >     --static const struct regmap_config llcc_regmap_config = {
> > > >     +-static struct regmap_config llcc_regmap_config = {
> > > >      -        .reg_bits = 32,
> > > >      -        .reg_stride = 4,
> > > >      -        .val_bits = 32,
> > > >     @@ drivers/soc/qcom/llcc-slice.c: static struct regmap *qcom_llcc_init_mmio(struct
> > > >       {
> > > >               struct resource *res;
> > > >               void __iomem *base;
> > > >     -+        static struct regmap_config llcc_regmap_config = {
> > > >     ++        struct regmap_config llcc_regmap_config = {
> > >
> > > Now that this isn't static I like the end result better. Not sure about
> > > the need for splitting it in two patches, but if Evan is happy I'll take
> > > it.
> > >
> >
> > Well I split it into bug fix and micro-optimization so backport choices
> > can be made. But yeah, I hope Evan is happy enough to provide a
> > reviewed-by tag!
> 
> It's definitely better without the static local since it no longer has
> the cognitive trap, but I still don't really get why we're messing
> with the global v. local aspect of it. We're now inconsistent with
> every other caller of this function, and for what exactly? We've
> traded some data space for a call to memset() and some instructions. I
> would have thought anecdotally that memory was the cheaper thing (ie
> cpu speeds stopped increasing awhile ago, but memory is still getting
> cheaper).
> 

The reason for making the structure local is because it's being modified
per instance, meaning it would still work as long as
qcom_llcc_init_mmio() is never called concurrently for two llcc
instances. But the correctness outweighs the performance degradation of
setting it up on the stack in my view.

Or am I missing something?

Regards,
Bjorn

> But either way it's correct, so really it's fine if you ignore me :)
> -Evan
