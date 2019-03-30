Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90129C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65714218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NpFUP1Om";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jHX8ONOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbfC3SjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:39:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51600 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730606AbfC3SjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:39:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0579B602AE; Sat, 30 Mar 2019 18:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553971159;
        bh=Xgke/FOsS6oIqAeywAyqaV72XxASsaICTQqdSasJLfE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=NpFUP1OmKbwtxoCEsqGdnNcMca+UlscX6ImAAGFiJl2161q2GcGE6M0/u5Gp2aHCH
         Xt1WCDLQKcOXQxg4uccbWMK76z2HllAqiVdc7/YjwPk1h1Wd7JoIXRdaOdd+IYtZgM
         5IWgZvedT/yBUdWlL7THsIPxNdWGC6W49wlyGInk=
Received: from [10.79.169.97] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CBC6D602AE;
        Sat, 30 Mar 2019 18:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553971158;
        bh=Xgke/FOsS6oIqAeywAyqaV72XxASsaICTQqdSasJLfE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=jHX8ONOgzTM897VscZU/t0znGD7Z+R58NpVE/cHJr7fglgORFAxVJXYUy0gZ+5hy+
         fPj7XCLwH7XRUmXkLjSF09GEeYomoM13Ur4rJYeNJT7ncuyZHT0GrluHNuj9ZsIVlK
         3AvW3ZO3/3xHa+m1rZvaPBplwrJyF77s7Kqx18hY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CBC6D602AE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] trace: events: fix error directive in argument list
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        luc.vanoostenryck@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        roopa@cumulusnetworks.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
References: <20190330181823.GA16263@hari-Inspiron-1545>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <fd591816-0144-94fa-a91b-35787ff03e86@codeaurora.org>
Date:   Sun, 31 Mar 2019 00:09:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190330181823.GA16263@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/30/2019 11:48 PM, Hariprasad Kelam wrote:
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
>                 if (n->tbl->family == AF_INET6) {
> to if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6)
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh


> ---
> Changes in V2:
>                  -Divide patch to only address spare error
> ---
>   include/trace/events/neigh.h | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/include/trace/events/neigh.h b/include/trace/events/neigh.h
> index 0bdb085..2ca0180 100644
> --- a/include/trace/events/neigh.h
> +++ b/include/trace/events/neigh.h
> @@ -70,12 +70,10 @@ TRACE_EVENT(neigh_update,
>   		else
>   			*p32 = 0;
>   
> -#if IS_ENABLED(CONFIG_IPV6)
> -		if (n->tbl->family == AF_INET6) {
> +		if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6) {
>   			pin6 = (struct in6_addr *)__entry->primary_key6;
>   			*pin6 = *(struct in6_addr *)n->primary_key;
>   		} else
> -#endif
>   		{
>   			ipv6_addr_set_v4mapped(*p32, pin6);
>   		}
> @@ -147,12 +145,10 @@ DECLARE_EVENT_CLASS(neigh__update,
>   		else
>   			*p32 = 0;
>   
> -#if IS_ENABLED(CONFIG_IPV6)
> -		if (n->tbl->family == AF_INET6) {
> +		if (IS_ENABLED(CONFIG_IPV6) && n->tbl->family == AF_INET6) {
>   			pin6 = (struct in6_addr *)__entry->primary_key6;
>   			*pin6 = *(struct in6_addr *)n->primary_key;
>   		} else
> -#endif
>   		{
>   			ipv6_addr_set_v4mapped(*p32, pin6);
>   		}
