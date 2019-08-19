Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DEBC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800DB2082A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566226225;
	bh=ymw3Kw+8cxX+oQfkPPvxyyrMYifjiGJnCyi5QOBej5E=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=zlWlWjdFFi2mh6KQ1qgn1YcsYBhKBIYinIwqZzhsdrd4qbZQSgsaP9kNTrsscJAYJ
	 tTJQ5HqnHthFxbdFhj55VdsFFoOViKmn2ibfflmyJwCizi9oAUy/nHktB4Ojzt15bS
	 iVhtWQ0si3S8b/H9U4cSLDIJbliCg3Id2qTo7/MA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfHSOuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfHSOuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:50:24 -0400
Received: from [192.168.0.101] (unknown [180.111.132.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B2752070D;
        Mon, 19 Aug 2019 14:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566226223;
        bh=ymw3Kw+8cxX+oQfkPPvxyyrMYifjiGJnCyi5QOBej5E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=szZD7vvv8SeH6gvjnceD6e8J8UL1NpP2W6v04Sz7qhA37WjawDfGvmZY+gMo01R9+
         oPhpZN26USZIyWiUJN3WrHsFdMnUzGizZoZpc83Am1NlAd3drloEUoTMtxB1p+XFIO
         sA1sHKdk2WgxYnNbt1nmv69DiBDqTta99OlZE1GE=
Subject: Re: [PATCH 4/6] staging: erofs: avoid loop in submit chains
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Miao Xie <miaoxie@huawei.com>, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>
References: <20190819080218.GA42231@138>
 <20190819103426.87579-1-gaoxiang25@huawei.com>
 <20190819103426.87579-5-gaoxiang25@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <24eacd62-3da1-e6cf-8166-43049dbedcf2@kernel.org>
Date:   Mon, 19 Aug 2019 22:50:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190819103426.87579-5-gaoxiang25@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-8-19 18:34, Gao Xiang wrote:
> As reported by erofs-utils fuzzer, 2 conditions
> can happen in corrupted images, which can cause
> unexpected behaviors.
>  - access the same pcluster one more time;
>  - access the tail end pcluster again, e.g.
>             _ access again (will trigger tail merging)
>            |
>      1 2 3 1 2             ->   1 2 3 1
>      |_ tail end of the chain    \___/ (unexpected behavior)
> Let's detect and avoid them now.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
