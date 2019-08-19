Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F092DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B921720843
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566225592;
	bh=7GHG3qP/65u7/idHzQXFAmmZuMo/SIqETzSvYcl8JG8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=HjEBvzeQJmQyBE4MSTqZ4HbgnscPPlYIwFGMTlUWxGmoVqbUXnhSn3S+wSRfavLgZ
	 nWb1aB0X0iZBthaBSVEQuD0wWJz3Q6hiCkqHRR/foxXeEAYppp2um30xLP3DT/8FOM
	 EPCvlpHKhi+xEnQX2P2JbfIoU66eliE9bOUTUGzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfHSOjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfHSOjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:39:51 -0400
Received: from [192.168.0.101] (unknown [180.111.132.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C58362070D;
        Mon, 19 Aug 2019 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566225590;
        bh=7GHG3qP/65u7/idHzQXFAmmZuMo/SIqETzSvYcl8JG8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EPw1vP9b/oF25i8O77todLQykzr4gtHG+YJdeswIUeeShA2PEZ4Li6yoxNKteNstX
         kNp8Lt082oeAOAokMFg9NFcJ8Lo2HnjEWwP3PlVB9URrZriPIfeUV7d8O4w+uGE3jo
         YMkfYBBohMvGWlaviK6Cn/EmMQXdC/iP8weA0HRk=
Subject: Re: [PATCH 1/6] staging: erofs: some compressed cluster should be
 submitted for corrupted images
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Miao Xie <miaoxie@huawei.com>, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>, stable@vger.kernel.org
References: <20190819080218.GA42231@138>
 <20190819103426.87579-1-gaoxiang25@huawei.com>
 <20190819103426.87579-2-gaoxiang25@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <00a03591-c2c7-f7e7-509f-29d436a9252e@kernel.org>
Date:   Mon, 19 Aug 2019 22:39:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190819103426.87579-2-gaoxiang25@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-8-19 18:34, Gao Xiang wrote:
> As reported by erofs_utils fuzzer, a logical page can belong
> to at most 2 compressed clusters, if one compressed cluster
> is corrupted, but the other has been ready in submitting chain.
> 
> The chain needs to submit anyway in order to keep the page
> working properly (page unlocked with PG_error set, PG_uptodate
> not set).
> 
> Let's fix it now.
> 
> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> Cc: <stable@vger.kernel.org> # 4.19+
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
