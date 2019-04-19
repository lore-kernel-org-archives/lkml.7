Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC1FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B0721479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/bi+KKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfDSTcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:32:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36025 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfDSTct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:32:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id u17so4696520lfi.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d7j7ibmI/hwuau+9LB435H5B5khOUvNKDYHZSK8OJFI=;
        b=K/bi+KKGE7S545qHzeqi6n/FJwXwGGUlAEbJUE+w2bUHyRKzGBFbKRCye4dUEz1qdz
         LwvqlLbO764cPhEDKXb6vj82GDFZxW7AJ1A/5wh9ym5F1FdF4d6d8rxiawecXO04Hfos
         7XYOWKRpQKGTb9XjGhEf1G3iW7yWQZfoMsYbhYcphRUxAk72mO56e2v8yiLpoOeNHip2
         pI88bF6Hpb/KQe96JeO52I9X7ncjXy+uY/pVVYsr/c1U51PxPweULIYZw7QhFBNGvtrl
         iSbqC/fyzaC3NN52XvGHlFlU1CwI+VAMHYCenP3E7YK0sE7zBYvpynJGUCFZPmodxJMm
         lTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=d7j7ibmI/hwuau+9LB435H5B5khOUvNKDYHZSK8OJFI=;
        b=JwzwRe8+nfS6KAPjTa1SSSl8z94c5tHHnC3bO3YIsYP/Ag+KgJhiPoR+IORDqhvSZ3
         J1COXQbcGcqUyUK+T4vxjc9hvo6g/QxnHjMQRjWInn0YG12YXKoeOfITBpr+Y3qmYkft
         UOr6CMdFl/gW/pbWxJSU7KeklIKyLh6ziZuur6VskEHR5eayxnrFPZSqkDg8RlovIFqD
         62OAWCBFW6FExQeoBomsyiZVw39G3pQc7tiIvbGC6vD2OXehhBcyCxxbie5Vr8e7D0jW
         OJo+J3MqfoflqfSfhiXPOdwg6SlLw/rw+BIDABXvcyUbDWxPWVYpO4ZOPlc3qwCHOtJn
         /bfQ==
X-Gm-Message-State: APjAAAUr08GGH1ZtFDWaFXD+T/w3gGZNtCwXNyB5XcvfbjDUA6WrXXKP
        mPjbulwRCl2X54frCHlssU3/fU2GMS0=
X-Google-Smtp-Source: APXvYqwTZmuIgaxsK6mxNtZhqxSzZBt6gqVy7LhhvyXiNb+iHuXGwBl9pp3nVnnMWQymAmV94CSj7w==
X-Received: by 2002:ac2:48bb:: with SMTP id u27mr1876562lfg.17.1555670553078;
        Fri, 19 Apr 2019 03:42:33 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id m18sm942231ljb.35.2019.04.19.03.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 03:42:32 -0700 (PDT)
Date:   Fri, 19 Apr 2019 13:42:30 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        hawk@kernel.org, xdp-newbies@vger.kernel.org, ast@kernel.org,
        aniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com
Subject: Re: [RFC PATCH 3/3] net: ethernet: ti: cpsw: add XDP support
Message-ID: <20190419104228.GA4268@khorivan>
Mail-Followup-To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        hawk@kernel.org, xdp-newbies@vger.kernel.org, ast@kernel.org,
        aniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com
References: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
 <20190417174942.11811-4-ivan.khoronzhuk@linaro.org>
 <20190419083156.GA6687@apalos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190419083156.GA6687@apalos>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 11:31:56AM +0300, Ilias Apalodimas wrote:
>Hi Ivan,
>
>> +static struct page *cpsw_alloc_page(struct cpsw_common *cpsw)
>> +{
>> +	struct page_pool *pool = cpsw->rx_page_pool;
>> +	struct page *page;
>> +	int i = 0;
>> +
>> +	do {
>> +		page = page_pool_dev_alloc_pages(pool);
>> +		if (!page)
>> +			return NULL;
>> +
>> +		/* skip pages used by skb netstack */
>I think the comment here is wrong and might confuse people.
>The page ref cnt is 1, which means the packet was *processed* and netstack is
>done with it, hence you can re-use it.
>If it's !=1 then you correctly unmap the buffer and decrease the ref cnt, so it
>will eventually be freed and not returned to the pool, right?
It's compensation substitution for page_pool support in skb netsack.
And should be considered in combine with:

skb = build_skb(xmeta, cpsw_rxbuf_total_len(pkt_size));
...
page_pool_recycle_direct(pool, page);
page_ref_inc(page);
netif_receive_skb(skb);

Here order is important.

I will correct comments in final version (w/o overloading) ofc, leaving
thinking environment for people. I think it's fair enough about this.

>> +		if (page_ref_count(page) == 1)
>> +			break;
>> +
>> +		/* it's a pitty, but free page */
>> +		page_pool_recycle_direct(pool, page);
>> +	} while (++i < descs_pool_size);
>> +
>> +	return page;
>> +}
>> +
>
> /Ilias

-- 
Regards,
Ivan Khoronzhuk
