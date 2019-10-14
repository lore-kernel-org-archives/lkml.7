Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C12DECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A592054F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HrE4MoWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfJNIsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:48:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46428 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbfJNIsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:48:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id r18so2396726eds.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xtv8eDUo7LGL8wXNVViezHRuz1eIYtvj8JrfIGcZVug=;
        b=HrE4MoWhmtc/2ksDE63nOcfdOtX17WLrOzhRQ9QxIpfLhDYJ37xkcRCjeilpHPQbY/
         a9VXf8/BQDX+xVYBdbQxwqJg/4C0nxCllPh4PXFjE6krWeWUAUVaKgU8hoVw1CcGNRUj
         havuz7CsORrPqD7MmaYvGtD/MPGCN3gWB5HRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xtv8eDUo7LGL8wXNVViezHRuz1eIYtvj8JrfIGcZVug=;
        b=ETmUQvxV5/hiJ5W/s5NpqGO8lHqI7ajaiTDZGEWAHGsSYLxqoE7sR23IWATujJGFwN
         PE4F4n5deIngUaKS2r9LkKEWRjtOx2pWrVFt3YXJAFZfoHQLdvMiQpyCpfxmXOnv0DF9
         HFVujb1W8TeZmDBMJSHs86KYadMEbzJUOUUrI0W8TDGqlVPoftMFPkuCsGDnVSCObqrV
         /TPKbs4+uvurRGh/LPikyipTezNb/fm56Shd8RctK2vsUQ8M6/QRbTGIR9dVX2dcFshz
         Am583vDJp8rPfJIvaaxltokcUZjRNtYfbsxeyYdvzFIUATnsp7+UCrF5N88CfuZqwzFx
         BYlA==
X-Gm-Message-State: APjAAAXDuT5YCzkze6Sp4dgENtfp0XxbZ40L4k2D1Ib27yQVk7FvJ7zR
        mMCGDnepcUjC+y0GIiB5kGPEAQ==
X-Google-Smtp-Source: APXvYqy/ZEwWAWWWTFpXjJ6+8zSYCyYSv2xT+RJWq3EenfofAI17t+WveIWMFS5L/0g7YiaoBEcqkg==
X-Received: by 2002:a17:906:309b:: with SMTP id 27mr27115276ejv.243.1571042930920;
        Mon, 14 Oct 2019 01:48:50 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id bq13sm2215123ejb.25.2019.10.14.01.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 01:48:50 -0700 (PDT)
Date:   Mon, 14 Oct 2019 10:48:47 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Johan Hovold <johan@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Harald Freudenberger <freude@linux.ibm.com>,
        David Airlie <airlied@linux.ie>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-s390@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/4] treewide: fix interrupted release
Message-ID: <20191014084847.GD11828@phenom.ffwll.local>
Mail-Followup-To: Johan Hovold <johan@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Harald Freudenberger <freude@linux.ibm.com>,
        David Airlie <airlied@linux.ie>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-s390@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20191010131333.23635-1-johan@kernel.org>
 <20191010135043.GA16989@phenom.ffwll.local>
 <20191011093633.GD27819@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011093633.GD27819@localhost>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:36:33AM +0200, Johan Hovold wrote:
> On Thu, Oct 10, 2019 at 03:50:43PM +0200, Daniel Vetter wrote:
> > On Thu, Oct 10, 2019 at 03:13:29PM +0200, Johan Hovold wrote:
> > > Two old USB drivers had a bug in them which could lead to memory leaks
> > > if an interrupted process raced with a disconnect event.
> > > 
> > > Turns out we had a few more driver in other subsystems with the same
> > > kind of bug in them.
> 
> > Random funny idea: Could we do some debug annotations (akin to
> > might_sleep) that splats when you might_sleep_interruptible somewhere
> > where interruptible sleeps are generally a bad idea? Like in
> > fops->release?
> 
> There's nothing wrong with interruptible sleep in fops->release per se,
> it's just that drivers cannot return -ERESTARTSYS and friends and expect
> to be called again later.

Do you have a legit usecase for interruptible sleeps in fops->release?

I'm not even sure killable is legit in there, since it's an fd, not a
process context ...

> The return value from release() is ignored by vfs, and adding a splat in
> __fput() to catch these buggy drivers might be overkill.

Ime once you have a handful of instances of a broken pattern, creating a
check for it (under a debug option only ofc) is very much justified.
Otherwise they just come back to life like the undead, all the time. And
there's a _lot_ of fops->release callbacks in the kernel.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
