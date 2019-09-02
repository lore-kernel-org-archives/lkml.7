Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BF0C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4FB208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="fWmw5ecG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfIBRv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 13:51:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44997 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfIBRv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 13:51:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id 30so3866713wrk.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 10:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=30614MWexEAQFM+0c4rqlG2WxuP4LBSIVe+DJzyvhvc=;
        b=fWmw5ecGjhuEvVvOKBnzb3BXie61SmPMnnGyAmOt+sESuO5Y515rwRIt18ZPGPB7dT
         N3zwUrX31YJzbFNafe5nqIT7U0clWdC0aiZjysV+oybc/zlXJLaJUwyYFrXxXcgXGMj6
         TiOh8NzQChy65d2ZS9yiaiOtD+POm7kLMeMCxMYfaUqu2pV6xYUyM0p5Djg2t9vvfsqE
         7dwqB6tTkUT+yvXLk/AsUQ2edm8Ar/mlBehaczbXiCxRCp9fWGSmQUnPl2r1ZSu6X+fD
         H6y8GBN26mBelF8B2PmYZs+95IDXjTQufmtkxa2mcJB3xk+nIMaMGcnJW28gmget9rai
         1bLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=30614MWexEAQFM+0c4rqlG2WxuP4LBSIVe+DJzyvhvc=;
        b=nRu5Cghb7JpR3DvDXY0bigXJS8U/iGTkMFrD/3fdzVQmBVXBFFP1sow20hEGEoRFl5
         Q8IwO+3wzonb9Ms3keRFk18ThJ5KmLPhTSSF7Kwv8kQzxLh5ljEJ+CTMIe3sTIoERhKi
         gyPlc0J6RjJOSXsVPyKDV7wlatEQ8qpoFjoi7BwSndbwVxJOrmhvuCaCwALwwTBwnn6s
         djnyCqy945azC2yBmQUEE7ejUCRfb8Jy5EjfKwkNFhtGSXEvzio+xKolLXAPmI55d4+k
         sZeE2OYIU3Z8PN6C2EF3QGg7l+EDA4N5Eowg+RYHj6H0hsitJ7kdZCYiVynxOboC2Ddu
         2+Dw==
X-Gm-Message-State: APjAAAUNJE6rGsxpqmOV9UsHOtrSPx5bECetSWWx7sMkz4MNDrT4EJVr
        aIKAU+Fj/kaHSHPtW6d7tdSp0g==
X-Google-Smtp-Source: APXvYqx5yXCKSx2boSLezl2KFaq9lzr7eU39ap8BcJtsjuDzDOx/5VOV3wTejM8u8tb/xqfd+jjHcg==
X-Received: by 2002:a5d:428c:: with SMTP id k12mr2963104wrq.196.1567446686259;
        Mon, 02 Sep 2019 10:51:26 -0700 (PDT)
Received: from localhost (ip-78-45-163-186.net.upcbroadband.cz. [78.45.163.186])
        by smtp.gmail.com with ESMTPSA id o3sm18024804wrv.90.2019.09.02.10.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 10:51:24 -0700 (PDT)
Date:   Mon, 2 Sep 2019 19:51:24 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     "Allan W. Nielsen" <allan.nielsen@microchip.com>
Cc:     David Miller <davem@davemloft.net>, idosch@idosch.org,
        andrew@lunn.ch, horatiu.vultur@microchip.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        ivecera@redhat.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net: core: Notify on changes to dev->promiscuity.
Message-ID: <20190902175124.GA2312@nanopsycho>
References: <20190829193613.GA23259@splinter>
 <20190829.151201.940681219080864052.davem@davemloft.net>
 <20190830053940.GL2312@nanopsycho>
 <20190829.230233.287975311556641534.davem@davemloft.net>
 <20190830063624.GN2312@nanopsycho>
 <20190902174229.uur7r7duq4dvbnqq@lx-anielsen.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902174229.uur7r7duq4dvbnqq@lx-anielsen.microsemi.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Sep 02, 2019 at 07:42:31PM CEST, allan.nielsen@microchip.com wrote:
>Hi Jiri,
>
>Sorry for joining the discussion this late, but I have been without mail access
>for the last few days.
>
>
>The 08/30/2019 08:36, Jiri Pirko wrote:
>> Fri, Aug 30, 2019 at 08:02:33AM CEST, davem@davemloft.net wrote:
>> >From: Jiri Pirko <jiri@resnulli.us>
>> >Date: Fri, 30 Aug 2019 07:39:40 +0200
>> >
>> >> Because the "promisc mode" would gain another meaning. Now how the
>> >> driver should guess which meaning the user ment when he setted it?
>> >> filter or trap?
>> >> 
>> >> That is very confusing. If the flag is the way to do this, let's
>> >> introduce another flag, like IFF_TRAPPING indicating that user wants
>> >> exactly this.
>> >
>> >I don't understand how the meaning of promiscuous mode for a
>> >networking device has suddenly become ambiguous, when did this start
>> >happening?
>> 
>> The promiscuity is a way to setup the rx filter. So promics == rx filter
>> off. For normal nics, where there is no hw fwd datapath,
>> this coincidentally means all received packets go to cpu.
>> But if there is hw fwd datapath, rx filter is still off, all rxed packets
>> are processed. But that does not mean they should be trapped to cpu.
>> 
>> Simple example:
>> I need to see slowpath packets, for example arps/stp/bgp/... that
>> are going to cpu, I do:
>> tcpdump -i swp1
>
>How is this different from "tcpdump -p -i swp1"
>
>> I don't want to get all the traffic running over hw running this cmd.
>> This is a valid usecase.
>> 
>> To cope with hw fwd datapath devices, I believe that tcpdump has to have
>> notion of that. Something like:
>> 
>> tcpdump -i swp1 --hw-trapping-mode
>> 
>> The logic can be inverse:
>> tcpdump -i swp1
>> tcpdump -i swp1 --no-hw-trapping-mode
>> 
>> However, that would provide inconsistent behaviour between existing and
>> patched tcpdump/kernel.
>> 
>> All I'm trying to say, there are 2 flags
>> needed (if we don't use tc trap).
>
>I have been reading through this thread several times and I still do not get it.
>
>As far as I understand you are arguing that we need 3 modes:
>
>- tcpdump -i swp1

Depends on default. Promisc is on.


>- tcpdump -p -i swp1

All traffic that is trapped to the cpu by default, not promisc means
only mac of the interface (if bridge for example haven't set promisc
already) and special macs. So host traffic (ip of host), bgp, arp, nsnd,
etc.


>- tcpdump -i swp1 --hw-trapping-mode

Promisc is on, all traffic received on the port and pushed to cpu. User
has to be careful because in case of mlxsw this can lead to couple
hundred gigabit traffic going over limited pci bandwidth (gigabits).


>
>Would you mind provide an example of the traffic you want to see in the 3 cases
>(or the traffic which you do not want to see).
>
>/Allan
>
