Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD0AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6862E21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7SHWAiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfDEJXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:23:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36508 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbfDEJXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:23:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so6387508wml.1;
        Fri, 05 Apr 2019 02:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N74Gigeamf6uW7mNOcPxG0cICPEw7tgItm/aODraEZ0=;
        b=Y7SHWAiNIsOj5UiBdsBF+XsixG/mkJwc4EwBvfuVtYNHYLm4c4m863UByTK0ik8zVs
         55Y5ewEhVmBlQxCmsbVhNDYygrBarScicFhVaoJ4tGeuSbIj0EbBZ0SAOZvVhbiMwlly
         7D0NXLgPrcMP19oKUf1pRSQd9cet0lDjCMGsyLd/1wHwAbfR3+wG8E0hnp6BxnH/1XOV
         DqVEFhBNQRbOSwugKKpOKONxTTNAXAuU4FSg1C14050qa6sxYC58ak0nIxHfIgihb31f
         qGdy5MgjJ1JGr0W9Pc/sh9KOhqtpA5I4gl/9e5FY/haKfr9gheeT7o+sBxan6/TUKuzH
         3heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N74Gigeamf6uW7mNOcPxG0cICPEw7tgItm/aODraEZ0=;
        b=WxijQ0xiPvtSbRkJWNT3MA+NXLDQ7/JjY+bNVYs4yeKd/P9IUSID6uDtvAn+LxJrc6
         TeieoBxou1H1GqNw8f4BP99rMDdJmYfbdzwXoODygQ/rHX+OYI5lLfEe94cODPLxDb77
         0T0TgFtRzj5OZY/gD651pB3cNKXTHIT30cpc3drtwmrkR7x8dHjLRTsz9heB5bM3GeFH
         Blb1h+gBwqJjvGrpuyOoYR3gJ3JP/gRj2RMt70AXLFb1EYbhbY1qrLQjlHC+ZyWle5p2
         i3snU+v1sNkKI4aOfP84AsFuNuBh7JcCdW/cAxC4ETjgpJQX4008V3rEJHOr6G0EBGXt
         JS5g==
X-Gm-Message-State: APjAAAWMiUF1eYTT3buq7JfePB2/7dyEukJIT1jy/4aHXPJUenfOFQuj
        qfoZZLeaqKlnF/nshqo9ZVsNRCJS
X-Google-Smtp-Source: APXvYqwxNixqbqPw9LU7ERDgrHwT2TcbHGXCp2DDun/APiJ91+X5DssdQVVHx+xJwmvNlUjCAgl7rQ==
X-Received: by 2002:a1c:9609:: with SMTP id y9mr7435012wmd.27.1554456225949;
        Fri, 05 Apr 2019 02:23:45 -0700 (PDT)
Received: from [192.168.8.147] (69.248.23.93.rev.sfr.net. [93.23.248.69])
        by smtp.gmail.com with ESMTPSA id n13sm24747978wrw.67.2019.04.05.02.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 02:23:44 -0700 (PDT)
Subject: Re: [PATCH net-next v2] tcp: Ensure DCTCP reacts to losses
To:     Lawrence Brakmo <brakmo@fb.com>,
        "Tilmans, Olivier (Nokia - BE/Antwerp)" 
        <olivier.tilmans@nokia-bell-labs.com>,
        David Miller <davem@davemloft.net>
Cc:     "De Schepper, Koen (Nokia - BE/Antwerp)" 
        <koen.de_schepper@nokia-bell-labs.com>,
        "research@bobbriscoe.net" <research@bobbriscoe.net>,
        "fw@strlen.de" <fw@strlen.de>,
        "borkmann@iogearbox.net" <borkmann@iogearbox.net>,
        "ycheng@google.com" <ycheng@google.com>,
        "ncardwell@google.com" <ncardwell@google.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "agshew@gmail.com" <agshew@gmail.com>,
        "glenn.judd@morganstanley.com" <glenn.judd@morganstanley.com>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190404121731.13917-1-olivier.tilmans@nokia-bell-labs.com>
 <20190404.105243.1039649838417325989.davem@davemloft.net>
 <532BB0D8-95C8-4A4D-A73D-3B563909780F@fb.com>
 <AM6PR07MB4821BB64AF86A1A650C95000E0500@AM6PR07MB4821.eurprd07.prod.outlook.com>
 <75CDFF88-5632-4A44-A2BF-5725CDDE7DCA@fb.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <0e5b047e-8ee1-ee53-cd46-3be70f0d618f@gmail.com>
Date:   Fri, 5 Apr 2019 02:23:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <75CDFF88-5632-4A44-A2BF-5725CDDE7DCA@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/2019 11:55 AM, Lawrence Brakmo wrote:
> 
> The module parameter, even if enabled by default, would have been
> preferable since it would support environments where this feature
> turned out to be sub-optimal.

Module parameters are awful, just add a sysctl if you need.

Bonus : per netns thing, meaning writing tests (say with packetdrill) is easier,
since you can launch dozens of them in parallel, each one in a different netns.
