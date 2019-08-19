Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8CBC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD1720989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="DxAobbEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfHSHtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:49:17 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:37816 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfHSHtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:49:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id BA29F3FC0E;
        Mon, 19 Aug 2019 09:49:14 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=DxAobbEa;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0HAfcH4O8cUi; Mon, 19 Aug 2019 09:49:13 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id EA75B3FBF0;
        Mon, 19 Aug 2019 09:49:12 +0200 (CEST)
Received: from linlap1.host.shipmail.org (unknown [94.191.144.211])
        by mail1.shipmail.org (Postfix) with ESMTPSA id F2593360142;
        Mon, 19 Aug 2019 09:49:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566200952; bh=wYe1IOQ9iDHjA70JntB0b4pIr8deOWfZxLROEjA/YAI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DxAobbEacgLm6BMTSfEQQQITyMv9QnsVj2KK5Fur3uH7Yulj3pdcnYpNmm4UtZ1BC
         uBstnRKnNpcxdJxT06VZ5dtU/Eq3TFtkQXui0t7JGVKf0hAYNPQ+qie/r0cZ9LeSoQ
         Kg3tiimoKSiHuw10F385TRF5XHn5ROjzNIMqsZLk=
Subject: Re: [PATCH 2/4] x86/vmware: Add a header file for hypercall
 definitions
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Doug Covelli <dcovelli@vmware.com>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
 <20190818143316.4906-3-thomas_os@shipmail.org>
 <20190818201942.GC29353@zn.tnic>
 <b8875504-b112-ba5e-13d7-6abb51c01121@shipmail.org>
 <20190819062552.GC4841@zn.tnic>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <970d2bb6-ab29-315f-f5d8-5d11095859af@shipmail.org>
Date:   Mon, 19 Aug 2019 09:49:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819062552.GC4841@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/19 8:25 AM, Borislav Petkov wrote:
> On Mon, Aug 19, 2019 at 12:28:05AM +0200, Thomas Hellström (VMware) wrote:
>> Unfortunately we can't use it, because it's unconditionally set on AMD even
>> if the VMware hypervisor
>> doesn't support it (by version or by configuration).
> AMD sets it because they don't support VMCALL. Nothing stops us from
> making that conditional depending on what the hypervisor can/supports.
> I'm thinking it would be even cleaner if we use those two flags:
>
> X86_FEATURE_VMMCALL
> X86_FEATURE_VMCALL
>
> to denote hw support for either one or the other instruction and switch
> accordingly. Just like KVM does.
>
> In your case, the HV would set the preferred flag in
> arch/x86/kernel/cpu/vmware.c - just like the others do in their
> respective CPU init files - and the alternatives code would switch to it
> when it runs.
>
> Or is there more? :)

Yes, unfortunately. I agree this is is the cleanest solution and my 
first choice. It would work for VMware, but AFAICT it might break setups 
of other hypervisors running at least the vmmouse driver. Quick googling 
tells me there are likely QEMU/KVM setups that do this. My thinking is 
they would have to set X86_FEATURE_VMMCALL on AMD to get the 
kvm_hypercall right, but that would mean the vmmouse hypercall also uses 
vmmcall, which they probably haven't implemented (yet). So the safe way 
would be to use at least XF86_FEATURE_VMW_VMMCALL + XF86_FEATURE_VMCALL 
until that has happened.

/Thomas


>
> Thx.
>

