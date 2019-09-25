Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4F3C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AE52146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu3jazJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbfIYQ1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:27:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38546 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732803AbfIYQ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 12:27:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id l21so3646436edr.5;
        Wed, 25 Sep 2019 09:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Kf9hn93bVYZrlXSfMDSlr/mbW/U/UaPgHwruad4IfQ=;
        b=Hu3jazJhr8bfs8oWmIbbhJVAnoTr793yhYViKFnPqhtjf2B3dHLr1oYLFE+X5ok1YN
         xyk7tbfScIGQcnVnHc6j3ScJa5jqlhn7Dov4EEgjw852Hu2iw+Fz98IhfhLIf2EZPrxz
         a7SXxbAIPLJ1dOFSZ9EnKd3DiySqio5TxtzpadfyjmxcSz6aJMCzex/RMJEH8aHpDFWa
         7EePeY0zH4WY2J2eAr4VYBRb5LaA2bHhiWNkSoVBOGuZnTy+VeGIwQL5P7tAUP2549ac
         RUWvzWBeiJ9/d/ynPv7/QPLT/+QF5XZu15lyFj+k7P+ABxryvcvBOnYW5hBaabOFDNFA
         cGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Kf9hn93bVYZrlXSfMDSlr/mbW/U/UaPgHwruad4IfQ=;
        b=MmB5EGahmd6g6FQaXZqtTqx22CRiB38GvsOwIXlK+FbJjjcaW02RPTtVBGqBM/pufX
         d969dvX59LV47i7z0Jqb4hFUhPHXcv2eoRe5MBi5EO9nQJdn64AgBBfJLICxQYvmXqfz
         j7mR67C4BZL9IuhBBv4Rt6nCShQFczBjQgVa5BplVIuwama9mqXzibTIOHQU5T7g1lyS
         pm9m0ywpuIdEGi/qQ8TUCSn9STLDO4yE8RzdR8p3lZWu6tw66Nqmv79Dr0vLMzsRLjvc
         szJNux4K66YxSYOSV8bwK8cXz4p/SgzE0iL7znMX3LRChkhXmdvgQ4z/LZY2SFuc2Dym
         0P6A==
X-Gm-Message-State: APjAAAV5UuodjMaPkZPuZu+78X8ry8Pz8MiIXu8fsvQ9FMc0NTV0sAEg
        y9V6SoOiUHDPMVEX1qKMRTE=
X-Google-Smtp-Source: APXvYqwsFPU0lvrsUmak9UXNUaAHaVaLkkJTDjkX+a7IIfjcv1CUu6jPL9gJOVmYaq5xeJ1xwBdcKg==
X-Received: by 2002:a17:906:5fc4:: with SMTP id k4mr78627ejv.300.1569428824597;
        Wed, 25 Sep 2019 09:27:04 -0700 (PDT)
Received: from localhost.localdomain ([185.107.117.129])
        by smtp.gmail.com with ESMTPSA id g15sm1094346edp.0.2019.09.25.09.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 09:27:03 -0700 (PDT)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92.1)
        (envelope-from <jekhor@gmail.com>)
        id 1iDA8G-0000yO-Ic; Wed, 25 Sep 2019 19:27:12 +0300
Date:   Wed, 25 Sep 2019 19:27:12 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [PATCH v5 1/1] platform/x86/intel_cht_int33fe: Split code to USB
 Micro-B and Type-C variants
Message-ID: <20190925162712.GA3653@jeknote.loshitsa1.net>
References: <20190920223356.6622-1-jekhor@gmail.com>
 <20190920223356.6622-2-jekhor@gmail.com>
 <1cca117d-1951-0335-1aef-ac994c3c757b@redhat.com>
 <CAHp75VcoS2OFr8kwM7vq0iCqf6BpyJ4SO7peAUHKxAXdgA7CMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcoS2OFr8kwM7vq0iCqf6BpyJ4SO7peAUHKxAXdgA7CMA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 06:02:22PM +0300, Andy Shevchenko wrote:
> On Sat, Sep 21, 2019 at 9:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi,
> >
> > On 21-09-2019 00:33, Yauhen Kharuzhy wrote:
> > > Existing intel_cht_int33fe ACPI pseudo-device driver assumes that
> > > hardware has Type-C connector and register related devices described as
> > > I2C connections in the _CRS resource.
> > >
> > > There is at least one hardware (Lenovo Yoga Book YB1-91L/F) with Micro-B
> > > USB connector exists. It has INT33FE device in the DSDT table but
> > > there are only two I2C connection described: PMIC and BQ27452 battery
> > > fuel gauge.
> > >
> > > Splitting existing INT33FE driver allow to maintain code for USB Micro-B
> > > (or AB) connector variant separately and make it simpler.
> > >
> > > Split driver to intel_cht_int33fe_common.c and
> > > intel_cht_int33fe_{microb,typec}.c. Compile all this sources to one .ko
> > > module to make user experience easier.
> > >
> > > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> >
> > This version still works for me on my typec device:
> >
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> >
> > The code also looks good to me:
> >
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >
> 
> By some reason it doesn't apply.

I have checked, and have no issues when applying this patch to the current
torvalds/master and linux-next/master branches (351c8a09b00b and 9e88347dedd8
commit IDs).


-- 
Yauhen Kharuzhy
