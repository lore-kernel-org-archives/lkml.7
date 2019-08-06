Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CE0C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA3920665
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="XtIPgb4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbfHFFee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 01:34:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40779 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFFee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:34:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so40846597pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 22:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ITZzXk4hkchefAa/C9vch93mRZp0Y9hrzcYHt1CxoXA=;
        b=XtIPgb4wZqOrKmW/tyl/QqxOYFVvbKKuvd9MA51RVQmTlFCPH2GcLl2+Yms2/Avcg9
         EZTxoWpQQUenC6fwYQ+VTBb7m34eiUsH2fGBy0sdch+TGCxAIZOZSk/oxFFOplsuZa9e
         V6E1ChrlnDWbp8GoKFGKqvTacAXBLXp3rbiVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ITZzXk4hkchefAa/C9vch93mRZp0Y9hrzcYHt1CxoXA=;
        b=gHk5cb26UidHXi8IDhLfd21uu1zCbuwvlHO5l+XjrejWHO1EjHr1rTmBpHcib5ZllU
         cGGTkdwxzbvt900+Slbtvcg3Yk3xF+d/rUwP4cP18jVjR6aWu2C/zIOL105yejxTo2SF
         ZmuSQOIIOhrft61MqHyD/UC8iMh0binr2HbRKAVgHlkeJWiW/RxPaFJdQDfdaeJyOobd
         FrDtWWfxIJCRcsbYECutgec5uJ2SyicJ2UKArk3UUMRKYOaX89vZciZ+DDl6yrDSi2G3
         QP2fYfdSFmFw4IQZpox+eGovSvX/ZiyC6kSX1HqFyak51l3TW0/lgZjrMoV/WQbSlIWa
         CFmg==
X-Gm-Message-State: APjAAAXRkB5lDasN17wPtOG0AIY+iwCgX6yOUlcLXpQE+g2T9vADGfcu
        mrKAkSCfnfOwgbnMAio7vP+9dg==
X-Google-Smtp-Source: APXvYqzH8Z0Hn489Zyo573sDGL6BycECAxRLofQeib0NEkjpsn4FwKtl3QVZuhTS8CTnrpt5DYMuQQ==
X-Received: by 2002:a62:5883:: with SMTP id m125mr1817575pfb.248.1565069673515;
        Mon, 05 Aug 2019 22:34:33 -0700 (PDT)
Received: from luke-XPS-13 (114-198-81-189.dyn.iinet.net.au. [114.198.81.189])
        by smtp.gmail.com with ESMTPSA id 143sm131382923pgc.6.2019.08.05.22.34.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 22:34:32 -0700 (PDT)
Date:   Mon, 5 Aug 2019 22:34:26 -0700
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        syzbot+a4387f5b6b799f6becbf@syzkaller.appspotmail.com
Subject: Re: [PATCH 5.2 10/20] media: radio-raremono: change devm_k*alloc to
 k*alloc
Message-ID: <20190806053426.GA7108@luke-XPS-13>
References: <20190802092055.131876977@linuxfoundation.org>
 <20190802092100.285432717@linuxfoundation.org>
 <9403fd1e250bb4dd8e1bcf0536e6d224be7c889c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9403fd1e250bb4dd8e1bcf0536e6d224be7c889c.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there, 

On Fri, Aug 02, 2019 at 03:04:25AM -0700, Joe Perches wrote:
> On Fri, 2019-08-02 at 11:40 +0200, Greg Kroah-Hartman wrote:
> > From: Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
> > 
> > commit c666355e60ddb4748ead3bdd983e3f7f2224aaf0 upstream.
> > 
> > Change devm_k*alloc to k*alloc to manually allocate memory
> > 
> > The manual allocation and freeing of memory is necessary because when
> > the USB radio is disconnected, the memory associated with devm_k*alloc
> > is freed. Meaning if we still have unresolved references to the radio
> > device, then we get use-after-free errors.
> > 
> > This patch fixes this by manually allocating memory, and freeing it in
> > the v4l2.release callback that gets called when the last radio device
> > exits.
> 
> This really should be commented in the code
> and not just in the commit changelog as some
> unsuspecting person will likely undo this in
> the future without one.

You reckon I should submit a patch with the necessary parts commented? 

Thanks, 
- Luke
