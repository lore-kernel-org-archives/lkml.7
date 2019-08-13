Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E4EC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C15206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfHMOA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:00:59 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36163 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfHMOA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:00:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id k18so40660037otr.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 07:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Idmq9Ela+dAzEHfkXXgCpLtAAlGcGfcAq5nVbCa7csQ=;
        b=TdU0KTjRkGrUcjmvz3eeCllBmGBm923N/a+ZZllPFJ15WHkv0newFRDcNim+XPmOeL
         GqilwoSvPjPul9fwkv56+cselT6wTeVntMtTUM7cBLrWlhQovaCYYbTGVPbBSKFffuZo
         829tWqZM6CVzHrvR2ElcRLxLFnoSmd7eTwxhw5EBJKmKyilSFA95uDnGBnhRwg9QjyrB
         ZZL3RL5WDBD09DYqBx9UVZWdZD+FwIrTV6jvii3UKZ1GmOoRGmFZLzpJUNY9HLnvuAIV
         PQKoSeJfKnx3YWmur2cXVAckCBonvZhOFJauz9kgkst8LHI3uH3gbfWuPepVMlB3a1wU
         V6/Q==
X-Gm-Message-State: APjAAAW1wIsRTMS8j7rzR8/Dfsjf3CEJAFNE+mSjIrIeyc7tJ0yQ+qTK
        LzToVw38Tn2P4FufZlYo4HW0IA==
X-Google-Smtp-Source: APXvYqxcHGhMgSCYok78PR7yvPzptpT3YD5UEkb319vYu7Xf5HBHeeR+wgip9mNwQL4ltLXlzzt+uw==
X-Received: by 2002:a02:37c6:: with SMTP id r189mr32472750jar.118.1565704858100;
        Tue, 13 Aug 2019 07:00:58 -0700 (PDT)
Received: from masetto.ahs3 (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id v13sm10600441iol.60.2019.08.13.07.00.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 07:00:57 -0700 (PDT)
Reply-To: ahs3@redhat.com
Subject: Re: [PATCH] ACPI / CPPC: do not require the _PSD method when using
 CPPC
To:     linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
References: <20190805170338.29493-1-ahs3@redhat.com>
From:   Al Stone <ahs3@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d60f5bed-ca91-fc72-2e4d-309fb8f42960@redhat.com>
Date:   Tue, 13 Aug 2019 08:00:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805170338.29493-1-ahs3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/19 11:03 AM, Al Stone wrote:
> According to the ACPI 6.3 specification, the _PSD method is optional
> when using CPPC.  The underlying assumption appears to be that each CPU
> can change frequency independently from all other CPUs; _PSD is provided
> to tell the OS that some processors can NOT do that.
> 
> However, the acpi_get_psd() function returns -ENODEV if there is no _PSD
> method present, or an ACPI error status if an error occurs when evaluating
> _PSD, if present.  This essentially makes _PSD mandatory when using CPPC,
> in violation of the specification, and only on Linux.
> 
> This has forced some firmware writers to provide a dummy _PSD, even though
> it is irrelevant, but only because Linux requires it; other OSPMs follow
> the spec.  We really do not want to have OS specific ACPI tables, though.
> 
> So, correct acpi_get_psd() so that it does not return an error if there
> is no _PSD method present, but does return a failure when the method can
> not be executed properly.  This allows _PSD to be optional as it should
> be.
> 
> Signed-off-by: Al Stone <ahs3@redhat.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> ---
>  drivers/acpi/cppc_acpi.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 15f103d7532b..e9ecfa13e997 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -365,10 +365,13 @@ static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
>  	union acpi_object  *psd = NULL;
>  	struct acpi_psd_package *pdomain;
>  
> -	status = acpi_evaluate_object_typed(handle, "_PSD", NULL, &buffer,
> -			ACPI_TYPE_PACKAGE);
> -	if (ACPI_FAILURE(status))
> -		return -ENODEV;
> +	if (acpi_has_method(handle, "_PSD")) {
> +		status = acpi_evaluate_object_typed(handle, "_PSD", NULL,
> +						    &buffer, ACPI_TYPE_PACKAGE);
> +		if (ACPI_FAILURE(status))
> +			return -ENODEV;
> +	} else
> +		return 0;		/* _PSD is optional */
>  
>  	psd = buffer.pointer;
>  	if (!psd || psd->package.count != 1) {
> 

Rafael,

Any other comments?  Would it be possible to pull this into an -rc?
I'd really like to avoid anyone else having to ship Linux-specific
DSDTs and SSDTs.

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
