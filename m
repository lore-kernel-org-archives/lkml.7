Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C91C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5B72343A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567515325;
	bh=ou7XNdfRGU3gcHcYxMOim1ILOsVWomGH3ay8vpnljRk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=wG0egduarQ/PIrNbBywKmUCoFUhM0gYT0B6TiHnQs+Fmhud2qIdciNVcyFra2XHmr
	 UHxalgCxAWB5MuruIdlcn323Z44UWilXrF8B9k79O9ZjLDTFogQV+3eH9RhmECsexp
	 1xqtftM9DmPnaYca71/26/BX9wTrsm2X0hI56Llc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfICMzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:55:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37314 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICMzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:55:24 -0400
Received: by mail-io1-f65.google.com with SMTP id r4so20349279iop.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xXXfF+BP1pkxaEeIfd5tf34OTBwH4aM/p3a2bJwD1PU=;
        b=igogQoDeX2H+I4Woipqlu0Qo9ejku4LeQgwB2Fp4c8tdVqy3RSap5LygcJRUx5UWBn
         4LoTLyH+qgQbxzisvs6hcrY21zb4+DzPRDpto2utwGtgRhLhMKtEiHkPpGsZyY1AtKaJ
         IRKXXdU75uefAXRP3m6lBAZjBAuGvTr9jl1zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xXXfF+BP1pkxaEeIfd5tf34OTBwH4aM/p3a2bJwD1PU=;
        b=U1CU+t8q7e6Xw78ocdq3qKJrl+YF6k1RBZrQZoWWBpnGGZb+QFBsyRPRilD0AWWkWb
         D7EpIEncRuNwvbWgkPqwsv1o+J4FCfgTqv3bgmyM5RFZDDZWW2yixZtdQXZ3DLWbAnND
         vLFzNKFYSEITL/YeABROZ2bUsXGnjcKqgJoJyQMMJ6T60G0RwGBFWiw89Xjje/9h+JgA
         s89R1Xs+tCKVuh0D8svY6esNjh4NZfhMVPftoxiVFDslcIoL46Tu3J6BSzsWb0uzbJ3Z
         o7lgA6VVPRNVBuCToc42CmKs4o+1q6t08HICF9t79NL4PTPLbUGf3qmvMLOig8YK3p/p
         5hZg==
X-Gm-Message-State: APjAAAVzNgEyh2R1Yes0MoFdIxEFY5EEGQ493E9qRwAMM2E4K2D0i9ND
        n3xFNMZizov6As9rEvRRAkZm/A==
X-Google-Smtp-Source: APXvYqxKaHcRm1F7gecWXyZPOBIQoF9Xm+B7IHtHtX+R40LM33bnpLjO1tceNHeXj9qaludehv/n5g==
X-Received: by 2002:a5d:8d12:: with SMTP id p18mr8329383ioj.251.1567515323453;
        Tue, 03 Sep 2019 05:55:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f7sm2873566ioc.31.2019.09.03.05.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 05:55:22 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] media: vimc: Collapse component structure into a
 single monolithic driver
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, helen.koike@collabora.com, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com, andrealmeid@collabora.com,
        dafna3 <dafna3@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1566334362.git.skhan@linuxfoundation.org>
 <a7b877c08d0885fe7e8bffc9b24ef0a2d6236147.1566334363.git.skhan@linuxfoundation.org>
 <09c3ddad7122efb23201dff6e11aaf7455c748ea.camel@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <76c8489f-4c6f-27df-ce28-a7ce3e8b3843@linuxfoundation.org>
Date:   Tue, 3 Sep 2019 06:55:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <09c3ddad7122efb23201dff6e11aaf7455c748ea.camel@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/19 6:50 AM, Dafna Hirschfeld wrote:
> Hi,
> Thank you for working on the patchset.
> 
> Since there is only one module now, the section in the vimc Documentation
> regarding module params should be changed:
> 
> In the file Documentation/media/v4l-drivers/vimc.rst
> The following text should be removed:
> 
> ```
> You should pass
> those arguments to each subdevice, not to the vimc module. For example::
> 
>          vimc_subdevice.param=value
> ```
> 
> (no inline comments)
> 

Thanks Dafna. Yes Documentation needs updates for other reasons and
the module params is on my list as well to fix.

thanks,
-- Shuah
