Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DE6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E04920857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrjlHZUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfCHSuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:50:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40366 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCHSuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:50:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id u9so14812570pgo.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7eTI525GHTyjcO/9cMydFKLnMqhybdMglZWeXdXExBw=;
        b=VrjlHZUoxqqSjD872dF7otECSiAktVwLH/AHdlSpHt1J7er/J050Fk7EjQe5xFt4pC
         HRb3ec1dQbq1hFetCly6Ytxwi4pZy1Zg3NLq3t31ZzIqsEvNLfcKoeTdsInI5lkWdb9e
         j8yCqMWtAOGYGi3thQOr/qidLsebEOTxnUKfuxi3Oa7wtRRB/7HrhPpoSU+S52SPd2QS
         3uDeEqg1/aPTf7LZhWstFy4lMQPgT/dVWJr/kfubIaKEkslNZ6pe8MH0a0qVVdPdL4np
         kM7NWQju1BfNu4aGt0AuRYQX9wFU499d7lS3rx/lsdHC99IH4rTWJ/IcBhTOhUSk2w54
         9gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7eTI525GHTyjcO/9cMydFKLnMqhybdMglZWeXdXExBw=;
        b=d7a9aDTh82yeggjjs6iyMzvvVhBQRmw1yYf9vKF/K3A1aKvbHcgsYae6W6T1cZqAJm
         2vzjVZsMxtwGjj4Sg3PH+8GqIhe4GKChB1aZ/IIByd3CZNNl6D9Kh/VICMhKSCB5cvvN
         hMY+rINvM9GUjPl+2StV+17N18tlgJ/w4jcWoSZB+T9DHZk81bmYVEOvKk5F3dUEqySB
         dJPY7vFCSIgNyZ55Ik/vn9g8KMXE7asQWGsxe/C3YBn1E89MY9GODAnnaZC5GwgcrRX2
         FtVLtGZc5ttr1I2uDLG92r8CeS6sW540OIVDrQmj4S7rvBZXzYB/BExlmVxIl8pFQmip
         RHaw==
X-Gm-Message-State: APjAAAUWbOwvkOpQlzTRiulH9vqHkhazkQlsH1lrarcESsJKyQEkQ71t
        60x9ercYv2N8RBOX7VBz2EDol2vj
X-Google-Smtp-Source: APXvYqzKnzsDrYt4IyyLDokRoBL4yx9C/QJxqFa6fx4lhMexvEZjEYTz+X/o3RamPzcn2H/fICqn9A==
X-Received: by 2002:a62:5385:: with SMTP id h127mr19685040pfb.10.1552071014978;
        Fri, 08 Mar 2019 10:50:14 -0800 (PST)
Received: from [10.67.50.31] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 17sm11166053pfj.80.2019.03.08.10.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 10:50:14 -0800 (PST)
Subject: Re: [PATCH v2 02/15] ARM: bcm: fix a leaked reference by adding
 missing of_node_put
To:     Ray Jui <ray.jui@broadcom.com>, Wen Yang <wen.yang99@zte.com.cn>,
        linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
 <1551785646-46173-2-git-send-email-wen.yang99@zte.com.cn>
 <67d1be96-ad8a-a453-996f-731a363677ae@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <472373f4-fc8e-3c8d-a2a3-e6cba261e2a7@gmail.com>
Date:   Fri, 8 Mar 2019 10:50:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <67d1be96-ad8a-a453-996f-731a363677ae@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 9:24 AM, Ray Jui wrote:
> 
> 
> On 3/5/2019 3:33 AM, Wen Yang wrote:
>> The call to of_get_next_child returns a node pointer with refcount
>> incremented thus it must be explicitly decremented after the last
>> usage.
>>
>> Detected by coccinelle with the following warnings:
>> ./arch/arm/mach-bcm/board_bcm281xx.c:43:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 35, but without a corresponding object release within this function.
>>
>> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
>> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>> Cc: Ray Jui <rjui@broadcom.com>
>> Cc: Scott Branden <sbranden@broadcom.com>
>> Cc: bcm-kernel-feedback-list@broadcom.com
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>> v2->v1: add a missing space between "adding" and "missing"
>>
>>  arch/arm/mach-bcm/board_bcm281xx.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-bcm/board_bcm281xx.c b/arch/arm/mach-bcm/board_bcm281xx.c
>> index b81bb38..1238ac8 100644
>> --- a/arch/arm/mach-bcm/board_bcm281xx.c
>> +++ b/arch/arm/mach-bcm/board_bcm281xx.c
>> @@ -38,6 +38,7 @@ static void bcm281xx_restart(enum reboot_mode mode, const char *cmd)
>>  		return;
>>  	}
>>  	base = of_iomap(np_wdog, 0);
>> +	of_node_put(np_wdog);
>>  	if (!base) {
>>  		pr_emerg("Couldn't map brcm,kona-wdt\n");
>>  		return;
>>
> 
> Change looks good to me. Thanks!
> 
> Acked-by: Ray Jui <ray.jui@broadcom.com>
> 

Squashed this patch and "[PATCH 1/4] ARM: brcmstb: fix a leaked
reference by adding missing of_node_put" into the same commit:

https://github.com/Broadcom/stblinux/commit/ff98f8f6083a7f317463f538e9a21822e1128657

thanks Wen!

-- 
Florian
