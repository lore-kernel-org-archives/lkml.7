Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA74C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AE620820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="fQHBXWI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbfDDSFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:05:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34194 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbfDDSFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:05:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so1758580pfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lpsKD2VU/Sb1onA3HKT8V7QN+mUTEHzIOmdecHq4LdM=;
        b=fQHBXWI7PWNuuhKNf01ZljMp9pqPFKzo4Yz4SHWj86lffVpR449gVNK6pKufldWyde
         /zZ1wt1EfXCQweLoDQbR6si3+LtjlCyzcCDXtX+baYkLI8xNbMTzXsOKCLjo0l+vl1Jv
         PS5xvdfqBHa4ic+NWgghaYWcDsL5CmAQo+d/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lpsKD2VU/Sb1onA3HKT8V7QN+mUTEHzIOmdecHq4LdM=;
        b=XIwEArwYQ361zP1W2J4kbGl8AZO5jzH9x9VwNMibAdLsw2//U/tzuT3aUq9idbsGVx
         1+O41NcVrKO7GaFtm4f8NGyNp308nJkXIgf3FlCq9KPsoSn4h1DGnKc8Ao1xehq+uoRk
         wm1X23kQEiMAMbjDAvDD3qZbTwNvQ10qAADQ8fuBZYAtXoV8dR6MNpvBNf71mEVden5I
         4jDMtaKyhsCUfyEB9sbZPDeiaFfdjzXEgaUfGkjdtyw8H2mPw4/8U84F7LGiHj53rJ5d
         ND7HDK5OZlXVZeI1edVquVPy1AQ8oGm2FLLWLWTyEplU/wXMEAVdrqNyd5V0B+9LR/+O
         REhA==
X-Gm-Message-State: APjAAAVt0nme3P2q87DnIuoaRFrosgF4GDjxKgjjiOA95BN4oVVMBWro
        2oE8qQBfU1rqpEUFv3W/2syx2Q==
X-Google-Smtp-Source: APXvYqywsSTS/MbRgIuHey/C0o16IppJ1/nhNdeMB8Z8+kKXKezuhlGRx/gLrarvk/zWEGSrPKkrgg==
X-Received: by 2002:a63:fd07:: with SMTP id d7mr7301949pgh.199.1554401107319;
        Thu, 04 Apr 2019 11:05:07 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:c5a1:6d6:d92c:c7c1? ([2601:282:800:fd80:c5a1:6d6:d92c:c7c1])
        by smtp.googlemail.com with ESMTPSA id k14sm31362701pfb.125.2019.04.04.11.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 11:05:06 -0700 (PDT)
Subject: Re: [PATCH net] net: vrf: Fix ping failed when vrf mtu is set to 0
To:     David Miller <davem@davemloft.net>, linmiaohe@huawei.com
Cc:     shrijeet@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingfangsen@huawei.com
References: <0da12059-229f-e167-ad41-14b56993a029@huawei.com>
 <20190404.105208.2083294844837792468.davem@davemloft.net>
From:   David Ahern <dsa@cumulusnetworks.com>
Message-ID: <9274e676-1d0d-51f9-6904-d97597c2a235@cumulusnetworks.com>
Date:   Thu, 4 Apr 2019 12:05:05 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190404.105208.2083294844837792468.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 11:52 AM, David Miller wrote:
> From: linmiaohe <linmiaohe@huawei.com>
> Date: Thu, 4 Apr 2019 20:01:13 +0800
> 
>> When the mtu of a vrf device is set to 0, it would cause ping
>> failed.So I think we should limit dev->min_mtu to ETH_MIN_MTU
>> to solve this problem. And if dev->max_mtu still be 0 can be
>> confusing, so I limit dev->max_mtu to ETH_MAX_MTU.
> 
> David A., please review.
> 

The failure is because in_device (and inet6_dev) are destroyed when the
MTU is below min size for IPv4 (and IPv6). The MTU is really irrelevant
for VRF except for odd cases like this. Really changing the MTU should
fail with an error message that MTU can not be changed for these devices.

As for the suggested ETH_MIN_MTU / MAX_MTU it works for IPv4 since
IPV4_MIN_MTU = 68 = ETH_MIN_MTU, but it does not solve the problem for
IPv6 which has a min MTU of IPV6_MIN_MTU = 1280.

Fixes tag should be:
Fixes: ad49bc6361ca2 ("net: vrf: remove MTU limits for vrf device")
