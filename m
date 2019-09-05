Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C09C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F6E21743
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QKFEqV2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbfIEFL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 01:11:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43623 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfIEFL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 01:11:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id u72so699071pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 22:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=m1T6OFZ8m2OWHUM6Qhu5Jm50/Ym1vGzeOil0qzo7tJ8=;
        b=QKFEqV2objc8mgIk7kxxl1GLBQ29uyx6yPkqpACsRyMRcKuo3pKhKnffLnK/+kbvP3
         37QZ6d92Vjv5p8W4wIdIpRqQMAn9y2TQ9Z0OeS1H5E19lsLaixlMpNiZf9aIZE4I+BzO
         9aYLX5o99EfVVLkFxaMJinGWQo5loFz6Oe4xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=m1T6OFZ8m2OWHUM6Qhu5Jm50/Ym1vGzeOil0qzo7tJ8=;
        b=YAurQYvZi6zeupKamMWGsH/yuBhgV8iM/9ju0MEFC9SuqvSPgf5etwczazP+CSrasB
         s7h/u0jyT5Fzrl7WcsukTFk2+iV7eOlAbG35EEHD+PsdcdT9nm5a9/EkeIoGcC2bbSwC
         PftfLx/vixNMAGIb27WWN8JyuCCafnvQJVnR4YpvrLQKoq4P8E/d/fJyKdm6F2WwW8uW
         uOiOmEUpmu7q0736IwOG9YCcnHB80SqxhDOMrOitgoj0pMnTNmF73RkylSmGgH09UFjN
         OLLNtNbzsZVgnOi3O2VKAqxlGDQaSkDY8adehes7qDdZw+RZpG3vrkffrtkAh6LKr4J9
         kn0g==
X-Gm-Message-State: APjAAAWnaa4AX1fkzgE3VKqfSUurqCDkM1o/w26QTGUekYVLBmoQLLke
        v9qqTa/S1ZvvjdgvEBOeJSOgBA==
X-Google-Smtp-Source: APXvYqzE/1hkGubnNED6jSeSVXtJEmEmJBapGn6BoztzrTpGIG8FVBwmgN87YsxsNnFZ9BFJ1ZwNOg==
X-Received: by 2002:a17:90a:17cb:: with SMTP id q69mr1782442pja.135.1567660316843;
        Wed, 04 Sep 2019 22:11:56 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i137sm733977pgc.4.2019.09.04.22.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 22:11:56 -0700 (PDT)
Message-ID: <5d70991c.1c69fb81.c0590.2f13@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190829092926.12037-6-srinivas.kandagatla@linaro.org>
References: <20190829092926.12037-1-srinivas.kandagatla@linaro.org> <20190829092926.12037-6-srinivas.kandagatla@linaro.org>
Cc:     arnd@arndb.de, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mayank Chopra <mak.chopra@codeaurora.org>
Subject: Re: [PATCH v2 5/5] misc: fastrpc: free dma buf scatter list
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        gregkh@linuxfoundation.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 04 Sep 2019 22:11:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivas Kandagatla (2019-08-29 02:29:26)
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index eee2bb398947..47ae84afac2e 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -550,6 +550,7 @@ static void fastrpc_dma_buf_detatch(struct dma_buf *d=
mabuf,

Is the function really called buf_detatch? Is it supposed to be
buf_detach?

>         mutex_lock(&buffer->lock);
>         list_del(&a->node);
>         mutex_unlock(&buffer->lock);
> +       sg_free_table(&a->sgt);
>         kfree(a);
