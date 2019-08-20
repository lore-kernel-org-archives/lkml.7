Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1223C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3B42054F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H50PQ5XZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfHTNJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:09:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44572 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfHTNJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:09:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so2729805plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 06:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=R/XEZX18qkyJvhxRVDCiF+uMNuLw57f1ZojJ1bFz9f8=;
        b=H50PQ5XZm7e7HPZqtsiAV1BlECpRkPYzUHgvQIOmbQXYrwcj9vPVBlNXpCsWZnYzIP
         HffL4/rfz53HSSwmFbD5hVG/omf43KELdSunZ5IkCLusywD2fKAXXYxVRpObFQ/FDpUx
         QqTF9jnjVmvQPw/IKpos0CsWqjBQHqEj9V9zitsMwThRWj/JMOmHpXKiy61E4dTsB9Wn
         gR8bO1eBdTdGPNFVWNt4CyK1FtLcXOEry8JD3Tqd+nGs+1LotJd3EtkTPOTTxqylLRmo
         YDw809dLvzu1PWhbeFTVdYPnBJrK0e7kVozVelfoZESQBgAFaEi6uDQaDm6AchCU7qKd
         bmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=R/XEZX18qkyJvhxRVDCiF+uMNuLw57f1ZojJ1bFz9f8=;
        b=QVxu740pDx9CAaUP8sKLRit+9iG3fzBSvOKvLnCftsgcthjSkAKC75s+vdI5dfk7qR
         cicmA4C9kX0i74mV43daeuwb6zwLMBcqY1X6KWrLlluY1CjzjnqSb7D6rb8QizHuO4lN
         XDZKgC+dtvVGmMpvv7KiTcIEI4V+pAuDBgq8hpK5t07tGbJIBQOSmaSWmHGuQSMtrDNm
         pDk9xxnIrCIndkuSfHemQ8VhRzNYXetkYA/YliYkDpRsZw0lQxpnZO0ipO3e8SkZDwcc
         KjJ/MC5BdRqXAR5iR+dUhbspuAG5M6GhEcvmCIri0jHUMrUSiMGhgS61JnxFo0/wM3x+
         c/lg==
X-Gm-Message-State: APjAAAUA8s5t+7//mCOZbGgZfHcP9tGIWvvGl2Hv7LRKjKcGQH1hb1QF
        Nav3S7IqvgGKoPfUQpKaf36pbw==
X-Google-Smtp-Source: APXvYqwjnLpfX2/kHGD4FwuuIV3Us193gOGmF+XHwkGpEjE84dg+hvKvFuMC5vT7Ag6Y7OEYTvV/xA==
X-Received: by 2002:a17:902:4283:: with SMTP id h3mr17410026pld.56.1566306548634;
        Tue, 20 Aug 2019 06:09:08 -0700 (PDT)
Received: from ?IPv6:240e:362:43e:2200:6d55:ae74:3a5b:9669? ([240e:362:43e:2200:6d55:ae74:3a5b:9669])
        by smtp.gmail.com with ESMTPSA id t4sm24029670pfd.109.2019.08.20.06.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 06:09:07 -0700 (PDT)
Subject: Re: [PATCH 2/2] uacce: add uacce module
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
 <20190815141351.GD23267@kroah.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <6daab785-a8f9-684e-eb71-7a81604d3bb0@linaro.org>
Date:   Tue, 20 Aug 2019 21:08:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815141351.GD23267@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/15 下午10:13, Greg Kroah-Hartman wrote:
> On Wed, Aug 14, 2019 at 05:34:25PM +0800, Zhangfei Gao wrote:
>> +int uacce_register(struct uacce *uacce)
>> +{
>> +	int ret;
>> +
>> +	if (!uacce->pdev) {
>> +		pr_debug("uacce parent device not set\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (uacce->flags & UACCE_DEV_NOIOMMU) {
>> +		add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
>> +		dev_warn(uacce->pdev,
>> +			 "Register to noiommu mode, which export kernel data to user space and may vulnerable to attack");
>> +	}
> THat is odd, why even offer this feature then if it is a major issue?
UACCE_DEV_NOIOMMU maybe confusing here.

In this mode, app use ioctl to get dma_handle from dma_alloc_coherent.

It does not matter iommu is enabled or not.
In case iommu is disabled, it maybe dangerous to kernel, so we added warning here, is it required?


We support two modes.
1. support sva, (va = iova)
a. If pasid is supported, multi-process can be supported.
b. If pasid is not supported, multi-process can NOT be supported.
We borrowed va from user space to achieve a single virtual address system.


2. Can not support sva, iova != va,
Here user app get dma_handle from dma_alloc_coherent via ioctl.
We need this mode for two reasons:
1. This mode can support multi-process, to support openssl etc.
2. Some accelerators (crypto like zip, etc) can work without sva, just prepare data and kick start.

Thanks
