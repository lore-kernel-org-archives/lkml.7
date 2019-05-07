Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B037C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE09121019
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIhb5IDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfEGWR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 18:17:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43542 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGWR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 18:17:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id t22so8985383pgi.10;
        Tue, 07 May 2019 15:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gZFWt3ZjdE2K8WseWLL9Mg/hno4mNEC9/tCwkX2YV1o=;
        b=SIhb5IDuHKGjmob+l0eNNMfXWQJM2boLCLgYrA101K/wscHUY8s8cOlNwvN6YOvL8J
         ZeCIohPChHHWaXDN5IffRNICcXJCITEPZ6Ci1W68/KOr1b3Elp6BbIrwLmVZQHf+Xenj
         Kno3EX6b8GmQdCdE4stqKXdoAKOT5RJ1i6KTkJC18/gzixCCP9MGAG5u13WYeEgtrNAK
         Qr3FjqaFQTSiWf6SwVSamGdQVQonMaHoy9uy9qDUQtrX12kOcHsCuSH2mudFOwnnAFoc
         PkTrf0ue4VbJBFtVVctWPjcWqWoFcBVZguTk2z/vm59oapnfw8Zy/m3Atgtgb1TwScl4
         bq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gZFWt3ZjdE2K8WseWLL9Mg/hno4mNEC9/tCwkX2YV1o=;
        b=KARzpFJxqkoYmJ7oEtxwWofgl9wGgwC0z6t/lLjKIN1WJi4niO+8YkqNuP3ste/LVV
         Y4ul4F1cU4p6P7ZAx+h/1imbEgXoy2mA2pcMU71+S2JVb9wZ7frxIF1aNgnf4HZs4dqs
         gSkzv0rmhtrALsAFJGkbZnioVB16D1xPXGfy5gI1NMUItCxkiI+TwFqs1mqZY6Q0eeEj
         /wYgAGYiP3lZqWhAkCTi7BrtpSwJo1L4FXGhCEACRmk27Oiao08nvTGdv4tC2JBMw2uT
         ssk9w86AoUc83TjzVPgHLZk2yU52iKw8FyCsB+de9UfJelhS+meMYl65dV7nv6fiYuzS
         jDCQ==
X-Gm-Message-State: APjAAAUFX56cESJMW8Z/DP1oFTChC6bZ1++x7tzhMdFYvzKIkMP93g1S
        7fduMC3xHwb0Z3PfFTvX92EYSB8z
X-Google-Smtp-Source: APXvYqxb5Mqj5qIHlP1Tr2YJnw/RPfX7kUj/WTB6Nc6oUwqC7G/DiG/3+UOOF19ZQ0isMxEr4RO/zg==
X-Received: by 2002:a62:2506:: with SMTP id l6mr27682044pfl.250.1557267475792;
        Tue, 07 May 2019 15:17:55 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id i1sm693977pgj.70.2019.05.07.15.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 15:17:55 -0700 (PDT)
Subject: Re: [PATCH] of: Add dummy for of_node_is_root if not CONFIG_OF
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20190507044801.250396-1-dianders@chromium.org>
 <a3573253-e3de-0a82-8af3-6bacea20bd97@gmail.com>
 <CAD=FV=UAFUH12DbA++HML75E55BCttpNBxe9t-VEQvGjGx0=Wg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <18324244-cca8-a836-5c2e-c626ca8771aa@gmail.com>
Date:   Tue, 7 May 2019 15:17:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UAFUH12DbA++HML75E55BCttpNBxe9t-VEQvGjGx0=Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/19 10:59 AM, Doug Anderson wrote:
> Hi,
> 
> 
> On Tue, May 7, 2019 at 10:52 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 5/6/19 9:48 PM, Douglas Anderson wrote:
>>> We'll add a dummy to just return false.
>>
>> A more complete explanation of why this is needed please.
>>
>> My one guess would be compile testing of arch/sparc/kernel/prom_64.c
>> fails???
> 
> Ah, sorry.  Needed for:
> 
> https://lkml.kernel.org/r/CAD=FV=Vxp-U7mZUNmAAOja5pt-8rZqPryEvwTg_Dv3ChuH_TrA@mail.gmail.com

Got it.  I went and looked at that.  I think a better approach would be to
check parent node not "/reserved-memory".  I am making this suggestion in
that email thread.

-Frank

> 
> 
> 
> -Doug
> .
> 

