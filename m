Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39898C17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 18:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14712214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 18:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T77cTQzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfKJSr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 13:47:27 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34018 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfKJSr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 13:47:27 -0500
Received: by mail-io1-f66.google.com with SMTP id q83so11984901iod.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ihq7lt4JbEWY+6wcZIMjCy2sGUa9cv1FuVr47U5+8AE=;
        b=T77cTQzBar9ULi4M3ndLSVhNCosWXGzTRsGB77e60yHLU89i55/ZoPV4lASEP4fZ5S
         UNGlHrBePOP28fLENE1BqS6l83VZhkIIfpg9Qon3vOsItveQhcTsrMCmczZJBJkpAVGM
         vn5Lwv7vCBatSN8Q9WSOKPjCuXSkLKGdoGdgRGs9h02v4JML4Q6KLocIwGdfKlYEcE9Y
         eyFB2cBrKhSlyQ9zceZbmxU54G3382lrEqFCat5J9rj8to7G+mrDcEIAzQspu8nD5GAX
         o38yTtoizmQiQHbi7byEyN0xhpJNxzu8UFKr1GTl3z8nVWYzANEQFF9O1iLEETyYnW3x
         40IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ihq7lt4JbEWY+6wcZIMjCy2sGUa9cv1FuVr47U5+8AE=;
        b=UYKnTwehXAP9rAoi989rllcrecMcygpul+ccvlNA0LMk0uTT3H3pay/F5ZaNC1qrvg
         bOkTOZBGeKJQ/+L2XHcOUGhHrZbXgAGF5C+sLJE5WvQdrc6cjYOlcTEuAcZ0ULGqpfDj
         Jy5ktW9jDQXi5/o7dExhk3T1p1HOg+dlLfx36eCgK2w/itCMREhnkzLxC1o8Kv5czN6L
         O8khL9A1NB3/g5vDF/Al1R9VzeBMltZ5ChdzXdhIiWfcDlFnsUZ/g+0Ahr8CUJlIpU/0
         gwn0KgXMC5pa+E0tCPOAO4ZrJchYrt0BATLRMWMM6OetED6l+1Vx3AHGXQfnJEshb6LW
         Ofyg==
X-Gm-Message-State: APjAAAUDMoHPOUsIgddiIDk4PLDCUvb7klaAFn1w/9mPYCk5phxujmzt
        eGzUfRTJoVOu8nwGXOjnGLYqHA==
X-Google-Smtp-Source: APXvYqxLkoIQ3LUVM1Fqb7H2YFPYu78eeSDnBiTZ0MwnEwtPq05F0D0BEsTGr6kALLsT8iCxHxE/Dg==
X-Received: by 2002:a05:6602:2429:: with SMTP id g9mr22152846iob.294.1573411646528;
        Sun, 10 Nov 2019 10:47:26 -0800 (PST)
Received: from google.com ([2620:15c:183:0:9f3b:444a:4649:ca05])
        by smtp.gmail.com with ESMTPSA id q69sm1745807ilb.4.2019.11.10.10.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 10:47:25 -0800 (PST)
Date:   Sun, 10 Nov 2019 11:47:21 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 2/2] mm: avoid slub allocation while holding list_lock
Message-ID: <20191110184721.GA171640@google.com>
References: <20190914000743.182739-1-yuzhao@google.com>
 <20191108193958.205102-1-yuzhao@google.com>
 <20191108193958.205102-2-yuzhao@google.com>
 <alpine.DEB.2.21.1911092024560.9034@www.lameter.com>
 <20191109230147.GA75074@google.com>
 <alpine.DEB.2.21.1911092313460.32415@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911092313460.32415@www.lameter.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09, 2019 at 11:16:28PM +0000, Christopher Lameter wrote:
> On Sat, 9 Nov 2019, Yu Zhao wrote:
> 
> > >  	struct page *page, *h;
> > > +	unsigned long *map = bitmap_alloc(oo_objects(s->max), GFP_KERNEL);
> > > +
> > > +	if (!map)
> > > +		return;
> >
> > What would happen if we are trying to allocate from the slab that is
> > being shut down? And shouldn't the allocation be conditional (i.e.,
> > only when CONFIG_SLUB_DEBUG=y)?
> 
> Kmalloc slabs are never shut down.

Maybe I'm not thinking straight -- isn't it what caused the deadlock in
the first place?

Kmalloc slabs can be shut down when memcg is on.
