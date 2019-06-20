Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD444C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900622080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8c29Wq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfFTMJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:09:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35478 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730596AbfFTMJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:09:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id a25so2283404lfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 05:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2cr8py9sRALmCyOvLdxMhLF/8u2ioUHp2N0xgg03ILg=;
        b=I8c29Wq+C4MPvFbYDrcrRHMeE6tYAcQivD+oMR0wnbMHTUqSD4VbEF50VTTVm/yBa5
         1zgLzjix5NVJ0VreFbPm2U6T0FoSgGRIZPyTDrE6Qf9lGHvyPtySzXLeof3/yiK63bgj
         cudFmcL+IH8Q4ClC+H+p6mnCFVAb+c61rCFgRcVmRNdAgibMT8PzPGmjkiks0WWjn1fs
         6ExjOeHTwxycNbsTe8sRVHgjQmuUy/jAKOLh10T1JBxQaY5FruTGiQ/M8eo8oHSn4AJE
         iIll65VCyi6P31ojvoTiMdVTpvX2DFYUbMeACcYXQKDdxNXnhu6ucpetnFC3609im66b
         sFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2cr8py9sRALmCyOvLdxMhLF/8u2ioUHp2N0xgg03ILg=;
        b=VStN6JNekFekHoG9je4mmzH9RoSyn9qyjDhJtNnSa72IZ+OEdih27+00WmdPs7+412
         pWaiU73e0b8x88QpCL82PW0PlgWDc3S+x4hbUAVcd5k16ygn15fKvn2m5WhyTrB7kHT4
         naigiXAnztJ5CbNhJGMaOknDiWH+aRl/+WvGJtddnrlRze/NW/KVsCr/ZOu6E91+go2n
         gGt8yArU7E4EBHzwentv0ins99p+/NqnyafYn8TyWANCW8q8Cj/NMPaK64WCB9U6HHem
         RB4e4mWkTBrEoDT0jH+lIOn4lsXeFrQ1Ns0hKbnC3/jFZfMi1C7NeFkJCgdnsvHKDnFn
         2DCQ==
X-Gm-Message-State: APjAAAWDjMvGNQqtVqaXzCcgyevbsFwemCni/mOlrsRDNhpX0k/MslgU
        jkLBHckHUwJlqj+kdu0iL+hP9qVn
X-Google-Smtp-Source: APXvYqxZK+7MC2bg3h+ndXVpb5dFmtIvnQ5+bHunPpqNpPbznQI3ixdBM3HjdjMQ8ZCKrfjy2oBpVA==
X-Received: by 2002:a19:e619:: with SMTP id d25mr21352598lfh.34.1561032549814;
        Thu, 20 Jun 2019 05:09:09 -0700 (PDT)
Received: from mail-personal.localdomain (v902-804.aalto.fi. [130.233.11.55])
        by smtp.gmail.com with ESMTPSA id p29sm3508081ljp.87.2019.06.20.05.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 05:09:08 -0700 (PDT)
Received: by mail-personal.localdomain (Postfix, from userid 1000)
        id DAC9B602E7; Thu, 20 Jun 2019 15:09:04 +0300 (EEST)
Date:   Thu, 20 Jun 2019 15:09:04 +0300
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 7/7] rslib: Fix remaining decoder flaws
Message-ID: <20190620120904.GB1116@mail-personal>
References: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
 <20190330182947.8823-8-ferdinand.blomqvist@gmail.com>
 <alpine.DEB.2.21.1906172249580.1963@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906172249580.1963@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019-06-17 23:00:27, Thomas Gleixner wrote:
>On Sat, 30 Mar 2019, Ferdinand Blomqvist wrote:
>> The decoder is flawed in the following ways:
>
>...
>
>Aside of the fact that I had to wrap my brain around this crime I committed
>more than a decade ago, all of this was really a pleasure to review.
>
>Thanks a lot for putting that effort in! I'm looking forward to V2 of that.
>
>Thanks,
>
>	tglx

Thanks for the review and comments! Will submit V2 shortly. Hopefully it 
addresses all concerns and suggestions in a satisfactory way.


Best,
Ferdinand
