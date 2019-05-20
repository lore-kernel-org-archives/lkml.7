Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FEFC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96626213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="JNAeBWNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391600AbfETO3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:29:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41941 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbfETO3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:29:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id f12so6805613plt.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tby8uXDZkwSZbAWO8fG57ZL2jX80Dve7pfkOGdmauFg=;
        b=JNAeBWNmgdatEhdfiKcx9Sg8mUpFZQ4xl1dyiceY9tj3D71kDu9tSjdW1TtuzViITP
         cd9K1+rzDR5r1qXns0bj/MRRdZx6252XB5KUG1hM+p7Ehyp02Tv9+e/Vp4nj/jNMv1+R
         agFTHEoSOUbBGr9YuvNIrk4td7lpKiE0QBtDxvarjgr4L31IyjG9NUu8YJM2uaXT0sF9
         j7IQ+rwLqcAN+gP+BeLpywnLy2AnoutN2ZJJD0STyOFgJyFu+YMlzoPY6r/Jj5zYeGAj
         VY6YvSGGyHYlNdkyBuhQ6aptTqcAIxo1BSZOSvTmSO3fBqT9nVmVLaaAzsjTiD++/F+c
         ba1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tby8uXDZkwSZbAWO8fG57ZL2jX80Dve7pfkOGdmauFg=;
        b=oyPUZEiUACTkS+QRhj2Pmxsuj+bTFGbydZiUxnklCZ0uhw0/+NBze26wZpxEh5+wT2
         RF7MaKZglyjW8gDxDyzp/Lv3Iv7R+kbZjIpkQEh3yVaoFsH5vAV4tlMAQI7kODuAnSsm
         PFX1Awsg6RcsAeY8oyaNe1c5Uy+8/U1/w4MHynH4X+kv862YP9ZJio77rLyzM+bAXUD6
         qcrR8zvYww8pZmcL9vXjNcI68N3tj38g3oy8NAOODSy6wYbnzWP9335CIVk4qkagtEfW
         4hXLOF6LGIIMS0IqTFweVC2qFApuLTaJauEn4ggz65r/Tsdd622OobyBNP+4tn+dbZa8
         z2Jw==
X-Gm-Message-State: APjAAAUxU5Z1sK+VnV7C03KPzkvogA0sIqbCObSA9WFHEVOOM1LsbgdE
        m8YJTKXfKf3qOupeeAAW3JJqpQ==
X-Google-Smtp-Source: APXvYqw3svrAsUwlajh8jgiqdVOAxl9UhhGQm15QXltkEN3f57/pm04uu9pJZeNxZjoXR2tFDPd8pA==
X-Received: by 2002:a17:902:8214:: with SMTP id x20mr53756900pln.308.1558362587237;
        Mon, 20 May 2019 07:29:47 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id z14sm22799268pfk.73.2019.05.20.07.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 07:29:46 -0700 (PDT)
Subject: Re: [PATCH] arch64: export __flush_dcache_area
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190517200012.136519-1-salyzyn@android.com>
 <20190517215303.3daebi7o66we2cjh@mbp>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <735fc46d-69a4-6b65-f0f7-a09c2be438a8@android.com>
Date:   Mon, 20 May 2019 07:29:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190517215303.3daebi7o66we2cjh@mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/2019 02:53 PM, Catalin Marinas wrote:
> On Fri, May 17, 2019 at 12:59:56PM -0700, Mark Salyzyn wrote:
>> Some (out of tree modular) drivers feel a need to ensure
>> data is flushed to the DDR before continuing flow.
>>
>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: kernel-team@android.com
>> ---
>>   arch/arm64/mm/cache.S | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
>> index a194fd0e837f..70d7cb5c0bd2 100644
>> --- a/arch/arm64/mm/cache.S
>> +++ b/arch/arm64/mm/cache.S
>> @@ -120,6 +120,7 @@ ENTRY(__flush_dcache_area)
>>   	dcache_by_line_op civac, sy, x0, x1, x2, x3
>>   	ret
>>   ENDPIPROC(__flush_dcache_area)
>> +EXPORT_SYMBOL_GPL(__flush_dcache_area)
>>   
>>   /*
>>    *	__clean_dcache_area_pou(kaddr, size)
> NAK. Such drivers are doing something wrong, there is a dedicated
> in-kernel API for that handles kernel maintenance (hint: DMA).
Thanks!

-- Mark


