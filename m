Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FB1C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CE1208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XowKl4Kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbfFLNo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:44:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33764 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfFLNo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:44:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so17032565wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 06:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CQKaNUnLIucKafeeoPkc/JJRL8af7D1Af/DQkJi/Aoo=;
        b=XowKl4Kd09YYo08R/kBpwc+m1HGn0FXQyhCkIIirTPUM/FUZ0tR6yYn/iiZgonpZFt
         hE5YSubBD+CsyLGQynk6CLKVY5r/jKdPJWnkarVgi9zExZpRn6O8Za/VtC6drM5x0lyR
         rSpy5Rv1h++k+zUO0+0so+WNpvldIwFx54r51S3161w2Z3O6uEeS57IfXSgTySWPHFwc
         dP1YbGrboihHucsIFmqye9kgrOKteOIlJkv3KTDtU3bUBP5A5XTh4dSv6OgCkAO7srIB
         Cii+KbxA6UFG3cSp2SPHVsqBT8quArXNZSW/F2vahuwrzXbekKpeiNjUHfeFadevEHv0
         HoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CQKaNUnLIucKafeeoPkc/JJRL8af7D1Af/DQkJi/Aoo=;
        b=CYpDgZLHpSvF4Qbyy8Z77MYL9Vf8rApdXMqZ3CpBWsNDofWv2PJefXJVQZQ3ZACFi3
         3Q9H6/WPmBGduj6A1o1kaWFZgo06TcHoUqMLzmpwiJ5IFcfMOUP+NsgMUQiEFBWmdD4r
         yq8qPFowL9+Dg9S17BzQ/Ymqga//1PIfkQH54agW92fBXzjiJEPklAyZXeRL7yGP7zk1
         agIrUmU7UmyPIpaU4mVQ8Ar0chzStzli3pM1h3/ts8RxKF7XX8uEvJh8CP4EcXyF3k8a
         Cjp/r6imLYty72ooNf/15VXoy71NH4oEZzXiGdELINR38YYH20so+ICQXGmBvjlFQygu
         rBOg==
X-Gm-Message-State: APjAAAWZpai4XCN6yR57kqqgpZLBXLbDJ+WQiFRnWDKsWT4ho5LFwOai
        6ywyFnZYf1/ItWhGA3yPsv3jwRu/FIs=
X-Google-Smtp-Source: APXvYqxgQ/VIbZ0qG24gAWKbCfqBD1oZHT9byjqAfsrleHeN8KhuFOTcNe+KuuC5pG+729IiAbtIyw==
X-Received: by 2002:adf:9dcc:: with SMTP id q12mr4720477wre.93.1560347097577;
        Wed, 12 Jun 2019 06:44:57 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id u11sm12745912wrn.1.2019.06.12.06.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:44:56 -0700 (PDT)
Date:   Wed, 12 Jun 2019 21:44:49 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     nico@fluxnic.net, kilobyte@angband.pl, textshell@uchuujin.de,
        mpatocka@redhat.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vt: fix a missing-check bug in con_init()
Message-ID: <20190612134449.GA4015@zhanggen-UX430UQ>
References: <20190612131506.GA3526@zhanggen-UX430UQ>
 <20190612133838.GA7748@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612133838.GA7748@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 03:38:38PM +0200, Greg KH wrote:
> On Wed, Jun 12, 2019 at 09:15:06PM +0800, Gen Zhang wrote:
> > In function con_init(), the pointer variable vc_cons[currcons].d, vc and 
> > vc->vc_screenbuf is allocated by kzalloc(). However, kzalloc() returns 
> > NULL when fails. Therefore, we should check the return value and handle 
> > the error.
> > 
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > ---
> 
> What changed from v1, v2, and v3?
Thanks for your timely response. I am not a native English speaker, so
I am not sure I understand this correctly. Does this mean that I should
use "v5", rather than "v4"? 
> 
> That always goes below the --- line.
And I can't see what goes wrong with "---". Could you please make some
explaination?

Thanks
Gen
> 
> v5 please.
> 
> thanks,
> 
> greg k-h
