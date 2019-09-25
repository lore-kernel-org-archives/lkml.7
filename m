Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A18AC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F0E21D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439409AbfIYPUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:20:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:52466 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfIYPUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:20:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 08:20:31 -0700
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; 
   d="scan'208";a="183287991"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 08:20:30 -0700
Message-ID: <f49df2d42d7e97b61a5e26ff4d89ede5fbe37a35.camel@linux.intel.com>
Subject: Re: [PATCH] async: Let kfree() out of the critical area of the lock
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        bvanassche@acm.org, bhelgaas@google.com, dsterba@suse.com,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        sakari.ailus@linux.intel.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 25 Sep 2019 08:20:30 -0700
In-Reply-To: <216356b1-38c1-8477-c4e8-03f497dd6ac8@huawei.com>
References: <216356b1-38c1-8477-c4e8-03f497dd6ac8@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-25 at 20:52 +0800, Yunfeng Ye wrote:
> It's not necessary to put kfree() in the critical area of the lock, so
> let it out.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  kernel/async.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/async.c b/kernel/async.c
> index 4f9c1d6..1de270d 100644
> --- a/kernel/async.c
> +++ b/kernel/async.c
> @@ -135,12 +135,12 @@ static void async_run_entry_fn(struct work_struct *work)
>  	list_del_init(&entry->domain_list);
>  	list_del_init(&entry->global_list);
> 
> -	/* 3) free the entry */
> -	kfree(entry);
>  	atomic_dec(&entry_count);
> -
>  	spin_unlock_irqrestore(&async_lock, flags);
> 
> +	/* 3) free the entry */
> +	kfree(entry);
> +
>  	/* 4) wake up any waiters */
>  	wake_up(&async_done);
>  }

It probably wouldn't hurt to update the patch description to mention that
async_schedule_node_domain does the allocation outside of the lock, then
takes the lock and does the list addition and entry_count increment inside
the critical section so this is just updating the code to match that it
seems.

Otherwise the change itself looks safe to me, though I am not sure there
is a performance gain to be had so this is mostly just a cosmetic patch.

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

