Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1C6C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B83E20869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmkXXKok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfDRWy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:54:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35558 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfDRWy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 18:54:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so1816385plp.2;
        Thu, 18 Apr 2019 15:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGSDlUW4pGvRZu329pw3z1b/8AHGi1XiEBU04a+XnqQ=;
        b=gmkXXKokpKTXoI24FPgP7E6IMbyK8P/Usef7Xr4p/MMVjJkebCSBp4yTRszqHN9mRs
         8KiM123JYVUjLi0sr/xyrcYkD7mc03y2SelRu+1QQbtgpgxmtZ9RKLkYU837mPpsoYWj
         e3MRnKxTsWYRyH8CSrS3Cgzh4IadTr6fGPV7iPuBjwrrJ9+GbndgHYJybdaO7BTxq4fu
         nx2TxhC6/W8GFrIjAXx3a98xAeRxtHI0DYjMDt4BOyv89ZDm+HuKsdwqUw+nen+hvjRD
         DCgur4d1MnGInK4b4eLaWrhHC/sRLum3ilO3h7ydC7v8HJ2r6T+rAilY/WV3ahGVNisY
         HMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGSDlUW4pGvRZu329pw3z1b/8AHGi1XiEBU04a+XnqQ=;
        b=GvQMK2zimhHOxN3CkOiiUX8SOK0nCWWe5x08vz+414rt9DhzOmOhfVbz66EVYnIJ3e
         g502nohwYHNOThVfDaxuEbk0sUyZjGkIRWMYOqFLl2F0zp+cOL/p3ECzfXoNOgKh0BnJ
         muR9cNpXcsgDDsawVtkn17Zji9nguEfR4JXpKx8pOGwOP5O5m7W3QBPlJGInlRkklCYn
         tgeKWXBg0yfLPMbk4uOul+SxihyIhuTIPds4RjipVBOw0WhlfAZoXPExD+NLldTRkoaj
         bBxLqveezm3cARq9gUAfnDPB/0bWxhltERLuIEDBH1x5HfvYHAihivlBbES/hRnoFvB2
         ac5Q==
X-Gm-Message-State: APjAAAXapg4tCGIejCFGwFFQEAagvX/o4U9RVKYT2wt8IXIvp99vJZUM
        tqJ8+U/WbwjF54dyD7lgSUjLwiVAxl+OECFSX38=
X-Google-Smtp-Source: APXvYqwh+NcUF7OCwmOOy0lIRpqLM0t0+QcVLsuI07deQAB8j3J3eIy4QK4nTQOg/bSoa69ZZxAzRc5k3HaewSNo3/k=
X-Received: by 2002:a17:902:9b83:: with SMTP id y3mr213525plp.165.1555628095472;
 Thu, 18 Apr 2019 15:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
 <20190416090726.GD27892@zn.tnic> <20190416221852.GA10781@agluck-desk>
 <CAM_iQpWit6gHTEFPB5cN3XuHQjeR4mBSb03wRc1F44WEQfNH_w@mail.gmail.com>
 <20190416232833.GA17372@agluck-desk> <CAM_iQpXBJ2eAz4TW_GmOWRLrkyJcO=u-8VSnmv91ZABG-21Agg@mail.gmail.com>
 <20190417015351.GA28490@agluck-desk> <CAM_iQpWXYTivg6tmGxB0xVSrcz8_Envb+yRh_6tBuX-DYKuL1Q@mail.gmail.com>
 <CAM_iQpVom+7oHCUh1=oWrR9NiHfDSGOWoOFV4tkdT6nnZKicmw@mail.gmail.com> <20190417211549.GA17200@agluck-desk>
In-Reply-To: <20190417211549.GA17200@agluck-desk>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 18 Apr 2019 15:54:44 -0700
Message-ID: <CAM_iQpVj5AtkgM3j1cTz8YXPG52Er9se7HnJ=PGWAuspDfRc7w@mail.gmail.com>
Subject: Re: [PATCH 1/2] ras: fix an off-by-one error in __find_elem()
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 2:15 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Tue, Apr 16, 2019 at 07:37:41PM -0700, Cong Wang wrote:
> > On Tue, Apr 16, 2019 at 7:31 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > Yes it is, I have a stacktrace in production which clearly shows
> > > del_elem.isra.1+0x34/0x40, unlike the one I triggered via fake
> > > PFN's. I can show you if you want, it is on 4.14, so very unlikely
> > > it is interesting to anyone here.
> >
> > Correct myself:
> >
> > The one triggered via fake PFN's also shows
> > del_elem.constprop.1+0x39/0x40.
> >
> > Sorry for the mistake, I kinda read into another crash...
>
> Ok. Now I follow what you are saying. I'll try to rephrase
> here.

Yes, your detailed analysis is correct. Sorry if I caused any
confusion here.

>
>
> So I'm now liking this version of the patch by Cong:
>
...
> Reviewed-by: Tony Luck <tony.luck@intel.com>


Thanks for reviewing my patch!
