Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED95C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3C8206A2
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfHEQtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:49:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33982 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfHEQtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:49:23 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so168771714iot.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 09:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iy0zgi7c5Mt6BCyigJ+sau0NZkAGLjojiGbTtlpXmX4=;
        b=AO8WILTZ2F4Y3kf5g/GRZ6sa70Xh6EURZvliiklrJnVqmHxLoYeYLxUqZQa1JZhjhH
         MKLjHewO8ZB0Izz1i9/YGQ0edVZSL8EidXmT3m2axVEBZ3CjkxcAZUNuyEUKEpvqY59S
         Cu2A4B0gTL6SY2id05Bm02i6OOGBGngxo1Y0yL4xnCekSAYNprFjvqv/NSNK/5NgUbbZ
         setNr+1S2Bmk4W3j93vYebcpp/f4J4xbvYkPaNi9UK9V61Z6BKqk5Nl1mBZQpEKBhev1
         whvWKr0lIiG8kJd0Uh/oO37Fl4dCq4+qRfgILYmkZu2OjooKTwxrYFPpnYkLQN8jxOC3
         NzEQ==
X-Gm-Message-State: APjAAAUGt4cjzhyCHTulaFtwTFIgFjdpFw2z/LkV5GdvcbvT4Xup+Pom
        XhEz3RtymE+jY+vWV2qoWlRYNA==
X-Google-Smtp-Source: APXvYqylsgW6+SJQlfTE/tTlTjRGeYSraVjmnVSRxvw6S4E37w75djUCGF7oXf/2sEbet6SG4H43dw==
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr101484652jan.90.1565023762315;
        Mon, 05 Aug 2019 09:49:22 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:5118:89b3:1f18:4090])
        by smtp.gmail.com with ESMTPSA id e188sm75590176ioa.3.2019.08.05.09.49.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 09:49:21 -0700 (PDT)
Date:   Mon, 5 Aug 2019 10:49:17 -0600
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
Message-ID: <20190805164917.GA93879@google.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <CAPDyKFpL1nHt1E1zgS-iDZf_KDWk2CN32Lvr+5Nmo8CtB2VCWg@mail.gmail.com>
 <20190607160553.GA185100@google.com>
 <CAPDyKFout6AY2Q92pYQ-KPH0NENq1-SkYivkDxjjb=uB=tKXuQ@mail.gmail.com>
 <20190610163252.GA227032@google.com>
 <fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com>
 <20190619145625.GA50985@google.com>
 <20190801151624.GA155392@google.com>
 <a9a8d3f5-d600-7c8d-8734-cf6a017849c5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9a8d3f5-d600-7c8d-8734-cf6a017849c5@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 07:58:20AM +0300, Adrian Hunter wrote:
> 
> You seem not to have answered to my suggestion for a change to sdhci_reinit() here:
> 
> 	https://lore.kernel.org/lkml/fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com/
> 
I thought I answered it here: https://lore.kernel.org/lkml/20190619145625.GA50985@google.com/#t

Did I miss something?

Thanks
