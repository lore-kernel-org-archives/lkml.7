Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B097C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51E621655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0lQ3L5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfLLLRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:17:33 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40288 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbfLLLRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:17:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id k25so985384pgt.7;
        Thu, 12 Dec 2019 03:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GwuLqIZzMSkOgjShx1lhBWPcILFbSLlfNnhrbVgefE8=;
        b=T0lQ3L5iAI1ysbK3n+jcnIhZs625Cviqe02IiaQKf5uDK2UOmBrtepr051nyFSZMce
         KLMa23/5U6kq5UB89aVOZeHr3DPcVsW3CvHjRCRbl9uSKUmLLzsej6873kdDe0fHWO9/
         lKhY1TL8AQgHCw9Mut/ySlPxG0L8L6LY2Z2ulDixwq8BCngQe5kCdd7ywZjJCD4xMn+E
         G8nWmuzPd50TgpjabmwZIJynLdiW+pdb0p9PXdqeFGbXaLlj0dDK39HATzi7/SniuPQU
         S6UIOKSFiPLcD9zULwzy1B44JH35PQjyaJvLQvLdcdQ7bXVzu1+rXHzrmXtHW1fJOEsB
         5vXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GwuLqIZzMSkOgjShx1lhBWPcILFbSLlfNnhrbVgefE8=;
        b=AxcipjPoZnucCCUyTjIMyOnYnreYxC5vtVyuL//GyNMRz4c15ziS7RvnkQE/o2VXKH
         JSdNGrcQTZG30HxtUucqWl9khZHbKHrGceMiPgtrydSrLN1a1ugZ0t3QrS5HuGBwDsox
         37o1Qs1wAH1f1DrmVU/cE0r3H0PrxSiAblzWO0ZH76aHAQOnjta/SncQnFEizx3ET9X/
         12/e1IDMZ3JMr2gBrOMn7UYnc2tVuG29a7zsC4evT9G+NKeCKofMSAwEniiTh6sgnh0J
         r1sBW9EYdqgf6EiSQAnAXnh7fzVDqtry7KVAY1JGqRrEMMGuJoBngV/MaSajwnFV0PF3
         1JHg==
X-Gm-Message-State: APjAAAVwlRxNkirpvOs5SgeRdeVu4CGiCFrSH0EXNQzFGbIYfeKhM3Dt
        d7XHsJ89rJgrgFyV3KaXqp7qQV2/mu0=
X-Google-Smtp-Source: APXvYqySpp0KjfkLQ1L1Nlzel5FRtxQVjK6BM+YDEy/cozoJZkSWBwdQwFSnHk63JVYsxyH5gaN6fg==
X-Received: by 2002:aa7:9aa5:: with SMTP id x5mr9255362pfi.131.1576149452097;
        Thu, 12 Dec 2019 03:17:32 -0800 (PST)
Received: from [10.231.110.95] ([125.29.25.186])
        by smtp.gmail.com with ESMTPSA id y38sm6535280pgk.33.2019.12.12.03.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:17:31 -0800 (PST)
Subject: Re: [PATCH] of: refcount leak when phandle_cache entry replaced
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1575965693-30395-1-git-send-email-frowand.list@gmail.com>
 <20191211201856.GA21857@bogus>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <486ce60c-8a74-7baf-1054-c81c83e79e56@gmail.com>
Date:   Thu, 12 Dec 2019 05:17:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191211201856.GA21857@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 2:18 PM, Rob Herring wrote:
> On Tue, 10 Dec 2019 02:14:53 -0600, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> of_find_node_by_phandle() does not do an of_node_put() of the existing
>> node in a phandle cache entry when that node is replaced by a new node.
>>
>> Reported-by: Rob Herring <robh+dt@kernel.org>
>> Fixes: b8a9ac1a5b99 ("of: of_node_get()/of_node_put() nodes held in phandle cache")
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> Checkpatch will warn about a line over 80 characters.  Let me know
>> if that bothers you.
>>
>>  drivers/of/base.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
> 
> Applied, thanks.
> 
> Rob
> 

If the rework patch of the cache that you posted shortly after accepting
my patch, then my patch becomes not needed and is just extra noise in the
history.  Once your patch finishes review (I am assuming it probably
will), then my patch should be reverted.

-Frank
