Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D1EC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182A8213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lu1AwZxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfDHRZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:25:53 -0400
Received: from mail.efficios.com ([167.114.142.138]:52004 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfDHRZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:25:51 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BFA7B1D3C4C;
        Mon,  8 Apr 2019 13:25:49 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id oZ-29zCel_oS; Mon,  8 Apr 2019 13:25:49 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6BF291D3C45;
        Mon,  8 Apr 2019 13:25:49 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6BF291D3C45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554744349;
        bh=jh26Zvv8udxRgGtlQh6FmH4n1moq3HDOeT3f96ju2p0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=lu1AwZxY1DOhL2vov/hwp2ydhntaGuabArCxiqZifzmgdEKtyh09NxmH0VV2yhWXx
         KRjqU5fh4y+jP7iptpdZTEsXO4qO7DpujwzqhiJZlu4JsH2+mrR0kg2YDqnWs9ckA9
         LVLqoflNPlMfleX+nR4y5TQ2AIRzvg6DNMDSYvKoFoHk9n97dcq2MaXPt0kaDVygKI
         4QyIVfmSkfRba1tus75mCXeNFl2DvGFdekor6ki7djBkp5yYBPDLaqfHXniYoWxv1I
         Ljz5yebzKT2V33JXE7IPXoGYx82Q0Pm/1RqCdR+PacXbBOfhDf90tcDbaciMSLBeJY
         FtQ0KCftky/0A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id LKT4lmb4o6Yo; Mon,  8 Apr 2019 13:25:49 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 4CB351D3C34;
        Mon,  8 Apr 2019 13:25:49 -0400 (EDT)
Date:   Mon, 8 Apr 2019 13:25:49 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@linux.ibm.com>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Message-ID: <1930819602.1467.1554744349263.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190408171041.GQ14111@linux.ibm.com>
References: <20190408135610.GN11264@shao2-debian> <20190408143037.GL14111@linux.ibm.com> <20190408145750.GO11264@shao2-debian> <20190408152112.GM14111@linux.ibm.com> <118257214.1376.1554743216233.JavaMail.zimbra@efficios.com> <20190408171041.GQ14111@linux.ibm.com>
Subject: Re: [srcu] a365bb5f6e: leaking_addresses.proc.___srcu_struct_ptrs.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: a365bb5f6e: leaking_addresses.proc.___srcu_struct_ptrs.
Thread-Index: SF2mnaFEDzZ2dPi6dfzsO1XZYVq0SQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 8, 2019, at 1:10 PM, paulmck paulmck@linux.ibm.com wrote:

> On Mon, Apr 08, 2019 at 01:06:56PM -0400, Mathieu Desnoyers wrote:
>> ----- On Apr 8, 2019, at 11:21 AM, paulmck paulmck@linux.ibm.com wrote:
>> 
>> > On Mon, Apr 08, 2019 at 10:57:50PM +0800, Rong Chen wrote:
>> >> On Mon, Apr 08, 2019 at 07:30:37AM -0700, Paul E. McKenney wrote:
>> >> > On Mon, Apr 08, 2019 at 09:56:10PM +0800, kernel test robot wrote:
>> >> > > FYI, we noticed the following commit (built with gcc-7):
>> >> > > 
>> >> > > commit: a365bb5f6eafb220a1448674054b05c250829313 ("srcu: Allocate per-CPU data
>> >> > > for DEFINE_SRCU() in modules")
>> >> > > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git
>> >> > > tmp.2019.04.07a
>> >> > > 
>> >> > > in testcase: leaking_addresses
>> >> > > with following parameters:
>> >> > > 
>> >> > > 
>> >> > > 
>> >> > > 
>> >> > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 2G
>> >> > > 
>> >> > > caused below changes (please refer to attached dmesg/kmsg for entire
>> >> > > log/backtrace):
>> >> > > 
>> >> > > 
>> >> > > +-------------------------------------------------+------------+------------+
>> >> > > |                                                 | a44a55abae | a365bb5f6e |
>> >> > > +-------------------------------------------------+------------+------------+
>> >> > > | boot_successes                                  | 0          | 3          |
>> >> > > | boot_failures                                   | 4          | 6          |
>> >> > > | BUG:kernel_reboot-without-warning_in_test_stage | 4          | 6          |
>> >> > > | leaking_addresses.proc.___srcu_struct_ptrs.     | 0          | 6          |
>> >> > > +-------------------------------------------------+------------+------------+
>> >> > 
>> >> > Please help me out here.  Without this commit, the kernel never succeeds
>> >> > in booting, but with it the kernel sometimes succeeds in booting?  Or am
>> >> > I misinterpreting the above table?
>> >> > 
>> >> > 							Thanx, Paul
>> >> 
>> >> Hi Paul,
>> >> 
>> >> The message "kernel_reboot-without-warning_in_test_stage" is from 0day,
>> >> leaking addresses generated many dmesgs, so 0day thought some bootings may
>> >> failed.
>> > 
>> [...]
>> >> > 
>> >> > > [1 .rodata.cst16.POLY] 0xffffffffc0498360
>> >> > > [1 .rodata.cst32.byteshift_table] 0xffffffffc03f50f0
>> >> > > [19 __bug_table] 0xffffffffc02be184
>> >> > > [2 __tracepoints_ptrs] 0xffffffffc02f1cd0
>> >> > > [15 .smp_locks] 0xffffffffc042b2cc
>> >> > > [1 .rodata.cst16.enc] 0xffffffffc0498420
>> >> > > [11 __ksymtab_gpl] 0xffffffffc042b028
>> >> > > [8 __ex_table] 0xffffffffc04f13f4
>> >> > > [1 .init.rodata] 0xffffffffc0316000
>> >> > > [36 .note.gnu.build-id] 0xffffffffc03ed000
>> >> > > [1 .rodata.cst16.dec] 0xffffffffc0498410
>> >> > > [16 .parainstructions] 0xffffffffc03ed940
>> >> > > [8 .text..refcount] 0xffffffffc04e2aaa
>> >> > > [36 .gnu.linkonce.this_module] 0xffffffffc03f12c0
>> >> > > [2 __bpf_raw_tp_map] 0xffffffffc03054a0
>> >> > > [30 .orc_unwind_ip] 0xffffffffc03ee9f9
>> >> > > [8 .altinstr_replacement] 0xffffffffc0497372
>> >> > > [26 .rodata.str1.8] 0xffffffffc03ed1f0
>> >> > > [11 __verbose] 0xffffffffc05c9398
>> >> > > [1 .rodata.cst16.TWOONE] 0xffffffffc0498380
>> >> > > [1 uevent] KEY=402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
>> >> > > [1 .rodata.cst16.ONE] 0xffffffffc04983e0
>> >> > > [8 .altinstructions] 0xffffffffc0498430
>> >> > > [36 modules] crct10dif_pclmul 16384 1 - Live 0xffffffffc03f4000
>> >> > > [1 ___srcu_struct_ptrs] 0xffffffffc03840d0
>> >> > > 
>> 
>> This list of "leaked" memory seems to include the __tracepoint_ptrs
>> as well. So at least you seem to have the same behavior as the tracepoint
>> code, which was your source of inspiration for this implementation,
>> which is a good start.
>> 
>> So the remaining question is: is this memory allocated for module sections
>> really leaked for each module, or is it an issue with memory allocation
>> tracking ?
> 
> Thank you, Mathieu!
> 
> Also, is there some way to put this read-only (OK, relocated-only)
> memory in with the module .text segment?  ;-)

Theoretically, there should be! But I have no clue on how to do it.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
