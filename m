Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C3BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD1F20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfCFXgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:36:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47525 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCFXgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:36:23 -0500
Received: from hanvin-mobl2.amr.corp.intel.com (jfdmzpr04-ext.jf.intel.com [134.134.139.73])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x26NZ67O1932541
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 6 Mar 2019 15:35:07 -0800
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
To:     Pavel Machek <pavel@ucw.cz>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, Borislav Petkov <bp@alien8.de>,
        dancol@google.com, gregkh@linuxfoundation.org,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        paulmck@linux.vnet.ibm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190306230934.GA7915@amd>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <3ada6062-d9f1-867e-828b-2796fb8d0a66@zytor.com>
Date:   Wed, 6 Mar 2019 15:35:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190306230934.GA7915@amd>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 3:09 PM, Pavel Machek wrote:
> On Fri 2019-01-18 17:55:43, Joel Fernandes wrote:
>> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>>
>> Introduce in-kernel headers and other artifacts which are made available
>> as an archive through proc (/proc/kheaders.tgz file). This archive makes
>> it possible to build kernel modules, run eBPF programs, and other
>> tracing programs that need to extend the kernel for tracing purposes
>> without any dependency on the file system having headers and build
>> artifacts.
>>
>> On Android and embedded systems, it is common to switch kernels but not
>> have kernel headers available on the file system. Raw kernel headers
>> also cannot be copied into the filesystem like they can be on other
>> distros, due to licensing and other issues. There's no linux-headers
> 
> If your licensing prevents you from having headers on the
> filesystem... then I guess you should fix the licensing.
> 
> I agree with Christoph, this looks pretty horrible.
> 									Pavel
> 

The argument that "it can be a module" is basically an admission of
failure - if it isn't part of the kernel image itself there is no
benefit over where the modules are stored, which will be *somewhere* in
the filesystem.

What I *do* think makes sense is to create an archive with this
information and stuff it in the same place as the modules. It reduces
the amount it is possible to muck it up.

	-hpa

