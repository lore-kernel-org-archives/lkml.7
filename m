Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC57C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB45620678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="aSP3I+0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391899AbfIQBsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 21:48:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42051 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391881AbfIQBsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:48:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id f16so2134240qkl.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 18:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edT1MwEV0Yvt3Eaj1HjVvWX2OiCmS2l00yghhSQmhh8=;
        b=aSP3I+0I+nRIj+73SiztqkTLRBYipxWxVa/2eCQpJX2zav0Vt2t57egFxrhJXLJN4T
         O9I/rutgX3kq2wLwfAuMftmT+yN3onzIGaQ/Cd5rlDXR/SQQztigJqKDjlIigsoZVZj+
         vmSCZYh/1v1+IldHyE7nga5tStmq7w1vkrO8F4A5wyq0hBaQeW6F2vcrbwGEbdX/MjJJ
         uIKyvkGH4hO8JMTnfQZvTShrcMGkvFA6csXm93BTeHBMzJkSkrX9PZdw6rAMxIyP5BWB
         ihsHObJmLtOl8WpR0Xp9cyE2kapAPxmjLdcrBVDaMWS+/rbpDhhfaZvC/6jaMmTmGzFX
         g47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edT1MwEV0Yvt3Eaj1HjVvWX2OiCmS2l00yghhSQmhh8=;
        b=MIwlt1cod/Er9D/rE8rHWkkphG+ZCglC274SBIutk+DzrLgEjThknyzFRBug14ujqx
         FMUCRx1K31b5Mw+rC5LjopkXsbV9B1CW9kNNhBHk5WKSkqZ2dzRGc5QHS0cUYKbxddNN
         ORfKiCfie0Tr2+3TSph6yJbaiv/1lNrLNiGUa+s1R6eIYaxvPL9e6j+flc7a8b0cEDal
         Ecws6yOZEnEd8TZFnQe+uQsJ3PsoNyH6LU4FS6p3lYZVVq+SwMNdVVdMEX5t1RYXRbEb
         PoEp2MCp70cslJuZ1wj9mVObXMZ8Z0KzLeMpM+iSwXDj3LyefNoT+u5kO7MuQagPzR2w
         UGLQ==
X-Gm-Message-State: APjAAAWT6av+vl9EfCObs7W1WHdNv5f14P11bllxBm3uYTJi6jfd2/o9
        Ygg7XSMKvMXupIb+w3eVGmFieP0IAo1DS23FOyw8fg==
X-Google-Smtp-Source: APXvYqxB9RUk2shXtPH36lM2sXDH6jnQgPup4a+emMeOnlShQR82DfRnnbGWl4+ZDJFFnKeHKMeuZgn7jU+QI6sHw2U=
X-Received: by 2002:a37:7403:: with SMTP id p3mr1286816qkc.366.1568684923337;
 Mon, 16 Sep 2019 18:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190805131452.13257-1-chiu@endlessm.com> <d0047834-957d-0cf3-5792-31faa5315ad1@gmail.com>
 <87wofibgk7.fsf@kamboji.qca.qualcomm.com> <a3ac212d-b976-fb16-227f-3246a317c4a2@gmail.com>
In-Reply-To: <a3ac212d-b976-fb16-227f-3246a317c4a2@gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 17 Sep 2019 09:48:32 +0800
Message-ID: <CAB4CAweWoFuXPci5Re6sdN_kB0i4DkpsYxux+GAHyRHWhC+hhA@mail.gmail.com>
Subject: Re: [RFC PATCH v7] rtl8xxxu: Improve TX performance of RTL8723BU on
 rtl8xxxu driver
To:     Jes Sorensen <jes.sorensen@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 11:21 PM Jes Sorensen <jes.sorensen@gmail.com> wrote:
>
> On 8/12/19 10:32 AM, Kalle Valo wrote:
> >> Signed-off-by: Jes Sorensen <Jes.Sorensen@gmail.com>
> >
> > This is marked as RFC so I'm not sure what's the plan. Should I apply
> > this?
>
> I think it's at a point where it's worth applying - I kinda wish I had
> had time to test it, but I won't be near my stash of USB dongles for a
> little while.
>
> Cheers,
> Jes
>

Gentle ping. Any suggestions for the next step?

Chris
