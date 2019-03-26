Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DE4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F59820863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/d6Um+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbfCZPjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:39:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34764 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZPjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:39:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id b3so6875055pfd.1;
        Tue, 26 Mar 2019 08:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K+UiSvBdlyg+pVKtZtRxa+/63GcEqfCdpK/DlPdzUPY=;
        b=h/d6Um+OtH/8H44MsioiGjdtdiZGJyjoile/+zABEJ/sGeahx/D+XXw4oza+tw4ruq
         2Wqmj/HkTk9d0OHgz4rfyWKcwfsIQKwWs4IAamYHrwtIpF+G2cJnJgqcL9o/6PzLeJhv
         XazPVlJLdj7Zbbqbb5QfTlgJkHMxqlQ2Bqm5gvhebRyhvYe0oFuQ7mtjSY/5lfyECELP
         VvEHvO4oJK7c9RV3XUd3Qjp/a4qHHZGqjiLUdOuffm+R1WHvOmQmaO7lnIoADeqSImlX
         cCJMrFMphuJBnq+LajwjfUuALlow9KW7OSzSyRDOiwFjcMRexHEs1IJ/tw1YLPP2fpUq
         R7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K+UiSvBdlyg+pVKtZtRxa+/63GcEqfCdpK/DlPdzUPY=;
        b=MQhDNxcUioeh2vzVKlys/PpltP5Q6F67V/mQc07e7zHC5cXLpF8fzT5XyHKzt19CZm
         EGyTyLKEcq2hOvKaAqhC9dqcJ9f9hXMlO45B/5humpmt6RUPsOuft10vNtSKR2aMma1E
         qQoURMO0PXIuZqG7rQIQhAe4to68ZXqYA5vsEfPdddbRGCZiXCzBwckZCqs8Z2OSOf11
         qqId8j6ursGTtIIvEXNL5hwEUY/iT5IZEhBS9vEZcP19jzC2nytbDTrmSWPdXwUdoL5m
         3pqXTlxRisIPTinXmOnITC5sy+9jnN6bYUjogHZjEjesRq/wcuvgOvKLaSoNJ0og+vSE
         s1fA==
X-Gm-Message-State: APjAAAVnPoufQC4x0Oo7ln6YGoKHt2x21SOM9fDbYVilycZG4aDVVJQG
        0aHJVgkmXSVwsmObIaVS0FvLRz0C
X-Google-Smtp-Source: APXvYqzMxh9gHcXhffehKhSLDr9hPbJ5cAefL5bLSmqzssU164Ixq8lpc/32pojs6vZ/TNP3FE5TSw==
X-Received: by 2002:a63:4343:: with SMTP id q64mr139022pga.105.1553614774395;
        Tue, 26 Mar 2019 08:39:34 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:68e1:6a44:f6ee:46a4? ([2601:282:800:fd80:68e1:6a44:f6ee:46a4])
        by smtp.googlemail.com with ESMTPSA id c2sm35358767pfm.187.2019.03.26.08.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 08:39:33 -0700 (PDT)
Subject: Re: [RFC 4/4] net/ipv4/fib: Don't synchronise_rcu() every 512Kb
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org
References: <20190326153026.24493-1-dima@arista.com>
 <20190326153026.24493-5-dima@arista.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <2f911647-f35f-13c2-8177-2fb93147b0fa@gmail.com>
Date:   Tue, 26 Mar 2019 09:39:31 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190326153026.24493-5-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/19 9:30 AM, Dmitry Safonov wrote:
> Fib trie has a hard-coded sync_pages limit to call synchronise_rcu().
> The limit is 128 pages or 512Kb (considering common case with 4Kb
> pages).
> 
> Unfortunately, at Arista we have use-scenarios with full view software
> forwarding. At the scale of 100K and more routes even on 2 core boxes
> the hard-coded limit starts actively shooting in the leg: lockup
> detector notices that rtnl_lock is held for seconds.
> First reason is previously broken MAX_WORK, that didn't limit pending
> balancing work. While fixing it, I've noticed that the bottle-neck is
> actually in the number of synchronise_rcu() calls.
> 
> I've tried to fix it with a patch to decrement number of tnodes in rcu
> callback, but it hasn't much affected performance.
> 
> One possible way to "fix" it - provide another sysctl to control
> sync_pages, but in my POV it's nasty - exposing another realisation
> detail into user-space.

well, that was accepted last week. ;-)

commit 9ab948a91b2c2abc8e82845c0e61f4b1683e3a4f
Author: David Ahern <dsahern@gmail.com>
Date:   Wed Mar 20 09:18:59 2019 -0700

    ipv4: Allow amount of dirty memory from fib resizing to be controllable


Can you see how that change (should backport easily) affects your test
case? From my perspective 16MB was the sweet spot.
