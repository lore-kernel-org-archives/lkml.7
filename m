Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECD2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635B320657
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HhsmWIEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbfCFQmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:42:20 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52014 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCFQmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:42:19 -0500
Received: by mail-it1-f196.google.com with SMTP id e24so10502765itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 08:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qj4+Bb2DbKj2RKmdRZjZiyAv4UmvOHroOu8tDL9W7zQ=;
        b=HhsmWIEtUafbIqHgM//rz8ZAukGg1jmNneCKXQmz/s1qQwtkqIrSpG8G1fqixgvOFU
         Tj3QI/vBIcL22Lrj0kCEdXsQI5gmig1tdAFjPhYvahvc68E8NiS6utWFxPbaMxJl26Br
         XPgtAuNwUEy68M0ZHzohPmHNw4m2dsa0xDYc7qQYOHdOOPCXK5kwt68CGi+GnT2VR6/W
         dDjWwf9hCq/m3c7QK2W74LiWlT6iCvfUyCq6UDTXEOrBw6YVLo0XmfdE6dhg9A9HK5Hc
         10prbqHwTiEgniCp/bhfYBlCp2cJ1Axybo14YjxnMMHpt4ZUnYV2tr35WHOxx6t2UWmg
         ctNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qj4+Bb2DbKj2RKmdRZjZiyAv4UmvOHroOu8tDL9W7zQ=;
        b=S3hVoKyBNsgz4HSDZkZhwLcqh2CbgfZ7jhxriogd3kV3EvfFxS3JIki/cBBa8bXo8g
         iAuOCEe4H8pkRXJyxQ7gdf7LmUB5amtSG58t1SWuSpMSoUgK+7EOFkTVdJ9C0ee137TO
         9b0pSAODT7MixsMCDhBM60XtZsU6izy2+DW7QjoYTEt1KvDYj8pqJ1EEM+gbRG8fYIrI
         ubOO5GW/SFQIo08YSINkhparRNYmplamIlNnARwW0pXquTQ4Z2Fm315jN2tRWV+xZ+Ln
         a1atB9MfnzyIsWWkJ42m5HBvyrYu7WLLiysr1bhZi1FWgT5qosR7d0CdqpTB2ZhKMifX
         DTLw==
X-Gm-Message-State: APjAAAV4olRAMOVu0zzk+GiUPB6YNqq41UlTqxyxWduqhvwdpECljmKs
        ZHlno8hTnZ3txIEXns0Q+5e4Ic29s7/QIA==
X-Google-Smtp-Source: APXvYqwKSJeU9t3HI8w2UrGkS6QGoDrZbIsE0inOr/hmF/EC/plA1NUup1mC/2Cuaq0nP0kfm8FBFA==
X-Received: by 2002:a24:eb0e:: with SMTP id h14mr2564978itj.100.1551890538836;
        Wed, 06 Mar 2019 08:42:18 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm702693ioc.45.2019.03.06.08.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 08:42:17 -0800 (PST)
Subject: Re: [GIT PULL] (xen) stable/for-jens-5.1 to your 'for-5.1/block'
 branch.
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org
References: <20190306022530.GC25368@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad623518-1a94-a8b6-fb29-26eb26968090@kernel.dk>
Date:   Wed, 6 Mar 2019 09:42:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306022530.GC25368@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 7:25 PM, Konrad Rzeszutek Wilk wrote:
> Hi Jens,
> 
> Apologies for doing it right at the merge window time. This patchset has been brewing
> for quite a while.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-jens-5.1
> 
> This patchset makes the backend more robust by reading a negotiation
> variable only once and not twice.

Pulled, thanks.

-- 
Jens Axboe

