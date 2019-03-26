Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BF6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536F9206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553624865;
	bh=DHbjnyiLLmEg6ENHMoS954rnrw07sdP+5a7HGtgLUSw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qOUf6jJrX882pQCxPOC5S6+XvUqsklENz3UvPk6T8Bthayp9N9SRHv5iUHVRhLAr1
	 Zg3B7vb6yA7NEjEwW2SDzhSXPb2XpzyB6rNvwiz5H5DOFdA+aewcoqtFE3HsCgwti3
	 lSkttDGvakPgRidej/Ef3ltrz4o1DkNzPlh1U/nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbfCZS1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:27:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45000 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732061AbfCZS1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:27:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id x10so11624458edh.11;
        Tue, 26 Mar 2019 11:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XEBSUxfngiyxJTMuOC2iszm8NvoPSPzRZrJrrrb07OI=;
        b=LfruEC0QTjLDOfHuYCPvlNvkJbsNBXnzIMQ699Xcg+FNvoJDYegL72ubP/rPZj0YKy
         /YwwoJmI/1cd4UN3HmgVR0zOUAZJYN5SDwX8lEpeNj7fYPHBhzzucXo4ZczHbnZlO0eD
         p1LdVapYAZpXD6BSRraZqil+MVpIxB1g276/+kK+W6vHDztK/XzkPKDe7Q5vi29hv9qV
         rX4aBHRGMhHzhxfzpCIQKOonPJCJn8eK5P/HP7JGVFptIxHGGnl3PDSYrUH6u21ragkC
         sA68BLrlzv8n15mvlvzrX6XAHpC1WiJfJ+PPBMUGva2OAqNKIgl25IEuSZXEyhqEk6sb
         zYWw==
X-Gm-Message-State: APjAAAX8ocYNTpWZMoIs5YhHtwNwvDTo1wEP63MFyBsB3UNnfvIrBAhD
        sR8UsYLiEbKNhe45BEIZbvZsSQsAfSGEnSc/wHI=
X-Google-Smtp-Source: APXvYqzzzUaq5vyem1OogFImYJPdHIG/PydRDPoiEJZuMP35ihE6PE2q9CauXdmthUZDE+esXeaGmu5oc3JRFfIuGeo=
X-Received: by 2002:a50:89fa:: with SMTP id h55mr21105766edh.296.1553624862406;
 Tue, 26 Mar 2019 11:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
 <4dd94a34999d6db4ced7a0759c02f7cd93729dc4.1551160674.git.len.brown@intel.com> <20190226190658.GS2861@worktop.programming.kicks-ass.net>
In-Reply-To: <20190226190658.GS2861@worktop.programming.kicks-ass.net>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 26 Mar 2019 14:27:30 -0400
Message-ID: <CAJvTdKmg4YwzYGfPZKdAFZCqA6hFROdSVT46iDk0mb1rL-TKvg@mail.gmail.com>
Subject: Re: [PATCH 07/14] powercap/intel_rapl: Simplify rapl_find_package()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 2:07 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 26, 2019 at 01:20:05AM -0500, Len Brown wrote:
> > -static struct rapl_package *find_package_by_id(int id)
> > +static struct rapl_package *rapl_find_package(int cpu)
> >  {
> > +     int id = topology_physical_package_id(cpu);
> >       struct rapl_package *rp;
>
> Which you'll change to topology_physical_die_id() in the next patch.
>
> If you respin the series again, could we pick a better name?

Done.
I called this routine "rapl_find_package_domain()" -- since that is
what it does --
it finds what RAPL calls a "Package Domain", no matter if that domain
is implemented in the topology by a die or a physical package.

thanks,
Len Brown, Intel Open Source Technology Center
