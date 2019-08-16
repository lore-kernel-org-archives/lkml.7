Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA89BC3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A030721721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565968814;
	bh=m1nzqTJ9sYzFdCEmJzo+71brG5gCoP64nZb+T+9Ji5U=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=v4McdvrP8QF1LLs4gOIkHqD1GCQZ1jD14UUDDgo9f5SJ+aMjMNZuawkGGIsODtBIa
	 Op38vCUR1q77s9f+YmLH1C7V/ELUv5uPc5qHFoxSH2NZPkbUNXUmIQkszWWWZyKE3t
	 E4LDnxAt6mAcrOuVvByIAVqKwzDhEnwHzitpEues=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfHPPUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:20:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34398 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfHPPUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 11:20:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id d3so720158plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 08:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uq/BinxihOIL92bxz7COo1OH8fndOXzflXkJ66CJ19A=;
        b=CtO92iiXc5Y6GCMFyP81KJqGtx3cMSHQcnbT4wPnCaWGkHOsjhN1O9X8nQWN/jBsE4
         nqFHNrGt94dG5lBLPnsNI572yKNVPgT89rkK/8rhSAipEeZ5CvH/MJO6A3Q9YVqS0mk/
         i8DC+ysqgNnB/DRACIdi7wJ9yGNASuop3y53MFE/C14nrOeTzMoAr5oByXeO/u332OAJ
         GjKAqcCWJhReVLCuCNJbdyGCU/QugUxaadZYCLvLBE069kqCBZyELlAJWcd6uac2owo4
         DylXP6CNruV5jAzBdjOPxPZv1f7Yt7584rIenB9imnxQ1N4iQJEz31pp9I+n7T+D45iq
         ONqQ==
X-Gm-Message-State: APjAAAU/+x/X8pk0MPMfvADj1/s2T793JW2eowus2iOqDAkIoShh+Yib
        JR0PZdcTyZ0TBMZ/Lh3zgQI/3w==
X-Google-Smtp-Source: APXvYqzFpiOvuE1Nb1T9iFvZuHhM5Z6kiBulQJFo5iggAoyERZSO6STGCj2ft+AMElV8wMfVwqHgvg==
X-Received: by 2002:a17:902:7d84:: with SMTP id a4mr9646776plm.90.1565968812494;
        Fri, 16 Aug 2019 08:20:12 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id h9sm4839072pgk.10.2019.08.16.08.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 08:20:11 -0700 (PDT)
Subject: Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family 15h/16h
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <87dacbb4-1733-fd70-1356-7f8d5c69c029@kernel.org>
Date:   Fri, 16 Aug 2019 08:19:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/19 2:17 PM, Lendacky, Thomas wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> There have been reports of RDRAND issues after resuming from suspend on
> some AMD family 15h and family 16h systems. This issue stems from BIOS
> not performing the proper steps during resume to ensure RDRAND continues
> to function properly.

Can you or someone from AMD document *precisely* what goes wrong here? 
The APM is crystal clear:

Hardware modifies the CF flag to indicate whether the value returned in 
the destination register is valid. If CF = 1, the value is valid. If CF 
= 0, the value is invalid.

If BIOS screws up and somehow RDRAND starts failing and returning CF = 
0, then I think it's legitimate to call it a BIOS bug.  Some degree of 
documentation would be nice, as would a way for BIOS to indicate to the 
OS that it does not have this bug.

But, from the reports, it sounds like RDRAND starts failing, setting CF 
= 1, and returning 0xFFFF.... in the destination register.  If true, 
then this is, in my book, a severe CPU bug.  Software is supposed to be 
able to trust that, if RDRAND sets CF = 1, the result is a 
cryptographically secure random number, even if everything else in the 
system is actively malicious.  On a SEV-ES system, this should be 
considered a security hole -- even if the hypervisor and BIOS collude, 
RDRAND in the guest should work as defined by the manual.

So, can you clarify what is actually going on?  And, if there is an 
issue where the CPU does not behave as documented in the APM, and AMD 
issue an erratum?  And ideally also fix it in microcode or in a stepping 
and give an indication that the issue is fixed?
