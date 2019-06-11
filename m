Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF59C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347482173B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="l1K26D6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436998AbfFKXC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:02:26 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:42902 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436837AbfFKXCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:02:25 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E4E9AC0187;
        Tue, 11 Jun 2019 23:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1560294144; bh=d4odOJInl1KtbgoSbnVGcXDnxySNZES3Wc2GbCByY1c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=l1K26D6rRiSOtCW65/t4xUrz4kLvx7e8cPcSycM+CE2LeSgteZECebI55+7mPuF1K
         y45EQr0Bfdei1rUL3LI7fMY3d6YIkN0j7YL70RTw0o3U75aOO2Qc2F2yZPI6Drr560
         AbyhjXeghPEhbVoEy30Xp/gCsqiR9LbtVN/wmUgi8oBpSnDaVHCurRUtXpTnmohyTB
         t91m8xQl4lv51BlEeW55xI6A8QBG+q0mlGGlT14FB2kc0p3WNEiB0NWZoOhBkNelju
         dyueF8vs6stChDQpkjqIlE7fOWedPX0qgaIYuS5J7fg9gMMzkYU2AeF1CYliv3jYme
         XPfF17JXtPXbA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 61EDEA023B;
        Tue, 11 Jun 2019 23:02:24 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 11 Jun 2019 16:02:23 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Jun 2019 04:32:20 +0530
Received: from [10.10.161.35] (10.10.161.35) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Jun 2019 04:32:33 +0530
Subject: Re: ARC Assembler: bundle_align_mode directive support
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Cupertino Miranda <Cupertino.Miranda@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Claudiu Zissulescu <Claudiu.Zissulescu@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.arc
References: <3962a9ad199cea45b1cfadb80be551aab83b7028.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A2525686@us01wembx1.internal.synopsys.com>
 <d79085cbc6126c2a4fad173934e1e9b29523abba.camel@synopsys.com>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 mQINBFEffBMBEADIXSn0fEQcM8GPYFZyvBrY8456hGplRnLLFimPi/BBGFA24IR+B/Vh/EFk
 B5LAyKuPEEbR3WSVB1x7TovwEErPWKmhHFbyugdCKDv7qWVj7pOB+vqycTG3i16eixB69row
 lDkZ2RQyy1i/wOtHt8Kr69V9aMOIVIlBNjx5vNOjxfOLux3C0SRl1veA8sdkoSACY3McOqJ8
 zR8q1mZDRHCfz+aNxgmVIVFN2JY29zBNOeCzNL1b6ndjU73whH/1hd9YMx2Sp149T8MBpkuQ
 cFYUPYm8Mn0dQ5PHAide+D3iKCHMupX0ux1Y6g7Ym9jhVtxq3OdUI5I5vsED7NgV9c8++baM
 7j7ext5v0l8UeulHfj4LglTaJIvwbUrCGgtyS9haKlUHbmey/af1j0sTrGxZs1ky1cTX7yeF
 nSYs12GRiVZkh/Pf3nRLkjV+kH++ZtR1GZLqwamiYZhAHjo1Vzyl50JT9EuX07/XTyq/Bx6E
 dcJWr79ZphJ+mR2HrMdvZo3VSpXEgjROpYlD4GKUApFxW6RrZkvMzuR2bqi48FThXKhFXJBd
 JiTfiO8tpXaHg/yh/V9vNQqdu7KmZIuZ0EdeZHoXe+8lxoNyQPcPSj7LcmE6gONJR8ZqAzyk
 F5voeRIy005ZmJJ3VOH3Gw6Gz49LVy7Kz72yo1IPHZJNpSV5xwARAQABtCpWaW5lZXQgR3Vw
 dGEgKGFsaWFzKSA8dmd1cHRhQHN5bm9wc3lzLmNvbT6JAj4EEwECACgCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheABQJbBYpwBQkLx0HcAAoJEGnX8d3iisJeChAQAMR2UVbJyydOv3aV
 jmqP47gVFq4Qml1weP5z6czl1I8n37bIhdW0/lV2Zll+yU1YGpMgdDTHiDqnGWi4pJeu4+c5
 xsI/VqkH6WWXpfruhDsbJ3IJQ46//jb79ogjm6VVeGlOOYxx/G/RUUXZ12+CMPQo7Bv+Jb+t
 NJnYXYMND2Dlr2TiRahFeeQo8uFbeEdJGDsSIbkOV0jzrYUAPeBwdN8N0eOB19KUgPqPAC4W
 HCg2LJ/o6/BImN7bhEFDFu7gTT0nqFVZNXlOw4UcGGpM3dq/qu8ZgRE0turY9SsjKsJYKvg4
 djAaOh7H9NJK72JOjUhXY/sMBwW5vnNwFyXCB5t4ZcNxStoxrMtyf35synJVinFy6wCzH3eJ
 XYNfFsv4gjF3l9VYmGEJeI8JG/ljYQVjsQxcrU1lf8lfARuNkleUL8Y3rtxn6eZVtAlJE8q2
 hBgu/RUj79BKnWEPFmxfKsaj8of+5wubTkP0I5tXh0akKZlVwQ3lbDdHxznejcVCwyjXBSny
 d0+qKIXX1eMh0/5sDYM06/B34rQyq9HZVVPRHdvsfwCU0s3G+5Fai02mK68okr8TECOzqZtG
 cuQmkAeegdY70Bpzfbwxo45WWQq8dSRURA7KDeY5LutMphQPIP2syqgIaiEatHgwetyVCOt6
 tf3ClCidHNaGky9KcNSQ
