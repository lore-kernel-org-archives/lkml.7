Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F624C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 00:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2ACD2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 00:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFPnUqqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfCMAbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 20:31:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56100 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfCMAbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 20:31:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so109065wmf.5;
        Tue, 12 Mar 2019 17:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKg+nARTdtsm7x8t8Xjwu4alcYJjw3luItz1ZtmLJWc=;
        b=LFPnUqqOKOq0XufiLgweF4Dm2YGpJj6u+ZQaoWS2nD1RxL0KQZktWgH3iZ8Cs2JooC
         ivefOfIdpSfTsEQ326PUeNda7AkHEEmC/qZFMX+bwj6xfz9X5W0BNK/o/eOpdhiB5Rzz
         An42GI35hN1oa2nsIVaGqTW7KatU5Wq+L3/1cbM2hMqhyze8yd/fN0Ezi2qnC+UwrUpH
         m9i51caOvN6Pv7k5wc0D42kiNI/QuPmQbcswKAi/L8sP25gVe1Xj3Q+6OFgq9uHCAv8v
         fXkR8IytLXQ9089Hf/668z6ANvqheTcRs8yH6nZX/aYDxoueLWR94m1EJqFhscUQ7CkU
         3ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKg+nARTdtsm7x8t8Xjwu4alcYJjw3luItz1ZtmLJWc=;
        b=Ww8Xl4sx5D4iKIuLGHEZM3h9LRJ9ag7sM/WzqnhOlwj8Q2LPywcdZsZquo9oCE34xn
         aFpzxiH3TmvxIEhfeREkfNPEiPkLoFkC815Bz55D65RM9oWYSbsbAoxZokn1AtBoTPXQ
         lqzmULqSWqvJkeyviHkT6Mx+7va9JIY9ZklfC3zYecLYMa78nw6yLrN1tI/A/P6ov9Ct
         zGs9ZCcYaNEnqyX1IReUHnOfo5/16K/wgrlQo3SpOsCMHiGnKkeVnoDz8RNJNL3v+PjX
         0DlOITfe44MTE5l45bXX/QZlBNMea/YObK2TslPO7fymG/sSMZhZ8ToyZyqmobSS0yO8
         yerA==
X-Gm-Message-State: APjAAAUNI7xEWGbjvAERIDXvTKZOruVcVuBSgHTNewV71r7CPa8Yy0z6
        zysJVdGqH0cTyJtZ2M/Dg75Xq1otUEVhIZpJE84=
X-Google-Smtp-Source: APXvYqwNXuNA9Ei0KiJya8Xew9u0EApjP8XO4F401s61x1pnoPN4Tiq6qSLo1C5L4OdIaa41gLaV4lyNc8h/LQDHqWs=
X-Received: by 2002:a1c:44:: with SMTP id 65mr212870wma.127.1552437091074;
 Tue, 12 Mar 2019 17:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190311213124.29325-1-angus@akkea.ca> <CAHQ1cqEHr1mB2EH3-fJPrYa+nkcWPPjmCTjSt-XsDnJp-SCf+w@mail.gmail.com>
 <9f25fb1a0acb35539dcd802502c49058@www.akkea.ca>
In-Reply-To: <9f25fb1a0acb35539dcd802502c49058@www.akkea.ca>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 12 Mar 2019 17:31:19 -0700
Message-ID: <CAHQ1cqHS6Q9naaYO8etfVC6ra0Km8a3Hs-4FTVdjjS5Ciwjpbw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: fsl: imx8mq: enable the thermal management
 unit (TMU)
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, daniel.baluta@nxp.com,
        agx@sigxcpu.org, dl-linux-imx <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 1:19 PM Angus Ainslie <angus@akkea.ca> wrote:
>
> Hi Andrey,
>
> On 2019-03-11 19:35, Andrey Smirnov wrote:
> > On Mon, Mar 11, 2019 at 2:35 PM Angus Ainslie (Purism) <angus@akkea.ca>
> > wrote:
> >>
> >> These are the TMU nodes from the NXP vendor kernel
> >>
> >
> > Hey Angus,
> >
> > TMU block supports multiple thermal zones and vendor kernel doesn't
> > really account for that (see below). Latest version of the driver in
> > thermal tree now actually supports that feature (mulit-sensor), so I
> > think the code in DT should reflect that as well. I recently submitted
> > a series adding HWMON integration for TMU
> > (https://lore.kernel.org/lkml/20190222200508.26325-1-andrew.smirnov@gmail.com/T/#u)
>
> I tried applying those to linux-next. They don't apply very cleanly
> there so I gave up.
>
> > and this is my take on this patch:
> >
> > https://github.com/ndreys/linux/commit/09931e3d60af0a74377307b433db97da1be31570
> >
> > All of the code there is up for grabs, if you feel like using it.
> >
>
> I followed that and I have a version that works with linux-next that
> does not include the GPU
> and VPU parts.
>
> I also tested a version with the GPU and VPU parts and it "works" but
> creates 2 useless
> paths in /sys/class/thermal .
>
> Should I wait for your changes to get into linux-next or resubmit a
> version that works with the current one ?
>

You don't really need my changes for multi sensor support, only the
patch Fabio pointed to. You can send the patch sans GPU and VPU nodes
to get it in sooner or you can wait until multi-sensor support patch
trickles down to get all in in a single patch. All options are fine by
me, so it's up to you and Shawn I'd say.

Thanks,
Andrey Smirnov
