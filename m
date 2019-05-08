Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A59C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEF120675
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfEHTxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:53:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35900 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfEHTxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:53:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id a17so3729625qth.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 12:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HCtX1frjqYU3uAHx2sJHA2OsRYk/uvM/1v6XS0m5Flc=;
        b=MfaMhbQEXZjY3kCi3m9agOToeTIW0LR+VPZe4nEUjeGd5NuxVQiO0Q5ZTQ+oTXlMc7
         Yoxs3aT2NjwdboyCA5klTkgZm783kRUQYPupxdtEgQuR4JkyB7fOt56AKXZ3rlNk0xUG
         bNSGEqNG7CXtWkMIan+9YAuzy/iZdvRjSKp3SazjpfIVwRHPfYCKQ2yTcEEWwa2b66hM
         O1wOp7bmWVj2kK/hh9Js8aaZSA8hcTezLM6Or7y4vf86MqcR9Hqpjt8ZUznHR11WZ8q0
         p/qxDnORajC3BVYwrZ4vkQ3VMWH09jrAWM5yzjbCaiOjp1NKg5vlK7XFNErFteDMUBkn
         HZlw==
X-Gm-Message-State: APjAAAU9qW/IusEcrp0Vl55QAGUmxu0dV4xQR9+zNaQXhXfLApWH2sNC
        AJaiDYA6y1T7oqMkcV/5kKHDKSR0Gd8=
X-Google-Smtp-Source: APXvYqwIq+qQq7KlphUsKHG//ULb8acsh1YzsFVjn3RIncz2/sckcX3cNza0iJjt02Ns8Uoy45TFHg==
X-Received: by 2002:aed:22ad:: with SMTP id p42mr6782261qtc.86.1557345184623;
        Wed, 08 May 2019 12:53:04 -0700 (PDT)
Received: from vitty.brq.redhat.com ([64.251.121.244])
        by smtp.gmail.com with ESMTPSA id g206sm9519349qkb.75.2019.05.08.12.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 12:53:03 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Stephen Hemminger <sthemmin@microsoft.com>,
        "m.maya.nakamura" <m.maya.nakamura@gmail.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] x86: hv: hv_init.c: Replace alloc_page() with kmem_cache_alloc()
In-Reply-To: <BYAPR21MB1317AC7CA4B242106FCAD698CC320@BYAPR21MB1317.namprd21.prod.outlook.com>
References: <cover.1554426039.git.m.maya.nakamura@gmail.com> <bdbacc872e369762a877af4415ad1b07054826db.1554426040.git.m.maya.nakamura@gmail.com> <87wok8it8p.fsf@vitty.brq.redhat.com> <20190412072401.GA69620@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net> <87mukvfynk.fsf@vitty.brq.redhat.com> <20190508064559.GA54416@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net> <87mujxro70.fsf@vitty.brq.redhat.com> <BYAPR21MB1317AC7CA4B242106FCAD698CC320@BYAPR21MB1317.namprd21.prod.outlook.com>
Date:   Wed, 08 May 2019 15:53:03 -0400
Message-ID: <87bm0csoyo.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <sthemmin@microsoft.com> writes:

> I would worry that kmem_cache_alloc does not currently have same alignment constraints.
> See discussion here:
> https://lwn.net/SubscriberLink/787740/a886fe4ea6681322/

I think it even was me who reported this bug with XFS originally :-) 

Yes, plain kmalloc() doesn't give you alignment guarantees (it is very
easy to prove, e.g. with CONFIG_KASAN), however, kmem_cache_create() (and
dma_pool_create() to that matter) has explicit 'align' parameter and it
is a bug if it is not respected.

-- 
Vitaly
