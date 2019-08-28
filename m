Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BF5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5682C22CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="PLFzOjVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfH1Hp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:45:29 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:39034 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfH1Hp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:45:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id ACF7F3F5B3;
        Wed, 28 Aug 2019 09:45:21 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=PLFzOjVN;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JQJY19CEXsGq; Wed, 28 Aug 2019 09:45:20 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id C1C7C3F56C;
        Wed, 28 Aug 2019 09:45:19 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 78592360206;
        Wed, 28 Aug 2019 09:45:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566978319; bh=mBkh856ME9O8BAVpJGkK0OhFC4RbDPtnfBYkUhq0j1k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PLFzOjVNUjnLtcpfuEsEUVU4TSRPOHj5Abbb1s/rqt5ayJdAApycaYedADfP0X5Xt
         70WBkqPs8tQsuW6HV41iBLAV446afqQ558z3CBmJXPIxly/mF8KpWLaBXYvcp2WyiS
         2YSypas5vCfUW+Zty1yhKvRZjydhErGlijA+yljQ=
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
Message-ID: <471e1f6b-56eb-281e-155d-3149f6915f81@shipmail.org>
Date:   Wed, 28 Aug 2019 09:45:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190827125636.GE29752@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/19 2:56 PM, Borislav Petkov wrote:
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


Hmm, we're missing a return 0; here. The number of return points and the 
moved up variable declarations worries me a little. I'll see if I can 
clean this up a bit, but would prefer to make a follow-up patch in that 
case.

/Thomas


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

