Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF89DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E2D218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hS5pceNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbfC2XWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 19:22:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33618 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbfC2XWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 19:22:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id q3so3445958edg.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 16:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zaAIfx8A2P7eqRpChzRBlxwPBjwz7FUntPJf2jPzeZs=;
        b=hS5pceNiQuq6YEHwYPmqHeX3U69gqhf3OHng+zS+43DQ+/w2LiHRtGXgMlNPaBdgaL
         Rq6VgQMuyShGRhOvjKbCE5+J9JAj8h+Y3b1m4WEpQWr+nsfrfYiw1k07wP4ko1SlV+CI
         ksHJyC/gpABljKVP1yaZkeX0ieY5P9aZ6xyGtRiQxYVY+z/KydWRvPP1fvg8BTZnuKhw
         9npuHzuVBdOwJwMYgQvfcmEXEEI55p2PoONLxl3SC5YoprgWNY8sVXDSM/2fMMs1EBrN
         DfQzy9A6Cdhu4R3H3pDIX24P08UWIoH1VOgp49ORoZYkEX8oQSNq9pWsCM33qNTcOkg0
         sVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zaAIfx8A2P7eqRpChzRBlxwPBjwz7FUntPJf2jPzeZs=;
        b=TNt5Ijt4TcRm06OCw76nBwMIi1eFiwkdgCmJu3RZJXZ5YI5J6JjDY9GCV6slngxum8
         OuSycxpvVIc/N5XhW4CMjY0B96E3YvSCt+TH7bHNi50f+1FmOwJVkO2kN4RuIC77w04P
         a57bUvFXw24mNOgmn/Cs51UKUur0FrYASf95TgrdH/xuxz/5XJFXCaAs9CFQ+L1okO99
         y38+69+Fwg0jLaDVNSI1qq55qQxOAJGthaWi8EbkUsrwrLxdTM1rTpL7owdgfp+17Lkd
         XE0ZgoMPD8bU0qVmGD7XAnBrbfMEu3DgN5wguQNP7AhhSAy19SpXeuvf694P+UOEOpNv
         YiGw==
X-Gm-Message-State: APjAAAXHXUfzdgPq3YNvg6VtVFbiDCiKzUy5i6rsCZL+2VTiia4mRJdU
        TzyWQeSeamNodRWcnfygMdCnar6v
X-Google-Smtp-Source: APXvYqwISpHOOTG0CmdJ/ZNI27HzOaik3AkhoXf+hwiIKtbVGwR7VqrbD7/e7ViYs9y9lQkloxGVeQ==
X-Received: by 2002:a17:906:48c8:: with SMTP id d8mr28629269ejt.208.1553901739528;
        Fri, 29 Mar 2019 16:22:19 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4079:2f00:a405:18aa:2541:8cdc])
        by smtp.gmail.com with ESMTPSA id y9sm581482ejj.60.2019.03.29.16.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 16:22:18 -0700 (PDT)
Date:   Sat, 30 Mar 2019 00:22:17 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, roopa@cumulusnetworks.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: events: fix  error directive in argument list
Message-ID: <20190329232215.itsvo3jj3lu4gr7k@ltop.local>
References: <20190325195303.GA20629@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325195303.GA20629@hari-Inspiron-1545>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 01:23:03AM +0530, Hariprasad Kelam wrote:
> This patch fixes below spare errors.
> 
> Sparse error:
> make C=2 CF=-D__CHECK_ENDIAN__ M=net/core
> ./include/trace/events/neigh.h:73:1: error: directive in argument list
> ./include/trace/events/neigh.h:78:1: error: directive in argument list
> ./include/trace/events/neigh.h:150:1: error: directive in argument list
> ./include/trace/events/neigh.h:155:1: error: directive in argument list
> 
> Changes below two lines to signle line to avoid sparse error
>  #if IS_ENABLED(CONFIG_IPV6)
>                if (n->tbl->family == AF_INET6) {
> to if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
> 
> and removes reassigning pin6 pointer when IPV6 is enabled
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  include/trace/events/neigh.h | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/include/trace/events/neigh.h b/include/trace/events/neigh.h
> index 0bdb085..6e310ea 100644
> --- a/include/trace/events/neigh.h
> +++ b/include/trace/events/neigh.h
> @@ -70,15 +70,11 @@ TRACE_EVENT(neigh_update,
>  		else
>  			*p32 = 0;
>  
> -#if IS_ENABLED(CONFIG_IPV6)
> -		if (n->tbl->family == AF_INET6) {
> -			pin6 = (struct in6_addr *)__entry->primary_key6;
> +		if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
>  			*pin6 = *(struct in6_addr *)n->primary_key;

Why removing the line wheer pin6 is assigned?
IMO, the patch should be:
-#if IS_ENABLED(CONFIG_IPV6)
-		if (n->tbl->family == AF_INET6) {
+		if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
 			pin6 = (struct in6_addr *)__entry->primary_key6;
  			*pin6 = *(struct in6_addr *)n->primary_key;

> @@ -147,15 +143,10 @@ DECLARE_EVENT_CLASS(neigh__update,
>  		else
>  			*p32 = 0;
>  
> -#if IS_ENABLED(CONFIG_IPV6)
> -		if (n->tbl->family == AF_INET6) {
> -			pin6 = (struct in6_addr *)__entry->primary_key6;

Same here.

-- Luc Van Oostenryck