Message-ID: <02fcd330-8b3c-a3cb-0aa9-e91bca6b6d0f@synopsys.com>
Date:   Tue, 11 Jun 2019 16:01:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d79085cbc6126c2a4fad173934e1e9b29523abba.camel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.35]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/19 11:47 AM, Eugeniy Paltsev wrote:
> Hi Vineet,
> 
> On Mon, 2019-06-10 at 15:55 +0000, Vineet Gupta wrote:
>> On 6/8/19 11:21 AM, Eugeniy Paltsev wrote:
>>> Hi Cupertino,
>>>
>>> I tried to use ".bundle_align_mode" directive in ARC assembly, but I got following error:
>>> ----------------->8--------------
>>> Assembler messages:
>>> Error: unknown pseudo-op: `.bundle_align_mode'
>>> ----------------->8--------------
>>>
>>> Is it possible to implement it in ARC assembler?
>>> There is some context about the reason we want to have it:
>>>
>>> I'm trying to add support of jump labels for ARC in linux kernel. Jump labels
>>> provide an interface to generate static branches using self-modifying code.
>>> This allows us to implement conditional branches where changing branch
>>> direction is expensive but branch selection is basically 'free'.
>>>
>>> There is nuance in current implementation:
>>> We need to patch code by rewriting 32-bit NOP by 32-bit BRANCH instruction (or vice versa).
>>> It can be easily done with following code:
>>> ----------------->8--------------
>>> write_32_bit(new_instruction)
>>> flush_l1_dcache_range_this_cpu
>>> invalidate_l1_icache_range_all_cpu
>>> ----------------->8--------------
>>>
>>> I$ update will be atomic in most of cases except the patched instruction share
>>> two L1 cache lines (so first 16 bits of instruction are in the one cache line and
>>> last 16 bit are in another cache line).
>>> In such case we can execute half-updated instruction if we are patching live code (and we are unlucky enough :)
>>
>> While I understand your need for alignment, I don't see how you can possibly
>> execute stray lines.
>> dcache flush will be propagated by hardware (SCU) to all cores (as applicable) and
>> the icache cache flush xcall is synchronous and will have to finish on all cores
>> before we proceed to execute the cod eitself.
>>
> 
> It's easy as hell - we may execute some code on one CPU and patch it on another CPU at the same moment :)
> 
> And here is the example of the situation when we can get the issue:
> - Let's imagine we have SMP system with CPU#0 and CPU#1.
> - We have instruction which share two L1 cache lines:
> ~ ---------------------------------|--------------------------------- ~
> ~            |instruction-Z (32-bit instruction we patch)|            ~
> ~ ---------------------------------|--------------------------------- ~
> ~   cache-line-X                   | cache-line-Y                     ~
> ~ ---------------------------------|--------------------------------- ~
> 
> CPU#0 is trying to switch our static branch, so it will patch the code (instruction-Z)
> CPU#1 is executing this code with our static branch, so it execute the code (with instruction-Z) that will be patched.
> 
> 1) CPU#0: we generate new instruction (to replace 'instruction-Z')
>    and write it with 32-bit store (st). It is written to CPU#0 L1 data cache.
> 2) CPU#0: we call our function flush_icache_range.
>    It firstly will flush L1 data cache region on CPU#0.
>    In our example it will flush CPU#0 L1 'cache-line-X' and 'cache-line-Y' to L2 cache.
> 3) CPU#1: we are executing code which is in 'cache-line-X'.
>    'cache-line-Y' is __NOT__ in the L1 instruction cache of CPU#1.
>    We need to execute 'instruction-Z', but only half of the instruction is in L1 instruction cache.
>    CPU#1 fetch 'cache-line-Y' to L1 instruction cache.
> 4)  Ooops: now we have corrupted 'instruction-Z' in L1 instruction cache of CPU#1:
>    First 16 bit of this instruction (which belongs to 'cache-line-X') are old (not patched).
>    Last 16 bit of this instruction (which belongs to 'cache-line-Y') are new (patched). 

OK I agree there is a race: I was not thinking of case where the exact patched
instruction is concurrently being executed on other core. Indeed we need to ensure
it doesn't straddle icache line.

We could potentially avoid all of these issues if we could use 2 byte (NOP_S +
B_S). The added advantage is even better icache footprint. Ofcourse with B_S the
branch range goes down from S25 to S10, but considering the use cases it might be
enough after all.

-------->8-----------
static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
        asm_volatile_goto("1:\n\t"
-                "nop \n\t"
+                "nop_s \n\t"
                 ".pushsection __jump_table,  \"aw\"\n\t"
                 ".word 1b, %l[l_yes], %c0\n\t"
                 ".popsection\n\t"

static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
branch)
 {
        asm_volatile_goto("1:\n\t"
-                "b %l[l_yes]\n\t"
+                "b_s %l[l_yes]\n\t"
-------->8-----------

It indeed works, except for 1 place in networking code where S10 is not enough.
Granted it is not future proof, I do like the effect

add/remove: 0/0 grow/shrink: 0/45 up/down: 0/-244 (-244)
function                                     old     new   delta
udp_queue_rcv_one_skb                       1010    1006      -4
udp_flow_hashrnd                              80      76      -4
udp_destroy_sock                             128     124      -4
udp4_lib_lookup2.constprop                   562     558      -4
udp4_gro_receive                             628     624      -4
try_to_wake_up                               876     872      -4
tcp_splice_read                             1026    1022      -4
tcp_recvmsg                                 2618    2614      -4
tcp_read_sock                                508     504      -4
switched_from_fair                           176     172      -4
secure_ipv4_port_ephemeral                   102      98      -4
sched_clock_cpu                               16      12      -4
run_filter                                   232     228      -4
process_backlog                              420     416      -4
pick_next_task_fair                         2984    2980      -4
netif_rx_internal                            174     170      -4
netif_reset_xps_queues                       690     686      -4
netif_receive_skb_list                       488     484      -4
netif_receive_skb_internal                   242     238      -4
load_balance                                2370    2366      -4
inet_sendpage                                352     348      -4
inet_sendmsg                                 244     240      -4
inet_recvmsg                                 192     188      -4
inet_lhash2_lookup                           414     410      -4
inet_accept                                  252     248      -4
housekeeping_affine                           30      26      -4
fnhe_hashfun                                 158     154      -4
finish_task_switch                           370     366      -4
enqueue_task_fair                           1504    1500      -4
do_page_fault                                658     654      -4
dequeue_task_fair                            988     984      -4
bpf_user_rnd_init_once                        62      58      -4
__skb_get_hash_symmetric                     694     690      -4
__skb_get_hash                               726     722      -4
__schedule                                   998     994      -4
__release_sock                               240     236      -4
__netif_receive_skb_core                    1782    1778      -4
__netdev_alloc_skb                           304     300      -4
task_tick_fair                               814     806      -8
sched_rt_period_timer                       1034    1026      -8
netdev_pick_tx                               664     656      -8
find_busiest_group                          2348    2340      -8
check_preempt_wakeup                         690     682      -8
jump_label_test                              324     312     -12
select_task_rq_fair                         3112    3072     -40
Total: Before=4064620, After=4064376, chg -1.000000%



>>> As of today I simply align by 4 byte instruction which can be patched with ".balign 4" directive:
>>> However 'align by 4' directive is much stricter than it actually required.
...

> All instructions on ARCv2 are aligned by 2 byte (even if the instruction is 4-byte long).
> 
> Using '.balign' directive we align instruction which can be
> patched by 4 byte.
> So compiler will add one 'nop_s' before our instruction if it is not 4 byte aligned.
> 

...

> 
> In most of the cases this extra 'nop_s' is unnecessary as it is fine to have our instruction
> not 4 byte aligned if it doesn't cross l1 cache line boundary.
> 
> It is't the huge problem - but we are adding one unnecessary 'nop' while we try to optimize hot code.
> 
...

> If we will have ".bundle_align_mode" directive supported we can add extra 'nop_s' only if it's really required
> (if our instruction _really_ cross L1 cache line boundary). So we won't add useless NOP to hot code.

OK understand, but this is not gating the feature. We can start off with .balign 4
and if-n-once tools support it we can remove the alignment requirements.

-Vineet
