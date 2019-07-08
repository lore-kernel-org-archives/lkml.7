Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334F9C606C0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C94620844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562597407;
	bh=htTulAks4yV7RBewepxmyXBolpOU1APsLx6lCZDTKvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p4iIQ8pAafgSUGoSaxyL2mMvaezFHNyZ03DQkgDGSQo+vL+pceRhyKJm8NWUvr8Ho
	 rgJMhZAyLv1zHpD4NyUWZtdrklR4ySQNHGuQM/7rkUHblhgQg4bQ4epk0nVWR71o3q
	 3ua8wiLESN4OhiVy/8Q5RzTw9a/pLRwGV85QLam4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbfGHOuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:50:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41781 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfGHOuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:50:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id v22so13487452qkj.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 07:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m4lJKeNqPF6PUhJfVn2/MLy0a1U7ORLGNDoWGGROjW8=;
        b=C7A5mLSiTfjgbzYTC3X6pmXN7G3Wa0TtLyNnOcY+pfGI7T0WZc5M/R2HsIgD+YdQsK
         eBhyIx56QXOIenHYBSVIn5kiePzp9OrF6DSOXDoHLKZ9sDktvhuqOddkDWRXMPAkDfqf
         3hxWPyzc/G2gDvbkL8XjGo2BSYPAipm/Dxh8RqebqTomEybidCUKAkHXKvSsH5kDGdb6
         IFbnAwzFkOzkAcjF/gHCBS+BAe8M1QmocAucp0bEzqcyDxXWVcDX2Tza1HfNAgIdySM5
         hq8wZeLaRg7vEAB44XJasKPie3agTxDLA/8Tu8W79Z/PRFx+ZuagUn4RnRioiVR3jRa2
         itpQ==
X-Gm-Message-State: APjAAAWL257FaERG0nIDvS1DWk1zzNlD3Gyn0zIFxdQ0fHlemh8+N4Z+
        RRF1ohxQle6tEnGRAMu6mIrKiyFSTFM=
X-Google-Smtp-Source: APXvYqzcydk75TJwyLHh1v1P7pYsUDMdBgKhP7Ny0LseHJK3GqpASJIMfeiWla1A76rTrchhM+b/iw==
X-Received: by 2002:a37:2c46:: with SMTP id s67mr15092125qkh.396.1562597404820;
        Mon, 08 Jul 2019 07:50:04 -0700 (PDT)
Received: from dennisz-mbp ([2620:10d:c091:500::3:8b5a])
        by smtp.gmail.com with ESMTPSA id a6sm6872044qkn.59.2019.07.08.07.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 07:50:03 -0700 (PDT)
Date:   Mon, 8 Jul 2019 10:50:02 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peng Fan <peng.fan@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: fix pcpu_page_first_chunk return code handling
Message-ID: <20190708145002.GA17098@dennisz-mbp>
References: <20190708125217.3757973-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708125217.3757973-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 02:52:09PM +0200, Arnd Bergmann wrote:
> gcc complains that pcpu_page_first_chunk() might return an uninitialized
> error code when the loop is never entered:
> 
> mm/percpu.c: In function 'pcpu_page_first_chunk':
> mm/percpu.c:2929:9: error: 'rc' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> Make it return zero like before the cleanup.
> 
> Fixes: a13e0ad81216 ("percpu: Make pcpu_setup_first_chunk() void function")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/percpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 5a918a4b1da0..5b65f753c575 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2917,6 +2917,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size,
>  		ai->reserved_size, ai->dyn_size);
>  
>  	pcpu_setup_first_chunk(ai, vm.addr);
> +	rc = 0;
>  	goto out_free_ar;
>  
>  enomem:
> -- 
> 2.20.0
> 

Hi Arnd,

I got the report for the kbuild bot. I have the fix in my tree already.

Thanks,
Dennis
