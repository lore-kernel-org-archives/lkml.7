Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251D8CA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E667420659
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="AmvxbgxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfJUIo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:44:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35804 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUIo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:44:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id y6so3105583lfj.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 01:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8/hi6STco3BJnKtkPIQo5XB037qXP/mO2OC/fnkWZ4g=;
        b=AmvxbgxZ1nqplWkvkmvLg1S+3doHd3O+FoFnUODtx947C7JXyxKZdKzXZ54IPTFKwQ
         lk2r4Bw8JpfwR6ikz4X5Wx9JXMLQ4My9AM4ZPqlvln3zkn5qfMycvc54l/mKvx6Oid2k
         1GATkH6tw5bojR5GlUqxoIyfDpGcdFMFrqv/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8/hi6STco3BJnKtkPIQo5XB037qXP/mO2OC/fnkWZ4g=;
        b=geHeXmvPoUWaoX/NYQTjiPGjdU7nS1j9ttFMpHK9Xpa+5XKik71O/7hqj8Kl9ET9fP
         40BozwTJGzJUcVQJZdIfG8PZC2xxdsJ3PqA2yk0Vqvm/deAZSa8c/o2EWpM6gGi6fHPE
         J1EDGfk+3FIJYeYfzsK9/q68IAblkdMNeqNzsNo8wZ+sconEipdbr8LuqiSHs9vlIcKG
         TY7B3P2MFB2EiyHSsVkuL5GmT0WdyfsaVrIn+tsLLEVQRuY9G5YBqG6iE6IimLTyQxC/
         PxvsR6L7WBSibnIO5g0EhbSyqAqL3JdD+ftEYZPJeZZsGlKCy+HVCMRY4Bz5jUgHDv2k
         qYyw==
X-Gm-Message-State: APjAAAXtJDdmLBcfIkeV0e6nWph5UuyPYx/gFGAteeQsiYdZdV6ByXi/
        mE63E1jBKGIj5A3JtJfZup/yFtJPd9pyFHVX
X-Google-Smtp-Source: APXvYqyrWDcNM6SJ9gZHhTTWqc+blLcYki76oV/4j/OJ5eLQE2mSnwjUq8i2SjuIjDI2gDLu/mZSSg==
X-Received: by 2002:a19:c518:: with SMTP id w24mr14768885lfe.14.1571647464949;
        Mon, 21 Oct 2019 01:44:24 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id i190sm11001603lfi.45.2019.10.21.01.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 01:44:24 -0700 (PDT)
Subject: Re: [PATCH 0/7] towards QE support on ARM
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Timur Tabi <timur@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <VE1PR04MB6687DA0268FAF03D3E77A23B8F6C0@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <e02fa027-9c78-3272-d2d7-7ad2b0ed3ab0@rasmusvillemoes.dk>
 <CADRPPNREUK1SVxO4P5qb2COn+T04dtYgpVEzrveKUt16hBqAtQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <679bf33b-8c05-b77a-0cb2-d79dc5bfbe75@rasmusvillemoes.dk>
