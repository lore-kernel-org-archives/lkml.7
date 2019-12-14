Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A77C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 00:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EB120724
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 00:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KHpcHkON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfLNAsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 19:48:13 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44845 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfLNAsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 19:48:11 -0500
Received: by mail-io1-f65.google.com with SMTP id b10so1428585iof.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 16:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFS8VgWqLfvH3Ij7xQNX1+MJfR1R/okTz8jIXQ/PrWw=;
        b=KHpcHkONtDRBkeXUyGK4TV4REhOe28eSqOpXzWRjTuEoQim33Pz9kdTNOakFhamF+2
         oBnmWQErhxq3ML+ldiVgaxFs4m8k5S1eCZhqaC1hax0V7votOZGHr8Y/bYrGxjIDJ/sH
         t282JVnHXDA3Kk/0/SW2h0yfhUsLzn5NgoZMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFS8VgWqLfvH3Ij7xQNX1+MJfR1R/okTz8jIXQ/PrWw=;
        b=iz+SUqh99AFrH+y+LBn7X0qL3cIf1hQI+icml2OsFtHrgsGtjDOnXCP+KIjsAKd2v2
         EpjKiH7hirz/9iSNWzH4cdRbk156n7ka+37zWLbZnNI57bYL5D0B9BJb7LKfRf13hHg8
         LBdujpsS8VfC6sgEGtgFCOtWBys1SbNnV9Fn2VB9pU3yl/ae2t//blZ1Vqhce+tEWWfE
         d8EiDZzVU8McH4AURJAoN0QwietBION0WTg1AYUbU62/9v42jFPmCoD9iXZLrCtyO2ta
         Mti82D2BSu+q2vWFDzytTX6OOtumSQAKvQ9LTsO4e48pCH+4zjUHAPP9J0VSl8VYfxdc
         /Ucg==
X-Gm-Message-State: APjAAAXEOf8z9DMzeW/UPXGcIv3aJ5QuHeO3LIDAD+Uu0bhpRVYeV6VO
        QoHJKYJhnRcvU+4RwjFP8Lc+D3teptM=
X-Google-Smtp-Source: APXvYqyj7JKW+xUvXyQezpPYO3L3nOf9TwFoO9WjjUVmBqiYB7pSBUFFIZI6H3QyPj8Z+aSwzYDDZQ==
X-Received: by 2002:a5e:d80f:: with SMTP id l15mr10190810iok.261.1576284490624;
        Fri, 13 Dec 2019 16:48:10 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id w85sm3232738ili.44.2019.12.13.16.48.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 16:48:09 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id x1so1460667iop.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 16:48:09 -0800 (PST)
X-Received: by 2002:a02:711d:: with SMTP id n29mr2124405jac.114.1576284489229;
 Fri, 13 Dec 2019 16:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20191213234530.145963-1-dianders@chromium.org>
 <20191213154448.9.I1791f91dd22894da04f86699a7507d101d4385bc@changeid> <20191214000738.GP624164@phenom.ffwll.local>
In-Reply-To: <20191214000738.GP624164@phenom.ffwll.local>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 13 Dec 2019 16:47:57 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VqU8Aeuno44hAi6SP+7NZRTfgJcYPHcWpVNCo6GXUJPw@mail.gmail.com>
Message-ID: <CAD=FV=VqU8Aeuno44hAi6SP+7NZRTfgJcYPHcWpVNCo6GXUJPw@mail.gmail.com>
Subject: Re: [PATCH 9/9] drm/bridge: ti-sn65dsi86: Skip non-standard DP rates
To:     Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 13, 2019 at 4:07 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Dec 13, 2019 at 03:45:30PM -0800, Douglas Anderson wrote:
> > The bridge chip supports these DP rates according to TI's spec:
> > * 1.62 Gbps (RBR)
> > * 2.16 Gbps
> > * 2.43 Gbps
> > * 2.7 Gbps (HBR)
> > * 3.24 Gbps
> > * 4.32 Gbps
> > * 5.4 Gbps (HBR2)
> >
> > As far as I can tell, only RBR, HBR, and HBR2 are part of the DP spec.
> > If other rates work then I believe it's because the sink has allowed
> > bending the spec a little bit.
>
> I think you need to look at the eDP spec. And filter this stuff correctly
> (there's more fields there for these somewhat irky edp timings). Simply
> not using them works, but it's defeating the point of having these
> intermediate clocks for edp panels.

Ah, I see my problem.  I had earlier only found the eDP 1.3 spec which
doesn't mention these rates.  The eDP 1.4 spec does, however.  ...and
the change log for 1.4 specifically mentions that it added 4 new link
rates and also adds the "SUPPORTED_LINK_RATES" register.

I can try to spin a v2 but for now I'll hold off for additional feedback.

I'll also note that I'd be totally OK if just the first 8 patches in
this series landed for now and someone could eventually figure out how
to make this work.  With just the first 8 patches I think we will
still be in an improved state compared to where we were before (and it
fixes the panel I care about) and someone could later write the code
to skip unsupported rates...


-Doug
