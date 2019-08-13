Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1715C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 22:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF3F206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 22:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfHMW0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 18:26:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38822 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfHMW0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 18:26:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id r20so27998993ota.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 15:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=suYvhmHKZHJtRbU1etiqI2wU0TBYticgz13MW2eBmCs=;
        b=T6CMZpk/PK4ge/wshF7yGB11iiL7qd5LndwMiEd9X2XCY+lbqwWUgVZU+mphfc3YUs
         e/MmjvjJjIzzMsLs1bDjGLM7t+q8VmaAvmxJQ+ZswsD+9zL9Ulr2muLSwXxxylvvOd/a
         dUf1CexexozaB5EcCXQJuGf93Lb08XwyXsCvoWJtdtcBxtUv6ZcFWOpGfyD77Tu9QzsU
         EVz1ZZnDskT/KfkS+XBadtqBrSFU64jdxdB6HBcrb+eT7F8PsPkvkWj3EQD0eipBIXio
         Er9166AzDY/JOBl40l9r2fGPARA16s4+i+5I4fe3L9el6rfTCyfMvYTSTxJsFqEBAXXr
         DNwA==
X-Gm-Message-State: APjAAAWlpHnbwWfcuvm+iEkKLSpaUxaoEe7c6iKiXPbDApMhyW0c3dfu
        3SSlixk7/3veuwOUG0n97VTHPQ==
X-Google-Smtp-Source: APXvYqxvnxOu8FQxxdgYaGL/EtAxC0fOJv+l8Zx6AbPm6JzhweJNdZba8aEa0MVGJ5h30rYO5uGyaA==
X-Received: by 2002:a5d:948a:: with SMTP id v10mr26587703ioj.103.1565735200010;
        Tue, 13 Aug 2019 15:26:40 -0700 (PDT)
Received: from masetto.ahs3 (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id e22sm16141388iog.2.2019.08.13.15.26.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 15:26:39 -0700 (PDT)
Reply-To: ahs3@redhat.com
Subject: Re: [PATCH] ACPI / CPPC: do not require the _PSD method when using
 CPPC
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>
References: <20190805170338.29493-1-ahs3@redhat.com>
 <521915646.RcUJINxfhL@kreacher>
From:   Al Stone <ahs3@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e103debd-d0f2-5b40-1e6d-7a533ef4ac07@redhat.com>
Date:   Tue, 13 Aug 2019 16:26:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <521915646.RcUJINxfhL@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/19 3:59 PM, Rafael J. Wysocki wrote:
> On Monday, August 5, 2019 7:03:38 PM CEST Al Stone wrote:
>> According to the ACPI 6.3 specification, the _PSD method is optional
>> when using CPPC.  The underlying assumption appears to be that each CPU
>> can change frequency independently from all other CPUs; _PSD is provided
>> to tell the OS that some processors can NOT do that.
>>
>> However, the acpi_get_psd() function returns -ENODEV if there is no _PSD
>> method present, or an ACPI error status if an error occurs when evaluating
>> _PSD, if present.  This essentially makes _PSD mandatory when using CPPC,
>> in violation of the specification, and only on Linux.
>>
>> This has forced some firmware writers to provide a dummy _PSD, even though
>> it is irrelevant, but only because Linux requires it; other OSPMs follow
>> the spec.  We really do not want to have OS specific ACPI tables, though.
>>
>> So, correct acpi_get_psd() so that it does not return an error if there
>> is no _PSD method present, but does return a failure when the method can
>> not be executed properly.  This allows _PSD to be optional as it should
>> be.
>>
>> Signed-off-by: Al Stone <ahs3@redhat.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Len Brown <lenb@kernel.org>
>> ---
>>  drivers/acpi/cppc_acpi.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 15f103d7532b..e9ecfa13e997 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -365,10 +365,13 @@ static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
>>  	union acpi_object  *psd = NULL;
>>  	struct acpi_psd_package *pdomain;
>>  
>> -	status = acpi_evaluate_object_typed(handle, "_PSD", NULL, &buffer,
>> -			ACPI_TYPE_PACKAGE);
>> -	if (ACPI_FAILURE(status))
>> -		return -ENODEV;
>> +	if (acpi_has_method(handle, "_PSD")) {
> 
> It would be better to compare the status below to AE_NOT_FOUND
> and return 0 if that's the case.
> 
> A couple of code lines could be saved this way at least.

D'oh.  Good point.

Let me dig back through the ACPICA code again; I had some reason for not
relying on AE_NOT_FOUND alone that I apparently did not write down in my
notes.  I'll send out a v2 when I figure out what it was, and if it was
of any consequence.

>> +		status = acpi_evaluate_object_typed(handle, "_PSD", NULL,
>> +						    &buffer, ACPI_TYPE_PACKAGE);
>> +		if (ACPI_FAILURE(status))
>> +			return -ENODEV;
>> +	} else
>> +		return 0;		/* _PSD is optional */
>>  
>>  	psd = buffer.pointer;
>>  	if (!psd || psd->package.count != 1) {
>>
Thanks.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
