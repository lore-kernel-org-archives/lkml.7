Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDBEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204ED2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BX3IR55p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfKLIRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:17:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34468 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfKLIRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:17:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id 139so16742084ljf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 00:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1UOrfE7eL3IqcRqo+GTUG4MyEyzZRkxeXy7A5k+rq7w=;
        b=BX3IR55pLCl6cXu5ECToHFRRet9jbkK5ccrkybPqkm9HryzEg+Vk1y587h9AeXIVNl
         hfxfeum8529o7h1XtQJZ0VtiGv4f4AjFzSyvTRbO8RczB2sYykTB2nw3/elVxka7pA/v
         BghNo/TL0TazYty8NYdFLKhrCgy/i7EqozlAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1UOrfE7eL3IqcRqo+GTUG4MyEyzZRkxeXy7A5k+rq7w=;
        b=i3PKkZD/39e8EumC7X7AtAlZwfzqNjINkwEzKcVxPhj4+hRWWgchpDuM85NSmPAQgA
         dGHnWR+y0Lujtmf93rrzc4Xxymc455fFcruPZcehF//y0594NCHDPPe562p/Nd5Gismh
         CLsW/AX/O7KMJPEDqwvkANBTeSWzML8o8z53cecqpvPQtq/bk9ndSkBAoU0amrW5hDeE
         UoGKF5B/2tRxoSpnhjq5QKaook9PBd4h6FVLpRe9WLNgqRn9Q8Neld1fmOjmeYIRMTdQ
         cXJowVZfXE2Ag0cOFcXWybAB6nhl8Y+xTmFFi+yPBwE3ugFS2/xe0tvpNRhd866Y4NNO
         djNg==
X-Gm-Message-State: APjAAAXDu3FtC//zTO8dqc3ymKhzpX7Kg2IuqAwSTU/kBmFSsj7b20uF
        L9y4toqaIsuq5FQT/efpYBJMZA==
X-Google-Smtp-Source: APXvYqwnzpW96b39jBou0jnSlL/HS7I564u3+KsUO4+qOnY1pdOoDbEAhAuUMgbbOG4MEk38oTo25g==
X-Received: by 2002:a2e:8518:: with SMTP id j24mr8331198lji.13.1573546643476;
        Tue, 12 Nov 2019 00:17:23 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a22sm7966566ljn.58.2019.11.12.00.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 00:17:22 -0800 (PST)
Subject: Re: [PATCH v4 34/47] soc: fsl: qe: change return type of
 cpm_muram_alloc() to s32
To:     Qiang Zhao <qiang.zhao@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-35-linux@rasmusvillemoes.dk>
 <VE1PR04MB6768D483426A2B6CC04E069D91770@VE1PR04MB6768.eurprd04.prod.outlook.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <75efc4ce-c6da-92c4-e3a5-5e37311b0f33@rasmusvillemoes.dk>
Date:   Tue, 12 Nov 2019 09:17:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VE1PR04MB6768D483426A2B6CC04E069D91770@VE1PR04MB6768.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2019 09.01, Qiang Zhao wrote:
> On Fri, Nov 8, 2019 at 21:01 Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
>> -unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long
>> size)
>> +s32 cpm_muram_alloc_fixed(unsigned long offset, unsigned long size)
>>  {
>> -	unsigned long start;
>> +	long start;
>>  	unsigned long flags;
>>  	struct genpool_data_fixed muram_pool_data_fixed;
>  
> "start" should be s32 here too?

Yes, of course. Good catch.

Rasmus
