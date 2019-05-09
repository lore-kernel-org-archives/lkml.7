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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E538C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501FB21479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8+t1ymT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfEIMnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:43:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32779 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfEIMnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:43:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so1922948edb.0;
        Thu, 09 May 2019 05:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QsgdOJDYHn/tfXe+apw05fuvXqjWkWLQh0vbJ3o4icQ=;
        b=X8+t1ymTYcyltAjf8v1dQF+XWnX6+Ka0h/n/Sp7NhymDucJNtZxdecMYnob2Injauf
         prmYn1KR0VaeFSnO5nN8SN73MXJZF0qI0mBEWIBZB9pui+fjXk9cWdDD+EyINCqMgx1Q
         PT6yJp94Qz0hthu8VQ2H1YaSFHjZ38HZ42VY4SnfYBSPXK/HDzFbSeoj3OQPuaOLAeFe
         eEJ1P8uvRoUwH9aNBvgmstZw14Q6XOf7bFPU079ouZQh/1QDXXkqf2kPgwMwSU+bFA7e
         LD8hzyVTjeLmlSqIETgbTm+FSLcZYsbhL7kX75dUPEc6gceTAXEWMhIGe/3LdCM831GM
         7kmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QsgdOJDYHn/tfXe+apw05fuvXqjWkWLQh0vbJ3o4icQ=;
        b=GL66Eqlr6Y2RoXRRKCR85TAk06fpVPPh6c77mFhdNOeYO/AP0wRyvglAzHVleVI1oI
         TxQfnmVFDKVbxyuqafE9sMRiOMVWVLDJkQ16w4le02fLFOrT6iI0lwJYz3HSQvDXGMA4
         SZ5v3LnqzopWgQVQAKOB9AEB3HprOOHJd+Hr8CMKW6IuJgmaANzEtGESa3uE4qXEdGFx
         IKK0bq3ie2UiWCcEUwinQjyPO6PyD+cC5L9kxbk3NRCtYww35KzqX1OOUWZFw/oDtn2z
         LDCocXRuiw/XXg4a2MV/G7/nSnCIslbB0tsR8TCU5phrUkBajPQj+5LeyLlI7sKn0wmo
         ZB8Q==
X-Gm-Message-State: APjAAAXOZNcBBTwJiKlWmapvQxKVBSjWinE4Q+bHo0AqcLvVUNLztbqz
        bfCcUTma8WQ7EhnRy83Bt2U=
X-Google-Smtp-Source: APXvYqwSMvc+IkN0goCuzZGHyfnoTzg7aUzcqfUpVzHNwIsf6cZyZm3yry5tEzCvNGV+FZLlTxCadw==
X-Received: by 2002:a17:906:1984:: with SMTP id g4mr3006437ejd.260.1557405783809;
        Thu, 09 May 2019 05:43:03 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e21sm300748ejk.86.2019.05.09.05.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 05:43:02 -0700 (PDT)
Date:   Thu, 9 May 2019 12:43:02 +0000
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
Message-ID: <20190509124302.at7jltfrycj7sxbd@master>
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
> {
>-	int ret = 0;
>+	unsigned long block_nr_pages = memory_block_size_bytes() >> PAGE_SHIFT;
>+	unsigned long start_pfn = PFN_DOWN(start);
>+	unsigned long end_pfn = start_pfn + (size >> PAGE_SHIFT);
>+	unsigned long pfn;
> 	struct memory_block *mem;
>+	int ret = 0;
> 
>-	mutex_lock(&mem_sysfs_mutex);
>+	BUG_ON(!IS_ALIGNED(start, memory_block_size_bytes()));
>+	BUG_ON(!IS_ALIGNED(size, memory_block_size_bytes()));

After this change, the call flow looks like this:

add_memory_resource
    check_hotplug_memory_range
    hotplug_memory_register

Since in check_hotplug_memory_range() has checked the boundary, do we need to
check here again?

-- 
Wei Yang
Help you, Help me
