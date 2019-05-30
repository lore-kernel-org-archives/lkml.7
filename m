Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16663C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25EA2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="GGWtO+am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfE3MHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:07:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34302 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfE3MHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:07:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so7041138edn.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 05:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3JV/VQkyO6ESrIi+x0cheGcU2SxYAPhzRd/KHj8yO4s=;
        b=GGWtO+amrl1+ByU0pLLXPn/FxONeBh3xk65sx+eVgGXegyl/y1LDn8hY8HfW0lN0HI
         F6tOFyn8FyW0H+lgDjB1GvK4rCsAYArwu2PsNX4X+RCzMi+WeWEUMIsPxShAEdwtNAjS
         oC6vb9ozpg+eemJSTav8I0lovUy2ngMBcVIVJW7UR7QKCmnA5o3CcG1SD+meazD7SJSW
         ub6snA54JUX9HeqXA1X1GZDLnAaYNIWoW5DKNnWfHHM0qZz+qfZ7ID/FEvEThOzus/ei
         dPQdj2OvjOWJZclDuUpyYCBuvuV/WXHgW3jdCY8WkJ1VFr/RDUCRCKEe4XmbReGAeniR
         wKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3JV/VQkyO6ESrIi+x0cheGcU2SxYAPhzRd/KHj8yO4s=;
        b=rlxQUaNOUr7M/24WEf8jkf/VJzkKfIYSmLdmbm/lYI4Q31BxnQqa5+SPkQSzWpgYNI
         H17cxjyG9Pk16DFYI2yu2bKiPIRcgAKUEARkSVVzh9oHy+p//wAXva/eqwlVY4tdRK9K
         2JrV8n8GtVg3ReFZoRKNXxwHZIuKN6vWuk9wSHaviZYoiFs2gVJpD0qHQi+rwinafHhA
         PF6F8rnMTYxEo0xTYtV1LXGknMxsM2ZRW4P2QcL1yQtQXL7ieHQxGycUtp08sWPePvoy
         j6zc3x2A9b0PMm6CHX092ZvlG3cyAoLaRA5rV2cxsw7DHbiILK/zeys+Lx4RMfVPXEde
         GVAw==
X-Gm-Message-State: APjAAAVjF7AqZB1aEfj2jxPmV4jShoJATM3593Pzsqt3wYMTUDM+R+38
        5GFM/rt/eu3NLEDLqI9R7KEHEQ==
X-Google-Smtp-Source: APXvYqzboVQ4IYoNX3TXCypP75fPfr4CCzJ6DUX3ZRs+3ZHWE6njrMWRYnkMJveH6jDCZ34/kA6D1A==
X-Received: by 2002:a17:906:e282:: with SMTP id gg2mr3253914ejb.38.1559218040079;
        Thu, 30 May 2019 05:07:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c12sm392594edt.38.2019.05.30.05.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 05:07:19 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 185351041ED; Thu, 30 May 2019 15:07:18 +0300 (+03)
Date:   Thu, 30 May 2019 15:07:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ktkhai@virtuozzo.com, hannes@cmpxchg.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        shakeelb@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: thp: make deferred split shrinker memcg aware
Message-ID: <20190530120718.52xuxgezkzsmaxqi@box>
References: <1559047464-59838-1-git-send-email-yang.shi@linux.alibaba.com>
 <1559047464-59838-2-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559047464-59838-2-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 08:44:22PM +0800, Yang Shi wrote:
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index bc74d6a..9ff5fab 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -316,6 +316,12 @@ struct mem_cgroup {
>  	struct list_head event_list;
>  	spinlock_t event_list_lock;
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	struct list_head split_queue;
> +	unsigned long split_queue_len;
> +	spinlock_t split_queue_lock;

Maybe we should wrap there into a struct and have helper that would return
pointer to the struct which is right for the page: from pgdat or from
memcg, depending on the situation?

This way we will be able to kill most of code duplication, right?

-- 
 Kirill A. Shutemov
