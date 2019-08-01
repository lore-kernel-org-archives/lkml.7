Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4633FC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE71206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbfHAPQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:16:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38639 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731067AbfHAPQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:16:30 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so25338045ioa.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 08:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A28GjhCVZJSUYeBqZVPzs9S8KLlBjDL+7h1oJI1m5Zc=;
        b=KJoja6PIzIY6IVmbEyXxF/Okzr/MGoZDuY+5KOMwt6ZlcUudJ+diGFf1Chxq058cRF
         nvbrMwkCkpNjLJd8Lvpn5uItcD/JYRDvWGTj1D0ABnwyJ5vQQbwD6qHIxWoe0fjGNv5i
         heOrolGFVeSWLz5pSEKPeWPv7dsNc0YIDHp92k9s9vpV1FRREs0AOhsyOdsL9t5pfxm+
         Ft1ZIPKvB7xx3KJBJIRyas2GsN1hJx6Z4ZOLbWg6x9YEbWGgINsgT/bOYgi1Tuzzjuff
         hQFWM+904/6FcGFpXOpKZ3QmBERWSYGG+NHr41pZjw2BIuLPU2cg17HoaHzaEyttETEY
         2aUA==
X-Gm-Message-State: APjAAAX9Gd+PwWavg+/eFzcyoGI9lYkSKGiNUK8NU4ElKDUDK1pfLf9D
        VTSGo2S9SY4yA0Ydj7GX+HIi8A==
X-Google-Smtp-Source: APXvYqwTmTw8q3S7+wmnzW7nURycARh98zNdnxgSBMexZJS7aGzgjb/DA1XsBfQf+Ksr20eqb+nL8w==
X-Received: by 2002:a5e:9314:: with SMTP id k20mr3543162iom.235.1564672589576;
        Thu, 01 Aug 2019 08:16:29 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:5118:89b3:1f18:4090])
        by smtp.gmail.com with ESMTPSA id j1sm64548891iop.14.2019.08.01.08.16.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 08:16:28 -0700 (PDT)
Date:   Thu, 1 Aug 2019 09:16:24 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after
 reset
Message-ID: <20190801151624.GA155392@google.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <CAPDyKFpL1nHt1E1zgS-iDZf_KDWk2CN32Lvr+5Nmo8CtB2VCWg@mail.gmail.com>
 <20190607160553.GA185100@google.com>
 <CAPDyKFout6AY2Q92pYQ-KPH0NENq1-SkYivkDxjjb=uB=tKXuQ@mail.gmail.com>
 <20190610163252.GA227032@google.com>
 <fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com>
 <20190619145625.GA50985@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619145625.GA50985@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 08:56:25AM -0600, Raul Rangel wrote:
> Your patch looks good. I tried it out and got over 57k insertion/removal
> iterations. Do you want me to send out your patch, or do you want to do
> it?
> 
> Just to recap, the patch you proposed + the AMD SDHCI specific patch fix
> the problem.
> 

Just pinging the thread again to see what you would prefer. I can send
the patch with you in the Signed-off. Or if you would prefer to not
update the sdhci driver at all, I can add the logic into the AMD
specific patch.

I would like to get this in so it lands by 5.4.

Thanks,
Raul
