Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E183C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08BC20896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553529085;
	bh=h2lbgB6xmFtCpQqsLhpRNTsIO/EMUe89EXhRz+pi9rA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=2LAU/oeLgd/FqVjF1qW52ZL41C6FEXwuWsBnGdcyNjLw5iIvc+tGhhJGzQWvQsxIM
	 LPXab39MaUzsrX8fX9FYOSBaFxt0gRcz+ENine0CsB2jzmpq46b/v5WbkOvvs0Evs9
	 KfJ+dae9toul9buMQw/Nj2rNI4mniiqXQruuFLKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfCYPvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfCYPvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:51:23 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F385120896;
        Mon, 25 Mar 2019 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553529082;
        bh=h2lbgB6xmFtCpQqsLhpRNTsIO/EMUe89EXhRz+pi9rA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1rL7bYKQPCGWvoNzUFbAzLqCvBjMm7RzZjjR+Nxwa4BKHahMoxeeR7MBBnvZywJ3G
         Ltg4fw70pk9ja+FpwR3h8jYIJNNH4nSf6Tm9l4pP3dFTKRrk6YWPlile5EiICQ5Xy8
         nTl6w+Y4nhUvDKhx9c2D3BUrvnjHDjJpXfCYktCI=
Subject: Re: [PATCH] tools: usb: usbip: adding support for older kernel
 versions
To:     Brian Norris <briannorris@chromium.org>
Cc:     David Valleau <valleau@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>
References: <20190306214730.6545-1-valleau@chromium.org>
 <44e151af-b6c4-d0af-3ef1-a5632d079915@kernel.org>
 <CA+ASDXMcnEfZzTjDGsDbZxX2Xknv6dt3H-3kN79WdKFzif2zsA@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <caee30e2-ddc4-0076-907e-558dbcfe7c52@kernel.org>
Date:   Mon, 25 Mar 2019 09:51:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CA+ASDXMcnEfZzTjDGsDbZxX2Xknv6dt3H-3kN79WdKFzif2zsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/19 12:23 PM, Brian Norris wrote:
> On Sat, Mar 16, 2019 at 4:40 PM shuah <shuah@kernel.org> wrote:
>> usbip tool is tied to the kernel version. This is reason why it is
>> co-located with the usbip driver in the kernel sources. This is not
>> a typical tool scenario to be able to use new tool on old kernels.
>>
>> I would like to understand the reasons for wanting to run new tool on
>> old kernels.
> 
> On Chromium OS, we ship more or less the same user space for a variety
> of systems, but not all of those run the same kernel. That's not
> exactly a novel concept -- many good tools are written such that they
> degrade gracefully when running with reduced feature sets (e.g., older
> kernels). While we are working on reducing the divergence and number
> of kernels we ship, it's currently a fact of life that we have to
> support multiple target kernel versions.

Thanks for the context for this change.

> 
> Is there a fundamental problem with VHCI such that it doesn't have a
> stable ABI that tools can be written against?
> 

In general the ABI is stable.

+#define V3_18_STATUS_HEADER "prt sta spd bus dev socket 
local_busid"

What's your 3.18 kernel version? I think you are missing security
fixes that prevent socket address leak in the status file.

+#define V4_4_STATUS_HEADER "prt sta spd dev      sockfd local_busid"
+#define V4_14_STATUS_HEADER "hub port sta spd dev      sockfd local_busid"

The difference here is the high speed support. Let's find a better
way to fix this than hard-coding kernel revisions in the tool.

> If stability is possible but you just don't care, then I guess we can
> fork our own version...
> 
> Or even worse, we could build N copies of usbip for N kernels. But we
> don't do that for any other user space component.
> 

It might be easier to build N versions than maintaining the fork :)

In any case, let's find ways to fix the problem with a constructive
approach.

thanks,
-- Shuah
