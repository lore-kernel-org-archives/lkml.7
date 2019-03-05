Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69823C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446BF20684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfCEDda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:33:30 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49050 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726522AbfCEDd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:33:29 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D7ACF861BD7F7355B318;
        Tue,  5 Mar 2019 11:33:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Tue, 5 Mar 2019
 11:33:22 +0800
Subject: Re: question about memory leak in ip_mc_del1_src
To:     David Miller <davem@davemloft.net>
References: <91def48c-15be-2bac-7c9b-2cead21b6fa9@huawei.com>
 <20190304.101633.1998818339852915958.davem@davemloft.net>
CC:     <edumazet@google.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kuznet@ms2.inr.ac.ru>
From:   maowenan <maowenan@huawei.com>
Message-ID: <3f48c0a1-f523-ac55-451a-2460050b0ee3@huawei.com>
Date:   Tue, 5 Mar 2019 11:33:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190304.101633.1998818339852915958.davem@davemloft.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/5 2:16, David Miller wrote:
> From: maowenan <maowenan@huawei.com>
> Date: Mon, 4 Mar 2019 20:47:42 +0800
> 
>> 			pmc->tomb = psf;
>> 			rv = 1;         //if it does not kfree(psf), will it lead to memory leak after this line?
> 
> pmc->tomb points to psf, why should we free it?

Thank you David.
Yes, pmc->tomb points to psf, but this is a delete path
for ip_mc_add1_src, if we don't free psf, where it can be done?
I'm not clear here.

> 
> .
> 

