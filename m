Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D182CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F1F21D82
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Qq1IRmOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502042AbfJYNor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:44:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33771 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfJYNoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:44:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id c184so1635585pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GB66w5zMnO6g29s6wAcFRJIvcQvj59wk11SwJfYrvKA=;
        b=Qq1IRmOU8QQXXK5dP7qVkmSaMc2yq7Rpi0+jYuWk5ryK9uF4E/5Q5RAo6IRi5rQpYO
         MijLDpKbtbCl53iC6+V6cSZa6ckR+CG9NvnGZp30+L7k1AHj4QImzgeXM8RnK6zDGsxq
         bVKbAvbgwnymLXAiH9nIW3DslByuA/r3z+vVz91vWhYVOQeXG4OoYJsj+3h4TlAZKdJD
         jZjGj8QlSuEFEGqmfb6p9Jd2kqOSjwRtjpebArzGY1EAP86Y2gQqvnJ3LHir/ZHbMuIJ
         ZLFAs2oRcdHHpbtABfKICAgOeJspOrdnp/ZB5wjPI65JZEcHb1rljP+Du8ppywyo5RBY
         OAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GB66w5zMnO6g29s6wAcFRJIvcQvj59wk11SwJfYrvKA=;
        b=ch6GpJ4vKn8sc0EZCJqx/vllbHRtkKOsavdf8o6I9N8DStusITZ6S+ljvEGtm2oNci
         ySMBpzRBPxyZAE2gke1g8pRdX5vUkLecrNAxnczWobUWxgmDS35NXPuEIHMVKjvMvFkr
         +x8ijZ9PrqbZfAY+SoiVzL47jcpcFvs4odEDloRjgdS6OwrjJgH3qAR1ysGNZPW6IVPp
         +8/gHugQ3RDZx5p7EbPUMC3Ezc91xqpiRtYK2k6eVZNEuObXX02mLafOYpjsePngsXOM
         Lq7KtUyidmgMtb0Ixk42x/nIifv/udjlNQweIj5NE02PTzADnmHVloWfU8cPXro/gtUk
         r+0g==
X-Gm-Message-State: APjAAAVJ0hASJiiO6JriqTK1KQhpYbV/y0BzMtnt6U4IY8F2/gHjxEyB
        8xojZRU5BCUe1Trw/1/6hDWImQ==
X-Google-Smtp-Source: APXvYqyiEFjS0AsnLhLndE+VCdtmMKp2KjunxS32g/fNq7UVoFTUkMLRgGPV3k3rKDum27SdorNUaw==
X-Received: by 2002:a17:90a:9f94:: with SMTP id o20mr4347710pjp.76.1572011086048;
        Fri, 25 Oct 2019 06:44:46 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::553e])
        by smtp.gmail.com with ESMTPSA id y17sm2913564pfo.171.2019.10.25.06.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 06:44:45 -0700 (PDT)
Date:   Fri, 25 Oct 2019 09:44:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 5/8] mm: vmscan: replace shrink_node() loop with a retry
 jump
Message-ID: <20191025134443.GA385668@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-6-hannes@cmpxchg.org>
 <20191023141857.GF17610@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023141857.GF17610@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 04:18:57PM +0200, Michal Hocko wrote:
> On Tue 22-10-19 10:48:00, Johannes Weiner wrote:
> > Most of the function body is inside a loop, which imposes an
> > additional indentation and scoping level that makes the code a bit
> > hard to follow and modify.
> 
> I do agree!
> 
> > The looping only happens in case of reclaim-compaction, which isn't
> > the common case. So rather than adding yet another function level to
> > the reclaim path and have every reclaim invocation go through a level
> > that only exists for one specific cornercase, use a retry goto.
> 
> I would just keep the core logic in its own function and do the loop
> around it rather than a goto retry. This is certainly a matter of taste
> but I like a loop with an explicit condition much more than a if with
> goto.

Yeah, as the changelog says, I'm intentionally putting the looping
construct into the "cold path" of the code flow: we only loops in a
very specific cornercase, and having the whole body in a loop, or
creating another function nesting level for it suggests otherwise.

A goto seems like the perfect tool to have a retry for one particular
caller without muddying the code flow for the common call stack.

Matter of taste, I guess.
