Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69474C2D0D1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B0121D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576595337;
	bh=vYx0v2RYfVbzezxf0WzhCOWD1hRsb9GKJtKuNB+YUAc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xtwvdm0rm/CXHDOaHdiU3PEiMkCTSjwDblmptlrBiHiM/uN49xuimCo+LV8Tne10h
	 J+0uq7cNhn7kMymUffxTKKfpW+kYNGG6np/xgFVCU/o0nOmEn+3UKDx2XAsmqr4/Rk
	 pyU9BXR7jUMDhacWQeAEoax/DIbXjYt8DyjQ0oxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfLQPI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:08:56 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35648 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbfLQPI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:08:56 -0500
Received: by mail-io1-f67.google.com with SMTP id v18so10373365iol.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 07:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bHgBoZjI4n84pTBe8b2XKBtgme/qK2l3tBlbTZYezI4=;
        b=AfmS0cSw5QZHULbCOFeGtG7GAHck2Q++sb5um6GXJkmP3N74teYGjrH8nxhXlh4S9U
         3K2/LXXnxBr7Qb4EnJcdKWCcBV4kBG6YIs+la6InGRWI03RKxE5NyD3e+dB73rH+39ur
         bC72PrPQnTlDFqxEATW/TENGnRKLcFeO1pRTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bHgBoZjI4n84pTBe8b2XKBtgme/qK2l3tBlbTZYezI4=;
        b=JhuDtjZVH9Bt9RZBFCjotNcf1aA9GKZMO3OL5qitJq4Wayy7f99rh53O1BUxifWZaZ
         wZb1x84DWKlSfyMQsXYMwdq1xu5vWff8mdg2LU0CqChk5Maa88xoqpdnFgUgbz3YVLZp
         uLlHGCRgupsFiBBhWav89xHDNUJOiivo36E5YHhb3JyDDM6pdat+kVmxkAlOCAZLnK5Z
         i6QJfKzINHnzNr4RRvXOH+yp+9h7lPHfmHkE4eBgSILd2siECjmYbtg4tuk3iF4PmaG/
         PU3qBTA3+loGPt7AHuXsj4f4LNi/GdA/ZpasXDMPmgBPWYvpG9TI9LkmFwlRUDWjh19K
         KfFQ==
X-Gm-Message-State: APjAAAWG5WrRfakupjd6SYZqoPg104A3ErBVYBqxTcNez7cWqCCM0NQP
        NqDwJsx7FTNDm9ksdmwvgOXo3Q==
X-Google-Smtp-Source: APXvYqyTHwu0VRhRXpJa0BvlWII0VilsqEu6uN33ZMGJiPdgsD3daCtfo2G9T4JwIvCqzVkI1QWgcA==
X-Received: by 2002:a6b:ed15:: with SMTP id n21mr1646057iog.128.1576595335283;
        Tue, 17 Dec 2019 07:08:55 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 16sm5246124iog.13.2019.12.17.07.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:08:54 -0800 (PST)
Subject: Re: [PATCH v2] selftests: livepatch: Fix it to do root uid check and
 skip
To:     Petr Mladek <pmladek@suse.com>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        joe.lawrence@redhat.com, shuah@kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20191216191840.15188-1-skhan@linuxfoundation.org>
 <20191217090210.ky3il3qu4jkr2vaa@pathway.suse.cz>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8f2a1599-df35-ec19-da9a-795330cf185f@linuxfoundation.org>
Date:   Tue, 17 Dec 2019 08:08:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217090210.ky3il3qu4jkr2vaa@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 2:02 AM, Petr Mladek wrote:
> On Mon 2019-12-16 12:18:40, Shuah Khan wrote:
>> livepatch test configures the system and debug environment to run
>> tests. Some of these actions fail without root access and test
>> dumps several permission denied messages before it exits.
>>
>> Fix test-state.sh to call setup_config instead of set_dynamic_debug
>> as suggested by Petr Mladek <pmladek@suse.com>
>>
>> Fix it to check root uid and exit with skip code instead.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Shuah, I assume that you will push this fix via linux-kselftest tree.
> Please, tell us if you have other preference.
> 

Hi Petr, Yes I will push this in. Thanks for the reviews.

thanks,
-- Shuah
