Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F6EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87250214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="MBgQktkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfH0TT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:19:59 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35818 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730479AbfH0TT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:19:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 519D04399D;
        Tue, 27 Aug 2019 21:19:57 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="MBgQktkO";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MCAvEmeSwmdr; Tue, 27 Aug 2019 21:19:56 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 00D8A43997;
        Tue, 27 Aug 2019 21:19:54 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 95EA736014E;
        Tue, 27 Aug 2019 21:19:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566933594; bh=YymLfbeahmI6clrzuJEC7JvhDkJItFo56UzBAwTeYGA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MBgQktkOd6h7LgfpfsJlvP5CakOHt/XQSCjvsttV14lJ0PuCswUuALR4lJKII3xuM
         qVpGQXN+9voeRuqU/8v+UQQVRWa5DNa0j6sQHPXvznu3YOxoUPRYvv8Ghf/L5zu5Rk
         fE+hSpum74kxBG9Mucg/TQD7jYPKj/kh7AouQekE=
Subject: Re: [PATCH v2 1/4] x86/vmware: Update platform detection code for
 VMCALL/VMMCALL hypercalls
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        dri-devel@lists.freedekstop.org, Doug Covelli <dcovelli@vmware.com>
References: <20190823081316.28478-1-thomas_os@shipmail.org>
 <20190823081316.28478-2-thomas_os@shipmail.org>
 <20190827125636.GE29752@zn.tnic>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <6bd6a477-17b1-20a3-79d6-9aee4f050244@shipmail.org>
Date:   Tue, 27 Aug 2019 21:19:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190827125636.GE29752@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing, Borislav. Comments inline.

On 8/27/19 2:56 PM, Borislav Petkov wrote:

> On Fri, Aug 23, 2019 at 10:13:13AM +0200, Thomas Hellström (VMware) wrote:
>
>> +
>> +#define VMWARE_CMD(cmd, eax, ebx, ecx, edx) do {		\
>> +	switch (vmware_hypercall_mode) {			\
>> +	case CPUID_VMWARE_FEATURES_ECX_VMCALL:			\
>> +		VMWARE_VMCALL(cmd, eax, ebx, ecx, edx);		\
>> +		break;						\
>> +	case CPUID_VMWARE_FEATURES_ECX_VMMCALL:			\
>> +		VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx);	\
>> +		break;						\
>> +	default:						\
> Please integrate scripts/checkpatch.pl into your patch creation
> workflow. Some of the warnings/errors *actually* make sense:
>
> WARNING: Possible switch case/default not preceded by break or fallthrough comment
> #110: FILE: arch/x86/kernel/cpu/vmware.c:81:
> +       case CPUID_VMWARE_FEATURES_ECX_VMMCALL:                 \
>
> WARNING: Possible switch case/default not preceded by break or fallthrough comment
> #113: FILE: arch/x86/kernel/cpu/vmware.c:84:
> +       default:
>
> In this case, we're going to enable -Wimplicit-fallthrough by default at
> some point.

We *do* have checkpatch.pl in the workflow. In this case I figured the 
warnings actually didn't make sense. There are breaks present and 
-Wimplicit-fallthrough doesn't complain...


	(unsigned int) vmware_hypercall_mode);

> Is that supposed to be debug output? If so, pr_dbg().

This is intentionally intended to be part of the initial output.

>
>> +
>>   			return CPUID_VMWARE_INFO_LEAF;
>> +		}
>>   	} else if (dmi_available && dmi_name_in_serial("VMware") &&
>>   		   __vmware_platform())
> What sets vmware_hypercall_mode in this case? Or is the 0 magic to mean,
> use the default: VMWARE_PORT inl call?

Yes, Perhaps I should add a comment about that.

>
> Also, you could restructure that function something like this to save yourself
> an indentation level or two and make it more easily readable:
>
> static uint32_t __init vmware_platform(void)
> {
>          unsigned int hyper_vendor_id[3];
>          unsigned int eax;
>
>          if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
>                  if (dmi_available && dmi_name_in_serial("VMware") && __vmware_platform())
>                          return 1;
>          }
>
>          cpuid(CPUID_VMWARE_INFO_LEAF, &eax, &hyper_vendor_id[0],
>                &hyper_vendor_id[1], &hyper_vendor_id[2]);
>
>          if (!memcmp(hyper_vendor_id, "VMwareVMware", 12)) {
>                  if (eax >= CPUID_VMWARE_FEATURES_LEAF)
>                          vmware_hypercall_mode = vmware_select_hypercall();
>
>                  pr_info("hypercall mode: 0x%02x\n", (unsigned int) vmware_hypercall_mode);
>
>                  return CPUID_VMWARE_INFO_LEAF;
>          }
>          return 0;
> }
>
Sure, I'll add that as a separate patch.

For the other comments, I'll fix up and respin.

Thanks,

Thomas


