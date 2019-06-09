Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B216C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40390208E4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlMJNDkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfFILq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 07:46:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39137 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbfFILq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 07:46:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so2534787plm.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 04:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zqEGlLMYn1Hf3PgR0bIsFQyRjDRf8RHqmbEQvYhF2so=;
        b=YlMJNDkjn9YWn2aopExFEm5W2Cx/O/pxE52GRc4nysb04HypPpPMP0hOJSaa1s8uHC
         F2x6RN582ZXawe87QM33O2fq5rpmDAvlV1tKRG0kcrmXsoRMS5jndRSZ1aQtxnDp9ISd
         1ouFEZfA6YcpDZ46ZeF+4HMPEy9juB0ml55nHyEBLhH4d94OTbN3y8LuMFLmpBKPGyA/
         /ZYGfz+fm5dbayVPzDr26eyTBnBFNUipLDS4j1QPjPfshgJmRgXxmRydcqPlPcJcZ9BM
         iqAgnU7mGEc+6XuQqfWOWTXg06Y1zgI9S/3pYFLGX8qkVJyCClb8CQdemx71HkqKC0Kb
         56oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zqEGlLMYn1Hf3PgR0bIsFQyRjDRf8RHqmbEQvYhF2so=;
        b=nnLSjvC9GLmHl6AFPyNrHgZkX+3D4RsotV4tuQMkoTSKG/qHYICkq6AEkaPI6EX1LU
         ejNBmqisbj4filiqWQafUTnvsYDmNgCw0WQ30AIfJX9nF2t1S5ZnClirvIoy0ngMlFnk
         gecHxqDrWRTyqx5Xd914jY0ja0woM0eLvaJFhF2oxhB8OVwUPk26hJJoe2qp5GCc39/6
         bw21peO7mndT3f/tJ3SDACdevM2AgcB8zUF0DT2LZli7rb9CIYKf0esqJo/LtqouhwbJ
         +fHaI1FCxZITzLdxk7y9xG3CKVTQ7+Ina9XPfrIrZZguWt+R5Jhp9UKYNO769yFDEMFH
         YX8g==
X-Gm-Message-State: APjAAAX7O1SMwIlgVAQa2gxoTRI5v8TAFarfXOD4Emy8rFruJnPNzk04
        TdMN/Lxjx3MVD9GHz//n/PQ=
X-Google-Smtp-Source: APXvYqwx1gMjrkgfvioi5xxBVaRSb3AqtsQkm5hHELkRV5zlsBPRhn0U+J1OuybEPlWg4lcfk9Xzdw==
X-Received: by 2002:a17:902:7d86:: with SMTP id a6mr40969598plm.199.1560080817014;
        Sun, 09 Jun 2019 04:46:57 -0700 (PDT)
Received: from [192.168.1.7] ([117.192.26.87])
        by smtp.gmail.com with ESMTPSA id v1sm6177825pjo.28.2019.06.09.04.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 04:46:56 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] staging: rtl8712: cleanup struct _adapter
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, straube.linux@gmail.com
References: <cover.1559990697.git.linux.dkm@gmail.com>
 <20190609111010.GA28875@kroah.com>
From:   Deepak Kumar Mishra <linux.dkm@gmail.com>
Message-ID: <933b8890-986c-8bdb-93ef-90edf248fb43@gmail.com>
Date:   Sun, 9 Jun 2019 17:16:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190609111010.GA28875@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 09/06/19 4:40 PM, Greg KH wrote:
> On Sat, Jun 08, 2019 at 04:26:55PM +0530, Deepak Mishra wrote:
>> In process of cleaning up rtl8712 struct _adapter in drv_types.h I have
>> tried to remove some unused variables and redundant lines of code
>> associated with those variables. I have also fixed some CamelCase
>> reported by checkpatch.pl
>>
>> Deepak Mishra (6):
>>    staging: rtl8712: Fixed CamelCase for EepromAddressSize
>>    staging: rtl8712: Removed redundant code from function
>>      oid_rt_pro_write_register_hdl
>>    staging: rtl8712: Fixed CamelCase cmdThread rename to cmd_thread
>>    staging: rtl8712: removed unused variables from struct _adapter
>>    staging: rtl8712: Renamed CamelCase wkFilterRxFF0 to wk_filter_rx_ff0
>>    staging: rtl8712: Renamed CamelCase lockRxFF0Filter to
>>      lock_rx_ff0_filter
> If this is a "v4" series, I do not see a list of what has changed from
> the previous versions at all here :(
>
> Please list it somewhere, usually in the individual patches below the
> --- line, or you can put it here in the 00/XX email as well.
>
> v5 please?
In my previous versions I mainly tried to correct the patch submission 
based on your suggestion for example
1.keeping every individual task separate.
2. Not only just fix CamelCase but if those variables are unused remove 
those.
3. If any variable is assigned but never used then remove those.

So should I put these review comments in my 0/6 file and send you the v5 
of the patch set,

or remove version number and send a new patch set again as if it is a 
fresh patch set ?

Please suggest.

Best regards
Deepak Mishra

> thanks,
>
> greg k-h