Date:   Mon, 21 Oct 2019 10:44:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADRPPNREUK1SVxO4P5qb2COn+T04dtYgpVEzrveKUt16hBqAtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2019 23.52, Li Yang wrote:
> On Fri, Oct 18, 2019 at 3:54 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> On 18/10/2019 22.16, Leo Li wrote:
>>>
>>>>
>>>> There have been several attempts in the past few years to allow building the
>>>> QUICC engine drivers for platforms other than PPC. This is (the beginning of)
>>>> yet another attempt. I hope I can get someone to pick up these relatively
>>>> trivial patches (I _think_ they shouldn't change functionality at all), and then
>>>> I'll continue slowly working towards removing the PPC32 dependency for
>>>> CONFIG_QUICC_ENGINE.
>>>
>>> Hi Rasmus,
>>>
>>> I don't fully understand the motivation of this work.  As far as I know the QUICC ENGINE is only used on PowerPC based SoCs.
>>
>> Hm, you're not the Leo Li that participated in this thread
>> <https://lore.kernel.org/lkml/AM3PR04MB11857AE8D2B0BE56121B97D391C90@AM3PR04MB1185.eurprd04.prod.outlook.com/T/#u>?
> 
> Oops, I totally forgot about this discussion which is just three years
> ago.  :)  The QE-HDLC on LS1021a is kind of a special case.
> 
>>
>>
>>  Can you give an example on how is it used on ARM system?
>>
>> LS1021A, for example, which is the one I'm aiming for getting fully
>> supported in mainline.
>> <https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/layerscape-communication-process/qoriq-layerscape-1021a-dual-core-communications-processor-with-lcd-controller:LS1021A>
>>
>> The forks at https://github.com/qoriq-open-source/linux.git have various
>> degrees of support (grep for commits saying stuff like "remove PPCisms"
>> - some versions can be found on
>> <https://lore.kernel.org/lkml/?q=remove+ppcisms>). Our current kernel is
>> based on commits from the now-vanished 4.1 branch, and unfortunately at
>> least the 4.14 branch (LSDK-18.06-V4.14) trivially doesn't build on ARM,
>> despite the PPC32 dependency having been removed from CONFIG_QUICC_ENGINE.
> 
> Can you try the 4.14 branch from a newer LSDK release?  LS1021a should
> be supported platform on LSDK.  If it is broken, something is wrong.

What newer release? LSDK-18.06-V4.14 is the latest -V4.14 tag at
https://github.com/qoriq-open-source/linux.git, and identical to the
linux-4.14 branch. And despite commit 4c33e2d0576b removing the PPC32
dependency from QUICC_ENGINE, it clearly hasn't been built on arm, since
back around v4.12, mainline's qe.c grew a call to pvr_version_is which
is ppc-only. So from that I sort of assumed that NXP had dropped trying
to support the LS1021A even in their own kernels.

In any case, we have zero interest in running an NXP kernel. Maybe I
should clarify what I meant by "based on commits from" above: We're
currently running a mainline 4.14 kernel on LS1021A, with a few patches
inspired from the NXP 4.1 branch applied on top - but also with some
manual fixes for e.g. the pvr_version_is() issue. Now we want to move
that to a 4.19-based kernel (so that it aligns with our MPC8309 platform).

>> This is just some first few steps, and I'm not claiming
>> that this is sufficient to make the QE drivers build on ARM yet. But I
>> have a customer with both mpc8309-based and ls1021a-based platforms, and
>> they want to run the same, as-close-to-mainline-as-possible, kernel on
>> both. So I will take a piecemeal approach, and try to make sure I don't
>> break the ppc boards in the process (just building and booting one board
>> is of course not sufficient, but better than nothing). Once I get to
>> actually build some of the QE drivers for ARM, I'll of course also test
>> them.
> 
> Understood.  Zhao Qiang also maintains some patches similar to your
> patchset and I think they are tested on ARM.  But the review of these
> patches from last submission didn't finish.  It looks like your
> patches are better divided but not really verified on ARM.  Zhao
> Qiang's patches are tested but maybe need some final touch for
> cleaning up.  I will let you guys decide what is the best approach to
> make this upstreamed.

Yes, as I said, I wanted to try a fresh approach since Zhao
Qiang's patches seemed to be getting nowhere. Splitting the patches into
smaller pieces is definitely part of that - for example, the completely
trivial whitespace fix in patch 1 is to make sure the later coccinelle
generated patch is precisely that (i.e., a later respin can just rerun
the coccinelle script, with zero manual fixups). I also want to avoid
mixing the ppcism cleanups with other things (e.g. replacing some
of_get_property() by of_property_read_u32()). And the "testing on ARM"
part comes once I get to actually building on ARM. But there's not much
point doing all that unless there's some indication that this can be
applied to some tree that actually feeds into Linus', which is why I
started with a few trivial patches and precisely to start this discussion.

Rasmus
