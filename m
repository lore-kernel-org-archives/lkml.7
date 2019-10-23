Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DD6CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27FC21A4A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="NcRpefvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406932AbfJWPqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:46:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38681 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406920AbfJWPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:46:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so10273936plq.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=taGR1hXeprMDq9i0gfttAyR0IxboixYe4H+G2i5Hoac=;
        b=NcRpefvb1LSd3wZe9Ri0T4pGb3LfDRR/OAaZt47YPHu1Vf4KKIf5Y4N/sgwPlyusuc
         aJUHs5KB128JF/OYIKkkRlUdIAOPxe2KcUDQUbHIq0aHuklTfHTyHirPt9pOP6MhyfKN
         5sM6NIT0hyPMfqCkVq/EiG9zBZOZPDpC4xBcZAtMibb9E7HbDHJ+jyTvSFvDwGiUmzuz
         NSVIO8Peedm1gMzE21bBesLSiAYKytCnh++xF/TE5nciyKMMh9E2d8PzLOYGFjTDfm42
         NV0nKUqnbGJIUV+oUcGNOHAuPx+BhHH2Rk74GSbhCJ0FqNqIqkWfJeT48JZ7y+t1k2dR
         RZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=taGR1hXeprMDq9i0gfttAyR0IxboixYe4H+G2i5Hoac=;
        b=gSJeTX8/RKjRwhcesZM8VKdGx73RF62enfLIyoMZ9ZkqbsX5DP9hF/el55NEd71emD
         JtsJevZHUz4CahW+qOl5J0z+6qQLehE877opLmQzDnO5hER9+R5yhPtwkOPv78itRfJE
         1UVym+o1kxP9annw63UJvLof5y0coQC+sq738fz9Rm9Blom4jiCT6H792hm9qrOg9gis
         7PpZXGSFaZ+Jsx2jRZ1DjmoSZ+F97YKcFna0DVAicccOtWu7hBjdsA3M9+hM13VAQyUz
         lEFtzgV4YJMTR/nu/HtgfHRvWxAj7KgDfSriUvajG0/Ly53OYLu8d1KLx9xNEjRkgKiL
         JUwA==
X-Gm-Message-State: APjAAAXl9Gar5/0Ze8Q3nqeSHTNb2i0YS/+vwHoGq4K473RT1z08PRSb
        eBzmbYRqLaOr2uhLOa62izWh5h7NJxLA4f5I
X-Google-Smtp-Source: APXvYqwZXdRubSZxv5CthIXLtpLOtYIUgrt/8HRGVXgNRzvU52NpOQvu6miN7xfYP04v4ZpUKJ+C0g==
X-Received: by 2002:a17:902:8bc4:: with SMTP id r4mr9984701plo.341.1571845570760;
        Wed, 23 Oct 2019 08:46:10 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id h8sm8496083pjp.1.2019.10.23.08.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 08:46:10 -0700 (PDT)
Subject: Re: linux-next: Tree for Oct 23
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191023155519.2d6765d4@canb.auug.org.au>
 <d1a57062-24cb-e9c4-e1db-07406b1cea9a@hisilicon.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <d1a0c336-1973-5c6d-90c0-9bb64e5a922c@android.com>
Date:   Wed, 23 Oct 2019 08:46:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d1a57062-24cb-e9c4-e1db-07406b1cea9a@hisilicon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/19 11:05 PM, Shaokun Zhang wrote:
> +Cc: Mark Salyzyn
>
> There is a compiler failure on arm64 platform, as follow:
> zhangshaokun@ubuntu:~/linux-next$ make -j64
>    CALL    scripts/atomic/check-atomics.sh
>    CC      arch/arm64/kernel/asm-offsets.s
> In file included from ./include/linux/sysctl.h:30:0,
>                   from ./include/linux/umh.h:9,
>                   from ./include/linux/kmod.h:9,
>                   from ./include/linux/module.h:13,
>                   from ./include/linux/acpi.h:29,
>                   from ./include/acpi/apei.h:9,
>                   from ./include/acpi/ghes.h:5,
>                   from ./include/linux/arm_sdei.h:8,
>                   from arch/arm64/kernel/asm-offsets.c:10:
> ./include/uapi/linux/sysctl.h:561:29: error: expected ‘,’ or ‘}’ before ‘__attribute__’
>    NET_IPV6_TEMP_PREFERED_LFT __attribute__((deprecated)) = /* NOTYPO */
>                               ^
> scripts/Makefile.build:99: recipe for target 'arch/arm64/kernel/asm-offsets.s' failed
> make[1]: *** [arch/arm64/kernel/asm-offsets.s] Error 1
> Makefile:1108: recipe for target 'prepare0' failed
> make: *** [prepare0] Error 2
>
> It's the commit <79f0cf35dccb> ("treewide: cleanup: replace prefered with preferred").
Ack, will split up patch and resubmit, compiler differences make that 
part of the cleanup unworkable.
>
> Thanks,
> Shaokun
>
>
> On 2019/10/23 12:55, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20191022:
>>
>> Non-merge commits (relative to Linus' tree): 5530
>>   5340 files changed, 192671 insertions(+), 90844 deletions(-)
>>
>> ----------------------------------------------------------------------------
>>
>> I have created today's linux-next tree at
>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
>> are tracking the linux-next tree using git, you should not use "git pull"
>> to do so as that will try to merge the new linux-next release with the
>> old one.  You should use "git fetch" and checkout or reset to the new
>> master.
>>
>> You can see which trees have been included by looking in the Next/Trees
>> file in the source.  There are also quilt-import.log and merge.log
>> files in the Next directory.  Between each merge, the tree was built
>> with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
>> multi_v7_defconfig for arm and a native build of tools/perf. After
>> the final fixups (if any), I do an x86_64 modules_install followed by
>> builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
>> ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
>> and sparc64 defconfig. And finally, a simple boot test of the powerpc
>> pseries_le_defconfig kernel in qemu (with and without kvm enabled).
>>
>> Below is a summary of the state of the merge.
>>
>> I am currently merging 310 trees (counting Linus' and 78 trees of bug
>> fix patches pending for the current merge release).
>>
>> Stats about the size of the tree over time can be seen at
>> http://neuling.org/linux-next-size.html .
>>
>> Status of my local build tests will be at
>> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
>> advice about cross compilers/configs that work, we are always open to add
>> more builds.
>>
>> Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
>> Gortmaker for triage and bug fixes.
>>
