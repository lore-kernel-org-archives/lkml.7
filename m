Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE85BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BE520835
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOGPfuVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfCTAxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:53:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46386 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfCTAxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:53:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id a22so399720pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dpCddqCmlhGyWyhS7C7r0+CGxfO81qERzU0CKME3BPQ=;
        b=JOGPfuVp00PibJiY1lX80qZBVdsO5epnmcGnA4moddPxIant5w0zqj+2ybWCeSXZJ6
         0jCUUUZi3eW295+Sh5BtwmBYtxZ8as2yWJ1lkSvD0V3FIbVGUGdUrmSjsbBioGRy0SwT
         a6/EuOxh+DliX9Tz6xEanzUqCSWW7m3i9fUPPukpY/7muVzgmv6BgnLjRc6WRx+ZVNVu
         5Q9Su7CxEkc2/o/UE8OBtbyS5pL0hkBNHWmIRuiVmKFJd+gJGHZ6Za0G/O91bmw5R6TB
         Hn6dGyy6zJ76TZOcvfzWJ/3x+kcF43IgpGFCCVrJI7LZneZuaWvgCS4EJjgCpeSIhYcA
         CJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dpCddqCmlhGyWyhS7C7r0+CGxfO81qERzU0CKME3BPQ=;
        b=q8lVQKqWxZrDK+wWhWpxaspHPr+Pa/AjbrntAMZm366yBbawXIdyU+6PxAAqjsUm8i
         fKjuiunrcbQp6pdeKd8we7pCVENDDVQXF7C7DAWZxoVWdKzZEW1X2xniVfvbDsCXIN5l
         6vOjtDzisQiyBLc9eo56qz2PM9qWD9hBZsUYoLSRlEqEgVrPfeYZl86TDACupbZudM1n
         hSqO49/ODr6tWDSG7J1ax7D5XWsQp4qDnuqYyikOdz0mnfc/MWOo3leJXUV0fqCQQnZI
         hQgjAW/+TEWlrL9MYASHdwJwQFMh4gga2F92lpM86dMFDe1YMzUbzpX2j6TzMeJw9P/j
         QmuQ==
X-Gm-Message-State: APjAAAWpZYe8P063qlaJtKs3JouhxRTbDfyZ31nUqtZWI/SDehsq8M0x
        8VZsWvrzRHPMNrV6cr00J0y3dg==
X-Google-Smtp-Source: APXvYqzmJ7dvx65HjZAxLlw7ltFKPcvUh2AmbHzeB3QMbmXSc2V8s1/umdgGWpPJmU3/OFGevH9fwA==
X-Received: by 2002:a63:e002:: with SMTP id e2mr5015037pgh.300.1553043232442;
        Tue, 19 Mar 2019 17:53:52 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id i126sm316612pfc.101.2019.03.19.17.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 17:53:51 -0700 (PDT)
Date:   Tue, 19 Mar 2019 17:53:51 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christopher Lameter <cl@linux.com>
cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [RFC 0/2] guarantee natural alignment for kmalloc()
In-Reply-To: <01000169988d4e34-b4178f68-c390-472b-b62f-a57a4f459a76-000000@email.amazonses.com>
Message-ID: <alpine.DEB.2.21.1903191751560.18028@chino.kir.corp.google.com>
References: <20190319211108.15495-1-vbabka@suse.cz> <01000169988d4e34-b4178f68-c390-472b-b62f-a57a4f459a76-000000@email.amazonses.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019, Christopher Lameter wrote:

> > The recent thread [1] inspired me to look into guaranteeing alignment for
> > kmalloc() for power-of-two sizes. Turns out it's not difficult and in most
> > configuration nothing really changes as it happens implicitly. More details in
> > the first patch. If we agree we want to do this, I will see where to update
> > documentation and perhaps if there are any workarounds in the tree that can be
> > converted to plain kmalloc() afterwards.
> 
> This means that the alignments are no longer uniform for all kmalloc
> caches and we get back to code making all sorts of assumptions about
> kmalloc alignments.
> 
> Currently all kmalloc objects are aligned to KMALLOC_MIN_ALIGN. That will
> no longer be the case and alignments will become inconsistent.
> 
> I think its valuable that alignment requirements need to be explicitly
> requested.
> 
> Lets add an array of power of two aligned kmalloc caches if that is really
> necessary. Add some GFP_XXX flag to kmalloc to make it ^2 aligned maybe?
> 

No objection, but I think the GFP flags should remain what they are for: 
to Get Free Pages.  If we are to add additional flags to specify 
characteristics of slab objects, can we add a kmalloc_flags() variant that 
will take a new set of flags?  SLAB_OBJ_ALIGN_POW2?
