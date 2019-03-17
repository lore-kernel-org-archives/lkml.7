Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE40C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1F321019
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="uitkFEjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfCQPor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 11:44:47 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54922 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfCQPoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 11:44:46 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 540675C2373;
        Sun, 17 Mar 2019 16:44:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1552837484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Kpro2NFMAD0NxEc2llmKLzygnZGmnEvQNupn985gnY=;
        b=uitkFEjtDC4ABFjtaYDlGf3AtNpYqPhMuWaQwGswv4XwrpC7eb7VpPIuQRKMOi0S7tSTn+
        Pl8449HSu2pGG10ByG8ncWXk+xunPX79YexbSxqvFIpKbCroMicJakAyVfRjIfvihmcUbL
        T300wdwHpZ7YMyj3uO2PBXnbnPNeH2w=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sun, 17 Mar 2019 16:44:44 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>, julien.thierry@arm.com,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kristof Beyls <Kristof.Beyls@arm.com>,
        Peter Smith <Peter.Smith@arm.com>
Subject: Re: [PATCH 1/2] ARM: drop unnecessary WASM
In-Reply-To: <CAKwvOdnb58nGXdweWTobGjqry7=9ZmfnMWnjTn8uHKt=Z5iabQ@mail.gmail.com>
References: <13835555f8ef44b21d1b7ddfe1c4203d0981f77e.1551824161.git.stefan@agner.ch>
 <cdf451c0-3947-9be1-3bee-2366577c4c5f@arm.com>
 <CAKwvOdnb58nGXdweWTobGjqry7=9ZmfnMWnjTn8uHKt=Z5iabQ@mail.gmail.com>
Message-ID: <e78bcb6154a5bf5f791fe29b40188ba0@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.03.2019 01:47, Nick Desaulniers wrote:
> On Tue, Mar 5, 2019 at 3:39 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> Hi Stefan,
>>
>> On 2019-03-05 10:18 pm, Stefan Agner wrote:
>> > The W macro for generating wide instructions when targeting Thumb-2
>> > is not required for the preload data instructions (pld, pldw) since
>> > they are only available as wide instructions. The GNU assembler seems
>> > to work with or without the .w appended when compiling an Thumb-2
>> > kernel. However, Clang's integrated assembler does not consider the
>> > .w variants as valid instructions:
>> >
>> >    ./arch/arm/include/asm/processor.h:133:5: error: invalid instruction
>> >                            "pldw.w\t%a0 \n"
>> >                             ^
>> >    <inline asm>:2:1: note: instantiated into assembly here
>> >    pldw.w  [r0]
>> >    ^
>> >    1 error generated.
>>
>> Have you filed a bug against Clang for that? Something like "pldwal.w"
> 
> Yes; please.  For each deficiency you find, please file a bug.  We're
> working on identifying what's missing from Clang's integrated
> assembler support.  Given the list of issues, it's easier to estimate
> how much effort is needed, which helps us allocate resources towards
> fixing those issues better.
> 
> It would be good to know if pldw.w is valid under UAL or not.

As far as I understand the Arm ARM it is valid under UAL.

Reported a bug in LLVM's bug tracker:
https://bugs.llvm.org/show_bug.cgi?id=40972

Will send a v2 patch mentioning this is really a work around for LLVM
and link to the bug report.

> 
> Hopefully, the ARM kernel team can stress the importance of assembler
> support for their ISA to their LLVM team.

--
Stefan
