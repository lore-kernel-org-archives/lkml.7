Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EC9C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 22:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC2D22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 22:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtzUgNUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfHUWSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 18:18:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46122 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbfHUWSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 18:18:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so2104044plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 15:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uRWHH/aM+UkPunAeZEcYoWrVH4+5skxbUg+WumsRgVA=;
        b=XtzUgNUMdbn+u28A49CH+Fcb4+5NG6wGPAdq2AbB4sJce30mABw9IZ91C2OoBtQmPT
         1wai5Q5IauNOff/9NU/6X8bDfc4tRI8v5Gy8YouagyzD4J5wS+IgfZK2Fz0Bnm7UW4VW
         6vDrZ+IXSjxoeF1UvAYMJqxklW88OErPfGZxjtVBpLfUBZoH6fY8o9/zGk+sAkvTnZgh
         oQ51I6L0ZrHD/xe49onARlEvlcfccpy/Ba1n8TkKA/NgozcxReNxSEtqKJOe+ThEu0Hd
         CyaejOjbCTcvijgnq3nok3FNLdOYE5kFCR8gGYyXPVC87I6+h92hqpz+Ep6NARlyZBes
         UK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uRWHH/aM+UkPunAeZEcYoWrVH4+5skxbUg+WumsRgVA=;
        b=EMgtV23Tg+LK/KxPUa3UfCTCnSMmcsb4c8oA99qjpdxQLOoEVqOHCVkLD2h7nrATtK
         l2Ru1inWeI56oxZTKu+x1veI65xJhiD8tgGfeXzBwTJdn4pUUznaM60cNAXOxOTI669W
         TDPKvbZgO0P0muuw8LvhwgdHzvUZj08M0FvLBqb2iRb7aLRwknecy9uLPKqKEbX2gYGA
         TVKrHTGnPHbcTkxO1G0H2+dtXqqnUvbBC6c1mD3U/jeP4NAPiFeD2E3lCMXeVsx4bwts
         +2sKUeCqNLCWK1HmZhtmkynR61VicbgLeMYtEtxUmf6E9DI36r0MlLF87vhnp0CohkKY
         v4NA==
X-Gm-Message-State: APjAAAXh05YbWpkFJAMR3CkpO4aQAPyj35rvhSxWZS53s0lxMoE3Ru9V
        T/U4NYT1Qqjj/GvEbsjYGuQldw==
X-Google-Smtp-Source: APXvYqxka50xMeSwMF1x/gmisRV3YfDJPdcEkDCUcQ9pUic4vCYwsXw9Y8y4zlmCzrTnTh9KjATPNg==
X-Received: by 2002:a17:902:f096:: with SMTP id go22mr36907820plb.58.1566425896980;
        Wed, 21 Aug 2019 15:18:16 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:668d:6035:b425:3a3a])
        by smtp.gmail.com with ESMTPSA id a11sm848491pju.2.2019.08.21.15.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 15:18:15 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:18:14 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] augmented rbtree: add new
 RB_DECLARE_CALLBACKS_MAX macro
Message-ID: <20190821221814.GB99147@google.com>
References: <20190702075819.34787-1-walken@google.com>
 <20190702075819.34787-3-walken@google.com>
 <20190702160913.ptg4p2jyb6ih43hb@linux-r8p5>
 <CANN689HVDJXKEwB80yPAVwvRwnV4HfiucQVAho=dupKM_iKozw@mail.gmail.com>
 <20190814000616.sd4mxwsewhqqz6ra@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814000616.sd4mxwsewhqqz6ra@linux-r8p5>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 05:06:16PM -0700, Davidlohr Bueso wrote:
> On Tue, 02 Jul 2019, Michel Lespinasse wrote:
> > - The majority of interval tree users (though either the
> > interval_tree.h or the interval_tree_generic.h API) do not store any
> > overlapping intervals, and as such they really don't have any reason
> > to use an augmented rbtree in the first place. This seems to be true
> > for at least drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c,
> > drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c, drivers/gpu/drm/drm_mm.c,
> > drivers/gpu/drm/radeon/radeon_mn.c,
> > drivers/infiniband/hw/usnic/usnic_uiom_interval_tree.c, and probably
> > (not 100% sure) also drivers/infiniband/hw/hfi1/mmu_rb.c and
> > drivers/vhost/vhost.c. I think the reason they do that is because they
> > like to have the auto-generated insert / remove / iter functions
> > rather than writing their own as they would have to do through the
> > base rbtree API. Not necessarily a huge problem but it is annoying
> > when working on inteval tree to consider that the data structure is
> > not optimal for most of its users.
> 
> I think the patch I sent earlier will add to your unhappiness.

Not really, I think the pat conversion is a good idea though I am
confused about the interval definitions (open or closed ?) in your
patch set.

> > - The intervals are represented as [start, last], where most
> > everything else in the kernel uses [start, end[ (with last == end -
> > 1). The reason it was done that way was for stabbing queries - I
> > thought these would be nicer to represent as a [stab, stab] interval
> > rather than [stab, stab+1[. But, things didn't turn out that way
> > because of huge pages, and we end up with stabbing queries in the
> > [stab, stab + page_size - 1] format, at which point we could just as
> > easily go for [stab, stab + page_size[ representation. Having looked
> > into it, my understanding is that *all* current users of the interval
> > tree API would be better served if the intervals were represented as
> > [start, end[ like everywhere else in the kernel.

Do you have any thoughts about changing the interval tree definitions
to use half-open intervals like everywhere else in the kernel ?

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
