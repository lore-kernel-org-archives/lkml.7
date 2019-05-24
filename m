Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F40C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A282120879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558733113;
	bh=DuRNdWoXNPWV/pDGEpjUDa9jGsQd439eg7QG44LhEX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uJtz1gexghKJMnE9sqvkqf8bNCo38+HK7KzhuaxH7jPKFinsWHvycSHCuWBCRDdgs
	 suYlCD3ZwJVecpm9+1NhIoNK9xDtPY053IsS3yDByrHTfsmboXBIH2+tjjhuQnJhft
	 AYd5TSDVzGMOnttRNeKtLOduF8iQg8SKudEG77dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404238AbfEXVZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 17:25:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44049 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391745AbfEXVZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:25:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id e13so9830251ljl.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 14:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FaNODhvZ2zAz55V/9kwroMA+03aglfJn5x7CPbjTXdc=;
        b=UQLo0B1wSkr2mGGLg5df1Lw+lipLZ19BvIfuApojhfgWtsKM6k4z0VWid3Zce/OTVa
         7HR1n1qN30kYlFrm2hAbZVORtbw8JyEzl906TZ1o72a7bKROciBc2FfJ1CfI4n+NjVqX
         bLyZRGC5+BrNgD8rNeMOspVyx9H5c3sfMDU7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FaNODhvZ2zAz55V/9kwroMA+03aglfJn5x7CPbjTXdc=;
        b=KcU7lfDLp6s+T8TFJD6NRUFhGzMtigcE1YKgrhXgxtIm1nttuDcie3ugMVDF3iPgt8
         QXVvq5Z68h04yf5iR6zxKYeV/LGpuvvZTfxuShJRodDZXggMwgnmNZ5G3RS2N/18PXIL
         bL96aA6/fN1A2Ii32fx17nKtYIUZOqoWNrQlL0IGmqHkWIVyYIb6vYZDVZE6BY9MQiRl
         1L/U1xBdIii3f43dexWmKo8jcVOZZmcA5FQvCso/WBrAcPx9GAAUB7S+FzM/xVAU8Zt2
         V0InO12bO2hxTWPhoIBSJK/d+6GKp6X+5+YzGy6HmFVpbbTpJ5C7sz7RrX9nHMJGiEAq
         uzvQ==
X-Gm-Message-State: APjAAAUGdxeUOjejxbUVK6Z5JOGY+x9vPkohoXr6k80u5gj128jYBLSn
        1SocRdeCWtknYPLl9iCoUobKfeazadY=
X-Google-Smtp-Source: APXvYqy5hgEvHt+fFVJNI0apzE5ReBsqt1dTzWZKT3YSM1cJxfOsqax3iBqzKnlV7/Dx7JrBjZ+low==
X-Received: by 2002:a2e:890c:: with SMTP id d12mr48270397lji.107.1558733109048;
        Fri, 24 May 2019 14:25:09 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 12sm735465ljf.12.2019.05.24.14.25.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 14:25:07 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id l26so8100925lfh.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 14:25:07 -0700 (PDT)
X-Received: by 2002:a19:7418:: with SMTP id v24mr8033313lfe.79.1558733107295;
 Fri, 24 May 2019 14:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190524194222.8398-1-longman@redhat.com>
In-Reply-To: <20190524194222.8398-1-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 May 2019 14:24:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi35_2=5AZTigBw3mPcLPriDJ3-C8fe-FPxLnp7b=464Q@mail.gmail.com>
Message-ID: <CAHk-=wi35_2=5AZTigBw3mPcLPriDJ3-C8fe-FPxLnp7b=464Q@mail.gmail.com>
Subject: Re: [PATCH v4] locking/lock_events: Use this_cpu_add() when necessary
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 12:42 PM Waiman Long <longman@redhat.com> wrote:
>
> Fixes: a8654596f0371 ("locking/rwsem: Enable lock event counting")

Applied directly,

               Linus
