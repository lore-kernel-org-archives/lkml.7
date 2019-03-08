Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12380C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D191F208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c4WWaPKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfCHQWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:22:48 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40582 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfCHQWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:22:47 -0500
Received: by mail-qk1-f193.google.com with SMTP id h28so11472677qkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 08:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9XZ6z5esk2ECGEn4d82w7AcqDOl+V/uIb9RPUFwu48=;
        b=c4WWaPKINbHnmdFXfBgz9Uesn6cP6DQv3/hQGrlVW+4+qBOuTMdK66k8ll1OfwPyYi
         RfRCkYRVaIlvlu75cldS/fFWU3PTHCQJtSsL+0FCKyR0bgodMznZ3GWLTu8hg8A7Sxf2
         gAVzAJhhfiB6BHtFBXJeLQQ5UiV+lHqPxVMrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9XZ6z5esk2ECGEn4d82w7AcqDOl+V/uIb9RPUFwu48=;
        b=OJt++nTe/5615TagpuXtGeCFoTQ7ErNvQDe+a3oJ2F5jhj+7MWN2gIc18tlNfIeSe8
         DHopS8g2x11RQ5uxR0/DB4AM4KrUp/0DxzzE5Ppth1MNk1Z7Gwz6cXfypuicQD42jfEg
         lq1J7O3zr9Jg3qWaBuFhlgIO9mVPTLwcAPXjVbsvPF/dHgJE8KFyprHFfJZOI6ljb7OV
         LlWOXl0gmFInk7BmT03HPmdUUjji/iz6ifq6etZDSNxXP4Db6PWspzkdulMInyhq7/RZ
         OYU2c6tzc+04JstQ+kVfaljBAVAvyw49bQQawiYneJlh5trpUY6v3yyGxDomLqJVuCfI
         8JuQ==
X-Gm-Message-State: APjAAAU0KLhkAmMq906QBdoJZJiCBSLb41iF3iSmJBZhpyVyeVb51srm
        RaEgPyAqY+eQpkXwmaCiO3kzo/rxBmjQN6yJDZFqzA==
X-Google-Smtp-Source: APXvYqwt8riDsgQHsTbxRjcgAfQbY7NpR5rSRwOB/QePjDLMVnpwnQ3nDZciRmGSB9EX1iLBMYKMykA2rIpmLXT/cKE=
X-Received: by 2002:a05:620a:124c:: with SMTP id a12mr14663552qkl.103.1552062166543;
 Fri, 08 Mar 2019 08:22:46 -0800 (PST)
MIME-Version: 1.0
References: <20190215090202.157100-1-hsinyi@chromium.org> <20190215090959.soxkf3ho3or2geme@ninjato>
 <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
 <20190215092500.6q3hqnoufyowiqaz@ninjato> <20190215163657.fs6t7p3vqez53su3@ninjato>
 <CAJMQK-jzvMBD_AaB7XMJtMqNWiEin25bem4Zo9T5W86Z-U=Tww@mail.gmail.com>
 <20190308112919.GA1674@kunai> <CAJMQK-j9b3o+KQfN8nLXGiP+TXi8i77=yTTQsEARa6cotPhxzw@mail.gmail.com>
 <20190308145203.GA4743@kunai>
In-Reply-To: <20190308145203.GA4743@kunai>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Sat, 9 Mar 2019 00:22:35 +0800
Message-ID: <CAJMQK-jRheyFwvKDURF9kxW4MXTQmgQjuGbXjerth26PLF_3dQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to i2c_get_dma_safe_msg_buf()
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jun Gao <jun.gao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, linux-i2c@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        qii.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 10:52 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > > I just checked this issue again and concluded that both are reasonable,
> > > the suggestion from me below with the adapter quirk AND your original
> > > patch setting the threshold to 1. With my suggestion the core will
> > > prevent 0-length messages. But still, we should set the threshold to 1
> > > because 0 is a value the HW is not capable of.
> > >
> > I think quirk might be better, since mediatek said they might have some ICs
> > that can handle zero-length transfer in the future, so flags might be
> > more clear if they want to restore functionality.
>
> But I guess you don't want to do the zero-length transfer with DMA then?
> With that in mind, raising the threshold still makes sense to me.
>
Yes. Then I think this patch is okay for merge?

And since the mt8183 patches are still under reviewing, we'll upload adapter
quirk patch after those are merged.

Thanks
