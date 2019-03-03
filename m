Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39413C10F06
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0614720842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfCCSTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 13:19:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38769 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCCSTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 13:19:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so1387789pgl.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 10:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IXCrn5Mcyh7N2bJX7dxYYFb3nrt3UYrtNNHcheDdhiw=;
        b=X6RyO5wV0eHocUwSkE5FyX6360nZdH8T0twf6NDsE1AaMjCEiJUPztMp5ItU1xO8MW
         K8SmgaEe/LBQylsQw/Z1dsqpDiMskeR6RKjdwRBdmKf69U3+IRVkiETfx1TYdYRjG57s
         OvQvFgVOgGuUAxR86tEAxVzFslzB4Yb7JC1+ZlvK8mLZUFtR9dSjSP4CZL/rL43pmvyu
         tWs104lG/ms2M2OKgI4dqgVBzebuNqXd84wX6FgQZY7+skhY/9QihOUx7kT1Hv5Wjdj7
         7b2S8bg3aATZ29hYR4UwCUDgPP39A+9GCcACU5ErczWCS+HLdnGs3dWLaG/kRUCyPI+s
         BQLw==
X-Gm-Message-State: APjAAAWD2DVBuAGuwLOZIX9mVHOWLqOvjcH/VXgB7hycQwSX5LMxfMl8
        nNS9DHmS+tDUAR45NlQn+4WBa4uz
X-Google-Smtp-Source: APXvYqzOKBcKy8v8cjfT4+I0f4nNJxfZ7OO7QWCeuBQg6sBQBJjZ3HXQmzwMC3u0csBxyc+GSW3T8Q==
X-Received: by 2002:a17:902:b404:: with SMTP id x4mr11481822plr.232.1551637182454;
        Sun, 03 Mar 2019 10:19:42 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id k125sm9389951pgc.51.2019.03.03.10.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 10:19:41 -0800 (PST)
Subject: Re: [PATCH -next] workqueue: fix a memory leak in wq->lock_name
To:     Qian Cai <cai@lca.pw>, tj@kernel.org, jiangshanlai@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org
References: <20190303143452.11629-1-cai@lca.pw>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f14f8b87-d55a-4ea9-c2d2-9a48d6360aa3@acm.org>
Date:   Sun, 3 Mar 2019 10:19:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190303143452.11629-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/19 6:34 AM, Qian Cai wrote:
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 497900263dbc..e780bf73eced 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3445,6 +3445,8 @@ static void wq_init_lockdep(struct workqueue_struct *wq)
>   	lock_name = kasprintf(GFP_KERNEL, "%s%s", "(wq_completion)", wq->name);
>   	if (!lock_name)
>   		lock_name = wq->name;
> +
> +	wq->lock_name = lock_name;
>   	lockdep_init_map(&wq->lockdep_map, lock_name, &wq->key, 0);
>   }

Not sure how this got overlooked. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
