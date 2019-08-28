Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69494C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A0C22CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566988336;
	bh=j1S9ga7k8HKOx5cyyvxNMrX2d5olmQ9B03a2BJKS/i4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rB1pj1FAnU1ldodBXpaUVEdQeSZY1Y0++N1I7/L9DAOyh5EwzlNpMhpfRcAvib7Nr
	 fZc8uTggzgwPUtPFIKRvMgSurVsvdTs27hSKs1nXh469TNz7IZigB0kT8o2lEA8ATh
	 mmlneVN0D3kjJPhoYuit0x0q6CDHBQiEYZ5FL2+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfH1KcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:32:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40416 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbfH1KcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:32:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 434A7AFBE;
        Wed, 28 Aug 2019 10:32:13 +0000 (UTC)
Date:   Wed, 28 Aug 2019 12:32:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Edward Chron <echron@arista.com>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional
 information
Message-ID: <20190828103211.GD28313@dhcp22.suse.cz>
References: <20190826193638.6638-1-echron@arista.com>
 <1566909632.5576.14.camel@lca.pw>
 <CAM3twVQEMGWMQEC0dduri0JWt3gH6F2YsSqOmk55VQz+CZDVKg@mail.gmail.com>
 <79FC3DA1-47F0-4FFC-A92B-9A7EBCE3F15F@lca.pw>
 <CAM3twVSdxJaEpmWXu2m_F1MxFMB58C6=LWWCDYNn5yT3Ns+0sQ@mail.gmail.com>
 <2A1D8FFC-9E9E-4D86-9A0E-28F8263CC508@lca.pw>
 <CAM3twVR5TVuuZSLM2qRJYnkCEKVZmA3XDNREaB+wdKH2Ne9vVA@mail.gmail.com>
 <20190828070845.GC7386@dhcp22.suse.cz>
 <2e816b05-7b5b-4bc0-8d38-8415daea920d@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e816b05-7b5b-4bc0-8d38-8415daea920d@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-08-19 19:12:41, Tetsuo Handa wrote:
> On 2019/08/28 16:08, Michal Hocko wrote:
> > On Tue 27-08-19 19:47:22, Edward Chron wrote:
> >> For production systems installing and updating EBPF scripts may someday
> >> be very common, but I wonder how data center managers feel about it now?
> >> Developers are very excited about it and it is a very powerful tool but can I
> >> get permission to add or replace an existing EBPF on production systems?
> > 
> > I am not sure I understand. There must be somebody trusted to take care
> > of systems, right?
> > 
> 
> Speak of my cases, those who take care of their systems are not developers.
> And they afraid changing code that runs in kernel mode. They unlikely give
> permission to install SystemTap/eBPF scripts. As a result, in many cases,
> the root cause cannot be identified.

Which is something I would call a process problem more than a kernel
one. Really if you need to debug a problem you really have to trust
those who can debug that for you. We are not going to take tons of code
to the kernel just because somebody is afraid to run a diagnostic.

> Moreover, we are talking about OOM situations, where we can't expect userspace
> processes to work properly. We need to dump information we want, without
> counting on userspace processes, before sending SIGKILL.

Yes, this is an inherent assumption I was making and that means that
whatever dynamic hooks would have to be registered in advance.

-- 
Michal Hocko
SUSE Labs
