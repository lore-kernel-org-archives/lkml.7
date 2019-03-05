Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53013C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5AD20652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfCERAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:00:24 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:50906 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCERAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:00:24 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 48781105D26CC;
        Tue,  5 Mar 2019 09:00:23 -0800 (PST)
Date:   Tue, 05 Mar 2019 09:00:20 -0800 (PST)
Message-Id: <20190305.090020.1424252324111549025.davem@davemloft.net>
To:     maowenan@huawei.com
Cc:     edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: question about memory leak in ip_mc_del1_src
From:   David Miller <davem@davemloft.net>
In-Reply-To: <3f48c0a1-f523-ac55-451a-2460050b0ee3@huawei.com>
References: <91def48c-15be-2bac-7c9b-2cead21b6fa9@huawei.com>
        <20190304.101633.1998818339852915958.davem@davemloft.net>
        <3f48c0a1-f523-ac55-451a-2460050b0ee3@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 05 Mar 2019 09:00:23 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: maowenan <maowenan@huawei.com>
Date: Tue, 5 Mar 2019 11:33:03 +0800

> 
> 
> On 2019/3/5 2:16, David Miller wrote:
>> From: maowenan <maowenan@huawei.com>
>> Date: Mon, 4 Mar 2019 20:47:42 +0800
>> 
>>> 			pmc->tomb = psf;
>>> 			rv = 1;         //if it does not kfree(psf), will it lead to memory leak after this line?
>> 
>> pmc->tomb points to psf, why should we free it?
> 
> Thank you David.
> Yes, pmc->tomb points to psf, but this is a delete path
> for ip_mc_add1_src, if we don't free psf, where it can be done?

When the 'pmc' object is destroyed.
