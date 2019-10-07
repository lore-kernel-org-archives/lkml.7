Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FD8ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1F521479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570459833;
	bh=+L1hKJ2VTUqRsllRhayb9YKLbiRzxfqRmz/3qXSqkK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0iOXvLGERc7FBj9PxW2QCuJ6a9AsYUiRreBZmR4g6nMxibz0IPb/4rHBN3P4GEQTw
	 CSRm+ZtJOuFNQWG3XR3bxYSwqgBT6zel1X9KqIaWBCD1m7kU/aN2YS0ufPaj3ph+hK
	 tNZ3HpTJwmpH3JgCN5gXeEiqsMbIwY2b26MwYybU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfJGOtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:49:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:51726 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728592AbfJGOtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7523EAD45;
        Mon,  7 Oct 2019 14:49:38 +0000 (UTC)
Date:   Mon, 7 Oct 2019 16:49:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191007144937.GO2381@dhcp22.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc s390 maintainers - the lockdep is http://lkml.kernel.org/r/1570228005-24979-1-git-send-email-cai@lca.pw
 Petr has explained it is a false positive
 http://lkml.kernel.org/r/20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz]
On Mon 07-10-19 16:30:02, Petr Mladek wrote:
[...]
> I believe that it cannot really happen because:
> 
> 	static int __init
> 	sclp_console_init(void)
> 	{
> 	[...]
> 		rc = sclp_rw_init();
> 	[...]
> 		register_console(&sclp_console);
> 		return 0;
> 	}
> 
> sclp_rw_init() is called before register_console(). And
> console_unlock() will never call sclp_console_write() before
> the console is registered.
> 
> AFAIK, lockdep only compares existing chain of locks. It does
> not know about console registration that would make some
> code paths mutually exclusive.
> 
> I believe that it is a false positive. I do not know how to
> avoid this lockdep report. I hope that it will disappear
> by deferring all printk() calls rather soon.

Thanks a lot for looking into this Petr. I have also checked the code
and I really fail to see why the allocation has to be done under the
lock in the first place. sclp_read_sccb and sclp_init_sccb are global
variables but I strongly suspect that they need a synchronization during
early init, callbacks are registered only later IIUC:

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index d2ab3f07c008..4b1c033e3255 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -1169,13 +1169,13 @@ sclp_init(void)
 	unsigned long flags;
 	int rc = 0;
 
+	sclp_read_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
+	sclp_init_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
 	spin_lock_irqsave(&sclp_lock, flags);
 	/* Check for previous or running initialization */
 	if (sclp_init_state != sclp_init_state_uninitialized)
 		goto fail_unlock;
 	sclp_init_state = sclp_init_state_initializing;
-	sclp_read_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
-	sclp_init_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
 	BUG_ON(!sclp_read_sccb || !sclp_init_sccb);
 	/* Set up variables */
 	INIT_LIST_HEAD(&sclp_req_queue);
-- 
Michal Hocko
SUSE Labs
