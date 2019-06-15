Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF38C46477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 18:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE642184D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 18:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="EY/IUPVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfFOSJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 14:09:21 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43956 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfFOSJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 14:09:21 -0400
Received: by mail-ot1-f65.google.com with SMTP id i8so5654062oth.10
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cb0Hmo2zAZrYDyoCgAidl3UeL9kc8+XrLoGdt6CrXZE=;
        b=EY/IUPVbu+1KTXp5GI53vNwR2z9Nvu64XsQUizbEMMU+aGYsXWtd2lTzv6Rx3V/2OG
         ZCHaTlatz8Y6DgkD78CATBQ1yUSjk/05HpPEqetVEj/+F5+Kom/9e7XbdGpDgyQQCBnL
         yj7evXXPdyreGRqDjU90YAS5Z/xg/+W8t5onIf68LdBa/3dqW/rLtaWBvtaURMP28S5L
         ACzapU9ov4J0F0u3SlQrs+vm8YDjsJurYg/jGuJheOXTmxVlf3qQXGWQIp1J0v1wmtf3
         4CKVxNLpNlkzY6vy0HsyUqk2Hkklo6bAEUB4ced5+znlBd2UCAgiXhA0LcanxooGfjdt
         jtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cb0Hmo2zAZrYDyoCgAidl3UeL9kc8+XrLoGdt6CrXZE=;
        b=OrnDLUJOoSEukJUegBvsrOWTFoDOj+aEuve1V8pVbNaboccn0dQy/lvvWJ2+LlJKNw
         uDO6ulncfNN+X8DOO/LqILvOiN26VbuDO3Br/WMYICw4Lcbu/80CVVQzJWMtAj+wMsoh
         QgeDznhKr5d416351zwFBf0g0EfjTPbbMUboXIaeuKn5JzP4hOOzmjcAsyINA2xB56bd
         a3bCjxrJSDKdFTLo7vTJ+WxSE6jEIihS2gu4ShwFMt6KO8TGLbTR274hn8KWPZRb7eLa
         QAVFVK15eFZ7e2eb0hSbifj6oBYMFQLrZs4URy0TEKVl1Qr3o6QfCJ9RX0aLkM3MCZq+
         SAxw==
X-Gm-Message-State: APjAAAWgKchRl0E3t8J/cxPeVZzeYiwyHO4zegOv1jdeJeCpVkb/rje8
        /oGqBibB7Z7WkBWfxp3DfM1UVQs5qMCjKDbgRKXoXw==
X-Google-Smtp-Source: APXvYqxK2ja20GipaVbp7qq4Oaf290msf2s3XleRazQ4mdHqmcalk7o8VyutGF6B5iu+bOwCwwdJPEhdvYDhbnFupMs=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr44930666otn.71.1560622160642;
 Sat, 15 Jun 2019 11:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de> <CAPcyv4jBdwYaiVwkhy6kP78OBAs+vJme1UTm47dX4Eq_5=JgSg@mail.gmail.com>
 <20190614061333.GC7246@lst.de> <CAPcyv4jmk6OBpXkuwjMn0Ovtv__2LBNMyEOWx9j5LWvWnr8f_A@mail.gmail.com>
 <20190615083356.GB23406@lst.de>
In-Reply-To: <20190615083356.GB23406@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 15 Jun 2019 11:09:09 -0700
Message-ID: <CAPcyv4jkDC3hRt_pj1e8j_OmzJ-wdumy-o1bN0ab=JVE_gfKdg@mail.gmail.com>
Subject: Re: dev_pagemap related cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 1:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 14, 2019 at 06:14:45PM -0700, Dan Williams wrote:
> > On Thu, Jun 13, 2019 at 11:14 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Thu, Jun 13, 2019 at 11:27:39AM -0700, Dan Williams wrote:
> > > > It also turns out the nvdimm unit tests crash with this signature on
> > > > that branch where base v5.2-rc3 passes:
> > >
> > > How do you run that test?
> >
> > This is the unit test suite that gets kicked off by running "make
> > check" from the ndctl source repository. In this case it requires the
> > nfit_test set of modules to create a fake nvdimm environment.
> >
> > The setup instructions are in the README, but feel free to send me
> > branches and I can kick off a test. One of these we'll get around to
> > making it automated for patch submissions to the linux-nvdimm mailing
> > list.
>
> Oh, now I remember, and that was the bummer as anything requiring modules
> just does not fit at all into my normal test flows that just inject
> kernel images and use otherwise static images.

Yeah... although we do have some changes being proposed from non-x86
devs to allow a subset of the tests to run without the nfit_test
modules: https://patchwork.kernel.org/patch/10980779/

...so this prompts me to go review that patch.
