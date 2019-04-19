Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A46C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4C520693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZW2Pzxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfDSTUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:20:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43331 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfDSTUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:20:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so2926389pfd.10;
        Fri, 19 Apr 2019 12:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0+GTSRc5QS5xYz3P51GSNvPGbm50JnV2PO3FdjsNEL4=;
        b=UZW2PzxblIu4P8D6YlvzK3HdkJ9HTDeuqIIyrHT/hZC3f70ZyLjgytq+duFwYeEvyP
         NSUfOmt8VxpzfNlIrQawMpjxiYxLUua07e2lPkNOneEg6E5oMLuN2rsy8WJStm69OhxZ
         4ioNcsvroaPLA1tIarQeVpteYxadsyNDcN15lofVPn8hOH46LWefrxjLxT+gRh6UMcZP
         OGoHVSyady3JOjVYc9eGZ8sWWbw1ivilQBSqybUT5UEZiCYYBOINNsbtdaqG38uoThEd
         fisL5E31fnDPaWiERztpAUxyHUNTzbK0hxTrcP0H77NkghQpPkhF5Z4gGtF6f7+2YooH
         h2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0+GTSRc5QS5xYz3P51GSNvPGbm50JnV2PO3FdjsNEL4=;
        b=i3WF3BON+8BQG4QXmKD/MfcR/iW02cCEy8yQmpyJjavw7MJe5b0nxAPIanffOonf8o
         mECpGzgBk1HHg2gg5QuYmw45ZTxILEOG1VeJO8XWvpQJ3H+p8vMDoFUA9Atv+8+WJU87
         Gv8l/g9IDOyqTRgIVAmr0iU83XXX7v1OId2Qzch1/LxLKo4w8Weoq+N0NPw8pbNnsVII
         DEkpE9nmRoMSI91Atl7OWUGPod/dlVjqlRwEDU8khdPp1QO7DwlEgm8ok+0k1zs49+j/
         vYYr9O6UFLzOgb5yghrypJk1iS9fSdNuGjSfWUjpTzfXR0vnwwPbhOkNsax3k+ag947a
         xrJg==
X-Gm-Message-State: APjAAAX2Jwz32E4DBWZb5zMmb5KSHqBwNxNKWBduMmEK+Ay6V9hDUNlw
        fS+H7fRID0RuXkX5SuLseqdAk9DV
X-Google-Smtp-Source: APXvYqwsh5clo7jqNQ7FOpOj21GFYprTCoLjOoj7tRMGybiF2nWXNJNNXz1u9T3xry2i5TPZzcSOCA==
X-Received: by 2002:aa7:9294:: with SMTP id j20mr3290825pfa.64.1555670558406;
        Fri, 19 Apr 2019 03:42:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y23sm5934688pfn.25.2019.04.19.03.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 03:42:37 -0700 (PDT)
Subject: Re: [PATCH 4.19 000/110] 4.19.36-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190418160437.484158340@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <548a30e9-742c-fdac-95da-5589b4fecb00@roeck-us.net>
Date:   Fri, 19 Apr 2019 03:42:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 10:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.36 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Apr 20 16:03:29 UTC 2019.
> Anything received after that time might be too late.
> 

Affects perf builds in v4.19.y, v5.0.y:

builtin-record.c: In function ‘record__process_auxtrace’:
builtin-record.c:181:36: error: implicit declaration of function ‘perf_data__is_dir’; did you mean ‘perf_data__is_pipe’?

Guenter
