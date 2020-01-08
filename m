Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619E9C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350BD20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emypeople.us header.i=@emypeople.us header.b="D0iHptDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgAHBaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:30:20 -0500
Received: from mail.emypeople.net ([216.220.167.73]:36211 "EHLO
        mail.emypeople.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgAHBaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:30:19 -0500
DKIM-Signature: a=rsa-sha256; t=1578447018; x=1579051818; s=mail; d=emypeople.us; c=relaxed/relaxed; v=1; bh=22iFXTU4vD4bDSj9yiGlaXhxfpRMPEDgH7sSp1HcqfQ=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=D0iHptDqb0nyOGjN68cPlUFSIQOZSDQ7hfW2fNmuDTvbhiRDpaLQIwBtl/TjDtfIaAyqc5F/N2dfNNS+kzxvaZXeJt/5iCA+w2fEcQeDL5GeyWb52On4e6dXOVb/pdppkPMAWsrgcgMh0OD7O88TOYkx+zS+b/RzVQkhoRoCvrA=
Received: from [192.168.1.2] ([10.12.2.17])
        by mail.emypeople.net (12.2.0 build 2 RHEL7 x64) with ASMTP id 202001072030183254;
        Tue, 07 Jan 2020 20:30:18 -0500
Subject: Re: [PATCH] x86/boot: fix cast to pointer compiler warning
To:     Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        Matthew Garrett <mjg59@google.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Josh Boyer <jwboyer@redhat.com>
References: <8dd48f03-4d7c-25bb-2a2f-27461c0004ba@211mainstreet.net>
 <0be4cdcc-a1f8-36a9-69f2-bac02c8f9a9f@infradead.org>
From:   Edwin Zimmerman <edwin@211mainstreet.net>
Message-ID: <049a6ca0-5f0d-0187-85d4-6d5f1e78af55@211mainstreet.net>
Date:   Wed, 8 Jan 2020 01:30:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0be4cdcc-a1f8-36a9-69f2-bac02c8f9a9f@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/2020 8:18 PM, Randy Dunlap wrote:
> On 1/7/20 9:38 PM, Edwin Zimmerman wrote:
>> Fix cast-to-pointer compiler warning
>>
>> arch/x86/boot/compressed/acpi.c: In function ‘get_acpi_srat_table’:
>> arch/x86/boot/compressed/acpi.c:316:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>> rsdp = (struct acpi_table_rsdp *)get_cmdline_acpi_rsdp();
>>         ^
>> Fixes: 41fa1ee9c6d6 ("acpi: Ignore acpi_rsdp kernel param when the kernel has been locked down")
>> Signed-off-by: Edwin Zimmerman <edwin@211mainstreet.net>
>> ---
>> arch/x86/boot/compressed/acpi.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
>> index 25019d42ae93..5d2568066d58 100644
>> --- a/arch/x86/boot/compressed/acpi.c
>> +++ b/arch/x86/boot/compressed/acpi.c
>> @@ -313,7 +313,7 @@ static unsigned long get_acpi_srat_table(void)
>> * stash this in boot params because the kernel itself may have
>> * different ideas about whether to trust a command-line parameter.
>> */
>> - rsdp = (struct acpi_table_rsdp *)get_cmdline_acpi_rsdp();
>> + rsdp = (struct acpi_table_rsdp *)(long)get_cmdline_acpi_rsdp();
>> if (!rsdp)
>> rsdp = (struct acpi_table_rsdp *)(long)
>>
> Lots of whitespace damage.  Probably your email client or some
> intermediary.
Email client, sorry.  Will resend.
