Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E59C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0923220850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zz63KpC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCTRKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:10:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34784 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfCTRKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:10:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id y18so2495571lfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K7Z5Oe9P8RmD90tly3iXOv2sACQpbSfPuldJEdUWiqY=;
        b=zz63KpC+w/A+FNE0K21DcVJm9pwDpes4knMlQ9OsboQjJBzx/e7Z+BFKQHn+hvkEwa
         kzlXRlERihlIqMiNZW6d6Arah4fGI5tbZCMAGVfuYalcZ+8Rc0nKUoUESoXPxLW5hw8k
         /QCZBdLMvW3rCZQjjui5wPFD3f8iHIxU/pRMz8krq2dIu3VwwTvcro9uPQsNFR6BTXMR
         2wEw5d/w8dBP4tyg8YGUhq8Vtz0MrDJN1WGT9Junl7h6kGl4QXgnHCPSLPb+mheNGtSB
         gbcxuN0d69I0X/bw31wapIjaZvAVTtefapr8+BQNK0FQ7vpU2SvfM7+0lxB8D4EhDxR6
         FMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K7Z5Oe9P8RmD90tly3iXOv2sACQpbSfPuldJEdUWiqY=;
        b=sKykCmOEr1zbzhmm0EczvkZU0WyRLf4+kKTwh6uGSvJ8X6+W6bhdbSRgZA8LKAuAUM
         rBoZJ37vkqFCbWMnvpnLBRyHZBOVNL2MMTenNwjxNMGOEUO47PLXBADSFEYKumfsmuch
         1REEWV/ZS5HkI2NSTFA+rCrXKhRKUIV6/wNZzFDbil3ltFVrRJcA3OEDemJeTMKFL8u7
         goYnCdLoSR5+vBAaHEOgf/6ApN43D0caeDjD7Z64bR/IWuA+f+2BCpYr4MBZvGsTgO9p
         pCPpkGXFw7/VjL75A23z4MUPn3Av+9nz/ncPcDW4ZWrJj1ze0VrYDFQqbZxWYoDrDGBV
         zApg==
X-Gm-Message-State: APjAAAVZ3JKr8liWEXQSwWuVqWFiembnr8sFAqzFSklxooeja1aiF4ho
        Ne5ytSQcG5QYVWeC51NRyM4TYA==
X-Google-Smtp-Source: APXvYqwUBgcwDm8oi2HnG565cPHxue2nMcDThYFNLQTEtxuYdbxnHAx/yB2KTA/zKgg1/MFZVHh2og==
X-Received: by 2002:ac2:43c3:: with SMTP id u3mr16732529lfl.69.1553101811727;
        Wed, 20 Mar 2019 10:10:11 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id f16sm462789lfa.91.2019.03.20.10.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 10:10:10 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] interconnect: Add support for path tags
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-pm@vger.kernel.org, daidavid1@codeaurora.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, Doug Anderson <dianders@chromium.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        henryc.chen@mediatek.com, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20190208172152.1807-1-georgi.djakov@linaro.org>
 <20190208172152.1807-2-georgi.djakov@linaro.org>
 <CAE=gft7uKN_EXqkuPvu+sSmJU69Le18yfqHcfmFApUHQyaBZ-Q@mail.gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <14cafee8-0252-754b-9f2b-1855b3fdc66d@linaro.org>
Date:   Wed, 20 Mar 2019 19:10:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAE=gft7uKN_EXqkuPvu+sSmJU69Le18yfqHcfmFApUHQyaBZ-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

On 3/8/19 20:40, Evan Green wrote:
> On Fri, Feb 8, 2019 at 9:21 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> Consumers may have use cases with different bandwidth requirements based
>> on the system or driver state. The consumer driver can append a specific
>> tag to the path and pass this information to the interconnect platform
>> driver to do the aggregation based on this state.
>>
>> Introduce icc_set_tag() function that will allow the consumers to append
>> an optional tag to each path. The aggregation of these tagged paths is
>> platform specific.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  drivers/interconnect/core.c           | 27 +++++++++++++++++++++++----
>>  drivers/interconnect/qcom/sdm845.c    |  2 +-
>>  include/linux/interconnect-provider.h |  4 ++--
>>  include/linux/interconnect.h          |  5 +++++
>>  4 files changed, 31 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>> index 6005a1c189f6..31eacd0f5349 100644
>> --- a/drivers/interconnect/core.c
>> +++ b/drivers/interconnect/core.c
>> @@ -42,10 +42,12 @@ struct icc_req {
>>
>>  /**
>>   * struct icc_path - interconnect path structure
>> + * @tag: path tag (optional)
>>   * @num_nodes: number of hops (nodes)
>>   * @reqs: array of the requests applicable to this path of nodes
>>   */
>>  struct icc_path {
>> +       u32 tag;
>>         size_t num_nodes;
>>         struct icc_req reqs[];
>>  };
>> @@ -206,7 +208,7 @@ static struct icc_path *path_find(struct device *dev, struct icc_node *src,
>>   * implementing its own aggregate() function.
>>   */
>>
>> -static int aggregate_requests(struct icc_node *node)
>> +static int aggregate_requests(struct icc_node *node, u32 tag)
>>  {
>>         struct icc_provider *p = node->provider;
>>         struct icc_req *r;
>> @@ -215,7 +217,7 @@ static int aggregate_requests(struct icc_node *node)
>>         node->peak_bw = 0;
> 
> For my suggestion in patch 2, this is where you'd need the callback to
> reset the SLEEP/WAKE shadow aggregation buckets that the provider is
> keeping, since the core just reset the values here. I wonder if you'd
> want to pass the &node->avg_bw and &node->peak_bw in with this
> callback as well... not sure if that's useful. Something like:
> 
>         if (p->begin_aggregation)
>                 p->begin_aggregation(node);

Currently this seems only Qcom specific, so i would prefer to wait and
see if there are similar need for other platforms before adding a new
callback. IMO the best option for now would be to reset the values in
the platform driver after they are committed.

>>
>>         hlist_for_each_entry(r, &node->req_list, req_node)
>> -               p->aggregate(node, r->avg_bw, r->peak_bw,
>> +               p->aggregate(node, tag, r->avg_bw, r->peak_bw,
>>                              &node->avg_bw, &node->peak_bw);
> 
> Wait I'm confused. The tag is associated with a particular path. But
> now aren't you looping over all the other requests and coloring them
> with whatever tag this is? Don't you need to store the tag with the
> request, and then pass r->tag for each r rather than the tag from
> whichever request happened to initiate the re-aggregation?

Yes indeed. I think i am missing a patch here. Thanks for catching it!

BR,
Georgi

>>
>>         return 0;
>> @@ -396,6 +398,23 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>>  }
>>  EXPORT_SYMBOL_GPL(of_icc_get);
>>
