Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35202C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F0720838
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfGOJJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:09:48 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:38252 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729427AbfGOJJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:09:47 -0400
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: xg4CgYAsXM5agBOKtFytyGo/Fzv179UDZbcs/wfMk16ELc4/e8qhLlqYAyvQI3WvPcrIWJsYFy
 XmYG1/nEk7B79YtZcmoZvRI/DFaKgzBVgVCqtQpvzph2pKDBTr2qy3TPmKYPLN/e/ZXRai1lzS
 a9wMup7nt6KXqSwCQs2adWfVP0e+SR+EKRO+gy66KD2EZhqlB6DSO+J2jpsFy2PMl3u+yPvrGk
 MvudkMo+/C/SHCD5tkTP7BJDwdZrN+34g6sJ55BrDwl09K5k3LbD8OLEnvEKwc+XHdKR1+w5R/
 lmA=
X-SBRS: 2.7
X-MesageID: 3036269
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,493,1557201600"; 
   d="scan'208";a="3036269"
Subject: Re: [Xen-devel] [PATCH v2] xen/pv: Fix a boot up hang revealed by
 int3 self test
To:     Jan Beulich <JBeulich@suse.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
CC:     Juergen Gross <JGross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srinivas.eeda@oracle.com" <srinivas.eeda@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <1562832921-20831-1-git-send-email-zhenzhong.duan@oracle.com>
 <ebf9657b-7d97-87a0-e32e-af8453ee7bba@citrix.com>
 <b9702975-dd2d-cf0b-e47f-a1c4361db18f@oracle.com>
 <18619ecb-108a-0d89-812c-7525a566e805@suse.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Openpgp: preference=signencrypt
Autocrypt: addr=andrew.cooper3@citrix.com; prefer-encrypt=mutual; keydata=
 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
 6+ahAA==
Message-ID: <654b7299-8fbf-168f-a9e3-f9ea6369d38a@citrix.com>
Date:   Mon, 15 Jul 2019 10:09:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <18619ecb-108a-0d89-812c-7525a566e805@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2019 07:54, Jan Beulich wrote:
> On 15.07.2019 07:05, Zhenzhong Duan wrote:
>> On 2019/7/12 22:06, Andrew Cooper wrote:
>>> On 11/07/2019 03:15, Zhenzhong Duan wrote:
>>>> Commit 7457c0da024b ("x86/alternatives: Add int3_emulate_call()
>>>> selftest") is used to ensure there is a gap setup in exception stack
>>>> which could be used for inserting call return address.
>>>>
>>>> This gap is missed in XEN PV int3 exception entry path, then below panic
>>>> triggered:
>>>>
>>>> [    0.772876] general protection fault: 0000 [#1] SMP NOPTI
>>>> [    0.772886] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0+ #11
>>>> [    0.772893] RIP: e030:int3_magic+0x0/0x7
>>>> [    0.772905] RSP: 3507:ffffffff82203e98 EFLAGS: 00000246
>>>> [    0.773334] Call Trace:
>>>> [    0.773334]  alternative_instructions+0x3d/0x12e
>>>> [    0.773334]  check_bugs+0x7c9/0x887
>>>> [    0.773334]  ? __get_locked_pte+0x178/0x1f0
>>>> [    0.773334]  start_kernel+0x4ff/0x535
>>>> [    0.773334]  ? set_init_arg+0x55/0x55
>>>> [    0.773334]  xen_start_kernel+0x571/0x57a
>>>>
>>>> As xenint3 and int3 entry code are same except xenint3 doesn't generate
>>>> a gap, we can fix it by using int3 and drop useless xenint3.
>>> For 64bit PV guests, Xen's ABI enters the kernel with using SYSRET, with
>>> %rcx/%r11 on the stack.
>>>
>>> To convert back to "normal" looking exceptions, the xen thunks do `pop
>>> %rcx; pop %r11; jmp do_*`...
>> I will add this to commit message.
>>>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>>>> index 0ea4831..35a66fc 100644
>>>> --- a/arch/x86/entry/entry_64.S
>>>> +++ b/arch/x86/entry/entry_64.S
>>>> @@ -1176,7 +1176,6 @@ idtentry stack_segment        do_stack_segment    has_error_code=1
>>>>   #ifdef CONFIG_XEN_PV
>>>>   idtentry xennmi            do_nmi            has_error_code=0
>>>>   idtentry xendebug        do_debug        has_error_code=0
>>>> -idtentry xenint3        do_int3            has_error_code=0
>>>>   #endif
>>> What is confusing is why there are 3 extra magic versions here.  At a
>>> guess, I'd say something to do with IST settings (given the vectors),
>>> but I don't see why #DB/#BP would need to be different in the first
>>> place.  (NMI sure, but that is more to do with the crazy hoops needing
>>> to be jumped through to keep native functioning safely.)
>> xenint3 will be removed in this patch safely as it don't use IST now.
>>
>> But debug and nmi need paranoid_entry which will read MSR_GS_BASE to determine
>>
>> if swapgs is needed. I guess PV guesting running in ring3 will #GP with swapgs?
> Not only that (Xen could trap and emulate swapgs if that was needed) - 64-bit
> PV kernel mode always gets entered with kernel GS base already set. Hence
> finding out whether to switch the GS base is specifically not something that
> any exception entry point would need to do (and it should actively try to
> avoid it, for performance reasons).

Indeed.  The SWAPGS PVOP is implemented as a nop for x86 PV, to simply
the entry assembly (rather than doubling up all entry vectors).

~Andrew
