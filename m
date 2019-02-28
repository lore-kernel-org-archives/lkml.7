Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CB9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E26218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEaIHPAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732858AbfB1Xbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:31:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44419 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732367AbfB1Xbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:31:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id a3so10452308pff.11;
        Thu, 28 Feb 2019 15:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ntjfVa+jngHFHVKJwKRWVLjgGzUEmZ1zbsiDrkIYxIo=;
        b=nEaIHPAiZtM905nJguLEKVXr7X5kW/qtIUC85tbg8CikmJxHmMelCHiR7nh6x0nwJO
         X9sYO8xgJ0qu5sP/c62jYFtdPyaxbc1j+WrZqZpK4W0gbe9TkQLDW9B79pMEmjOt9Ub6
         51pmu5PBL+b4Re2l7EhfIrKq2yq3Hhn53GjizKeME/JSdXIPZLtB3uFi0ymJM15+K1h/
         SF/FIzKQ3mV+lvDYU/LRdESUIwiXqQTHMfE/5x//kYZZw1O1ve9+tBieXRfyBi01eVlH
         /JDLDWPYeZWxQZJ4m13SMqcVkntIMMLcnOc8Yb8nSv6U0LswkOGxN8nRecMI6UFcSt3q
         Y73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ntjfVa+jngHFHVKJwKRWVLjgGzUEmZ1zbsiDrkIYxIo=;
        b=LDPV/cKASy9DqlqlbKeRgEbVpDM+pCcp+EggwUqu3DqN9OJ7oYtstBCK0pw8+CxKIF
         KPJjwqvb3KYqhIXdcUa9JkT4TyOMuP8Sdp9izD/5evwkRy9EXeJ3KGLkTtTI7OlzxscA
         4mZQ2J19aMJTAZAsU4fEDijPqfMLg16edtHmix2rmHWpj5H3udelWJLylmMjM+2rnOIQ
         AZt2Ie7J6xptxj6MaAHvEHnmThW8lU3OKyBhX3c6ZNFq3M8twSGhS03It1q4dQGbB8pv
         X6BP+cczMF9WdsgLPf/VDGMRLDMTRVzJms0La6J8WrVsvPsKmg5z0TBksCLcjoBq5qFX
         518Q==
X-Gm-Message-State: APjAAAWax1MjSqNjs02Jtx0aQEqq2tJVG20q2onYvQJhXHowxtg7FcU0
        SjyMB3i190rTX2ntUsxh02wwYcwQ
X-Google-Smtp-Source: APXvYqzG2TvvEDbj+fCX6zqbl0k8Tw/WLcjYDPXGjKGC5u02DNYV2Vr/JbaOSLtTlJ/agl/GsfwCcA==
X-Received: by 2002:a63:144:: with SMTP id 65mr1808067pgb.38.1551396703305;
        Thu, 28 Feb 2019 15:31:43 -0800 (PST)
Received: from ?IPv6:2601:282:800:fd80:426:ff55:d0ef:2e52? ([2601:282:800:fd80:426:ff55:d0ef:2e52])
        by smtp.googlemail.com with ESMTPSA id o5sm45932039pfi.118.2019.02.28.15.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 15:31:42 -0800 (PST)
Subject: Re: [PATCH] net: ipv6: check net in ip6_call_ra_chain
To:     David Miller <davem@davemloft.net>, fruggeri@arista.com
Cc:     yoshfuji@linux-ipv6.org, kuznet@ms2.inr.ac.ru, maxim@arista.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20190228190146.802CD95C016B@us180.sjc.aristanetworks.com>
 <20190228.130213.1481374802407995712.davem@davemloft.net>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <171e33d9-ee82-6a62-693e-5d585e4eca28@gmail.com>
Date:   Thu, 28 Feb 2019 16:31:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190228.130213.1481374802407995712.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/19 2:02 PM, David Miller wrote:
> From: fruggeri@arista.com (Francesco Ruggeri)
> Date: Thu, 28 Feb 2019 11:01:46 -0800
> 
>> ip6_call_ra_chain is called when IPv6 packet with Router Alert option
>> is forwarded.
>> It needs to check if the net of the socket is the same as the net of the
>> input device, otherwise the packet gets delivered to every IPv6 socket
>> listening for Router Alerts, no matter which network namespace it is in.
>>
>> Suggested-by: Maxim Martynov <maxim@arista.com>
>> Signed-off-by: Maxim Martynov <maxim@arista.com>
>> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
> 
> Right now someone using such a tool does get all RAs in the system.
> 
> Your change not only breaks them, but also gives them no method by
> which to keep obtaining the same behavior.
> 
> I don't know what to do or suggest in this situation, but right now
> I'm putting this patch on hold.
> 

need an equivalent to NETLINK_LISTEN_ALL_NSID
