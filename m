Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEBEC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EFA2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578561589;
	bh=jUPsCSxMZUMB6dPFB7mw+NFmNdP4wLbr0CsujIasChU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kerwn2iuQiAyDIPcOG8pryn3X6Xlu5960ngDb3FAuwtPQjT6C/YTtClj/ZydgaEcO
	 +OwhyHVXzXvYZ2Mc2hxjcKkBM+JK3lab+SInLAKrsmxfXVsQWRTdfGLV3y/3nurGGw
	 3VMH7pUhwA1xsAYWzrFRZuXbu8qPV0REliL57M+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgAIJTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:19:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38109 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgAIJTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:19:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so6568232wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4SCChYUlcp0vzHdJMd/wsYXHSo83PeCAsdJt/W4GS14=;
        b=g5//1eItlh4I5NMYzYGwlZZhgqxrsjRPw/TQYmJpecgh1WBgD3xajosDDbXkD0Mv38
         B5LLIsZMug5M9gmtE3k0rtmM3SnKMyHHHOsSCVlFUxFycgNMQNmMwxqw1gTN1IpNehDd
         BsCrGqWV/NnfJyF8Y7J6BmF4NmavCD4iL/KbCKGc3xWbcTiNrcH3VdBAhxnYYQNqUYck
         23mSP+NHji06W6mvt1bstGUxQrv8ykTEi8KPpDrd1jUe7hdr749PEN4U9DJiv/jZhUzs
         bNPxRyluV6OyQNhS6lQBYks+cS2gC/kA9s00I3/aP2Z7lMkSp9qTMJSkuRLw0VhlD+Z7
         Ohaw==
X-Gm-Message-State: APjAAAVp0w+BfLgiXLv408TajxTGlUH0ZX2sEHn7HAhoQ467/GR5PqVy
        6t4bOPQlf+2YfLjwmx1vYaU=
X-Google-Smtp-Source: APXvYqzvIAD0dwTrG2rTY0SppyZrkxDt7BQWioq4xfUn3/IPLADgOTX+r0s+QdNrn5AXv0Z8PwjeJw==
X-Received: by 2002:adf:d850:: with SMTP id k16mr9295162wrl.96.1578561576174;
        Thu, 09 Jan 2020 01:19:36 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id r6sm7680536wrq.92.2020.01.09.01.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 01:19:35 -0800 (PST)
Date:   Thu, 9 Jan 2020 10:19:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>, nathanl@linux.ibm.com,
        ricklind@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
Message-ID: <20200109091934.GK4951@dhcp22.suse.cz>
References: <20191121195952.3728-1-cheloha@linux.vnet.ibm.com>
 <20191217193238.3098-1-cheloha@linux.vnet.ibm.com>
 <20200107214801.GN32178@dhcp22.suse.cz>
 <20200109084955.GI4951@dhcp22.suse.cz>
 <20200109085623.GB2583500@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109085623.GB2583500@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-01-20 09:56:23, Greg KH wrote:
> On Thu, Jan 09, 2020 at 09:49:55AM +0100, Michal Hocko wrote:
> > On Tue 07-01-20 22:48:04, Michal Hocko wrote:
> > > [Cc Andrew]
> > > 
> > > On Tue 17-12-19 13:32:38, Scott Cheloha wrote:
> > > > Searching for a particular memory block by id is slow because each block
> > > > device is kept in an unsorted linked list on the subsystem bus.
> > > 
> > > Noting that this is O(N^2) would be useful.
> > > 
> > > > Lookup is much faster if we cache the blocks in a radix tree.
> > > 
> > > While this is really easy and straightforward, is there any reason why
> > > subsys_find_device_by_id has to use such a slow lookup? I suspect nobody
> > > simply needed a more optimized data structure for that purpose yet.
> > > Would it be too hard to use radix tree for all lookups rather than
> > > adding a shadow copy for memblocks?
> > 
> > Greg, Rafael, this seems to be your domain. Do you have any opinion on
> > this?
> 
> No one has cared about the speed of that call as it has never been on
> any "fast path" that I know of.  And it should just be O(N), isn't it
> just walking the list of devices in order?

Which means that if you have to call it N times then it is O(N^2) and
that is the case here because you are adding N memblocks. See
memory_dev_init
  for each memblock
    add_memory_block
      init_memory_block
        find_memory_block_by_id # checks all existing devices
        register_memory
	  device_register # add new device
  
In this particular case find_memory_block_by_id is called mostly to make
sure we are no re-registering something multiple times which shouldn't
happen so it sucks to spend a lot of time on that. We might think of
removing that for boot time but who knows what kind of surprises we
might see from crazy HW setups.
 
> If the "memory subsystem" wants a faster lookup for their objects,
> there's nothing stopping you from using your own data structure for the
> pointers to the objects if you want.  Just be careful about the lifetime
> rules.

The main question is whether replacing the linked list with a radix tree
in the generic code is something more meaningful.
-- 
Michal Hocko
SUSE Labs
