Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ED9C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71ED420850
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="X23lUBqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfEJLgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:36:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41962 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfEJLgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:36:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id k8so4782781lja.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 04:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DdK4VYsZIEbSLXJrQyG/7TUuBmyrq0ldZxl+dNKDJZA=;
        b=X23lUBqBIEgNeorB4mnEnDE7MwsA9SPWbadECvHxxzNEwVHcv+yI9LVgl9Mkq1gD/7
         RF0yENOo/07CgAv3VKhdKsNAIqPFNImkpKKGRApwJWNZ6OHeXRKNQwIfRI5M57XWFs91
         5dbSikFnoIxdfRA6ZWaWKJk7908n0PF8i6RHksKCprP5oRvro35LbC4FzaO1Hw1Kak3F
         zb9Di/XPYPZ3oAaDeP7DNLWWF1+j7nQt5isR1TraspDfXbn1jJIislBjcLp0Ka5HPAxt
         qA4AV6b6Mf7bAkFpRuJyR9kkTffAA+8u+1IGFcqmpebxxDML4ELXw6WKnG+PmMTVgKqR
         PNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DdK4VYsZIEbSLXJrQyG/7TUuBmyrq0ldZxl+dNKDJZA=;
        b=T7YWxlrc9Fm964V659zxUh3Dfg3pJUF+MZgf1fhgtS9/m9Zh6xNKJugcNcmxmpmstF
         bTJ32CbHdkQbwaCNdkJQncpffgEcNjn36kDWfM5NoTa2wU85/cyJthc0BOSlPSdYjoCv
         oJ5PVis4IUsz5cIB7XLCyhNIPZRUVNCKAa6eqU5tLYI8s7cuqZtSnCS4KUlY+MOqrYLm
         YYXeo6YLcqZoqVsTkxiPI7KktdShpbABhg+EKSLFLCyliuVacW64H75i/Nmcdbp/1BJ3
         KLDeYY/ToBXps4C4BbzfUeJ2HJmbBcciJcD1N+6F3WrlrFeMtX4EtIJPT0cuA0CnMdAn
         GuZg==
X-Gm-Message-State: APjAAAW3Mc08Yv0BALhKhGQWl2QXTotHk+CZibrEIhUuCaTMmBAHiii+
        1FRE3kk4A5K1anv7ABotBEbX7A==
X-Google-Smtp-Source: APXvYqytRoPGUINyB2n2hrYqrUC6Gj/kWGleaoeIUXRYMCsMbem2vuxJg1IEcmMmlAZiaPXGkfQk1g==
X-Received: by 2002:a2e:568d:: with SMTP id k13mr5567860lje.194.1557488169880;
        Fri, 10 May 2019 04:36:09 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id m5sm1193093ljc.65.2019.05.10.04.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 04:36:08 -0700 (PDT)
Date:   Fri, 10 May 2019 13:36:08 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Jiada Wang <jiada_wang@mentor.com>, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms+renesas@verge.net.au, geert+renesas@glider.be,
        sergei.shtylyov@cogentembedded.com, marek.vasut+renesas@gmail.com,
        kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com,
        fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com,
        biju.das@bp.renesas.com, george_davis@mentor.com,
        joshua_frkuska@mentor.com, Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v4 0/2] thermal: rcar_gen3_thermal: fix IRQ issues
Message-ID: <20190510113608.GD28561@bigcity.dyn.berto.se>
References: <20190424051145.23072-1-jiada_wang@mentor.com>
 <20190507235403.GA24112@bigcity.dyn.berto.se>
 <20190510104231.GA15836@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190510104231.GA15836@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugeniu,

On 2019-05-10 12:42:31 +0200, Eugeniu Rosca wrote:
> Hi Niklas,
> 
> On Wed, May 08, 2019 at 01:54:03AM +0200, Niklas Söderlund wrote:
> > Hi Jiada,
> [..]
> > I really like this series, nice work.
> > 
> > Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Is there anything off-the-shelf available for testing the rcar3
> thermal driver, to avoid reinventing the wheel via
> https://patchwork.kernel.org/cover/10913163/#22602335

Not that I know of, unfortunately :-(

I have a private home hacked testing framework (don't we all?) based on 
tcl+expect where I have two basic tests for rcar_gen3_thermal. I'm 
willing to share the tests if you by chance want them, but be warned 
that they are highly specialised for my needs and I'm reluctant to 
publish my whole hack tool as it just a ugly hack ;-)

On a high level the tests I have are

1. thermal-load
    Generates load on target and observes the temperature is increased 
    using the /sys/class/thermal/thermal_zone*/temp" interface. This 
    seems similar to the test case your reference using stress-ng.

2. thermal-cooling
    Emulate the passive trip point temperatures using the 
    /sys/class/thermal/*/emul_temp interface and observe that the 
    specified cooling state is achieved.

I should add a third test to make sure IRQ fires but this is just a pet 
project for me so maybe I will get around to it sometime...

If you know of anything around to test thermal drivers or if you create 
something please let me know so I can add it to my tests. And let me 
know if you want my hacks for inspiration for your own testing.

-- 
Regards,
Niklas Söderlund
