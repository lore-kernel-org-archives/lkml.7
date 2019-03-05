Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2273C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF8F206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZst/F9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfCEBHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:07:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37598 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEBHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:07:15 -0500
Received: by mail-pg1-f195.google.com with SMTP id q206so4341358pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 17:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X08UU1rb6v3NKQ4XfD3Fm0wBIUETYOgkWCKnSjdIGIk=;
        b=kZst/F9lKEVfE/lOWPPFjtSqbv34WNhAjVhG824j/M0LMuRqM8YksVzQ8kR+aF3RtL
         I43qPDCY39DvnBcPqnWN/5ieKvb/geWNiTH+mdQWE2j3IXpMdn2/4gQaML9I7hHBjo86
         DN+ZD6sMZbtno1cIsy5HXojFX2zCRPiGoFIJJS9ox9JmC6/TPN/l5a/1TBGUBFBdy1rU
         eIm0T2VQk9dKZPp+yM0YDexMl/sEsWzlkCOoKSIO1hSUghRgTUnkuUkkkNB7jRP9a89J
         8bcZlCIKVY5pLQQJiBUlDWb0/zQcOD1uJ68ogWMVfDGNSEdXZ28KocElS+qdW3LR1ucA
         bXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X08UU1rb6v3NKQ4XfD3Fm0wBIUETYOgkWCKnSjdIGIk=;
        b=STNA645dIynJ54K2rNSmv3LwK6bxSGtMqd9UXfEXuI6kGW0bJ1wLfJimRO1puhN1GR
         U2En7bMX4xuM0KOFGfBtNKOBljipIcMVcM02vv4FG/9PJ65DUKS1gSQCXFafcr6BzS2c
         l+CHR8L42TSJNDkkW5UEwYbOhHQWfR5um3twLDto0l3G0RHJq3eRMSMeN/T+paAkbTYq
         zbxmepuH6pfd5cFBcXhjZzf6Ndq6SLKwbdsZP3W75qdLcp2Kf3fZHKOEEsU1383vrER9
         POcNl2iusGAyJKQA+yNU2Lj7cexA3wEk5c71Lv8kWRj3WcY3RHU/YG0NeWh4YiT6QHgI
         DERg==
X-Gm-Message-State: APjAAAXyjDoA//FPlsozR8ri1pToj5PJiuS+RX5whVGsN0mPuJN85RHs
        tXcm+tr8uJLlSOK96DPYnnTbHg==
X-Google-Smtp-Source: APXvYqyNkW1NmDxwO7A7zFRXv1Wv9wxYw+TVsqu7bW3Mn8LFhevu3JseU95TbT3Mqhdm/cx2gHjExg==
X-Received: by 2002:a17:902:d203:: with SMTP id t3mr5807416ply.310.1551748034399;
        Mon, 04 Mar 2019 17:07:14 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1206-191.members.linode.com. [45.79.107.191])
        by smtp.gmail.com with ESMTPSA id n4sm17327716pfh.8.2019.03.04.17.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 17:07:13 -0800 (PST)
Date:   Tue, 5 Mar 2019 09:07:07 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, shiwanglai@hisilicon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, john.stultz@linaro.org,
        xuwei5@huawei.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzhuangluan@hisilicon.com
Subject: Re: [PATCH v2] dts: arm64: add CoreSight trace support for hi3660
Message-ID: <20190305010707.GA9544@leoy-ThinkPad-X240s>
References: <6496F4728C09F6479CFF21A8E67D33D568F32660@dggema525-mbx.china.huawei.com>
 <20190302125955.GA11385@leoy-ThinkPad-X240s>
 <CANLsYkzakXjuMR+=ncVpcohE8n-uF60Qa6EAN+Xh=FKBoJtrgg@mail.gmail.com>
 <9109e498-0cd9-0b81-15a0-2208d4282359@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9109e498-0cd9-0b81-15a0-2208d4282359@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 05:29:22PM +0000, Suzuki K Poulose wrote:

[...]

> > > To support for a funnel without any register address range (we have
> > > support replicator like this mode), we also need to extend the driver
> > > drivers/hwtracing/coresight/coresight-funnel.c.
> > > 
> > > Mathieu, Mike, Suzuki, could you help confirm this is the right
> > > direction we should move forward to?
> > 
> > Leo, thanks for testing this out.  Shiwanglai, please add Suzuki and
> > myself to future revision of this set - this will help you getting a
> > timely response for your work.

Yeah, I didn't give a good example for this; just remind to Wanglai,
usually we can add maintainers' email address in the "To:" list so
this will be more friendly for email filters.

> > As Leo pointed out we already have support for replicators that don't
> > have a register map and the same thing should be done in this case.
> > But contrary to what was done for replicators, I think we should keep
> > the drivers in the same file as Russell did here[1].  That way we can
> > keep all things funnel at the same place and reduce the amount of
> > kernel configuration options.
> 
> I back that. I have already merged the static and programmable replicators
> into one and this should be out here soon. So, I back the single driver
> approach for funnels.

That's great!  Thanks for advices, Mathieu & Suzuki.

Will sync with you offline for proceeding.

Thanks,
Leo Yan
