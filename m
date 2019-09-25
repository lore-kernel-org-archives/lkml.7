Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA647C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3FE21D79
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt6NIi0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbfIYT4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 15:56:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34299 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731229AbfIYT4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:56:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id a11so116175wrx.1;
        Wed, 25 Sep 2019 12:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uwE3NiK8u+bxgHZ+HUFoTn6YzX3YfI6lWA87gOzdcWY=;
        b=Xt6NIi0WjoL2BbXIfO4Qdd2wVTiqsKYtqYFdYd48zmhuGPqisIsviqcJG+G43NSsDO
         k0URO6ROFk3tYd5J2CgP1dF7O/c45PTOb5oW4WksihDC1/RaFJwbDMQljl1z9//jMb4H
         blWJm1QibltgkD0SMMH3AA+zAjJoPuR0p+PYdgyiss7wwpOQMucE3g7Un39N8i4huPFt
         3iMsHsxXTjsD8xYS0WPzGJEW4O+hkt9rijBD2uygsrUZb/kt9FLM6a2Hi8qmQXdaGMgY
         kSmTUwp+IeRh4NWCaz7zlt0Nhna6eSstMFwdHKGjYWvcmi9jRo9jpzaHlr9lCS19CWye
         yIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uwE3NiK8u+bxgHZ+HUFoTn6YzX3YfI6lWA87gOzdcWY=;
        b=gYK0SZyLoAY2d93qN+bBdMo0y2NjFYLtzcgc2rTMj6/xIaKhtIoXq8ah6eqPguYbdH
         KkGDmBoH+Oi4UmOrGgvsMw2z4pfVJHDGm9ldWo5qz1OWqDasI54so6ulfW9h8ZFbNdiE
         KSahOA5YOrlXSuHuSVWYgrxri5GnrqvWQIAd7DScVDanWXJTP3LYqxvxwyOXg9E1SSiZ
         IwaiyfaFm9KzUkPifY+cT8jogEv0b6AQf6IBJOs+kypmlbCwtazWhXD+1Qm5q/ZvLIkz
         xuVWQ0z71iOky9loQqvH4qffgYGK4JQRFnYaRVdkKBKacnDRTCahCcN5Dwtb2DP2xZic
         2FvA==
X-Gm-Message-State: APjAAAWX24ytRotlEWSKiB4hny5kYMTlfTNsurTtN275j9KBIW2ExOCA
        JMjw250CRLjh2ppKP0F4Vs8=
X-Google-Smtp-Source: APXvYqxBrzAB7FElDzuLgGE02iUemO9rVd6fi3TPPuuELGMtG+mycy1PCK8XGE5zVqtwQD0yZ/w4fg==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr67324wrp.122.1569441378315;
        Wed, 25 Sep 2019 12:56:18 -0700 (PDT)
Received: from localhost.localdomain (101.26.95.79.rev.sfr.net. [79.95.26.101])
        by smtp.gmail.com with ESMTPSA id b7sm48899wrj.28.2019.09.25.12.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 12:56:17 -0700 (PDT)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92.1)
        (envelope-from <jekhor@gmail.com>)
        id 1iDDOb-0002f2-6g; Wed, 25 Sep 2019 22:56:17 +0300
Date:   Wed, 25 Sep 2019 22:56:17 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [PATCH v5 1/1] platform/x86/intel_cht_int33fe: Split code to USB
 Micro-B and Type-C variants
Message-ID: <20190925195617.GA8666@jeknote.loshitsa1.net>
References: <20190920223356.6622-1-jekhor@gmail.com>
 <20190920223356.6622-2-jekhor@gmail.com>
 <1cca117d-1951-0335-1aef-ac994c3c757b@redhat.com>
 <CAHp75VcoS2OFr8kwM7vq0iCqf6BpyJ4SO7peAUHKxAXdgA7CMA@mail.gmail.com>
 <20190925162712.GA3653@jeknote.loshitsa1.net>
 <CAHp75VfL0RUgMhZk=gesxBcBfRkfV8kC1zsN9TNg53qpUNVU0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfL0RUgMhZk=gesxBcBfRkfV8kC1zsN9TNg53qpUNVU0w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 08:42:03PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 25, 2019 at 7:27 PM Yauhen Kharuzhy <jekhor@gmail.com> wrote:
> > On Wed, Sep 25, 2019 at 06:02:22PM +0300, Andy Shevchenko wrote:
> > > On Sat, Sep 21, 2019 at 9:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
> > > By some reason it doesn't apply.
> >
> > I have checked, and have no issues when applying this patch to the current
> > torvalds/master and linux-next/master branches (351c8a09b00b and 9e88347dedd8
> > commit IDs).
> 
> It doesn't apply to the subsystem tree (for-next or my review branch)

Yes, it doesn't apply because this subsystem tree doesn't contain commit

"78cd4bf53635 platform/x86: intel_cht_int33fe: Use new API to gain access to the role switch"

which was accepted to torvalds/master tree already.



-- 
Yauhen Kharuzhy
