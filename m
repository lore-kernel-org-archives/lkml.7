Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AFCC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC9320820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="WAHSQYe+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfHLKVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:21:44 -0400
Received: from smtp113.ord1c.emailsrvr.com ([108.166.43.113]:39085 "EHLO
        smtp113.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727795AbfHLKVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:21:43 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Aug 2019 06:21:42 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1565604861;
        bh=xOQ2SaWxyHXU419hBRM5D56wTKkjqwAXGPtYpsJA9bI=;
        h=Subject:To:From:Date:From;
        b=WAHSQYe+ucBnJ2Z7rSn//9GhxtOR7ghG3tr4F+/NPFOzz4pPWuRcxn9YSQrlgid44
         nvPQRDO+eeMnwHphb5CZsIWbZDhrCI+KvVzJEeX5H3hXMcmNFPccyCSQkW3ZvaGbc2
         GbJFSVwnD2KB/9my0GxCeLXem8Xkqg7gwy7JGji8=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id D444A402D3;
        Mon, 12 Aug 2019 06:14:20 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.62] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 12 Aug 2019 06:14:21 -0400
Subject: Re: linux-5.3-rc4/drivers/staging/comedi/drivers/dt3000.c:373:
 (error) Signed integer overflow for expression 'divider*base'
To:     David Binderman <dcb314@hotmail.com>,
        "hsweeten@visionengravers.com" <hsweeten@visionengravers.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <DB7PR08MB3801C29431C1A737AE60F0C99CD30@DB7PR08MB3801.eurprd08.prod.outlook.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <482e8016-fc00-025f-fe91-aecf7cbe844b@mev.co.uk>
Date:   Mon, 12 Aug 2019 11:14:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <DB7PR08MB3801C29431C1A737AE60F0C99CD30@DB7PR08MB3801.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2019 08:37, David Binderman wrote:
> Hello there,
> 
> Source code is
> 
>      prescale = 15;
>      base = timer_base * (1 << prescale);
>      divider = 65535;
>      *nanosec = divider * base;
> 
> timer_base seems to be 500 or 100.
> nanosec is a pointer to int, so it can only hold about 2,000,000,000 nanoseconds, or about 2 seconds.

Thanks for the report.

I couldn't reproduce the error with the compiler version I was using, 
but I can see that it is likely to result in an arithmetic overflow.

I think the main problem is that the line (in (dt3k_ns_to_timer()):

       base = timer_base * (1 << prescale);

should be:

       base = timer_base * (prescale + 1);

which matches the earlier instance of this calculation in the same function.

In practice, these lines of code should never be reached due to earlier 
range checks in dt3k_ai_cmdtest().

> Suggest rework code to use longs.

It wouldn't do any harm to change the `int` variables to `unsigned int`.

> 
> Regards
> 
> David Binderman
> 
> 
> time-_Base seems to be 50 or 100.
> 


-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
