Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879F5C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CBE2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOlNtK75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfEIOb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 10:31:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41969 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfEIOb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 10:31:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id m4so2221541edd.8;
        Thu, 09 May 2019 07:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=28M3/Gt0muyIKgyfcpD9ysscEUSK1ZnFipvrQH7okoo=;
        b=qOlNtK752XXn4kkfsFMWyY7kRPfrZUsTtqBPdR/hrsY1mJM2tbu2nhsutSmVVSM1WW
         nXRASbDxRAmYKoGMORG1Srq+QfFSesIFDMzjzchm3j4kE/sLGsIywSyqVlu3Yz91d/8r
         FlEQUB4qvWSHM4vKfCBekEvL6H1BeRT6mMgSjN/ZfvQ7xjppTiRrhRzhd0DiONdD3rHG
         8+F+D+pkIWAxOZxeIGT+39UvOnSIMPWvX3z65R9GJNUd8yqfL58nMe8pY6Q7GvVCzYIM
         6GCvJUep1xdo/Z8mF1dvC94zMfD6T5hlTY7VkMhVkudMpY654rvkzmeZxmnK6kPTSOvF
         yY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=28M3/Gt0muyIKgyfcpD9ysscEUSK1ZnFipvrQH7okoo=;
        b=jed3anqXrvbj4ZZvMcgvnz2hOSjNy3GlKDIkndxem5pg6xUhbMGp3DiRnlt/60D/Fk
         Nlbqyk3kvsw5x5NNqNL02gvzh9nW04qPjtRpZ+jO7Dgzq6mbG3ThT1PPv8X3oj9vvk/W
         OMK93AhtoT7mXqO/l3WoH01bVYsfoeY9NBwtKv86IT2pYmybAp30GHGvAwi6pSNWU6oY
         GXzSbR3Hc8CCDpT34neVeyM2AMAQhpVLcuo6A40bfsVXQGMfTMVUO6XYUYUFSZy2lEmp
         qigou5nhe2KQQCZQjwm79BXY9V9JeBEf+x11vniURnLwIltSOAp45KB2wogDLdka78WF
         rGcA==
X-Gm-Message-State: APjAAAWhrKkU7a4KxYYR7kMJH3IGts2oxo9gKjXZjrkhOiYntjm9cdEt
        yhy0jtvkuEDm1nuMcMbNUVQ=
X-Google-Smtp-Source: APXvYqzkJhS5L8NnWGrt01x6w71u7E8s0GHuJykWEj8KfZGhfTtKpBAzu9nFzSqSe/2NArkKjIgUMw==
X-Received: by 2002:a50:be48:: with SMTP id b8mr4401819edi.284.1557412313899;
        Thu, 09 May 2019 07:31:53 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d11sm623679eda.45.2019.05.09.07.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:31:52 -0700 (PDT)
Date:   Thu, 9 May 2019 14:31:51 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Banman <andrew.banman@hpe.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Qian Cai <cai@lca.pw>, Wei Yang <richard.weiyang@gmail.com>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH v2 4/8] mm/memory_hotplug: Create memory block devices
 after arch_add_memory()
Message-ID: <20190509143151.zexjmwu3ikkmye7i@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190507183804.5512-1-david@redhat.com>
 <20190507183804.5512-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507183804.5512-5-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 08:38:00PM +0200, David Hildenbrand wrote:
>Only memory to be added to the buddy and to be onlined/offlined by
>user space using memory block devices needs (and should have!) memory
>block devices.
>
>Factor out creation of memory block devices Create all devices after
>arch_add_memory() succeeded. We can later drop the want_memblock parameter,
>because it is now effectively stale.
>
>Only after memory block devices have been added, memory can be onlined
>by user space. This implies, that memory is not visible to user space at
>all before arch_add_memory() succeeded.
>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>Cc: David Hildenbrand <david@redhat.com>
>Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Ingo Molnar <mingo@kernel.org>
>Cc: Andrew Banman <andrew.banman@hpe.com>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>Cc: Qian Cai <cai@lca.pw>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>Cc: Arun KS <arunks@codeaurora.org>
>Cc: Mathieu Malaterre <malat@debian.org>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> drivers/base/memory.c  | 70 ++++++++++++++++++++++++++----------------
> include/linux/memory.h |  2 +-
> mm/memory_hotplug.c    | 15 ++++-----
> 3 files changed, 53 insertions(+), 34 deletions(-)
>
>diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>index 6e0cb4fda179..862c202a18ca 100644
>--- a/drivers/base/memory.c
>+++ b/drivers/base/memory.c
>@@ -701,44 +701,62 @@ static int add_memory_block(int base_section_nr)
> 	return 0;
> }
> 
>+static void unregister_memory(struct memory_block *memory)
>+{
>+	BUG_ON(memory->dev.bus != &memory_subsys);
>+
>+	/* drop the ref. we got via find_memory_block() */
>+	put_device(&memory->dev);
>+	device_unregister(&memory->dev);
>+}
>+
> /*
>- * need an interface for the VM to add new memory regions,
>- * but without onlining it.
>+ * Create memory block devices for the given memory area. Start and size
>+ * have to be aligned to memory block granularity. Memory block devices
>+ * will be initialized as offline.
>  */
>-int hotplug_memory_register(int nid, struct mem_section *section)
>+int hotplug_memory_register(unsigned long start, unsigned long size)

One trivial suggestion about the function name.

For memory_block device, sometimes we use the full name

    find_memory_block
    init_memory_block
    add_memory_block

But sometimes we use *nick* name

    hotplug_memory_register
    register_memory
    unregister_memory

This is a little bit confusion.

Can we use one name convention here? 

[...]

> /*
>@@ -1106,6 +1100,13 @@ int __ref add_memory_resource(int nid, struct resource *res)
> 	if (ret < 0)
> 		goto error;
> 
>+	/* create memory block devices after memory was added */
>+	ret = hotplug_memory_register(start, size);
>+	if (ret) {
>+		arch_remove_memory(nid, start, size, NULL);

Functionally, it works I think.

But arch_remove_memory() would remove pages from zone. At this point, we just
allocate section/mmap for pages, the zones are empty and pages are not
connected to zone.

Function  zone = page_zone(page); always gets zone #0, since pages->flags is 0
at  this point. This is not exact.

Would we add some comment to mention this? Or we need to clean up
arch_remove_memory() to take out __remove_zone()?


>+		goto error;
>+	}
>+
> 	if (new_node) {
> 		/* If sysfs file of new node can't be created, cpu on the node
> 		 * can't be hot-added. There is no rollback way now.
>-- 
>2.20.1

-- 
Wei Yang
Help you, Help me
