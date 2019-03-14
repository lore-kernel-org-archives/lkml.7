Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC834C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB81204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="OencM2l/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfCNNTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:19:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34526 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfCNNTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:19:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id l5so4800824lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uz4vEUEAV0jZ+8zFpeiwVqh90llxQAgozGOjulREeb8=;
        b=OencM2l/hlpEDiBq1rouEa3lPWX6Po51sf36mlV6TAJ7bg1mwdyzOaE/FmI6JI8SXO
         10fFn0iBesTVTVXa/rFYKJjb69QW3aCTPKSoY5Nml0qLBkqpEAKE6XaTIPaYWMy3HfgQ
         STdLF65vKryn6QKFj9rZMoTqTpICuxA26kWxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uz4vEUEAV0jZ+8zFpeiwVqh90llxQAgozGOjulREeb8=;
        b=hZIVrwRx0Oft73Tx29lr/HSQwmyITa2fASk8um2Zx81B8gxhZu96iM4Ryub2tHGrsb
         CUVRVUPs2oNrBHLVuH6dYrOMKn4/Xvl+vQ0viR2P9dKoNFfmD4afuXtUKqPeKBdt8ZvX
         cqnaZipuxOtabd+d6FFJlXJo/Hba05/zZU/olBN81R6tPSoHy5jpJxU/HzwPxDqw4car
         NnqxF22av3NhuyF+q4DEkuwKILgOkFREDdgKtzBYL4Z9xDhlZgUsbrExNNnzm3cHeRQT
         V4U77kPodvjk7cZG4iDoDcKzz39SWdnFqGTf84Z3Fa/hchgp43Geu99BIQYX/LJu0G3F
         MmGQ==
X-Gm-Message-State: APjAAAUSlSP4xoxMpGZKHKZQEQJRBn3XkCeRhwq4MgMkJtPp77igmb/S
        IbEeyhK65XgMi+yXjHUQfgXlbw==
X-Google-Smtp-Source: APXvYqwHptS9y4lw+u/IzNQkpC8f4pljE3QRqmXfV7h3Vl7bxpscz8NLWSSjFHXQTt4XFFjPRW+UUw==
X-Received: by 2002:a2e:408:: with SMTP id 8mr26525877lje.15.1552569586572;
        Thu, 14 Mar 2019 06:19:46 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id v12sm2730333lfd.20.2019.03.14.06.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 06:19:44 -0700 (PDT)
Subject: Re: [PATCH 4/4] leds: netdev trigger: allow setting initial values in
 device tree
To:     Pavel Machek <pavel@ucw.cz>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-5-linux@rasmusvillemoes.dk>
 <20190314102911.GA15173@amd>
 <6fb71b90-1ae3-9d93-6e0c-c95e441ced7a@rasmusvillemoes.dk>
 <20190314120047.GA19072@amd>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <2cd9c42c-1056-979f-568e-c7e387bf90c6@rasmusvillemoes.dk>
Date:   Thu, 14 Mar 2019 14:19:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190314120047.GA19072@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2019 13.00, Pavel Machek wrote:
linux,default-trigger from
> 
> Yeah and now insert the modules for the can devices in different
> order... May not happen in your case but will be fairly common for
> ethernets.

Unpredictable device names is not a problem I'm trying to solve, nor one
that actually occurs on embedded systems. And even if one has such a
system, one is likely running udev or similar to rename devices to
something sane and predictable, in which case a fixed string _still_
works fine. Or one uses udev rules to munge the netdev trigger sysfs
files, and has applications dealing with devices appearing as banana457.

OK, so there's of_find_net_device_by_node, so a phandle solution might
also be possible, and might work just as well for my case. But I still
think initializing with a fixed string is the simplest and sanest thing
to do.

Rasmus


