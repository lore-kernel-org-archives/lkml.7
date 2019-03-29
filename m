Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A177C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB368218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MZABh0Gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfC2SKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:10:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbfC2SKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cfnDbEyF8f3jK6rE9tvOedJ62dm6dAUPE3LAW9VXfgY=; b=MZABh0GxYIsd0IG3di5ESr7MF
        kO1b00Kb7MBoGMvrXcbbFpww+LlgET3S5/IqOTrn2i0yWF2kmNAFXCmMtNnDKMLcykhULTvjVBVRe
        s1xeA3aopEJUHlGDOFG0J/z5YtpuIyqtVGHsESTEHMkblFGMp2ZtQtmZyxk3KmG5jkn85RGtuysv/
        DRgUUL8Kr0++WAbXLoYVm4Iq2yA2WRuYll0NRZPeNE86DoJ7SEVMyZTz1j/7hhcMZFi6UZJ5x10Tm
        2DMYHcq9LgQ4Qlr1+xGDCERojwGxMaHIAK/H+aNj/Nrj3iqssx59dQTAy1Lu0PW9jTiVnQuKi0cKe
        jwaHh6N1g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9vxq-0002dh-29; Fri, 29 Mar 2019 18:10:50 +0000
Subject: Re: [PATCH] gcov: include linux/module.h for within_module
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Hackmann <ghackmann@android.com>,
        Tri Vo <trong@android.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kbuild-all@01.org, kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <201903291603.7podsjD7%lkp@intel.com>
 <20190329174541.79972-1-ndesaulniers@google.com>
 <9f1ad3e1-fad7-2fb4-31c0-d31832468143@infradead.org>
 <CAKwvOdmv4_8pN5r8EO8c59WN+EE7ZPST8qHKMg7SzPH1rzaqag@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eea3ce6a-732b-5c1d-9975-eddaeee21cf5@infradead.org>
Date:   Fri, 29 Mar 2019 11:10:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmv4_8pN5r8EO8c59WN+EE7ZPST8qHKMg7SzPH1rzaqag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 11:09 AM, Nick Desaulniers wrote:
> On Fri, Mar 29, 2019 at 11:01 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 3/29/19 10:45 AM, Nick Desaulniers wrote:
>>> Fixes commit 8c3d220cb6b5 ("gcov: clang support")
>>>
>>> Cc: Greg Hackmann <ghackmann@android.com>
>>> Cc: Tri Vo <trong@android.com>
>>> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
>>> Cc: linux-mm@kvack.org
>>> Cc: kbuild-all@01.org
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>> Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
>>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> see https://lore.kernel.org/linux-mm/20190328225107.ULwYw%25akpm@linux-foundation.org/T/#mee26c00158574326e807480fc39dfcbd7bebd5fd
>>
>> Did you test this?
> 
> Yes, built with gcc 7.3 and
> defconfig
> +
> CONFIG_GCOV_KERNEL=y
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> CONFIG_GCOV_FORMAT_4_7=y
> 
>> kernel/gcov/gcc_4_7.c includes local "gcov.h",
>> which includes <linux/module.h>, so why didn't that work or why
>> does this patch work?
> 
> Good point. May be something in the configs from 0-day bot.  Boarding
> a plane for Bangkok, but can dig further once landed.
> 
> Maybe module support was disabled?

Yes, I reported the problem with CONFIG_MODULES not enabled.


-- 
~Randy
