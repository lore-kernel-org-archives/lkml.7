Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BA3C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2815204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iKNqEgMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfDSTM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:12:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54602 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfDSTM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:12:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id c1so7128654wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=es1iLl139MqIIzoVQVdVNHyENizy6SXrassvrh1IEwI=;
        b=iKNqEgMDx2SvsoTV74mwhZhYo0sszYqcp1d14TvGu+HDIhKsGeYJRFhMSBbDpv/zXz
         MKT9HcX9EAn9qI4RCBZv+nORLy/1W7/77k9RGE7I82EM2TE/EZQgYiKMffKkxlmfM1UM
         WZo8DOE4qlgbd9lxWY8XDMru9TdFx/dGmQoN+JjrAn9uWavvXEPWd9ZUkeurGqxx4EjW
         tNC+L2LjBP2AUACKFaVAvPwGXy0QnsTgpHzu44HYcU8CoUbR/cSO04qk7Bjwmlbji1h1
         9ONheE2IzenBZm5L1nNfsZlPlx1OeZJ0H87K01xpocbSvSIRv5/K6cBEtWBJnMeeeDZ6
         /Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=es1iLl139MqIIzoVQVdVNHyENizy6SXrassvrh1IEwI=;
        b=Iq/a/9mcwWRBJ7SKfE1MwXnqLEywyQEuH65mk/fBv44Lr1krGF+T7eGK7uAJ2p0im6
         eJ9OhODr64sN/kVtJihlANBdQoUz8zM5qXmtsaF69V+7kt/p7Ey9DGwZEYCXmVvh8qkT
         tiQ6hOLGM6//gsUXn+eVio+OerWVIObnXNc/3Lgsr0zEZoH8bllQMMRAtkqdRpkkRJ6M
         YYOmPG6DgAN7ZdfVIDAPTA3egHg2LDdMoU91rEZeA5326tNsqgXC5lWXi4mecj5htx3G
         vJoUpYwUzF0i2YRB4A8jbyajzJt8hpXWYtxEJj7DKL3sYFwey1BGoW0KqAUSTtj/kDOZ
         Y19A==
X-Gm-Message-State: APjAAAX/qp9ZNYUO7mOZDaDZt/LtOJGWR0J6g/tBBGv1KrFPmnTA3ldw
        qfERkNT7XGOaid5xkmOSeGGgANxaCHc=
X-Google-Smtp-Source: APXvYqyxnX7B2gQanmwA6RUDY5jBFce9H2LGwab2QkWaHpOGfs6Eg7RNQNbrGj6B19LxNM+9PaE97g==
X-Received: by 2002:a1c:e709:: with SMTP id e9mr1819419wmh.14.1555662720183;
        Fri, 19 Apr 2019 01:32:00 -0700 (PDT)
Received: from apalos (athedsl-4485328.home.otenet.gr. [94.71.60.216])
        by smtp.gmail.com with ESMTPSA id h12sm1046285wrw.36.2019.04.19.01.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 01:31:59 -0700 (PDT)
Date:   Fri, 19 Apr 2019 11:31:56 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc:     grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        hawk@kernel.org, xdp-newbies@vger.kernel.org, ast@kernel.org,
        aniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com
Subject: Re: [RFC PATCH 3/3] net: ethernet: ti: cpsw: add XDP support
Message-ID: <20190419083156.GA6687@apalos>
References: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
 <20190417174942.11811-4-ivan.khoronzhuk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417174942.11811-4-ivan.khoronzhuk@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan, 

> +static struct page *cpsw_alloc_page(struct cpsw_common *cpsw)
> +{
> +	struct page_pool *pool = cpsw->rx_page_pool;
> +	struct page *page;
> +	int i = 0;
> +
> +	do {
> +		page = page_pool_dev_alloc_pages(pool);
> +		if (!page)
> +			return NULL;
> +
> +		/* skip pages used by skb netstack */
I think the comment here is wrong and might confuse people.
The page ref cnt is 1, which means the packet was *processed* and netstack is
done with it, hence you can re-use it.
If it's !=1 then you correctly unmap the buffer and decrease the ref cnt, so it
will eventually be freed and not returned to the pool, right?
> +		if (page_ref_count(page) == 1)
> +			break;
> +
> +		/* it's a pitty, but free page */
> +		page_pool_recycle_direct(pool, page);
> +	} while (++i < descs_pool_size);
> +
> +	return page;
> +}
> +
 
 /Ilias
