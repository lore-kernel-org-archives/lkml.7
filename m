Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E786C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525D620B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560874518;
	bh=1BwusKkArFoFe3y/riTD+IVCEPqR3QL4jrDlr5wtdIA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=LgaNZscMFXYNoBUrkWsbLmcdEOO4JHH4RmBiWTRt7SE9h+chNkMZj4y6sg3YWcEYh
	 aULCHHlS4qLHGUEDJvbKbDQOwYInU6xmCDMpuQdA+qabjiKNhrHzvy3czdJDLoRoDH
	 aEzxv0xrrbWdco990kXrytibRFg9KGNLEjUOBhE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfFRQPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:15:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37396 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729835AbfFRQPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:15:14 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so31234471iok.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hil1qRmTyPMHXxg40ww3Oi6DawOnzGePOXKCto+p4II=;
        b=cJhoAWJgd0yHNdC6TcZAMxY22bh8u2rlIKRFBY8ZYeg+qTU1nMl+pFI3Rwcl5M2mXB
         XWzZUp7nsHKcbRb8jf+jAjKiwoPjuWu6UWRdTdReAGaarPG6zVkkuImtYFp/YoAmzI8E
         W/tJW63O58jnfOs5/XArn4zHKT9fRxptVedGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hil1qRmTyPMHXxg40ww3Oi6DawOnzGePOXKCto+p4II=;
        b=Ab7rbwE9qNbL7ifUp9cu74RYq8pZmn5HFu66BBxuwT9rsoyYSfKVsu0t8DI2WEPLDc
         D89XQWt5VX5an+cni5ZqgnTG3Xc3EZYT1gCHUpM1ZPSJ4MDYcaUVxwhGKIu2x1BKdOix
         vCBAy++WtLbKfcybSr+aGxF4dIX5I2qQiVGFoYnAdcb/oMmh2DuJBf1Kd4bSbTISTL4A
         SJsqBl/lOFQpmb4oON87YTlJ55f67D696iWTxGf/H0j43GHViRc+ijUPf+NbKK3pWTRE
         /iJxD+rkr99pVckOeX99VPFhu4sj2Hb5UXXZkMiU8SqkE/p+do9+RTxfS9kEWItANkqH
         ibfg==
X-Gm-Message-State: APjAAAUfDjP9JnieAQYRthscl3F+BVfRTY7KlXQVswWqeeVs3PdWk+Gz
        sZFhX4iRycVURRrF2DsxuiFhcA==
X-Google-Smtp-Source: APXvYqwzsWXT4yFmsWP4Cue6GqTupoAZYKlrN8N1O4hOd9f/JFm7eym5sAZZpvMMSITuuF92nV7LTA==
X-Received: by 2002:a6b:14c2:: with SMTP id 185mr158848iou.69.1560874513443;
        Tue, 18 Jun 2019 09:15:13 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c23sm14863843iod.11.2019.06.18.09.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 09:15:12 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees] [PATCH v2] fs: cramfs_fs.h: Fix shifting
 signed 32-bit value by 31 bits problem
To:     Greg KH <gregkh@linuxfoundation.org>,
        Puranjay Mohan <puranjay12@gmail.com>
Cc:     hch@infradead.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20190618114947.10563-1-puranjay12@gmail.com>
 <20190618160847.GC27611@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <777ee79c-9371-956a-07df-be866796047b@linuxfoundation.org>
Date:   Tue, 18 Jun 2019 10:15:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618160847.GC27611@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/19 10:08 AM, Greg KH wrote:
> On Tue, Jun 18, 2019 at 05:19:47PM +0530, Puranjay Mohan wrote:
>> Fix CRAMFS_BLK_FLAG_UNCOMPRESSED to use "U" cast to avoid shifting signed
>> 32-bit value by 31 bits problem. This isn't a problem for kernel builds
>> with gcc.
>>
>> This could be problem since this header is part of public API which
>> could be included for builds using compilers that don't handle this
>> condition safely resulting in undefined behavior.
>>
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> You should resend this and cc: Nicolas Pitre <nico@fluxnic.net> as he is
> the cramfs maintainer.
> 

Puranjay! You can add all the Reviewed-by tags when you resend the patch
with Nicolas Pitre <nico@fluxnic.net> on the thread.


Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
