Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F16C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F192077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="1hwtmF+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfDKPbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:31:17 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43959 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKPbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:31:16 -0400
Received: by mail-yb1-f193.google.com with SMTP id d20so2347223ybm.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3iJKixxuhPHlPoZGh40Oi3FjBSMfJGKskcYDOhWiKGQ=;
        b=1hwtmF+hHKwJ6ukgkNYfDzhggthKX24NSk2lZP6PHZKK0OuNX/iwCbFuFzPm57tK2P
         gdNbZDktsfSgeGeQ08V+cWQQmM0Jw9isIS3WhHhuBTBJs2BToG6Tb/eO7VtZT59u6C0V
         aMA/z6Z3nDieLbf8Pn1TG/Xw4o+Td3G5OUt8msHHo+q/xNxiOR6PHHQXP5i2DL22SxZS
         yH7x9QB6XSulVn4JbEd2bqKkJKiFN4KVm9Z7DnJO4wXcwe1DtLf+7FHHDf3aOuEHrf0U
         NlNYSwvNKgcrNkisAliIuUeCvEh/7u7of22dG3702V13GJKwj6q5D4lfNuB0qJuxBKmm
         70SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3iJKixxuhPHlPoZGh40Oi3FjBSMfJGKskcYDOhWiKGQ=;
        b=M28Xm23kFjOHHDw97bC0hts0qo0lyqo3nk/0g7U5AtLpSFyHAoprOyhVytKK7oHQwG
         daK9DaAz8wvF2ve2nc8LxMgYNCfIk9kAE7P4evXSAC2IQNRG9ikEKh227hV6cPzofmqQ
         Zq9VmzvBCIZMv5I0EL7g8V02pMQO2hxF6NpG0gYLk8O+u4tlEmhdjNjeP3Gdt+Ur/jwR
         HC1WmwXkSecc8SujIwJrVBcQHZGhPcBUovwSKNZ7Llnzpme4RQmJg5nPaf6qc6LupUq4
         YxQN/SX6jYEMJgfifJHRXfxQy+mkEOsH/fUuPcEGJhg+DadJXDmkK/ZHsc1nDsYCAIIU
         cm6g==
X-Gm-Message-State: APjAAAUE5zOa7FmOgXb0TlflA4ZNHITbBnixhHySMW8Tj11lImkMV2uP
        47I/ixRS8TDvufmv4AvU52qx4Q==
X-Google-Smtp-Source: APXvYqzuP7mXVps+wydtaxT46o4Hr126QvRlymscA1wR/cFGUUcqB+O2cYv4Je4UHlaqQtB0/Ye0wQ==
X-Received: by 2002:a25:68cb:: with SMTP id d194mr19752622ybc.33.1554996675392;
        Thu, 11 Apr 2019 08:31:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:2a81])
        by smtp.gmail.com with ESMTPSA id i139sm11910189ywa.101.2019.04.11.08.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 08:31:14 -0700 (PDT)
Date:   Thu, 11 Apr 2019 11:31:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC PATCH 0/2] mm/memcontrol: Finer-grained memory control
Message-ID: <20190411153113.GA32469@cmpxchg.org>
References: <20190410191321.9527-1-longman@redhat.com>
 <20190410195443.GL10383@dhcp22.suse.cz>
 <daef5f22-0bc2-a637-fa3d-833205623fb6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daef5f22-0bc2-a637-fa3d-833205623fb6@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 10:02:16AM -0400, Waiman Long wrote:
> On 04/10/2019 03:54 PM, Michal Hocko wrote:
> > On Wed 10-04-19 15:13:19, Waiman Long wrote:
> >> The current control mechanism for memory cgroup v2 lumps all the memory
> >> together irrespective of the type of memory objects. However, there
> >> are cases where users may have more concern about one type of memory
> >> usage than the others.
> >>
> >> We have customer request to limit memory consumption on anonymous memory
> >> only as they said the feature was available in other OSes like Solaris.
> > Please be more specific about a usecase.
> 
> From that customer's point of view, page cache is more like common goods
> that can typically be shared by a number of different groups. Depending
> on which groups touch the pages first, it is possible that most of those
> pages can be disproportionately attributed to one group than the others.
>
> Anonymous memory, on the other hand, are not shared and so can more
> correctly represent the memory footprint of an application. Of course,
> there are certainly cases where an application can have large private
> files that can consume a lot of cache pages. These are probably not the
> case for the applications used by that customer.

I don't understand what the goal is. What do you accomplish by only
restricting anon memory? Are you trying to contain malfunctioning
applications? Malicious applications?

Cache can apply as much pressure to the system as anon can. So if you
are in the position to ask your applications to behave wrt cache,
surely you can ask them to behave wrt anon as well...?

This also answers only one narrow question out of the many that arise
when heavily sharing cache. The accounting isn't done right,
memory.current of the participating cgroups will make no sense, IO
read and writeback burden is assigned to random cgroups.

> >> For simplicity, the limit is not hierarchical and applies to only tasks
> >> in the local memory cgroup.
> > This is a no-go to begin with.
> 
> The reason for doing that is to introduce as little overhead as
> possible. We can certainly make it hierarchical, but it will complicate
> the code and increase runtime overhead. Another alternative is to limit
> this feature to only leaf memory cgroups. That should be enough to cover
> what the customer is asking for and leave room for future hierarchical
> extension, if needed.

I agree with Michal, this is a no-go. It involves userspace ABI that
we have to maintain indefinitely, so it needs to integrate properly
with the overall model of the cgroup2 interface.

That includes hierarchical support, but as per above it includes wider
questions of how this is supposed to integrate with the concepts of
comprehensive resource control. How it integrates with the accounting
(if you want to support shared pages, they should also be accounted as
shared and not to random groups), the relationships with connected
resources such as IO (in a virtual memory system that can do paging,
memory and IO are fungible, so if you want to be able to share one,
you have to be able to share the other as well to the same extent),
how it integrates with memory.low protection etc.

As it stands, I don't see this patch set addressing any of these.
