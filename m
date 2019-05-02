Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83260C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379A121479
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h8z77/Mb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEBUJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 16:09:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35770 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEBUJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 16:09:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so4230897wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 13:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HW4SbB3KBHe9bRL0VlP/PJqEOuDxOC8P1nukhCffYWo=;
        b=h8z77/MbeE7n7BavEdaP0BOUlwpzvJ5jtp6tgzNMaP8N28RJMK2COb25uAt1EOlnPx
         OY428iKmJccCuMsthVYwfLS2H3LYKHMBOL/VWbgP/FdcyH8V47lHxwM3Rp8CKHraloQA
         huDcFlE2k5PIm12rTAN/BwAERxq0LAfrE08nricZtSAK2Jrsu8e+q6RrpBXX4tdlLvwF
         8NGnTW9iEAh/7O4PgMI8qGRUNDJ7FHSyeeyFOhFGGYdz9V5JX7U4hOf/vOn7Ocjm0kN4
         0tX/rA08xUaYDPh+J7tQSRL0n7SKTt3bMtB/HtfgXCNHuMB+4oUPvvKPOh+zAyYQjgtR
         KUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HW4SbB3KBHe9bRL0VlP/PJqEOuDxOC8P1nukhCffYWo=;
        b=c9Nl8Uu4m32KmHp2OO/EfRyvP6CR/pC9ygTebQySdJlPkltKuL5oWy5T+qkpNNt4iO
         OD4aOPgc384AwgK0dujfRudFGQeuV0E/SRHceUJFcdwxIZUejNlA/vSvYjujrTswIrqG
         8VFmF+87/43FJnTM7vH0dWeAZchvVaugI6ftflHbXIP+iPUwgLes3147k9LyfNrlyjOV
         VUeF/jz34yyJIYR7l/eabu7s8/hUYlL1/T0SDdtcr6ZqwuTHnJi1+K7zsGykwUQWrLG5
         ZT3F6zwsxRCUUG+LrVi05X3tDxAQbD/skTco1OlWBeLMr+ueL23avutnHmZ1IHCAySIq
         zK1w==
X-Gm-Message-State: APjAAAX36WwoC2C6azn1V9HpvcAntaMC0eWw5VzkYZ5KM2l7bZB+h8iW
        Kvi3GEItUR+iaFFnV/bKDZc1FLP1Kdk=
X-Google-Smtp-Source: APXvYqxlo8jyi6vBQeh19cyTKM4Pg+7rPPUD0TfdgOYYMRiMVuhSDkjvgWxDKe326k36jjpQmD1FmQ==
X-Received: by 2002:a1c:2109:: with SMTP id h9mr3695160wmh.68.1556827792261;
        Thu, 02 May 2019 13:09:52 -0700 (PDT)
Received: from [192.168.0.41] (71.193.95.92.rev.sfr.net. [92.95.193.71])
        by smtp.googlemail.com with ESMTPSA id a22sm103477wmb.47.2019.05.02.13.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 13:09:51 -0700 (PDT)
Subject: Re: linux-next: Tree for May 2
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, maxime.ripard@bootlin.com,
        andre.przywara@arm.com, samuel@sholland.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190502201028.707453d8@canb.auug.org.au>
 <CADYN=9LHJpDyvA=3wkcqdS5f3kahD0vdXFY415k8UmLHMDzL+Q@mail.gmail.com>
 <20190502190845.GA19485@archlinux-i9>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0a28f5b8-296a-451c-c2f4-c0057833fb00@linaro.org>
