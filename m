Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B2FC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A66E218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/jAnWo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfCWErD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 00:47:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33045 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCWErC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 00:47:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so2861114pfd.0;
        Fri, 22 Mar 2019 21:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8d2yFQgpq2z0dSPWAtuErkUqzrX03q/XNoEzCK8IWaQ=;
        b=C/jAnWo/LUpgP5tSMB2Wx2dv3xqH8+jf4kkzzIWnik6XECUDleDb5zrl53C9Ksnf0o
         lw7MNo5LMRii+JxDxZwr1IX84WFy6MjWdJWC5fHefeCPVC4JkZB7XC4sJPZqvv1jz90L
         BbzS+rq+yDzY12tU/N39yOw+uoRKNcpW+M0V8yLk9yKG00AiLsTNVDLGx67On4FF/yIA
         45Fz1M+iqrPvV0ZZcnCwH51UmUPs/MD4qAJDzBHcKi/TqDrOw+BX+yreyY01/YjtPNet
         8IXuNziz4rWjU2Qk9CqJKB2qT3k3G5JacEySrnphd/VYA3/Q6ecO/BfPEO2/y26BGq4r
         CAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8d2yFQgpq2z0dSPWAtuErkUqzrX03q/XNoEzCK8IWaQ=;
        b=ZRr60geBU4PnWbDvqa3cet1T6iWi3DVIpYw6EVdn9PBlvhHNsJh+d6sZFYuCtmvYyn
         yoxwxrbUFrZftyjRjpW0HIXK1zrfesIngvkyjlMPvFoFTieivyCIws2okwSdUWIv7Itw
         MjpYNeGOtlwiQrV7SMUPsRR9Pr1BtbrHhSKtZypKf8PVYCF2JxCIbFt6KuC0OKipbonu
         klejM9PaVrvygK2+hbmIQPgpZmRlDyv/KIu/iBY8qz/ysIuSf3cpl4J6PPXo/mg3D4Jk
         7aNHbipCGD6aQUWT7es0DupppReVlKBCjRYRZ/m1r3Jp9ASSrbR/MaO4joD28v9MPk0W
         a6TQ==
X-Gm-Message-State: APjAAAVWE/3mt682324BETBln7bqjxLDnlTVVSB2IyqOgPRJBM8cd79X
        Yzrvp+nJo47qgcJFzJCigKcwZiNZ
X-Google-Smtp-Source: APXvYqztf/uDJ5/XmHnHrHZ5hDnMh6LoN4RUt/VKQqlkTHVvGQ8BsnGdt87mtbhiFBoL94vwiM0suQ==
X-Received: by 2002:aa7:818a:: with SMTP id g10mr12718246pfi.178.1553316421895;
        Fri, 22 Mar 2019 21:47:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l63sm13462979pfc.89.2019.03.22.21.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 21:47:01 -0700 (PDT)
Subject: Re: [PATCH 4.19 000/280] 4.19.31-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190322111306.356185024@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <73944567-c284-9aa7-3ce3-c9129ae9a93b@roeck-us.net>
Date:   Fri, 22 Mar 2019 21:47:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 4:12 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.31 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 24 11:11:09 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 345 pass: 345 fail: 0

Guenter
