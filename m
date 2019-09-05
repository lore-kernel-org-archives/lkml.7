Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBC8C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D44D222BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="a2pBHK6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfIEOOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:14:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35030 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbfIEOOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:14:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id n4so1519572pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 07:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2dyh/qzhi2qens90CnAyZpu8nc1Cd1yi17MqcISR+xc=;
        b=a2pBHK6eVeP+DeXitzdhwlEvM99BkuEdPz9b/HbbIFuBRONPO0F/o6Um+dJ+WhLiki
         loBC03lOXyRmzxlQZn5Tub6me3ggBWFKOWP+jpBivc0UDj0Fuao3xzjPV3fWdHbmL60s
         bMR4jmepYzML3yWOff4TJnVSFSDkAhK0twfJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2dyh/qzhi2qens90CnAyZpu8nc1Cd1yi17MqcISR+xc=;
        b=U0lxyrJsh03inFn4W1pup+7RDfO33R+XaJZjDiGSICjXRAJzJIcFGx8rX+4ssYTUOw
         iC36roSdn2BNxJBXBGDXMm/4AIN834kK9zRLLXwwD+IRu4EDANtydmXdnuvnPqZynYkg
         Mib7ls3V726t02Zn16tgqs/fcO94ZZhjgFb24MZ6OXPbrdFJSjo6I0LF/IxoWXWj29Gm
         1B6Y+XAfpkfDncCtdC/yHqN0Hf0qFfRjL1E9OEFMLqqPRYvgWienomodP720K0oPLr4K
         8vb6Vob96f2+J5gUGQeL3VTbEEDsKe37WeaJjH3UwMcEYrz3O9zO13JZVdvjiQCi4z1C
         mUFg==
X-Gm-Message-State: APjAAAWxa3q6BVI4rTXyL3GYXcfBGkvRY9FsHeOUhMaxbuDeQfip7lwn
        XedLw8nVSYnBk0y/0iKSlbMwYg==
X-Google-Smtp-Source: APXvYqyWhg5wWBza0xoQXn734lb+BXrNSStNRVuCl14e2+JVF+qyGjoVQWM/ZfKFG0+uOaZkfe8M4w==
X-Received: by 2002:a65:518a:: with SMTP id h10mr3310283pgq.117.1567692894079;
        Thu, 05 Sep 2019 07:14:54 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l6sm8709786pje.28.2019.09.05.07.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 07:14:53 -0700 (PDT)
Date:   Thu, 5 Sep 2019 10:14:52 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tim Murray <timmurray@google.com>,
        carmenjackson@google.com, mayankgupta@google.com,
        dancol@google.com, rostedt@goodmis.org, minchan@kernel.org,
        akpm@linux-foundation.org, kernel-team@android.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
Message-ID: <20190905141452.GA26466@google.com>
References: <20190903200905.198642-1-joel@joelfernandes.org>
 <20190904084508.GL3838@dhcp22.suse.cz>
 <20190904153258.GH240514@google.com>
 <20190904153759.GC3838@dhcp22.suse.cz>
 <20190904162808.GO240514@google.com>
 <20190905105424.GG3838@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905105424.GG3838@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 12:54:24PM +0200, Michal Hocko wrote:
> On Wed 04-09-19 12:28:08, Joel Fernandes wrote:
> > On Wed, Sep 4, 2019 at 11:38 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Wed 04-09-19 11:32:58, Joel Fernandes wrote:
> > > > On Wed, Sep 04, 2019 at 10:45:08AM +0200, Michal Hocko wrote:
> > > > > On Tue 03-09-19 16:09:05, Joel Fernandes (Google) wrote:
> > > > > > Useful to track how RSS is changing per TGID to detect spikes in RSS and
> > > > > > memory hogs. Several Android teams have been using this patch in various
> > > > > > kernel trees for half a year now. Many reported to me it is really
> > > > > > useful so I'm posting it upstream.
> > > > > >
> > > > > > Initial patch developed by Tim Murray. Changes I made from original patch:
> > > > > > o Prevent any additional space consumed by mm_struct.
> > > > > > o Keep overhead low by checking if tracing is enabled.
> > > > > > o Add some noise reduction and lower overhead by emitting only on
> > > > > >   threshold changes.
> > > > >
> > > > > Does this have any pre-requisite? I do not see trace_rss_stat_enabled in
> > > > > the Linus tree (nor in linux-next).
> > > >
> > > > No, this is generated automatically by the tracepoint infrastructure when a
> > > > tracepoint is added.
> > >
> > > OK, I was not aware of that.
> > >
> > > > > Besides that why do we need batching in the first place. Does this have a
> > > > > measurable overhead? How does it differ from any other tracepoints that we
> > > > > have in other hotpaths (e.g.  page allocator doesn't do any checks).
> > > >
> > > > We do need batching not only for overhead reduction,
> > >
> > > What is the overhead?
> > 
> > The overhead is occasionally higher without the threshold (that is if we
> > trace every counter change). I would classify performance benefit to be
> > almost the same and within the noise.
> 
> OK, so the additional code is not really justified.

It is really justified. Did you read the whole of the last email?

thanks,

 - Joel

