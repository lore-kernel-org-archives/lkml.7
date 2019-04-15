Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2835C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DEE21873
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555338157;
	bh=f0MTa7O9eKaqafBFgQG47VlmY1xfprmetDMdk8EjmCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HRl0cSQuiSGnNOvKHabZMfy0D6TNJfKwm7ikRTYMGzk5IxbKZ6YtlnnwvCeOqw9yV
	 1Nb87HgsDK9+DB0K0yKMU4xLaD55R+4Ca+oKOWyLnhp3ErqAf/ZSM49/DF8WGCJfIG
	 qwbaQC2aMJ3zxrzvD2oSBZ+AOfOBecxOjwEuElvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfDOOWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfDOOWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:22:35 -0400
Received: from linux-8ccs (ip5f5adbb4.dynamic.kabel-deutschland.de [95.90.219.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51E4020880;
        Mon, 15 Apr 2019 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555338154;
        bh=f0MTa7O9eKaqafBFgQG47VlmY1xfprmetDMdk8EjmCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gda2MW/VzVJSa3xOMiLc5NR4KzuPJtxxImHxRxhpaIVjF3mbNKxbji4LvC98vvwgE
         XwggmmZ9821q4ATTw4dihR9dTGPKKAvqWEz08cOFZPlPBvEy+veEOoO2291H5Pne6I
         rWHkItre8LoCmzTpMcHtAu27dKt48fVWz1d/1L08=
Date:   Mon, 15 Apr 2019 16:22:29 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tri Vo <trong@android.com>, Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Hackmann <ghackmann@android.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kbuild-all@01.org, kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petri Gynther <pgynther@google.com>
Subject: Re: [PATCH] module: add stub for within_module
Message-ID: <20190415142229.GA14330@linux-8ccs>
References: <20190407022558.65489-1-trong@android.com>
 <CAKwvOdmBa-Ckk4wnp4OEPNdxeYSxEhzddykuWWGG1Wi6JEGDwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdmBa-Ckk4wnp4OEPNdxeYSxEhzddykuWWGG1Wi6JEGDwA@mail.gmail.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Nick Desaulniers [08/04/19 11:08 -0700]:
>On Sat, Apr 6, 2019 at 7:26 PM Tri Vo <trong@android.com> wrote:
>>
>> Provide a stub for within_module() when CONFIG_MODULES is not set. This
>> is needed to build CONFIG_GCOV_KERNEL.
>>
>> Fixes: 8c3d220cb6b5 ("gcov: clang support")
>
>The above commit got backed out of the -mm tree, due to the issue this
>patch addresses, so not sure it provides the correct context for the
>patch.  Maybe that line in the commit message should be dropped?

Yeah, if the commit is no longer valid, then we should drop this line
and perhaps generalize the commit message more, maybe something like
"provide a stub for within_module() to prevent build errors when 
!CONFIG_MODULES".

>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
>> Signed-off-by: Tri Vo <trong@android.com>
>> ---
>>  include/linux/module.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/include/linux/module.h b/include/linux/module.h
>> index 5bf5dcd91009..47190ebb70bf 100644
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
>> @@ -709,6 +709,11 @@ static inline bool is_module_text_address(unsigned long addr)
>>         return false;
>>  }
>>
>> +static inline bool within_module(unsigned long addr, const struct module *mod)
>> +{
>> +       return false;
>> +}
>> +
>
>Do folks think that similar stubs for within_module_core and
>within_module_init should be added, while we're here?
>
>It looks like kernel/trace/ftrace.c uses them, but has proper
>CONFIG_MODULE guards.

Tri, if you plan on sending a v2, could you add Nick's suggestion
above? Would probably be good to prevent future build errors if a user
omits CONFIG_MODULE guards.

Thanks,

Jessica

