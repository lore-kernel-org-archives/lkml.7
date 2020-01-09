Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87B2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B962120842
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578608880;
	bh=TxbIGR36dvOlKfNVHdzDzkWYnXZTHkmv3nkio2YU/DY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NMDMiwBCww2oz4erLsswxZjgdJVczxf+wy7vph3cM8osMUiW9vHe0MaB6DLyOv5T/
	 V6TT0op2Zo7wFI5sbXKZsmMB169UMmB4y/qRylBD8VIL2xP+3ba92WrscvJl4YpE5B
	 /hClBq6kGkIdSqzH/YzBajEv3K2AVuAGL0x/xUH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgAIW2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:28:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgAIW17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:27:59 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB2CF20721;
        Thu,  9 Jan 2020 22:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578608879;
        bh=TxbIGR36dvOlKfNVHdzDzkWYnXZTHkmv3nkio2YU/DY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z1/mxcQb8o1oxfKd+2AaQ24Z6XwN7xjdpxSzkptPtP70tSOu7PxwfSjyepRoSAvMS
         mnAeT1A9zkE9kFL8wv5+4rag7hw+aj534gCLcsUTtP+xUGe8VShhMKUBOiK0E3aEGQ
         6lsp0pVZeMXjMw5WDIYr0jDETmazl6LYTDXr4fAA=
Date:   Thu, 9 Jan 2020 14:27:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        mhocko@suse.com, Scott Cheloha <cheloha@linux.ibm.com>
Subject: Re: [PATCH v4] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
Message-Id: <20200109142758.659c1545cb8df2d05f299a4a@linux-foundation.org>
In-Reply-To: <A7C7E3ED-3A02-43C7-B739-53A7756822D4@redhat.com>
References: <20200109140004.d5e6dc581b62d6e078dcca4c@linux-foundation.org>
        <A7C7E3ED-3A02-43C7-B739-53A7756822D4@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020 23:17:09 +0100 David Hildenbrand <david@redhat.com> wrote:

> 
> 
> > Am 09.01.2020 um 23:00 schrieb Andrew Morton <akpm@linux-foundation.org>:
> > 
> > ﻿On Thu,  9 Jan 2020 15:25:16 -0600 Scott Cheloha <cheloha@linux.vnet.ibm.com> wrote:
> > 
> >> Searching for a particular memory block by id is an O(n) operation
> >> because each memory block's underlying device is kept in an unsorted
> >> linked list on the subsystem bus.
> >> 
> >> We can cut the lookup cost to O(log n) if we cache the memory blocks in
> >> a radix tree.  With a radix tree cache in place both memory subsystem
> >> initialization and memory hotplug run palpably faster on systems with a
> >> large number of memory blocks.
> >> 
> >> ...
> >> 
> >> @@ -56,6 +57,13 @@ static struct bus_type memory_subsys = {
> >>    .offline = memory_subsys_offline,
> >> };
> >> 
> >> +/*
> >> + * Memory blocks are cached in a local radix tree to avoid
> >> + * a costly linear search for the corresponding device on
> >> + * the subsystem bus.
> >> + */
> >> +static RADIX_TREE(memory_blocks, GFP_KERNEL);
> > 
> > What protects this tree from racy accesses?
> 
> I think the device hotplug lock currently (except during boot where no races can happen).
> 

So this?

--- a/drivers/base/memory.c~drivers-base-memoryc-cache-blocks-in-radix-tree-to-accelerate-lookup-fix
+++ a/drivers/base/memory.c
@@ -61,6 +61,9 @@ static struct bus_type memory_subsys = {
  * Memory blocks are cached in a local radix tree to avoid
  * a costly linear search for the corresponding device on
  * the subsystem bus.
+ *
+ * Protected by mem_hotplug_lock in mem_hotplug_begin(), and by the guaranteed
+ * single-threadness at boot time.
  */
 static RADIX_TREE(memory_blocks, GFP_KERNEL);
 

But are we sure this is all true?
