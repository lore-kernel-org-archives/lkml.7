Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84A1C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7012080D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561037927;
	bh=+bXbBe0xE56OjWv37/4gi2uLzzB/2RVquwbJj/ebiKI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xCHSweFT9M7Ur8EP2Bs2BbaPVR7yH/4qHkjG5qUs4uTnRNq33qlm5eixARGXTiRnQ
	 NI1WYGtLuDBOXu07po9ZU3fBJnswRokO05PR3fC6Wsocfe+D7sx5MerHXeRrUb7Mxg
	 E4csCYEzJ3Eph4MXQ0Dm9BlBcUXwFL9ObG/kpwGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbfFTNip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:38:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37437 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfFTNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:38:44 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so1932490iok.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zM1I+AFmSj1LQ0M/T+xR3ArL000jWNNRfBPPk3QAc+o=;
        b=FBA7wXeKSJz5qlVuadKqqw5EKT+Ge0O185FI6n/xQOLGrJEA1KmEuKIxcUJIIR2ZID
         seas4TLnuOxNXDF4P/1USYyHm+iDHfENBMNvGX7qJd+p44cdNL3NQi4e+wxuv61lPicB
         XXxUMaQzkMCKJ1oU+s3TdNZ7D+4mj+ZiGVuQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zM1I+AFmSj1LQ0M/T+xR3ArL000jWNNRfBPPk3QAc+o=;
        b=r6yvYVJErOqstigCr9G6ctaGZ29oSTcmAHZ+F/ooKLYgnzh10Zz/7WcUwQlYlyXmL5
         DWHahcnlA2aBuPujLhGTkrthftAywRL4+Glq0PQyGeH57AMAhDQvHnpYHTxjJJoA9ltg
         UYOwq5c3DjwGB7i1QtHfLcpvF2N0vU3wnGqsZ0QNCazaeYn+lmg5fipHHCWPaRqPrxbk
         i2ualcz6ZOIgjA5b4iYfWdp4jcFapCBjzt0dDHPsPaTQrR9D4+t0kVN6QAtRJ5WkKVgB
         xyiFDtDNzbd0S0MvThzA0OWhVI2/REQTTZ1LZ4KenW1STKB/8FR/FruoPoGxY6TaB37A
         weFA==
X-Gm-Message-State: APjAAAViYd4E3oWLdoagU2eMs6Th0t/VmLIzeAjQrxt0iei5lKXd6VGq
        5xR7prYNFQmEnn00jrneQZmuNA==
X-Google-Smtp-Source: APXvYqyErKm3SQCklJFa5bOOBL2dXuou5zFbMDkVgJqGSixTktCbF9tnM8W969cEfQjb0GQBLq++GQ==
X-Received: by 2002:a6b:fe05:: with SMTP id x5mr8185908ioh.208.1561037923147;
        Thu, 20 Jun 2019 06:38:43 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u26sm25191288iol.1.2019.06.20.06.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 06:38:42 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees] [PATCH] Documentation: platform: convert
 x86-laptop-drivers.txt to reST
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190618053227.31678-1-puranjay12@gmail.com>
 <20190618054158.GA3713@kroah.com> <20190618071717.2132a1b7@lwn.net>
 <20190618133948.GB5416@kroah.com>
 <8aeb222a-ee44-4125-45fd-ce9a741e7ecc@linuxfoundation.org>
 <CAHp75Vf__EtLVTOf0XvA3w7RPj+bnoQOud3gCXr1Fya0b_o4cw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bf25df8c-9135-c23b-0307-1e3ea611d9d4@linuxfoundation.org>
Date:   Thu, 20 Jun 2019 07:38:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf__EtLVTOf0XvA3w7RPj+bnoQOud3gCXr1Fya0b_o4cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/19 12:19 AM, Andy Shevchenko wrote:
> On Tue, Jun 18, 2019 at 6:06 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>> On 6/18/19 7:39 AM, Greg KH wrote:
>>> On Tue, Jun 18, 2019 at 07:17:17AM -0600, Jonathan Corbet wrote:
>>>> On Tue, 18 Jun 2019 07:41:58 +0200
>>>> Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>> On Tue, Jun 18, 2019 at 11:02:27AM +0530, Puranjay Mohan wrote:
> 
>>> I bet it should be deleted, but we should ask the platform driver
>>> maintainers first before we do that :)
> 
>> Adding Platform driver maintainers Darren Hart and Andy Shevchenko, and
>> Compal laptop maintainer Cezary Jackiewicz to the discussion.
>>
>> + platform-driver-x86@vger.kernel.org
>>
>> Hi Darren, Andy, and Cezary,
>>
>> Would it be okay to remove the x86-laptop-drivers.txt or should it be
>> converted to .rst and kept around?
> 
> Shuan, thanks for heads up.
> The list of laptops supported by drivers in PDx86 subsystem is quite
> big and growing. The mentioned file contains less than per cent out of
> it and I don't think there is sense to make it up to date with
> thousands lines. Agree on removal.
> 

Thanks Andy!

Puranjay!

Please remove the file and cc everybody on this list on the v2 patch.
Make sure to build docs and see if this removal doesn't cause errors.

thanks,
-- Shuah
