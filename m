Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20178C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDD8218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LWbuB4hK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TiwtO0/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfCVG7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:59:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49734 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCVG7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:59:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 718286081E; Fri, 22 Mar 2019 06:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553237954;
        bh=FoBHhrNXYB6j+zeUfiMkH+oYYZXMkOloZkj8DR7f6mY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LWbuB4hKka0KTp5qs8O2Xm3YKqUwKYNnsqCdAC1187dgvdiUOXSUhm3ZEqpJpk5Tn
         VqQguOL42hhJFj3RtHj0OrSwHwKc7+MdyJMxTVpYibwChH5AH655WLw3PcPwgWBY8N
         kfcSsmvU6KXjgtbObcS1qVYo8JaqFPRs5F+EmOh0=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8043960744;
        Fri, 22 Mar 2019 06:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553237953;
        bh=FoBHhrNXYB6j+zeUfiMkH+oYYZXMkOloZkj8DR7f6mY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TiwtO0/GcbzqY0Ir0luBWI0TToIk71qKaRlVgAm/ZUu+lJzkou/KPLWfvjqi7ZgZ2
         tU3rKxXPGa4VgSsm8C5rSLa5v0k+CztNgMihcY01w3oYZz+uHrFW7Xn65dR64Z6ylq
         PIzWYLserpsM6TB8j7l/qg0fSJDk4ECzjnqr1DaY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8043960744
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] ubifs: remove unused function __ubifs_shash_final
To:     Richard Weinberger <richard@nod.at>
Cc:     Yue Haibing <yuehaibing@huawei.com>, dedekind1@gmail.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <20190320140955.11576-1-yuehaibing@huawei.com>
 <2691086.gDEv9kBeKS@blindfold>
 <289f9994-0980-081e-f913-5729b16d16f4@codeaurora.org>
 <24657306.kQxLvZqZK3@blindfold>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <9c91e8fd-ba11-1cbd-c8d6-87b86f74d8b3@codeaurora.org>
Date:   Fri, 22 Mar 2019 12:29:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <24657306.kQxLvZqZK3@blindfold>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/21/2019 1:39 PM, Richard Weinberger wrote:
> Am Donnerstag, 21. März 2019, 08:54:55 CET schrieb Mukesh Ojha:
>>>> Acked-by: Mukesh Ojha <mojha@codeaurora.org>
>>> I guess you mean Reviewed-by?
>> As i am unsure about future scope of this func. i.e why Acked.
> Acked-by is usually something I expect from the code author
> or the person that owns the code.

Take it as Reviewed-by then.

Thanks.
Mukesh

>
> Thanks,
> //richard
>
>
