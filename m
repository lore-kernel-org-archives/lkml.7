Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FE4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CF520811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d8LBccvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbfC0AYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:24:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34117 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731159AbfC0AYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:24:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so9066135pgq.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 17:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pM5lfy5uK1o6QH81yfiNB8f+N42sksFZ3M2xo8AR0+w=;
        b=d8LBccvYGaLfY2gFL+MCyU/USreh9hADi1itEhgTiUbqJFIRgUDySofPMvYb7luU4Y
         MKEGtXTvZJ7Jbp0G0WOW3sAqjdf/u6+s8h11kiG8ejf6boJkA3TLv38apiw2C6L5iGZ/
         15zBIwUi0LQUW2Syjhsy4CxuP9MJ9MQusxlbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pM5lfy5uK1o6QH81yfiNB8f+N42sksFZ3M2xo8AR0+w=;
        b=JSeQ7M51McCGUQ2spR3vZYPFT+9/DMadXfVjrn5njGFaCpmItiIBZgLWYpUmkv2cNj
         Q5jz4PMRvNeKQaVoVLR8PY1O89QS8NAdV92KSgqSYBIXefxcCFfQP613/Ce1knezt0hO
         cLzuHmI1eyj5CEL4rV8wg+raxAHSmMyEi0nJ1eN9o82TFDtiuuNWS7Yd0H2pLdtXgVI3
         zUlfyc+KbqSmIcfW44PuDTG3injD16MsbdIiplOvWNhG/lMmgQXz3MIEbMHOpb6xHHF5
         IKQaO729lHX6I6V4QkuE9Gkovn3/1rcIYihSHn75bMmqV5Nuq7c6ncje4QnID/mK7ebi
         5fgA==
X-Gm-Message-State: APjAAAUz3xbmC57p858vpn7rWqJeBqGZRroEwT/ZRXsF4dpetpRjgazz
        Jo0Km1usdeNt5Z5apO151zTi6g==
X-Google-Smtp-Source: APXvYqwu4iyrJl/vn7kE01szxTWiCMZMic4cou8V5ECSy4TBIQZwsCRQkzMp5gtuVKiwrZKTYKMFbg==
X-Received: by 2002:a62:e911:: with SMTP id j17mr32430006pfh.107.1553646283104;
        Tue, 26 Mar 2019 17:24:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 125sm30045677pfw.139.2019.03.26.17.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 17:24:42 -0700 (PDT)
Date:   Tue, 26 Mar 2019 17:24:41 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     =?utf-8?B?R2HDq2w=?= PORTAY <gael.portay@collabora.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-rockchip@lists.infradead.org, Randy Li <ayaka@soulik.info>,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>
Subject: Re: [PATCH v2 3/5] devfreq: rk3399_dmc: Pass ODT and auto power down
 parameters to TF-A.
Message-ID: <20190327002441.GB112750@google.com>
References: <20190319181323.22804-1-gael.portay@collabora.com>
 <20190319181323.22804-4-gael.portay@collabora.com>
 <20190320003352.GN112750@google.com>
 <20190320215013.43zgvyn5frnb3yud@archlinux.localdomain>
 <20190320220223.GP112750@google.com>
 <20190321231055.j7z23f3k3rcngq4u@archlinux.localdomain>
 <20190322000107.GU112750@google.com>
 <20190322124525.ge5thq4a7c6ufcra@archlinux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190322124525.ge5thq4a7c6ufcra@archlinux.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 08:45:26AM -0400, Gaël PORTAY wrote:
> Hi Matthias,
> 
> On Thu, Mar 21, 2019 at 05:01:07PM -0700, Matthias Kaehlcke wrote:
> > > ...
> > > 
> > > So, for a reason that I ignore, if we try to save unecessary calls to
> > > ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD (odt_enable has not changed since
> > > last call), we get stalled in the call to ROCKCHIP_SIP_CONFIG_SET_RAGE
> > > that follows. The function arm_smccc_smc never returns and the device
> > > hard hang.
> > 
> > Thanks for giving it a try!
> > 
> > Did your code ensure to perform the SMC call for the first frequency
> > change? If not the problem could be that the DDR PD timings and ODT
> > resistors are not properly configured for the new frequency.
> > 
> 
> The DRAM_ODT_PD SMC call is supposed to be performed before the
> DRAM_SET_RATE; unless someone else is doing the set_rate.

However earlier the call wasn't done at all, and that didn't cause
problems.

> Does the ODT resistors should be configured for every existing
> frequency?

I don't have any background here. My initial assumption would be that
it should be enough to re-configure them when the frequency passes the
threshold in either direction.

Anyway, IIUC there shouldn't be more than 5 frequency changes per
second (polling_ms = 200), and likely no all of them would pass the
threshold, so it seems limiting the calls (if possible) would be a
micro-optimization and is probably not worth the hassle :)

Thanks

Matthias
