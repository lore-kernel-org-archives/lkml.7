Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80FAC17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0787222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uAo9yOmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfKMNYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:24:23 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46551 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKMNYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:24:23 -0500
Received: by mail-ed1-f65.google.com with SMTP id x11so1754608eds.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 05:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JRP/6EKOcSy60KLVoWb7jM1Tf5lS/OPVbKzG0KgZCIY=;
        b=uAo9yOmMnM/3SrNHSnXryuXkoyxb7GED2KW+gIH19apn94zis9+gv/nx8PglsR6vpz
         qgtdeMAI+ooZ7/giFoQgpO9y5Lk6VE/AHCfSm/vZLHdwBv3H8neAZyQ9j9WyTEHri1Xa
         lJieaXHz3a86aDe6YDxtgc/RLaADka6P+E/kyDkiaBWNprpijul2teXVwERnh1LlT7pu
         roagxEM8zv0CKc08CIY7j5Cs6C7GbzXyRZRYcCm5++1/44kHTBy8c/SL2b6YN6AiyeVL
         m6zBIp5Yl0jCmcqa1K9N2gaDZWAPTq1WfzDTgAhUMawRzqwg8IJ1qNETtKIncMHKfqrM
         PGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JRP/6EKOcSy60KLVoWb7jM1Tf5lS/OPVbKzG0KgZCIY=;
        b=KbxkLtNbNHTQOEe+aAOZ8gqaxT3mPNb0SR66hwf3KJey5ytKqAxGVLhk/cIyWAWHvr
         NCvgrbNNDcI+PgUiYOZ/6SFgwXHiD6w8ZMkFR5tJgAeX6ogfBJ2xBXDxHmg+O0C2hUTw
         RK5fcAMmK51u3Kyl9HlFHiNN4ZL3DZC5z+kpCZF600/oIHALiAUhUtkQqevGHFBD+bvR
         QdQ/34GBwMkBUQRTUPUHpgwaKboJOzLipM0c4+vMM2K/L4rfaoHfsuXiyjqHIDNzU+ie
         iho1i2sjkOEtSFZZSDArvhO7y9qG7Lq5YdPkKLohQWdp4jGAzIQ4w2GX6hXq32OFfXf4
         GrhQ==
X-Gm-Message-State: APjAAAWURGb5bAubz2RRVgeRBdKa0ZlmheMdxlc3aVmnpTtjvovCoubQ
        DKKszkU0cXM6y07aZQDthRzgGcJYkT8=
X-Google-Smtp-Source: APXvYqxeIzEC0kKghBW/pPOmDCzIOyjj19Pwibt4u2DqsePBx8gRya4BnBeKHlC6mxU0yG1bCUmjRw==
X-Received: by 2002:a17:906:c797:: with SMTP id cw23mr2705388ejb.19.1573651461073;
        Wed, 13 Nov 2019 05:24:21 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id r12sm245953edm.85.2019.11.13.05.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 05:24:20 -0800 (PST)
Subject: Re: [PATCH v10 2/3] interconnect: qcom: Add MSM8916 interconnect
 provider driver
To:     Dmitry Osipenko <digetx@gmail.com>, robh+dt@kernel.org,
        linux-pm@vger.kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        vincent.guittot@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191030153904.8715-1-georgi.djakov@linaro.org>
 <20191030153904.8715-3-georgi.djakov@linaro.org>
 <88315b5a-1354-acf9-d57d-b301fb78cfa4@gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <95eb0a55-d36b-b66e-ae64-18aa5baafff7@linaro.org>
Date:   Wed, 13 Nov 2019 15:24:19 +0200
MIME-Version: 1.0
In-Reply-To: <88315b5a-1354-acf9-d57d-b301fb78cfa4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 13.11.19 г. 15:03 ч., Dmitry Osipenko wrote:
> 30.10.2019 18:39, Georgi Djakov пишет:
>> Add driver for the Qualcomm interconnect buses found in MSM8916 based
>> platforms. The topology consists of three NoCs that are controlled by
>> a remote processor that collects the aggregated bandwidth for each
>> master-slave pairs.
>>
[..]
>> +static int qnoc_remove(struct platform_device *pdev)
>> +{
>> +	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
>> +	struct icc_provider *provider = &qp->provider;
>> +	struct icc_node *n;
>> +
>> +	list_for_each_entry(n, &provider->nodes, node_list) {
>> +		icc_node_del(n);
>> +		icc_node_destroy(n->id);
>> +	}
> 
> Hello Georgi,
> 
> While examining the interconnect API and current drivers' code, I
> noticed that everybody are copying this chunk of code which should crash
> kernel because removing node from a list during the traverse is allowed
> only when list_for_each_entry_safe() is used.

Nice catch. Thank you!

> Seems the IMX driver (which is under review now on the ML) is the only
> driver that does the removing procedure correctly.
> 
> Maybe it won't hurt to factor out the removal of provider's nodes into a
> common helper.
> 

Yes, this is a very good idea. Will do it.

Thanks,
Georgi
