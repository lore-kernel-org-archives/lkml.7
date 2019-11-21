Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CE5C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552C320656
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elz/lVLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKUOnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:43:10 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43987 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKUOnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:43:09 -0500
Received: by mail-qt1-f195.google.com with SMTP id q8so1265568qtr.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8V2qnILlFtYyfjoegvk07S2xRy9xrnxSif3rglNQkjM=;
        b=elz/lVLVUtWW/NJ6SWJVcwhd/xwX9uoiIRSrHkNbGjxOqRqm/1uOfiaMAba79mSx9v
         jHAQ7nCOBiOH872gAieSBanhI0WBJ0e6/Vk0D9rWHZQmFBb0Al+QQ90/9bb6yCHVlVRl
         1C0TiPcozPVi8Eg4iFM/MaCAViXZz2rpce+skOMSY1AVFyb+l31NIiR5cioAmIBbLHkt
         lX8aeQrWhkuh8Hdp8n5PAD6yfgM3cCRTrVBclu2TyWQXCxkQ54djh9IYChhwSEXALzrq
         fTNnFmlFVo3SdO/YpjVhOBmaM4wggDgGf+rDWs+3infk2zc7k5Y1Vo+9IiuG9XukRoYK
         T07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8V2qnILlFtYyfjoegvk07S2xRy9xrnxSif3rglNQkjM=;
        b=U61UxqTSHJJnJvYngdX2o95i4jNazNjTMV/5AgdIGuxeHFint2Xpl6jYNryzb6pWAZ
         OBBl5rCc7wvGMYBChJFZk0KHPjMwUE6soA01yfDlnUD5BSqmu/sB4QtDPYke7OKCvR72
         ZtQJb5GZG3Wu0XR51l7tvSNdi+TZaQ7IzhLpApHP+kxzPNrjGFqV7dNqeUNobvHo/DEf
         nUEIq9gZJEBzcy579FfXm2aYFDbDRTQQOTTIJLVRBe7rR9OGeitaCs7hiX4QlUCGmg6v
         TyYDFkRpu4/LaoadV9dMUNkVZ2h6hpe7BoWap415HRd/Mc1dT6lcaUZ6JeKMeBifC7Y+
         Ccgw==
X-Gm-Message-State: APjAAAWnKCyaZn42aDds1MroN9Zfc3oR3mfsqbkAMEbXeGCYPkxPFupP
        r9NAbiVGXHP/zYu3XRB1K5E=
X-Google-Smtp-Source: APXvYqzDLVA1uhhLWu74gy4ZyNtrmBahyXA8olhshtcJ2qQE6Zqe5LbQvlBEO2KPLdnVEz83WlmDjg==
X-Received: by 2002:ac8:3787:: with SMTP id d7mr8776537qtc.160.1574347388844;
        Thu, 21 Nov 2019 06:43:08 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id p33sm1612937qtf.80.2019.11.21.06.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 06:43:08 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1C4A640D3E; Thu, 21 Nov 2019 11:43:06 -0300 (-03)
Date:   Thu, 21 Nov 2019 11:43:06 -0300
To:     Hewenliang <hewenliang4@huawei.com>
Cc:     rostedt@goodmis.org, acme@redhat.com, tstoyanov@vmware.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools lib traceevent: Fix memory leakage in
 copy_filter_type
Message-ID: <20191121144306.GG5078@kernel.org>
References: <20191113154044.5b591bf8@gandalf.local.home>
 <20191119014415.57210-1-hewenliang4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119014415.57210-1-hewenliang4@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 18, 2019 at 08:44:15PM -0500, Hewenliang escreveu:
> It is necessary to free the memory that we have allocated when error occurs.
> 
> Fixes: ef3072cd1d5c ("tools lib traceevent: Get rid of die in add_filter_type()")
> Signed-off-by: Hewenliang <hewenliang4@huawei.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks, applied.

- Arnaldo

> ---
>  tools/lib/traceevent/parse-filter.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
> index 552592d153fb..f3cbf86e51ac 100644
> --- a/tools/lib/traceevent/parse-filter.c
> +++ b/tools/lib/traceevent/parse-filter.c
> @@ -1473,8 +1473,10 @@ static int copy_filter_type(struct tep_event_filter *filter,
>  	if (strcmp(str, "TRUE") == 0 || strcmp(str, "FALSE") == 0) {
>  		/* Add trivial event */
>  		arg = allocate_arg();
> -		if (arg == NULL)
> +		if (arg == NULL) {
> +			free(str);
>  			return -1;
> +		}
>  
>  		arg->type = TEP_FILTER_ARG_BOOLEAN;
>  		if (strcmp(str, "TRUE") == 0)
> @@ -1483,8 +1485,11 @@ static int copy_filter_type(struct tep_event_filter *filter,
>  			arg->boolean.value = 0;
>  
>  		filter_type = add_filter_type(filter, event->id);
> -		if (filter_type == NULL)
> +		if (filter_type == NULL) {
> +			free(str);
> +			free_arg(arg);
>  			return -1;
> +		}
>  
>  		filter_type->filter = arg;
>  
> -- 
> 2.19.1

-- 

- Arnaldo
