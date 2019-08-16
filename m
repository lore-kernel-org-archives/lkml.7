Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2EAC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC3320644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNyCP1TO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfHPGkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:40:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45087 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfHPGj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:39:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id q12so477479wrj.12;
        Thu, 15 Aug 2019 23:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5CiCivYuLKVWcTvhyXRHZSRzZ+pFRBC2NZeakCldL+o=;
        b=BNyCP1TO3qjPbK5rP9vIaHG8bXEJrTnMwc2yeOZxIcv/p0DrAl6K0DMQvWGoLArbzC
         mQC7LUTTKemH6cvncmuqk9381Xuy1e4RZLqGH67YfB4EOh4EYk4sF5R7b2+V09DDjSyr
         IN0ntVFz18ofbM2seF0IQ5OXDMZ0r+17FPSf4DHu7ZmiGTcteoBO8e+JaHeZdm+vNwek
         6FMLXr0rtwp2D7sJkbsjm8v3JB2KJxgoSt5M9Q07dtykb7V6KYUeNTTDhOXRWKAa2mtn
         BxWt7/wvlDjSLCoHQeAJLty5vrNdHvDeH9NIG8luAiEyO1c+BJU8am6vL+cBl/SWPBRX
         lwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5CiCivYuLKVWcTvhyXRHZSRzZ+pFRBC2NZeakCldL+o=;
        b=ZWA5NtgNDxDuTWurBjGB5E+vJftoWjnPSsW7gNiuLgdFthbDb1mx/Lup1365+E4Tv5
         GKwXgCMQSStKkK2pnIxqOwbK0G/TcHbi8m8zfqRx2QfMAh2H9axLQYNsZZpA4e+4Ok9X
         RRA2RrJjfYHACMSM4782FEtORFskRNY/jcRLTZj2u232QQsOewjt/epcqB1ciJFgy+bK
         tCUlrMyu6+KQSEKeNnrHxmp5ugndZ6ZSeyFCdtaWZlcX4P3LKWwGe+RITUYs9YDgXH0w
         Cy4tLR14CtymksAMkQIETkXNML1fSbp7eK7KKCSYrKwjC3Z5G3S8fDV9yFBNQQxwy7Ei
         OovA==
X-Gm-Message-State: APjAAAUjSU/6Yv5nn0vJZhOoRCVgDHJmHGp7HFK+uTy+vWfHaT6H/WjS
        0NREcFtNPlmcy+oWMs18/ZtuYkjn
X-Google-Smtp-Source: APXvYqzu5S4jP1HucZDHre6xJ2x0X8lPA3VySpIREgwplU+EW/f3cCL3cxMcL864x1snQikP1wEkSA==
X-Received: by 2002:adf:f14f:: with SMTP id y15mr8733609wro.28.1565937597703;
        Thu, 15 Aug 2019 23:39:57 -0700 (PDT)
Received: from [192.168.8.147] (187.170.185.81.rev.sfr.net. [81.185.170.187])
        by smtp.gmail.com with ESMTPSA id o8sm5576893wma.1.2019.08.15.23.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 23:39:56 -0700 (PDT)
Subject: Re: [PATCH net-next] r8152: divide the tx and rx bottom functions
To:     Hayes Wang <hayeswang@realtek.com>, netdev@vger.kernel.org
Cc:     nic_swsd@realtek.com, linux-kernel@vger.kernel.org
References: <1394712342-15778-301-Taiwan-albertk@realtek.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <9749764d-7815-b673-0fc4-22475601efec@gmail.com>
Date:   Fri, 16 Aug 2019 08:39:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1394712342-15778-301-Taiwan-albertk@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/19 10:30 AM, Hayes Wang wrote:
> Move the tx bottom function from NAPI to a new tasklet. Then, for
> multi-cores, the bottom functions of tx and rx may be run at same
> time with different cores. This is used to improve performance.
> 
>  

tasklet and NAPI are scheduled on the same core (the current
cpu calling napi_schedule() or tasklet_schedule())

I would rather not add this dubious tasklet, and instead try to understand
what is wrong in this driver ;)

The various napi_schedule() calls are suspect IMO.

Also rtl8152_start_xmit() uses skb_queue_tail(&tp->tx_queue, skb);

But I see nothing really kicking the transmit if tx_free is empty ?

tx_bottom() is only called from bottom_half() (called from r8152_poll())


