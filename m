Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF2BC32753
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 22:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A94020665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 22:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfHMWPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 18:15:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46602 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfHMWPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 18:15:54 -0400
Received: by mail-ot1-f66.google.com with SMTP id z17so59325961otk.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 15:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=l3UiqyQdkzzBfC+pgGtBbYgwOzNc0kqIlToMjux/dcg=;
        b=H4D66IVuxsPwcOUE4nxYHq523bCvmc3MWiDGqCLgoRkv5apROAPjQ3xRJkirsDVsZS
         F1QZhzd1DOJVlW8+YeF/3CDfI387rlrEvmhD+tnstmd6Gotx1hHck9793n+oNyMz66AK
         bxsEmJ7TyhbIWJ4w35+vTPLuNQq3JDMbZOCwl7878mk2RWZohJEbyS/jL17GbKmt1gsq
         5uMkH1HdPzsvBhbjbvI4yhABG3MewOAmVfGbHUUftOYbWUOhyg45wnPzO+lqDSzwcTLK
         yiNpoQMuTu8JxiwJrKufQw96juuNnoyfWm3DMtE7SlpV0GDFdnjL6ZMMoCaGHhBBsxUY
         qyAg==
X-Gm-Message-State: APjAAAUKcIe9X8psiBFN4mcfZZcnENdFEFE2olGmIk/DblmZGzJtKnas
        gyuo3NsQeEsgcPU7ZjiVqQ4wFg==
X-Google-Smtp-Source: APXvYqxv+oF6XIEC+dv7wJmSSoinLlXdDjSl0WGd3LDyf4pIirWgA7sw8J1fy8iFq9Uq2j49IrwB8w==
X-Received: by 2002:a5e:9308:: with SMTP id k8mr28048240iom.143.1565734553758;
        Tue, 13 Aug 2019 15:15:53 -0700 (PDT)
Received: from masetto.ahs3 (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id r20sm15757418ioj.32.2019.08.13.15.15.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 15:15:53 -0700 (PDT)
Reply-To: ahs3@redhat.com
Subject: Re: [PATCH] ACPI / CPPC: do not require the _PSD method when using
 CPPC
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>
References: <20190805170338.29493-1-ahs3@redhat.com>
 <d60f5bed-ca91-fc72-2e4d-309fb8f42960@redhat.com>
 <3154828.dzdK0YMts5@kreacher>
From:   Al Stone <ahs3@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <84c60c6c-949e-2ebd-e9be-7e7cb0fcca00@redhat.com>
Date:   Tue, 13 Aug 2019 16:15:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3154828.dzdK0YMts5@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/19 3:57 PM, Rafael J. Wysocki wrote:
> On Tuesday, August 13, 2019 4:00:56 PM CEST Al Stone wrote:
>> On 8/5/19 11:03 AM, Al Stone wrote:
>>> According to the ACPI 6.3 specification, the _PSD method is optional
>>> when using CPPC.  The underlying assumption appears to be that each CPU
>>> can change frequency independently from all other CPUs; _PSD is provided
>>> to tell the OS that some processors can NOT do that.
>>>
>>> However, the acpi_get_psd() function returns -ENODEV if there is no _PSD
>>> method present, or an ACPI error status if an error occurs when evaluating
>>> _PSD, if present.  This essentially makes _PSD mandatory when using CPPC,
>>> in violation of the specification, and only on Linux.
>>>
>>> This has forced some firmware writers to provide a dummy _PSD, even though
>>> it is irrelevant, but only because Linux requires it; other OSPMs follow
>>> the spec.  We really do not want to have OS specific ACPI tables, though.
>>>
>>> So, correct acpi_get_psd() so that it does not return an error if there
>>> is no _PSD method present, but does return a failure when the method can
>>> not be executed properly.  This allows _PSD to be optional as it should
>>> be.
>>>
>>> Signed-off-by: Al Stone <ahs3@redhat.com>
>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>> Cc: Len Brown <lenb@kernel.org>
>>> ---
>>>  drivers/acpi/cppc_acpi.c | 11 +++++++----
>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index 15f103d7532b..e9ecfa13e997 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -365,10 +365,13 @@ static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
>>>  	union acpi_object  *psd = NULL;
>>>  	struct acpi_psd_package *pdomain;
>>>  
>>> -	status = acpi_evaluate_object_typed(handle, "_PSD", NULL, &buffer,
>>> -			ACPI_TYPE_PACKAGE);
>>> -	if (ACPI_FAILURE(status))
>>> -		return -ENODEV;
>>> +	if (acpi_has_method(handle, "_PSD")) {
>>> +		status = acpi_evaluate_object_typed(handle, "_PSD", NULL,
>>> +						    &buffer, ACPI_TYPE_PACKAGE);
>>> +		if (ACPI_FAILURE(status))
>>> +			return -ENODEV;
>>> +	} else
>>> +		return 0;		/* _PSD is optional */
>>>  
>>>  	psd = buffer.pointer;
>>>  	if (!psd || psd->package.count != 1) {
>>>
>>
>> Rafael,
>>
>> Any other comments?
> 
> Yes (they will be sent separately).

Thanks, I appreciate it.

>> Would it be possible to pull this into an -rc?
>> I'd really like to avoid anyone else having to ship Linux-specific
>> DSDTs and SSDTs.
> 
> You won't achieve that through this patch alone, because they will
> also want older kernels that don't include it to run on their platforms.

My apologies for not mentioning this before, but these are platforms
that are not widely available yet.  As far as I know they will not be
able to use older kernels at all, even with this fix.  They are very
heavily reliant on the most recent changes to quite a few other things
such as HMAT, PPTT, and CPPC in general.  This was just one of the items
their firmware developers ran into, so a 5.3 fix is plenty.

Unless, of course, I missed your point entirely....

> Thanks,
> Rafael
> 
> 
> 


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