Date:   Thu, 2 May 2019 22:09:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502190845.GA19485@archlinux-i9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2019 21:08, Nathan Chancellor wrote:
> On Thu, May 02, 2019 at 09:00:58PM +0200, Anders Roxell wrote:
>> On Thu, 2 May 2019 at 12:10, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>
>>> Hi all,
>>>
>>> Changes since 20190501:
>>>
>>> The kbuild tree gained a conflict against Linus' tree.
>>>
>>> The f2fs tree gained a build failure for which I applied a patch.
>>>
>>> The net-next tree gained a conflict against the net tree.
>>>
>>> The pidfd tree gained a conflict against the kbuild tree.
>>>
>>> The akpm-current tree gained a conflict against the parisc-hd tree.
>>>
>>> Non-merge commits (relative to Linus' tree): 10425
>>>  10206 files changed, 459072 insertions(+), 301989 deletions(-)
>>>
>>> ----------------------------------------------------------------------------
>>>
>>> I have created today's linux-next tree at
>>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
>>> are tracking the linux-next tree using git, you should not use "git pull"
>>> to do so as that will try to merge the new linux-next release with the
>>> old one.  You should use "git fetch" and checkout or reset to the new
>>> master.
>>>
>>> You can see which trees have been included by looking in the Next/Trees
>>> file in the source.  There are also quilt-import.log and merge.log
>>> files in the Next directory.  Between each merge, the tree was built
>>> with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
>>> multi_v7_defconfig for arm and a native build of tools/perf. After
>>> the final fixups (if any), I do an x86_64 modules_install followed by
>>> builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
>>> ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
>>> and sparc64 defconfig. And finally, a simple boot test of the powerpc
>>> pseries_le_defconfig kernel in qemu (with and without kvm enabled).
>>>
>>> Below is a summary of the state of the merge.
>>>
>>> I am currently merging 298 trees (counting Linus' and 69 trees of bug
>>> fix patches pending for the current merge release).
>>>
>>> Stats about the size of the tree over time can be seen at
>>> http://neuling.org/linux-next-size.html .
>>>
>>> Status of my local build tests will be at
>>> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
>>> advice about cross compilers/configs that work, we are always open to add
>>> more builds.
>>>
>>> Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
>>> Gortmaker for triage and bug fixes.

[ ... ]

>> Hi, I've noticed a build error if CONFIG_50I_ERRATUM_UNKNOWN1=y is enabled:
>>
>> ../drivers/clocksource/arm_arch_timer.c:402:20: error: redefinition of
>> â€˜sun50i_a64_read_cntpct_el0â€™
>>  static u64 notrace sun50i_a64_read_cntpct_el0(void)
>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../drivers/clocksource/arm_arch_timer.c:360:20: note: previous
>> definition of â€˜sun50i_a64_read_cntpct_el0â€™ was here
>>  static u64 notrace sun50i_a64_read_cntpct_el0(void)
>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../drivers/clocksource/arm_arch_timer.c:407:20: error: redefinition of
>> â€˜sun50i_a64_read_cntvct_el0â€™
>>  static u64 notrace sun50i_a64_read_cntvct_el0(void)
>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../drivers/clocksource/arm_arch_timer.c:365:20: note: previous
>> definition of â€˜sun50i_a64_read_cntvct_el0â€™ was here
>>  static u64 notrace sun50i_a64_read_cntvct_el0(void)
>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../drivers/clocksource/arm_arch_timer.c:412:20: error: redefinition of
>> â€˜sun50i_a64_read_cntp_tval_el0â€™
>>  static u32 notrace sun50i_a64_read_cntp_tval_el0(void)
>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../drivers/clocksource/arm_arch_timer.c:370:20: note: previous
>> definition of â€˜sun50i_a64_read_cntp_tval_el0â€™ was here
>>  static u32 notrace sun50i_a64_read_cntp_tval_el0(void)
>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../drivers/clocksource/arm_arch_timer.c:417:20: error: redefinition of
>> â€˜sun50i_a64_read_cntv_tval_el0â€™
>>  static u32 notrace sun50i_a64_read_cntv_tval_el0(void)
>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../drivers/clocksource/arm_arch_timer.c:375:20: note: previous
>> definition of â€˜sun50i_a64_read_cntv_tval_el0â€™ was here
>>  static u32 notrace sun50i_a64_read_cntv_tval_el0(void)
>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../drivers/clocksource/arm_arch_timer.c:375:20: warning:
>> â€˜sun50i_a64_read_cntv_tval_el0â€™ defined but not used
>> [-Wunused-function]
>> ../drivers/clocksource/arm_arch_timer.c:370:20: warning:
>> â€˜sun50i_a64_read_cntp_tval_el0â€™ defined but not used
>> [-Wunused-function]
>>  static u32 notrace sun50i_a64_read_cntp_tval_el0(void)
>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> make[3]: *** [../scripts/Makefile.build:279:
>> drivers/clocksource/arm_arch_timer.o] Error 1
>> make[3]: Target '__build' not remade because of errors.
>> make[2]: *** [../scripts/Makefile.build:489: drivers/clocksource] Error 2
>>
>> I think commit c950ca8c35ee ("clocksource/drivers/arch_timer:
>> Workaround for Allwinner A64 timer instability") introduced the issue.
>>
>> Cheers,
>> Anders
> 
> It actually looks like it is the clocksource tree merge that causes it:
> 
> https://git.kernel.org/next/linux-next/c/5e70bc4029d33b14a6cee87707e7b402801ca310
> 
> Since that commit exists in two different trees.

Yes, I picked the patch and it was merged it via the tip tree [1] as
requested by Marc Zyngier [2] and notified [3].

In any case, this patch should have go through my tree initially, so if
it is found somewhere else that's wrong.

I did a respin of my branch and pushed it again in case there was
something wrong from it.

Thanks

  -- Daniel

[1] https://lkml.org/lkml/2019/3/5/274
[2] https://lkml.org/lkml/2019/1/14/122
[3] https://lkml.org/lkml/2019/1/14/381

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

