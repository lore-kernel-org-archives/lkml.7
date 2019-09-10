Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5E8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E6A2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="eQS3JCRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389443AbfIJKXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:23:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44211 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732145AbfIJKXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:23:06 -0400
Received: by mail-lf1-f66.google.com with SMTP id l26so1296559lfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lGeaxF3361ZDLiRqfF69m3YDCCCGOzfp7qjSAKXwPTg=;
        b=eQS3JCRLBSiW5Mt35LrQ5+2f69gohd/Yvt8jIougG7z5DGVI1WZuwY6W/hPXPyTsth
         oxwTJdx/YhhpD+vkH7T2M9/kxF7cb53Kb+BZ/xRuCc8XAaIDLBX5VmNRgAUo8SDlCuID
         DB1rLbTklq+0pIZro1F8T5EeehSHzEmP3Fi9zAoWknKzIojzEZ0wkr0e+op5tKKxkwKy
         l2J0gqH6sQq93lagiag3PoxkwqSGdLBTEHvm1CTqD5cutL1Fx0gb/SSiqPnODDarVSCw
         xZV/TDRhPEbg/lR0nG6mNYSUYlvmuW2JbOutnXB2HjCxOVtwREvNXYd1z6ZfIzqiCWYd
         00Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lGeaxF3361ZDLiRqfF69m3YDCCCGOzfp7qjSAKXwPTg=;
        b=PmHBT1TyvHheH0qiO6DzTBILdOl0KoTxreR/aeBjVaUGO8T6pSXNAsqnnop4GJIsmb
         bTtdqRnEDt+LMNV5irKYBgVN6flhlATk4PaPh0ACIS9lCKSeIoi8AME85ZHTm3CzAwiZ
         5LRz6GKYGUcDy3G+bH9mXMqBokJpPsWhDbNXFHqpeDUHBG7ujaj2QCa/nl68lM1irWcv
         lpmoNw1Yne+/c6uEKVVv+4Ji1jM6WwKPXOUCVolJWQ3fSlVzw0jokk87nRMd/DSzdpXV
         ftPbpyrzthyUVk/3G3QzHADk9e03jOcvhyKgITMDlWum+Gks1HOz4Ft/2lLgdaGRmKh9
         lslw==
X-Gm-Message-State: APjAAAUU/hUV9hfqK3y5BIYuEQK4lPSHY/ovFffNQtFAgEnMC65otubo
        w2wCSDZFRMHK7exFKY0Aefg/pw==
X-Google-Smtp-Source: APXvYqztvyzPBWtSL77EjwyenOIL/v0d8dvqSOCsEqtZmZvm4lpKZu/t14IHzUuXAQcJsBk8FzxIAA==
X-Received: by 2002:a19:6008:: with SMTP id u8mr16932886lfb.12.1568110984703;
        Tue, 10 Sep 2019 03:23:04 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:29f:2049:ec7c:4ff3:ee75:27b0? ([2a00:1fa0:29f:2049:ec7c:4ff3:ee75:27b0])
        by smtp.gmail.com with ESMTPSA id s5sm3722048lji.104.2019.09.10.03.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 03:23:04 -0700 (PDT)
Subject: Re: [PATCH net] net: sonic: replace dev_kfree_skb in
 sonic_send_packet
To:     Mao Wenan <maowenan@huawei.com>, tsbogend@alpha.franken.de,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190910085848.144780-1-maowenan@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <a48a6690-eeb4-91d2-bed8-439d14b63e2f@cogentembedded.com>
Date:   Tue, 10 Sep 2019 13:23:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190910085848.144780-1-maowenan@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10.09.2019 11:58, Mao Wenan wrote:

> sonic_send_packet will be processed in irq or none

    s/none irq/non-irq/?

> irq context, so it would better use dev_kfree_skb_any
> instead of dev_kfree_skb.
> 
> Fixes: d9fb9f384292 ("*sonic/natsemi/ns83829: Move the National Semi-conductor drivers")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
[...]

MBR, Sergei
