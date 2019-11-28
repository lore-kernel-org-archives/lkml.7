Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BFDC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFB02176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2bSOyqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfK1NwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:52:06 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46951 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1NwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:52:05 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so126082edi.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OXomE3LhGTg9naIJXoKzldNxQQhZc2QZdqofXcgRGAw=;
        b=X2bSOyqIdi8cnv05tOfNI+Mur1hm3UDPtX+7e7QriBG09PhJCRKlOlHpC2sJ4/eC27
         AnUh4aIFMUnD8KV/32jsLizlgv17g3OiG3v1U+KoIp+xSuYvuTjvyZaKqUeJfLUw9OX6
         5WXX0qzjfk0RqQC/cvZ4MhDdji1hktXsdNFQmDJmSCJx+wcmVgZkNn9TVn8mgMtXI9P7
         r3iZOgXfCICax/BAAbUTucJPt8Fm54+2gdyjvQ8nkg5JbqfqAvrx/EKs+xc7SqSFlWkZ
         AJFWRltnWa4zzIX0P71c6MFOFAo9Kp2+gDwRnk4pxzazBwPGVJfShsKVcot6KacPUYv4
         EUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OXomE3LhGTg9naIJXoKzldNxQQhZc2QZdqofXcgRGAw=;
        b=KJZlE19iVK3vnV5dVUAf84KPnMK073aU3yt3EPTCXNZ9VZejCJKbd5dDE3hY6w7j7Q
         IQ5P+8YV5RSN+OySW7JKlK5Du9w5PQAk0urMjYzhiSSn4Wu3bHKE+jugoPpI5DDG/WL6
         jgm6D77JM7mt/oV43IcxW6GdUL+nzR+MIFKusCsVJmF+r56yFZ8xkhAcxj7vet967ARh
         LPd2ptOf86wRJRZ1pJJlLMBmrV8a5Jv8mnpVLl6ZdKeZhCZTJcRucQzqGw9kInimm50n
         fk4VUOo8UobXEWBSqbsVsR1CX0PI/szVuQbK5TJLGM0XvnNiZe6+g0q7T4JCyJ5gAK1G
         4FOA==
X-Gm-Message-State: APjAAAVFvJkpQkkeRgU+VO57vpiClZzUgdF2rD8e2ZuJ5/ZvDa20Ei8m
        ttZA0c7xu8OxKYjxBtbQghezFw==
X-Google-Smtp-Source: APXvYqze3moY1+8pWkzpxVwArM0DcJsWSudhDMAXq4Iy7IMU1isjW8C8xkNEfHZ7nMxTtW6CUd5m7g==
X-Received: by 2002:aa7:cf83:: with SMTP id z3mr13233275edx.166.1574949123947;
        Thu, 28 Nov 2019 05:52:03 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.193])
        by smtp.googlemail.com with ESMTPSA id f18sm500625ejr.80.2019.11.28.05.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 05:52:03 -0800 (PST)
Subject: Re: [PATCH 5/5] interconnect: qcom: Use the new common helper for
 node removal
To:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20191128133435.25667-1-georgi.djakov@linaro.org>
 <20191128133435.25667-5-georgi.djakov@linaro.org>
 <5686a003-d72f-7a20-4851-9ebb3d2e9b20@gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <3286eb91-f5b8-a4b4-2031-5be50cbb9206@linaro.org>
Date:   Thu, 28 Nov 2019 15:52:02 +0200
MIME-Version: 1.0
In-Reply-To: <5686a003-d72f-7a20-4851-9ebb3d2e9b20@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.19 г. 15:43 ч., Dmitry Osipenko wrote:
> 28.11.2019 16:34, Georgi Djakov пишет:
>> There is a new helper function for removing all nodes. Let's use it instead
>> of duplicating the code.
>>
>> In addition to the above, instead of duplicating the code, simplify the
>> probe function error path by calling driver removal function directly.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>   drivers/interconnect/qcom/msm8974.c | 40 ++++++++++-------------------
>>   drivers/interconnect/qcom/qcs404.c  | 31 ++++++++--------------
>>   drivers/interconnect/qcom/sdm845.c  | 29 +++++++--------------
>>   3 files changed, 33 insertions(+), 67 deletions(-)
>>
[..]>> +static int qnoc_remove(struct platform_device *pdev)
>> +{
>> +	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
>> +
>> +	icc_nodes_remove(&qp->provider);
>> +	return icc_provider_del(&qp->provider);
>> +}
>> +
>>   static int qnoc_probe(struct platform_device *pdev)
>>   {
>>   	const struct qcom_icc_desc *desc;
>> @@ -855,29 +863,10 @@ static int qnoc_probe(struct platform_device *pdev)
>>   
>>   	return ret;
>>   err:
>> -	list_for_each_entry(node, &provider->nodes, node_list) {
>> -		icc_node_del(node);
>> -		icc_node_destroy(node->id);
>> -	}
>> -
>> -	icc_provider_del(provider);
>> +	qnoc_remove(pdev);
> 
> This is wrong because platform_set_drvdata() is invoked at the end of
> qnoc_probe(), thus platform_get_drvdata() of qnoc_remove() returns NULL
> here.

True! Will fix it! Thank you!

BR,
Georgi
