Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6430AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3148F20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLh2TsMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfDSSzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:55:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40263 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfDSSzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:55:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so3013097pgl.7;
        Fri, 19 Apr 2019 11:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3oACOke3mjxS7Ds+PxG4Asb3iI3bZvS7rcJZH4/T9TI=;
        b=pLh2TsMj83rpvnTYzvgoqZCS25nwprEAlxc37MQw9OJjFlc2U3zChRb6dhdFKNVN7K
         mB75l/NpQAPcYKSALBTfZ2mggR/IdCUAveYvxCQwxRMmfp+gQDy5lNUeOFOhAiVAbT5K
         AqLYHU4IZ0/dpHTEfZsP7tIQE+N+GOrrOv55ur7Iq9F3CSfhJI8dmitZgn2bKkCuCAtX
         sIRJY+Sg7hGk1E/TP8qitEfyibuZqZ2KQPQBJJvbal5go9dlCjZQV2Ac6hgpPhJ/9i+n
         C3bNS8vyFGowSc42S5TLeYV2vAdx2+tbB4CnE0EBotcDSUxmuOUWnyKP3jvrBsSIvFxR
         r3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3oACOke3mjxS7Ds+PxG4Asb3iI3bZvS7rcJZH4/T9TI=;
        b=EfQhhX97slWpwj/CXj/SLHuXhtAy87HX46lYsult/FLP995nBotRx1+7qqC/1TYoql
         aMYCzgCt7/CIv57QRxwY/BNewbkSieVRPdD2VvcgJe+J4VhSugtrdNekbyUXWe9rMNsW
         YGOkEOhy7YDZ5saD8IVKB1vNrrrugVAgH8TCvfNaE/kQZ55OWIkoHdvOl7e1LvRtjupv
         mlSjPo0IwG1GyaN8pC2MTWo0Zs7F9YEgLz2gS4pip35sKwdMtwpTUbTvKB2nq/Nls55i
         EnG+HFKbhq7NOP4P9TEfowI9y7rTIdBQuWOOs8rCuAwEPnroHxvIHi7JKIWth0Cn3Duq
         ERgg==
X-Gm-Message-State: APjAAAVxGb6SMOfDUCTvyQXGKBz0mEapGv63GQxnJvgSLPbnyot4xIbz
        D52L/qARH2PXNElS37uIlLcW/V5w
X-Google-Smtp-Source: APXvYqzi+1wlwz3gFkMQ9B85hXYd8skQGQICJV2XNdAb/mRFVHeVdND9+jmkcaFXM3oXam0lXfBvig==
X-Received: by 2002:a62:6587:: with SMTP id z129mr4155548pfb.88.1555681299267;
        Fri, 19 Apr 2019 06:41:39 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id a3sm7073933pfn.182.2019.04.19.06.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 06:41:38 -0700 (PDT)
Subject: Re: [PATCH 1/4] net/skbuff: don't waste memory reserves
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Willem de Bruijn <willemb@google.com>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190418180524.23489-1-aryabinin@virtuozzo.com>
 <791f4f23-d931-4ac8-4e60-3ffe46c4ece2@gmail.com>
 <c2c270d9-29c0-b993-84c5-4c994608f7c8@virtuozzo.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <a80606cf-3076-b01d-0442-ccff3c462276@gmail.com>
Date:   Fri, 19 Apr 2019 06:41:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c2c270d9-29c0-b993-84c5-4c994608f7c8@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/19/2019 06:17 AM, Andrey Ryabinin wrote:
> 

> I don't see why that would be a problem. If refill failed because we didn't have
> access to reserves, then there going to be an another refill attempt, right?
> And the next refill attempt will be with access to the reserves if memalloc socket was created.
> We can't predict the future, so until the memalloc socket appeared we must assume that those
> RX ring buffers won't be used to reclaim memory (and that is actually true in 99% of cases).
> 

I just said that the alloc might be attempted "in the past"

Yes, we can not predict the future, this is why we need to access the reserve _now_ and not
at the time the packet is received.

The 'being true in 99% of cases' argument is not really convincing.

You want the NIC to be ready to receive packets even before sk_memalloc_socks() becomes true.

If a NIC driver has a bug, please fix it.
