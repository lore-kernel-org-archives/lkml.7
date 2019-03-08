Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5B0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BDB2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfCHOpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 09:45:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35920 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 09:45:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so14320821pfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 06:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YmGEY7oVvcRxVmDgeY4XvX7k/g/WDgZdx7alUZTjNkg=;
        b=ptuyBj5WD4vIdBJUBuQkCT2osNAjAWS7P1xmWj4VARAbg0DQgsFkglPv72gO/MwXh+
         M/4Xw4nh5+hG/ayS65OmiEkvgVW7p7xR3DTiXBCTNT1sRIWrAgdcCzCENu/Y+F3CaIe2
         sSeuuj2DkwG0Mb2RXC78uH4hnyJKLi5tvXK091sQ/HzhNfsCh9Z3HWFx0dHveqX0kaMm
         aDvKnP7S/OnFi650zhju5IQJphUMgzP2dnuZ3nBSlYq3ZmCMVP8uauZWcGFCYjXbAdPc
         /2HgZYJ0KPtg2BE8nMBaXEkynMlgJ+8JLQwUDCadAoFvY2COzGGdMzeAtgJuQj8lFpja
         3yYA==
X-Gm-Message-State: APjAAAX564DOp1u7PNFrDLoF8STYG9hmgUIP3iljP/T9D/JkYZa2FV4/
        KYJmNA9zsPUjEdSOl1O5B3LLUO03+j0=
X-Google-Smtp-Source: APXvYqwrIe3G2dHlchZPF3YsYD8ZzT3NyuecUsp8S02EJCcGJabira4pjIj2w8XGtHJx+1mK1IK6Ig==
X-Received: by 2002:a17:902:266:: with SMTP id 93mr14376556plc.161.1552056328761;
        Fri, 08 Mar 2019 06:45:28 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id y14sm21936290pgs.47.2019.03.08.06.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 06:45:28 -0800 (PST)
Subject: Re: [PATCH] workqueue: unregister wq lockdep on error path in
 alloc_workqueue()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     syzbot+17335689e239ce135d8b@syzkaller.appspotmail.com
References: <20190308073713.39853-1-wangkefeng.wang@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <150578a7-f053-a479-2b1a-34279c93fc4b@acm.org>
Date:   Fri, 8 Mar 2019 06:45:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190308073713.39853-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/19 11:37 PM, Kefeng Wang wrote:
> syzkaller report an issue "KASAN: use-after-free Read in alloc_workqueue",
> 
> alloc_workqueue
>   - kzalloc wq
>   - wq_init_lockdep(wq);
>     - lockdep_register_key(&wq->key);  // add to hlist
>   - kfree wq
> 
> But forget to call wq_unregister_lockdep()->lockdep_unregister_key(), it
> will delete the entry from hlist.
> 
> Reported-by: syzbot+17335689e239ce135d8b@syzkaller.appspotmail.com
> Fixes: 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for workqueues")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   kernel/workqueue.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 7abbeed13421..9209d25dfade 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -4291,6 +4291,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>   	return wq;
>   
>   err_free_wq:
> +	wq_unregister_lockdep(wq);
>   	free_workqueue_attrs(wq->unbound_attrs);
>   	kfree(wq);
>   	return NULL;

Hi Kefeng,

Five days ago I had posted a similar but slightly different patch. Can 
you have a look at it? See also 
https://lore.kernel.org/lkml/20190303220046.29448-1-bvanassche@acm.org/

Thanks,

Bart.


