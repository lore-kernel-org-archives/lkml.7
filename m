Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BC0C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D5C2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="mBGIaMQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfKFUvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:51:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41146 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfKFUvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:51:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id l3so17947805pgr.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 12:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vJ9OYEmFicBQTWC5Whu4ZobVh1fTGzzolfkLnikbPY4=;
        b=mBGIaMQE3+XoVaKnpNhd92Abqgr7jZea+yZZJIKuyqtQXCqrt1QwBqnV/d1M6mMaLI
         CpbZ0Ed/mH7mdSu3rACsHRsu0R4J1u1lKv4a0FhPvA8hv4V4u6K73a+8auCT1VxRsXF4
         qBEfKY+G7dDAdfa44Cc2QlpWcfB1f6l3xozLnpY4F6WQsq1agIgA09BqYKZDmQPq5yuR
         tvsxe4T9Pa99B3/RaWl//T0GtcPZPyPBsTbc4nfbyvW5iGAadIOjil73EhVOfpUJ9zfi
         KMHfqTLRnsf48A9ZVi9H5ALepCZS8V4UFj3j+Yah/iY8YqPWOPgwnEUtps47DFwtEIs3
         h6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vJ9OYEmFicBQTWC5Whu4ZobVh1fTGzzolfkLnikbPY4=;
        b=LrK+ZuimzNqqzsIXaJm+FGfKK40BO9h0VorV8EbWb0vI+2uo5jX9p0vBghdMP3qoys
         V4nU+r+9UV7W5YB4aynLesS31JDXRdtUBfwe4so7vif3NaewzdZ31i7eYDHPqUl0IH5D
         imQbVKM6zVZy/rRHDZJUZ7typA154RfPStk9cZxeWm9VFNyIeKcqrmfA15CWvbc4SMeD
         km6amBZoyN+sC8b77D2mBjPRJJHoiP0FcLBZcG0sZQk7aCrBbGu5qOBWCMGlMH29NWvW
         r5ivhVu64BA5zZ2yfD1+c8wt5gn5U5ybwd0R7FHY8OjdYxlil3VJc38Lq6ULlROsskjs
         WDAQ==
X-Gm-Message-State: APjAAAW/bh3u8bYSSOxQDk/HkXoXLmlJgUP1zL2dHO6bv6TcMs2fAlFl
        eHBsIWRRCtksrdZbpVcU8EPaXw==
X-Google-Smtp-Source: APXvYqwouta6uHeps+u/Wn/QIEPYm2HcRS7bY3pNz6pJLTSOhmt8wo684FG3WBIqHX1IT/+hoWNhtw==
X-Received: by 2002:a65:6119:: with SMTP id z25mr5370779pgu.332.1573073469666;
        Wed, 06 Nov 2019 12:51:09 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 205sm22138639pge.56.2019.11.06.12.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 12:51:07 -0800 (PST)
Subject: Re: [PATCH] xtensa: improve stack dumping
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
References: <20191106181617.1832-1-jcmvbkbc@gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <27720768-9fb7-0382-e1ef-ac9760cdf5cc@arista.com>
Date:   Wed, 6 Nov 2019 20:50:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106181617.1832-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On 11/6/19 6:16 PM, Max Filippov wrote:
> Collect whole stack dump lines in a buffer and print the whole buffer
> when it's ready with pr_info instead of pr_cont. This makes stack dump
> lines consistent in SMP case and relies less on pr_cont/printk
> differences related to timestamps.
> Make size of stack dump configurable.
> Drop extra newline output in show_trace as its output format does not
> depend on CONFIG_KALLSYMS.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

[..]

>  void show_stack(struct task_struct *task, unsigned long *sp)
>  {
>  	int i = 0;
>  	unsigned long *stack;
> +	char buf[9 * 8 + 1];
>  
>  	if (!sp)
>  		sp = stack_pointer(task);
> @@ -512,10 +510,12 @@ void show_stack(struct task_struct *task, unsigned long *sp)
>  	for (i = 0; i < kstack_depth_to_print; i++) {
>  		if (kstack_end(sp))
>  			break;
> -		pr_cont(" %08lx", *sp++);
> +		sprintf(buf + (i % 8) * 9, " %08lx", *sp++);

buf is on the stack, does sprintf() put null-terminator for hex?

>  		if (i % 8 == 7)
> -			pr_cont("\n");
> +			pr_info("%s\n", buf);
>  	}
> +	if (i % 8)
> +		pr_info("%s\n", buf);

If the stack trace ends with (i % 8 == 7), you'll double-print the last
line?

Thanks,
          Dmitry
