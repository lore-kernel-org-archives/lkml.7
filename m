Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9207DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1402184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arrikto-com.20150623.gappssmtp.com header.i=@arrikto-com.20150623.gappssmtp.com header.b="LNYZPgXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfCTRoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:44:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45645 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfCTRod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:44:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so3734921wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DjLlnVJlihTC9Ib0FLMZvDbZ9ZyWjgzRsseOQK8Fk08=;
        b=LNYZPgXMx2z2HFHZQF1FQ1rNiv+6X9cZAji3KfWaui1xo3xBQQXGrwgSLp4Y4IjJku
         JM8tYAApw8gffTCN+wvTfvCW/uhs46ykHnhtv1qt2IRfA+5RCucIDemGWURqBVvu3Rez
         OqQb6wusNxkfi8dXzZIlKL+WWH3DKTaovUK6RECnEptsD+HAK3OQu/memmx2uBO94QqJ
         dDTu01fqJouDWv0HqBFC+Q4qv6kr72A79AxkfiWOzoR/Gj8z9w54l3Vsee9wEOOQzObP
         JnUnb++rHpmp7MuYuuwK9Jpth8L+rBSjLaUiwCS5LShLY1QwKIz5um0bGtRHsW1WF+yX
         Pyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DjLlnVJlihTC9Ib0FLMZvDbZ9ZyWjgzRsseOQK8Fk08=;
        b=YHT7MppxQgDnrJ6m4xgfvywvLmV7Km8NwfWFd9nc2Q+6nHLyhskdG2QGxpb+5Q79Jq
         doS1TB/ddr4NPASV4z1lthfwvYeUe2fTs8wm7HJducdFU43gJyRcVwNCwu2iwT29YCRt
         koeJZtjNmq0c2hWHBey/Ud8JVrkT6tBG/brmhaDcRzDwe8uxlsoexQod10+73ptZdJgo
         7N96hcWzJyZTZeoDRQeNuBROs537qDnTUX0uvDJvi2ulYGn8D3Ttm3ofj0TINGPWfGhN
         9tHpdJ25jJcFbpfldF4iwZwYJSGSIzi5Gg0z48yQelOrdNZ17lVBpjpwbbK+oRAM81EY
         SacQ==
X-Gm-Message-State: APjAAAWlNFSgGLNuAgPk+XEunX0Z6YOpSiQNUCA5IaOeGY5x8a/AsfUg
        1vKrVTbPi4rudm/TV2fe2QimXQ7MQcI=
X-Google-Smtp-Source: APXvYqx86bUurON9o1nGZ12kWQlXsQF6LexUTKyGJrj/kFGY3tIKVp/cA35SGtB2SB2RenUOiswybg==
X-Received: by 2002:a5d:5703:: with SMTP id a3mr16483260wrv.175.1553103871466;
        Wed, 20 Mar 2019 10:44:31 -0700 (PDT)
Received: from [10.94.250.119] ([31.177.62.212])
        by smtp.gmail.com with ESMTPSA id e16sm5350536wrs.0.2019.03.20.10.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 10:44:30 -0700 (PDT)
Subject: Re: [PATCH v3 2/6] list_bl: Add hlist_bl_add_before/behind helpers
To:     paulmck@linux.ibm.com
Cc:     snitzer@redhat.com, agk@redhat.com, dm-devel@redhat.com,
        mpatocka@redhat.com, hch@infradead.org, iliastsi@arrikto.com,
        linux-kernel@vger.kernel.org
References: <20190317122258.21760-1-ntsironis@arrikto.com>
 <20190317122258.21760-3-ntsironis@arrikto.com>
 <20190318154138.GI4102@linux.ibm.com>
From:   Nikos Tsironis <ntsironis@arrikto.com>
Message-ID: <b34c05b0-11a6-19a4-f6e0-bb0ea2666eb5@arrikto.com>
Date:   Wed, 20 Mar 2019 19:44:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318154138.GI4102@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/19 5:41 PM, Paul E. McKenney wrote:
> On Sun, Mar 17, 2019 at 02:22:54PM +0200, Nikos Tsironis wrote:
>> Add hlist_bl_add_before/behind helpers to add an element before/after an
>> existing element in a bl_list.
>>
>> Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
>> Signed-off-by: Ilias Tsitsimpis <iliastsi@arrikto.com>
> 
> On both this and the previous patch, the double signed-off-by lines
> are a bit strange.  You might be wanting Co-developed-by, but please
> see Documentation/process/submitting-patches.rst.

Hi Paul,

Thanks for your suggestion. I will make sure to reread the Documentation
regarding patch submission.

Thanks,
Nikos

> 
> Other than that:
> 
> Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
>> ---
>>  include/linux/list_bl.h | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
>> index 3fc2cc57ba1b..ae1b541446c9 100644
>> --- a/include/linux/list_bl.h
>> +++ b/include/linux/list_bl.h
>> @@ -86,6 +86,32 @@ static inline void hlist_bl_add_head(struct hlist_bl_node *n,
>>  	hlist_bl_set_first(h, n);
>>  }
>>  
>> +static inline void hlist_bl_add_before(struct hlist_bl_node *n,
>> +				       struct hlist_bl_node *next)
>> +{
>> +	struct hlist_bl_node **pprev = next->pprev;
>> +
>> +	n->pprev = pprev;
>> +	n->next = next;
>> +	next->pprev = &n->next;
>> +
>> +	/* pprev may be `first`, so be careful not to lose the lock bit */
>> +	WRITE_ONCE(*pprev,
>> +		   (struct hlist_bl_node *)
>> +			((uintptr_t)n | ((uintptr_t)*pprev & LIST_BL_LOCKMASK)));
>> +}
>> +
>> +static inline void hlist_bl_add_behind(struct hlist_bl_node *n,
>> +				       struct hlist_bl_node *prev)
>> +{
>> +	n->next = prev->next;
>> +	n->pprev = &prev->next;
>> +	prev->next = n;
>> +
>> +	if (n->next)
>> +		n->next->pprev = &n->next;
>> +}
>> +
>>  static inline void __hlist_bl_del(struct hlist_bl_node *n)
>>  {
>>  	struct hlist_bl_node *next = n->next;
>> -- 
>> 2.11.0
>>
> 
