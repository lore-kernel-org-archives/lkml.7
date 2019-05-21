Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89054C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5F020862
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfEUEO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:14:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfEUEO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:14:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCFDDC057E65;
        Tue, 21 May 2019 04:14:28 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0245600C6;
        Tue, 21 May 2019 04:14:28 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id B2B924A460;
        Tue, 21 May 2019 04:14:28 +0000 (UTC)
Date:   Tue, 21 May 2019 00:14:28 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Message-ID: <255137178.29997735.1558412068338.JavaMail.zimbra@redhat.com>
In-Reply-To: <1558403523-22079-1-git-send-email-jane.chu@oracle.com>
References: <1558403523-22079-1-git-send-email-jane.chu@oracle.com>
Subject: Re: [PATCH v2] mm, memory-failure: clarify error message
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.97, 10.4.195.29]
Thread-Topic: mm, memory-failure: clarify error message
Thread-Index: 1DbEf0kdw7K8egROywjW6H/tEghkdQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 21 May 2019 04:14:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Some user who install SIGBUS handler that does longjmp out
> therefore keeping the process alive is confused by the error
> message
>   "[188988.765862] Memory failure: 0x1840200: Killing
>    cellsrv:33395 due to hardware memory corruption"
> Slightly modify the error message to improve clarity.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  mm/memory-failure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fc8b517..c4f4bcd 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -216,7 +216,7 @@ static int kill_proc(struct to_kill *tk, unsigned long
> pfn, int flags)
>          short addr_lsb = tk->size_shift;
>          int ret;
>  
> -        pr_err("Memory failure: %#lx: Killing %s:%d due to hardware memory
> corruption\n",
> +        pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware
> memory corruption\n",
>                  pfn, t->comm, t->pid);
>  
>          if ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm) {
> --
> 1.8.3.1

This error message is helpful.

Acked-by: Pankaj Gupta <pagupta@redhat.com>

> 
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
> 
