Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F21C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0C421773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="0Cj5ef94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfC1OFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:05:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38049 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfC1OFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:05:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id d13so18485003qth.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OZsN+KjF6P0mNOSjgzFw3fqkoVmkhJo6T0apoMNZd18=;
        b=0Cj5ef94+CRYvijQ1AKj4UAqc1sd4cV79FVilXIDCXG80htX0gpXBVJh72zcQtcJlO
         83oIVfRWYgGi6lHslyDtBI3ISnwIp+M5c97aBdGGSBoOLO7P0Kq8VgRgXDXrDFSj6+Ly
         Fh1kQXuELevRdHZlCwh6RbGwkyggA16Rmaen1DQAvAgsDUxHHE4m5zGtKKuYRdDomMbS
         p/aamlRNU+LM7rc6ak7M6DGzDhKOv3Bos/DVp1U6uVikCyCEn5ZD5js8unIeQTNtJZZM
         TmQIYr/CClYewtDHXV+F6YqaE9UWtU8KTpv5bB3oZQlejMPBoKJYTh5o/oDASbqx/6V7
         Gx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OZsN+KjF6P0mNOSjgzFw3fqkoVmkhJo6T0apoMNZd18=;
        b=hqxdep5nPMG2Fa0WRdahXBigwLnMV/4VDBW9lMg6wQnleHjxMjA58mjVunsECG3rvr
         SXivONh9ACuiMIbxZpFZUy11nyar8dGZCLsXWhq2OQf4CYnGNOK6lRrJIRcQJ0LwXyAB
         ToAF44xlzh2VM7kGQJYA4y6WGgrL/pKnC00mmCoqBDUj+KK1xGguc2oG/DwaV4zq6zQa
         Pt2TXZXL69snviNafiUAOWUqNuBjKLKp1jIBg7SFuEguPX8Gg0TjmuoZue0MeU5SRt8C
         DQeKKXzOuO/X5Kycz5WLLs8mFLH0ibgkSRZUz4rAjcnKTuRYqtCgTch+igEZvCSv3yyQ
         t2Yw==
X-Gm-Message-State: APjAAAV/X3sa1NKFKeR+9j0ekyNMvz/IsDECOe5Dn3DgESuvxamYDDvI
        DRSssLDYCznQMh9uOVR4bFNmBg==
X-Google-Smtp-Source: APXvYqzhlNfyJWYewSPQn9Q2ZGgaGwby4p0a0N5/E0M0U5RjcC3vbzUObNwUIUTLX3Be4ykk3m8SjQ==
X-Received: by 2002:ac8:3fbc:: with SMTP id d57mr34297897qtk.96.1553781937336;
        Thu, 28 Mar 2019 07:05:37 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id b37sm10221707qtb.92.2019.03.28.07.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 07:05:36 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:05:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Greg Thelen <gthelen@google.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] writeback: sum memcg dirty counters as needed
Message-ID: <20190328140535.GA15622@cmpxchg.org>
References: <20190307165632.35810-1-gthelen@google.com>
 <20190322181517.GA12378@tower.DHCP.thefacebook.com>
 <CAHH2K0ZqTXhdA+RSZU0a4kjeJexQ5Kh+rMaspzhMCwjKjJvHug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHH2K0ZqTXhdA+RSZU0a4kjeJexQ5Kh+rMaspzhMCwjKjJvHug@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 03:29:47PM -0700, Greg Thelen wrote:
> On Fri, Mar 22, 2019 at 11:15 AM Roman Gushchin <guro@fb.com> wrote:
> > On Thu, Mar 07, 2019 at 08:56:32AM -0800, Greg Thelen wrote:
> > > +     int cpu;
> > > +
> > > +     for_each_online_cpu(cpu)
> > > +             x += per_cpu_ptr(memcg->stat_cpu, cpu)->count[idx];
> > > +     if (x < 0)
> > > +             x = 0;
> > > +#endif
> > > +     return x;
> > > +}
> >
> > Also, isn't it worth it to generalize memcg_page_state() instead?
> > By adding an bool exact argument? I believe dirty balance is not
> > the only place, where we need a better accuracy.
> 
> Nod.  I'll provide a more general version of memcg_page_state().  I'm
> testing updated (forthcoming v2) patch set now with feedback from
> Andrew and Roman.

I'm working on a patch series that reworks the memcg_page_state() API
and by far the most callers do NOT need the exact numbers. So I'd ask
to please keep this a separate function so I don't have to update tens
of callsites to pass "false". Thanks!
