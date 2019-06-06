Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E62C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E409C20866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2r+s5VI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfFFPUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:20:54 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51573 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbfFFPUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:20:53 -0400
Received: by mail-it1-f194.google.com with SMTP id m3so569857itl.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PiMfO4YCof/W4JkE5dyaN3W6EpzaEIO712mn6YXuGlQ=;
        b=n2r+s5VI77v/Gl4qX5FTH2C3QoCnzX7QviDVxNwEh8v1VqtutxdY5cKYrbeIhUAYfe
         VsQI2A59EJb4m3eV3xZObhXAQiS03hkRIWDrVgg+KmDAA36jQXofXhgoyd/EW3mnmBQe
         +FkL7Quaar04j1iF1sTSuDhZ3PkowMgcPRdNLpDtUZ/LdvrBxdBFQep7j9hZLjRrwsFJ
         bDDn/uaFHCz1uJDdpSTa8otDDOf7h88eC3Cj/aYs4QUJIeto5WgVIRcTc1yaWbtdlHJx
         2JD0m120jGPSw12tYIsrEwsVrO4tpuowAiFXJGRwMiiD/hMR7IPJuwJgbSzwvnL/0CrD
         HrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PiMfO4YCof/W4JkE5dyaN3W6EpzaEIO712mn6YXuGlQ=;
        b=RBLtITm+/yR464Wi+Cj21oaeeJsPEjXqR9s6JGmv1PVseGKsj8oN0zIPmRZDNWnbFV
         gw20Oj6WwKJh6CRT+HxU0Z+9TPZMpNN+38jDktbrjDd2ztaw0k6aQl0jfuqK2tjC7ELO
         Ivutg2XGK0WJXvGvY5acFjS9iESrMDJEWAhnuUwH5Bgt/7ZD6a8gMPB8jT0yDRXTkDl3
         Wu++eMbqS3iFyS3U0hbEh3TgWdHj68SoxHfp5yCWYuCHh+B85xKbbM6QN8iEW+dUFE1K
         9P565Lasrcf18/WIk+n/2QLst+WwhzjCcQN1mrRs0Y/D3/a3ZVznMouA65U5G+DoSP9+
         mvig==
X-Gm-Message-State: APjAAAVFQ73W7wGDHClEtc1BCBxdioVxSWafjEVmRfvW2Uh2Oy+hLiAZ
        DtTyz9Zki/UP7BlQMcLGXlBP5iiFN+Kzt3J1A6c=
X-Google-Smtp-Source: APXvYqwoGrsOerFQadM6uR//lLBEZzEAIg6wBoWX+NYN57fO/8eXWEoPhiyO83o6l0JvSjzFVa8euk8cY7ZxCX8L1Zw=
X-Received: by 2002:a24:424f:: with SMTP id i76mr499467itb.119.1559834452931;
 Thu, 06 Jun 2019 08:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190531143320.8895-1-sudeep.holla@arm.com> <CABb+yY1u5zdocgV=HhQcHWQa_R7ArtFqndU5_T=NsPHJ=jwseA@mail.gmail.com>
 <20190531165326.GA18115@e107155-lin> <20190603193946.GC2456@sirena.org.uk>
 <20190604093827.GA31069@e107533-lin.cambridge.arm.com> <20190605194636.GW2456@sirena.org.uk>
 <CABb+yY27Xe7d5=drKUGg82rJXcRU3EfZkG9FygZoOiioY-BMyw@mail.gmail.com> <20190606125140.GB26273@e107155-lin>
In-Reply-To: <20190606125140.GB26273@e107155-lin>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 6 Jun 2019 10:20:40 -0500
Message-ID: <CABb+yY06heJ5s5-2tvrDt9CdL+--YLG+P52e52YFPqTA=Nb3vw@mail.gmail.com>
Subject: Re: [PATCH 0/6] mailbox: arm_mhu: add support to use in doorbell mode
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 7:51 AM Sudeep Holla <sudeep.holla@arm.com> wrote:

>
> > BTW, this is not going to be the end of SCMI troubles (I believe
> > that's what his client is). SCMI will eventually have to be broken up
> > in layers (protocol and transport) for many legit platforms to use it.
> > That is mbox_send_message() will have to be replaced by, say,
> > platform_mbox_send()  in drivers/firmware/arm_scmi/driver.c  OR  the
> > platforms have to have shmem and each mailbox controller driver (that
> > could ever be used under scmi) will have to implement "doorbell
> > emulation" mode. That is the reason I am not letting the way paved for
> > such emulations.
> >
>
> While I don't dislike or disagree with separate transport in SCMI which
> I have invested time and realised that I will duplicate mailbox framework
> at the end.
>
Can you please share the code? Or is it no more available?

> So I am against it only because of duplication and extra
> layer of indirection which has performance impact(we have this seen in
> sched governor for DVFS).
>
I don't see why the overhead should increase noticeably.

> So idea wise, it's good and I don't disagree
> with practically seen performance impact. Hence I thought it's sane to
> do something I am proposing.
>
Please suggest how is SCMI supposed to work on ~15 controllers
upstream (except tegra-hsp) ?

> It also avoids coming up with virtual DT
> nodes for this layer of abstract which I am completely against.
>
I don't see why virtual DT nodes would be needed for platform layer.
