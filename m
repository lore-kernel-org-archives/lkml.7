Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95678C3A5A3
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6293820870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="jfa8ujf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfHXVgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 17:36:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39725 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbfHXVgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 17:36:33 -0400
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3281:e7ea:4585:74bd:2ff0])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x7OLZlZI1693806
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 24 Aug 2019 14:35:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x7OLZlZI1693806
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019081901; t=1566682550;
        bh=2gQzKPo4WrQnlvDY26oni/RH8wMNjOHmljo2FnAYqSQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jfa8ujf6Bo1t5AdTUjdpXdAFm8XuC39+BjMNqj+VUJ3I53oJo8pLL8aqGEuCFFlpF
         mwuiVt5W4twlgKdrwazMwd/61MKfTF4NAY11XuCMz/Ej1knheH/Kqod+N3MIPMcnIK
         cktpL1xZjdX5eoOtI9MknxvSwHVr1fI8qBSoNC3LNQYeNSnmeD84o3whZzxDwNPfwG
         gh/3M8807qmCeoj0hhRip3VMQkcUT2k058MR72yR9RAETn0/4FIKzK3WhJgnwoAar5
         HnEPzDPWJwws1MytshNO8EJOiF+QUagVUh1dO3bzXlhf83JKnsGzcKS+aVx/usQ/fp
         EvEO265n3vcaQ==
Subject: Re: [tip: x86/urgent] x86/CPU/AMD: Clear RDRAND CPUID bit on AMD
 family 15h/16h
To:     Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Chen Yu <yu.c.chen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <7543af91666f491547bd86cebb1e17c66824ab9f.1566229943.git.thomas.lendacky@amd.com>
 <156652264945.9541.4969272027980914591.tip-bot2@tip-bot2>
 <20190824181929.GA18551@amd>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <409703ae-6d70-3f6a-d6fc-b7dada3c2797@zytor.com>
Date:   Sat, 24 Aug 2019 14:35:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824181929.GA18551@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/19 11:19 AM, Pavel Machek wrote:
> On Fri 2019-08-23 01:10:49, tip-bot2 for Tom Lendacky wrote:
>> The following commit has been merged into the x86/urgent branch of tip:
>>
>> Commit-ID:     c49a0a80137c7ca7d6ced4c812c9e07a949f6f24
>> Gitweb:        https://git.kernel.org/tip/c49a0a80137c7ca7d6ced4c812c9e07a949f6f24
>> Author:        Tom Lendacky <thomas.lendacky@amd.com>
>> AuthorDate:    Mon, 19 Aug 2019 15:52:35 
>> Committer:     Borislav Petkov <bp@suse.de>
>> CommitterDate: Mon, 19 Aug 2019 19:42:52 +02:00
>>
>> x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family 15h/16h
>>
>> There have been reports of RDRAND issues after resuming from suspend on
>> some AMD family 15h and family 16h systems. This issue stems from a BIOS
>> not performing the proper steps during resume to ensure RDRAND continues
>> to function properly.
> 
> There are quite a few unanswered questions here.
> 
> a) Is there/should there be CVE for this?
> 
> b) Can we perform proper steps in kernel, thus making RDRAND usable
> even when BIOS is buggy?
> 

The kernel should at least be able to set its internal "CPUID" bit, visible
through /proc/cpuinfo.

	-hpa

