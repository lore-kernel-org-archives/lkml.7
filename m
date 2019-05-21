Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DECBC46470
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14364217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558435985;
	bh=NieFekJpcls3cvStkVQ4lObIOw1rZWqS833M5xNAwgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oi0fRFN4MobqqJRXoc219QjnquW3o9QG6pz4ZDMG4broy8vBwNSGN6tC/oy2zcwTz
	 sI0vOhfLYSLzt888wH8Rm0gyFgI11unhe7eukbCoQlE7ucIBrzoRhqCXqaOJBVTzZN
	 Esin7oAv0Sc9fqPsPbbxfokmh4Fms3PtArVoD30o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfEUKxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:53:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46627 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfEUKxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:53:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id y11so8860033pfm.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 03:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Sic2O7wb52L5CR9NZn4I8czhdSoXaChDb/juZvSzjk=;
        b=kqar2URpzHjwHZxhz9FhJySyjNcvp48Yvzwkmxf2VubqeURESj6Vff0i/jsIthS7y9
         fPRjulw8tqg5W/oB23bfQ6UFnd8nscb2aa5s8AAzR6x2gUQbSsbmCcBbB7K1Uh/hzbiv
         ZeoxCNKSzYQ80A1lxxKgGkbjkN61+GLe0vQUUtixqAl/tDRPbShOiB0e1oWE/ejNmBFv
         dqBUvs9CRSKIAN4+yxm1aYazKW+oNgGlzkPpuhdWb4Z3w7wGKiYDfQlj3WlYFi/as9VJ
         VFMSyRQc0lXkd32xUqS1qV7HC6vxnJFGeLEI1qV1TDkfxSHCiLUZ0ohK/bMC56iKFykQ
         9XTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Sic2O7wb52L5CR9NZn4I8czhdSoXaChDb/juZvSzjk=;
        b=JMfnlsuXu8JIfhQJG9u8+YXWZMO2sSOMRNHzdbhtbgl3foV+FHe+Co61lgM1Wkdkj5
         MTcS6KGGUhvx7EzSpyhU2+YUWLrHXDoeTg3YqlJhUBQXfv7HGCMca5+k1oZmMX1GQbaT
         r9PJKe2voPG638Ey5ECcvrXRrrzFu40wK4WhC0pRx/0SVle+u/eE8eYPPvNijtcPuAuy
         vH8OfMPFaQBulr89qTms5ictAZOAdXuKml/exb0c/vNhNpvO40HIMYiABBZu7ZcABFFC
         +iT+7dOPdRfmfHx4qCel3RpHO18R5leHIf3slqFrFg/ToInZWXLLwFh4FE7J2DOjxRVG
         Yohw==
X-Gm-Message-State: APjAAAVFjTynL2lGRMXVM8OPpzEj4x2FxYWPSWSecSa+Uh7cCsr2W0sm
        ax07f4ivYMlmjo5xAbUFB7w=
X-Google-Smtp-Source: APXvYqzWwsWL/43VXabxfdXeVLd95/lm6etnN5YVFlIWX66F8XbYX0NSYXLCPcewwlk31OvvzN3rhw==
X-Received: by 2002:a63:ba5a:: with SMTP id l26mr80865856pgu.183.1558435982668;
        Tue, 21 May 2019 03:53:02 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id j64sm37602676pfb.126.2019.05.21.03.52.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 03:53:01 -0700 (PDT)
Date:   Tue, 21 May 2019 19:52:56 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 4/7] mm: factor out madvise's core functionality
Message-ID: <20190521105256.GF219653@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-5-minchan@kernel.org>
 <20190520142633.x5d27gk454qruc4o@butterfly.localdomain>
 <20190521012649.GE10039@google.com>
 <20190521063628.x2npirvs75jxjilx@butterfly.localdomain>
 <20190521065000.GH32329@dhcp22.suse.cz>
 <20190521070638.yhn3w4lpohwcqbl3@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521070638.yhn3w4lpohwcqbl3@butterfly.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 09:06:38AM +0200, Oleksandr Natalenko wrote:
> Hi.
> 
> On Tue, May 21, 2019 at 08:50:00AM +0200, Michal Hocko wrote:
> > On Tue 21-05-19 08:36:28, Oleksandr Natalenko wrote:
> > [...]
> > > Regarding restricting the hints, I'm definitely interested in having
> > > remote MADV_MERGEABLE/MADV_UNMERGEABLE. But, OTOH, doing it via remote
> > > madvise() introduces another issue with traversing remote VMAs reliably.
> > > IIUC, one can do this via userspace by parsing [s]maps file only, which
> > > is not very consistent, and once some range is parsed, and then it is
> > > immediately gone, a wrong hint will be sent.
> > > 
> > > Isn't this a problem we should worry about?
> > 
> > See http://lkml.kernel.org/r/20190520091829.GY6836@dhcp22.suse.cz
> 
> Oh, thanks for the pointer.
> 
> Indeed, for my specific task with remote KSM I'd go with map_files
> instead. This doesn't solve the task completely in case of traversal
> through all the VMAs in one pass, but makes it easier comparing to a
> remote syscall.

I'm wondering how map_files can solve your concern exactly if you have
a concern about the race of vma unmap/remap even there are anonymous
vma which map_files doesn't support.

> 
> -- 
>   Best regards,
>     Oleksandr Natalenko (post-factum)
>     Senior Software Maintenance Engineer
