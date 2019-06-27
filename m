Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129E3C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60AC2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561606467;
	bh=jExHqCtroC0O2c5m9HpZuLjhLrXiZKARMGrhPquScz4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=YjzdBWMhnRPeta4kneppA2Gl/OTLHMqaXEjIXOudzPOe4IADMul+HiCJbNIO5CCMM
	 Ez8RkWBea1gC9KPQIJyHTSOUXQ+kzcUSiEB5rI5fhXLdWIsvgFrubritc9PIBQ14v3
	 qlDQvqHC7KrgGMUPIoblYzyHaV7buiGXrZB4UVug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfF0De0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 23:34:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38234 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfF0De0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 23:34:26 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so1575420ioa.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 20:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cxDvf2EckOFsaWAF+zMj7Hm50/dc6nb7LsEYeMsZ3hk=;
        b=eRpWdlfuu+A6OEdiV1qhT5guPlgtKctbQ69jxdFyllFS8wVAtikTN1jV75K1tHllvl
         oPbmqXpeotzEtekJuCxzrBY8c05Wsowzx2L8q7SbWOHqshv7buY6RHMabcD1vWnDm5+G
         nALVQfH1sqX/nVC2ZmuMhgiXZyU0t7tJmMoHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cxDvf2EckOFsaWAF+zMj7Hm50/dc6nb7LsEYeMsZ3hk=;
        b=sClxt+eQgRaPmfJM2osm0E7vZPnk0qPJkEjq4kCGIyMvQ3FSkarePETDdqW+aQLMSL
         HYW34vJLYcE/5ix5ZLQ4XKNCz4XqOI+K8lro7qT/LW6oAvKQLvlsL/j4QqFlMFb5RjTA
         Fqh9ibvEMMnomhzp/YdPkmAcBtKtyneI2LlBVQKnUvPyRDBPj5yRs+gJF67SE6pqU7XQ
         ZIdObcBjBZfICkDxhqvys4ljWKE3BsEeBjklMdO/n8VZNmmBMXvO6goMUik4gUykqkny
         loMvW8MJwXG3PyPM7TR4+OWwc2pMuMF1W8OIhUq5LR2YdptWf4+PHAHcXCEmFrqtAAzE
         sQxQ==
X-Gm-Message-State: APjAAAUMfXBLnHYZ7M6C68Mvs7Z6qkxrCqHRg1dT9L7qyriphCRaj4f5
        hlu0tsUc40P0LMp7e4/wJEYMKw==
X-Google-Smtp-Source: APXvYqwZIRB3Q5ITjsBX19z9dZ8zAt/ttB279IMyg/3OvEyjlzYQ3nsra3lQHVmCioNv5HA6mQiqAg==
X-Received: by 2002:a5d:8195:: with SMTP id u21mr2064521ion.260.1561606465802;
        Wed, 26 Jun 2019 20:34:25 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t19sm652941iog.41.2019.06.26.20.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 20:34:25 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees][PATCH v2] nl80211: Fix undefined behavior
 in bit shift
To:     Jiunn Chang <c0d1n61at3@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        johannes@sipsolutions.net, Shuah Khan <skhan@linuxfoundation.org>
References: <20190627010137.5612-4-c0d1n61at3@gmail.com>
 <20190627032532.18374-4-c0d1n61at3@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c20a0a94-ab50-bb85-7c78-e02a465c5a40@linuxfoundation.org>
Date:   Wed, 26 Jun 2019 21:34:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627032532.18374-4-c0d1n61at3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/19 9:25 PM, Jiunn Chang wrote:
> Shifting signed 32-bit value by 31 bits is undefined.  Changing most
> significant bit to unsigned.
> 
> Changes included in v2:
>    - use subsystem specific subject lines
>    - CC required mailing lists
> 
> Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
> ---

Move version change lines here. They don't belong in the commit log.

>   include/uapi/linux/nl80211.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index 6f09d1500960..fa7ebbc6ff27 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -5314,7 +5314,7 @@ enum nl80211_feature_flags {
>   	NL80211_FEATURE_TDLS_CHANNEL_SWITCH		= 1 << 28,
>   	NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR		= 1 << 29,
>   	NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR	= 1 << 30,
> -	NL80211_FEATURE_ND_RANDOM_MAC_ADDR		= 1 << 31,
> +	NL80211_FEATURE_ND_RANDOM_MAC_ADDR		= 1U << 31,
>   };
>   
>   /**
> 

thanks,
-- Shuah
