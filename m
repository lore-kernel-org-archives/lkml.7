Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7898C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0832190F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570447566;
	bh=DedA3pbgkep8D1AIrI3G79PbCUutNiADMm5nmExKRrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Elbq3zrxi0e6oBfhGWA3j0tdp8VD6cFdOEawhobVNelGnhQLAqyC25bumGByVXwRE
	 DT/TB46bwyFhucARRrTyGOhnvaSQSau1nCXHNlXeUT/yc993EhvwRnL7qA7BiCMK5M
	 E83TLA+AqQgSgnPUL7GfgD1wrGNnQ2vKTGgJb7/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfJGL0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbfJGL0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:26:05 -0400
Received: from linux-8ccs (unknown [92.117.158.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDAA621835;
        Mon,  7 Oct 2019 11:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570447564;
        bh=DedA3pbgkep8D1AIrI3G79PbCUutNiADMm5nmExKRrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oabOaMt0RQdJ1W9ZBXnGrH48LeLk/kUeEq/eSQ5hy8zyBFum9q1+0dp8mla3hySSo
         GG5SllyB4tw5eKfKlf25gmsdZxG2MsGuGK/lWgS5N7C1vQYYY3c9uIt33z+KcAiEFB
         H6YBHHsMJNsW9jI3n5rTy+ByEPzEn8oSOHjGOK8A=
Date:   Mon, 7 Oct 2019 13:25:58 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martijn Coenen <maco@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] depmod: create and use System.map.no_namespaces
Message-ID: <20191007112557.GB8279@linux-8ccs>
References: <20190917231031.81341-1-maennich@google.com>
 <20191004095748.223119-1-maennich@google.com>
 <CAKi4VALPF7r25SJ+9jazeRz612pv_4MmhjOsJ8aumW_JO29VvA@mail.gmail.com>
 <CAK7LNAQ10xCm52PrgUvE=Z+d4BabuATSRpw+kL9Xm=O-ik_Duw@mail.gmail.com>
 <20191007064631.GB142813@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191007064631.GB142813@google.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Matthias Maennich [07/10/19 07:46 +0100]:
>Hi!
>
>On Sat, Oct 05, 2019 at 04:53:56PM +0900, Masahiro Yamada wrote:
>>On Sat, Oct 5, 2019 at 3:25 AM Lucas De Marchi
>><lucas.de.marchi@gmail.com> wrote:
>>>
>>>On Fri, Oct 4, 2019 at 2:57 AM Matthias Maennich <maennich@google.com> wrote:
>>>>
>>>> depmod in its current version is not aware of symbol namespace in
>>>> ksymtab entries introduced with 8651ec01daed ("module: add support for
>>>> symbol namespaces."). They have the form
>>>>
>>>>   __ksymtab_NAMESPACE.symbol_name
>>>>
>>>> A fix for kmod's depmod has been proposed [1]. In order to support older
>>>> versions of depmod as well, create a System.map.no_namespaces during
>>>> scripts/depmod.sh that has the pre-namespaces format. That way users do
>>>> not immediately upgrade the userspace tool.
>>>>
>>>> [1] https://lore.kernel.org/linux-modules/20191004094136.166621-1-maennich@google.com/
>>>>
>>>> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>> Fixes: 8651ec01daed ("module: add support for symbol namespaces.")
>>>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
>>>> Cc: Jessica Yu <jeyu@kernel.org>
>>>> Cc: Martijn Coenen <maco@android.com>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: linux-modules@vger.kernel.org
>>>> Signed-off-by: Matthias Maennich <maennich@google.com>
>>>> ---
>>>>
>>>> Please note this depends on the new ksymtab entry format proposed in
>>>> https://lore.kernel.org/lkml/20191003075826.7478-2-yamada.masahiro@socionext.com/
>>>
>>>I don't really agree with that thought, more below.
>>>
>>>>
>>>> That is likely to be merged soon as well as it fixes problems in 5.4-rc*, hence
>>>> this patch depends on it.
>>>>
>>>> Cheers,
>>>> Matthias
>>>>
>>>>  .gitignore        | 1 +
>>>>  scripts/depmod.sh | 8 +++++++-
>>>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/.gitignore b/.gitignore
>>>> index 70580bdd352c..5ed58a7cb433 100644
>>>> --- a/.gitignore
>>>> +++ b/.gitignore
>>>> @@ -59,6 +59,7 @@ modules.order
>>>>  /vmlinux-gdb.py
>>>>  /vmlinuz
>>>>  /System.map
>>>> +/System.map.no_namespaces
>>>>  /Module.markers
>>>>  /modules.builtin.modinfo
>>>>
>>>> diff --git a/scripts/depmod.sh b/scripts/depmod.sh
>>>> index e083bcae343f..602e1af072c7 100755
>>>> --- a/scripts/depmod.sh
>>>> +++ b/scripts/depmod.sh
>>>> @@ -39,7 +39,13 @@ if $depmod_hack_needed; then
>>>>         KERNELRELEASE=99.98.$KERNELRELEASE
>>>>  fi
>>>>
>>>> -set -- -ae -F System.map
>>>> +# Older versions of depmod do not support symbol namespaces in ksymtab entries,
>>>> +# hence create an alternative System.map with namespace patched out to use for
>>>> +# depmod. I.e. transform entries as follows:
>>>> +#    __ksymtab_NAMESPACE.symbol_name -> __ksymtab_symbol_name
>>>> +sed 's/__ksymtab_.*\./__ksymtab_/' System.map > System.map.no_namespaces
>>>
>>>So people with old kmod will have to know they need to pass
>>>System.map.no_namespaces rather than the usual
>>>System.map. Also, distros will need to be update to also copy the new
>>>file to the kernel package (or upgrade/patch kmod).
>>>
>>>I'd rather maintain the current format and fix the bug that patch is
>>>fixing. The namespace
>>>in the end IMO is just a small annoyance with a reason to  exist.
>>
>>I agree, this fix is bad.
>>We should not bother kmod or any tools.
>>And System.map.no_namespaces is a cheesy workaround.
>
>Thanks for the feedback!
>
>Based on the discussion from last year about changing kmod/depmod for
>this change to the ksymtab entries,
>(https://lore.kernel.org/lkml/CAKi4VA+wvVxPxVSP6ruSR++TYvavKPNAQ5XhREF_9ZxeOKQirg@mail.gmail.com/),
>I assumed this approach would be acceptable. The workaround (yeah, it is
>a hack) is a way to mitigate the issue for people that can't update
>depmod so easily. System.map.no_namespaces was not intended to be part
>of any distribution, but rather used locally in depmod.sh. I could have
>made this more clear.
>
>>
>>BTW, I expressed my negative opinion in the review process
>>for the patch set. I am still not convinced with the
>>namespace feature, but anyway it was merged
>>(with poor review and test).
>>
>>
>>
>>Get back on track, probably the right fix would be to
>>stop using __ksymtab_<namespace>.<symbol>.
>>
>>It is not used for any purposes but passing
>><namespace> / <symbol> pairs to modpost.
>>
>>
>>For example, __kstrtabns_##sym points to
>>the namespace string, so it would be possible
>>to parse it from modpost?
>>
>>Then, asm("__ksymtab_" #ns NS_SEPARATOR #sym)
>>will go away.
>
>I will give this a try.

That sounds like a good idea. Maybe one way of going about it is to
take the symbol value of __kstrtabns_##sym, subtract the section address
(the section referred to by the st_shndx) from it to obtain the offset
into __ksymtab_strings, and read in the namespace string from that
offset.

