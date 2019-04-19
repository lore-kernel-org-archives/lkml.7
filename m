Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06254C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C063421736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555707791;
	bh=58oPZUXjhRkw7XY+ljE3W49BNutBG0Z7wXR2Np07/u8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=KXXnn9uKsdk68tyXoy9u5VQEoOTshP1GxUJmfP1M0zjEagJBackb6lXc8EKuAlJhD
	 +dWVN5m7A1jtunIxydpVBgE5pUVFSw5SH+ZlSnmwwwE4VP0OEGtjbvQ/sC2JvR6Vu+
	 Be052g7AwQU2X9iMaRJJehiToBcxXTpsuqbtTQMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfDSVDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfDSVDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:03:10 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEF692171F;
        Fri, 19 Apr 2019 21:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555707789;
        bh=58oPZUXjhRkw7XY+ljE3W49BNutBG0Z7wXR2Np07/u8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C/bHvNaHcIXeWTwuL4x1cs1/7dBlY4x29liDaN4LHtUSDwBkqLePe1fjMRyPC902Z
         QcPnNI/CHYJAbns+AYhpf3gHKMV4LkxxpMhvkhYOdbCvQlAw1aTYZyo6IcG3kIIdeg
         DnZ/rdq1r9fBVfBhj7uYsxuSOvABq7i/OUZpeur0=
Subject: Re: [PATCH for 5.1 3/3] rseq/selftests: Adapt number of threads to
 the number of detected cpus
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
 <1444419838.71.1555677682502.JavaMail.zimbra@efficios.com>
 <1266612341.87.1555678507226.JavaMail.zimbra@efficios.com>
 <614774674.134.1555681346941.JavaMail.zimbra@efficios.com>
 <1863599735.141.1555681723685.JavaMail.zimbra@efficios.com>
 <6ba0796c-8a96-f797-265c-37bfb9b4bb71@kernel.org>
 <580328197.148.1555684824260.JavaMail.zimbra@efficios.com>
 <cfcbace7-363d-e45e-11da-8efb200783b7@kernel.org>
 <1136505826.203.1555707541777.JavaMail.zimbra@efficios.com>
From:   shuah <shuah@kernel.org>
Message-ID: <45ecf26a-a2f4-fa86-a252-e1d9b3bc4224@kernel.org>
Date:   Fri, 19 Apr 2019 15:03:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1136505826.203.1555707541777.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/19 2:59 PM, Mathieu Desnoyers wrote:
> ----- On Apr 19, 2019, at 2:57 PM, shuah shuah@kernel.org wrote:
> [...]
>> Should I drop this patch that is currently in linux-kseltest next? Just
>> confirming if your new patch is supposed to be applied on top of this
>> one or not?
> 
> We should keep this patch in linux-kselftest next. The fix applies on top
> of it.
> 

Will do. Thanks for a quick response.

-- Shuah
