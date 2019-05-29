Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09FDC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D2420B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+VZs9Wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfE2J6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:58:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35585 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfE2J6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:58:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id h11so1830878ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 02:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/sVA9YKu8BEhrQsD2y3FdbEDwI/iZvTti9LgKUCmCho=;
        b=g+VZs9Wxzz58VQ5DfHuZCBSCmF8aIdt6hK2FWdf0aNvXP76PgEkEf4YXVcL7dYgQHM
         VpIeRvv5y1ZohW1l8kwQ1c890KodOvZp0InN/sTV9/KjSQEYcDEXqVue1N/EBRHpf1UD
         m2osWXg00PBOXJjV+EHuOoBB/GHktgYIA/LqkSY+ZUWgKu/urkNwpq8DWtOZTc/6egeV
         NE9etHNAxCUyYK3TH6bo2fQpZRnnr2lM4RfGEc0eiN2Z5wGJFVIrFscKwD7vSDgBc/hK
         4aRzH1y/V6P1mdWF4oOeZZp/vj/703I/BX3k0UU3AVEA9WhXraoDNNN8qLYYSnRy2aNC
         TitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=/sVA9YKu8BEhrQsD2y3FdbEDwI/iZvTti9LgKUCmCho=;
        b=Wm9LkIfnuJNGOkLO+Xqirwn+FppkFqblX2qrQyaFpKJ3tzzuQA8mIvxHLt9BJg66jk
         zLWUptNroF2sW0YfymR3Moq0cpFExCV/pRwv9eggkFOT34g0XXcvCbW9aAnYQJ+L01Q+
         85N+P/TY+b5fVOd7j6KJlPOhh2k4r6hWJfwFrNBKyNpuHTCIm8uJ/tIoK3KTr/Ewjtfs
         LZnzqEheSyonE41JObmkRBAEl1Pa5kzsXslVH/zvPyNtbzX8OEGb9pu4nT4VG8cXkxf6
         eyIpBk2qNNNo8A7Mic9+RuOBBepPLqMG7q866XBPsRCLTioitj1n3Cu0yim47a/PsOmx
         NTAQ==
X-Gm-Message-State: APjAAAWLCnOG+/hBP7PbQCSgmm06E2LxnJzMYfG1kQ0PGU6qNwTWo2k7
        COpe8CDfDkXcgW+TpSg9xZDrWw==
X-Google-Smtp-Source: APXvYqwKiANimuGQ4pshZYkZK2pN3RuXOcvwID5gqoUKwV2aHk7xiqEVLVSRPzHagRqjYp4pJSQQsw==
X-Received: by 2002:a2e:9c09:: with SMTP id s9mr39657738lji.74.1559123899025;
        Wed, 29 May 2019 02:58:19 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id h10sm3937299ljm.9.2019.05.29.02.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 02:58:18 -0700 (PDT)
Date:   Wed, 29 May 2019 12:58:16 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net,
        ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com
Subject: Re: [PATCH net-next 3/3] net: ethernet: ti: cpsw: add XDP support
Message-ID: <20190529095814.GA4639@khorivan>
Mail-Followup-To: Jesper Dangaard Brouer <brouer@redhat.com>,
        grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net,
        ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com
References: <20190523182035.9283-1-ivan.khoronzhuk@linaro.org>
 <20190523182035.9283-4-ivan.khoronzhuk@linaro.org>
 <20190529101659.2aa714b8@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190529101659.2aa714b8@carbon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:16:59AM +0200, Jesper Dangaard Brouer wrote:
>On Thu, 23 May 2019 21:20:35 +0300
>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>
>> +static struct page *cpsw_alloc_page(struct cpsw_common *cpsw)
>> +{
>> +	struct page_pool *pool = cpsw->rx_page_pool;
>> +	struct page *page, *prev_page = NULL;
>> +	int try = pool->p.pool_size << 2;
>> +	int start_free = 0, ret;
>> +
>> +	do {
>> +		page = page_pool_dev_alloc_pages(pool);
>> +		if (!page)
>> +			return NULL;
>> +
>> +		/* if netstack has page_pool recycling remove the rest */
>> +		if (page_ref_count(page) == 1)
>> +			break;
>> +
>> +		/* start free pages in use, shouldn't happen */
>> +		if (prev_page == page || start_free) {
>> +			/* dma unmap/puts page if rfcnt != 1 */
>> +			page_pool_recycle_direct(pool, page);
>> +			start_free = 1;
>> +			continue;
>> +		}
>> +
>> +		/* if refcnt > 1, page has been holding by netstack, it's pity,
>> +		 * so put it to the ring to be consumed later when fast cash is
>> +		 * empty. If ring is full then free page by recycling as above.
>> +		 */
>> +		ret = ptr_ring_produce(&pool->ring, page);
>
>This looks very wrong to me!  First of all you are manipulation
>directly with the internal pool->ring and not using the API, which
>makes this code un-maintainable.
Yes I know, it's hack, it was with assumption to be dropped once page_pool
recycling is added.

>Second this is wrong, as page_pool
>assume the in-variance that pages on the ring have refcnt==1.
Yes, but this is w/o obvious reason, seems like it can work with refcnt > 1 if
remove restriction and use >= instead of ==.

As I answered on Ilias comment, I'm going to leave version from RFC and drop
this one.

>
>> +		if (ret) {
>> +			page_pool_recycle_direct(pool, page);
>> +			continue;
>> +		}
>> +
>> +		if (!prev_page)
>> +			prev_page = page;
>> +	} while (try--);
>> +
>> +	return page;
>> +}
>
>
>-- 
>Best regards,
>  Jesper Dangaard Brouer
>  MSc.CS, Principal Kernel Engineer at Red Hat
>  LinkedIn: http://www.linkedin.com/in/brouer

-- 
Regards,
Ivan Khoronzhuk
