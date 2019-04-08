Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD14C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C5F20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OXk7JYbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfDHT5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:57:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43974 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfDHT5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:57:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so4972644pgu.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 12:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q3PnJbNuSyBNZDd5iQroinCQi2SQfpCz5wwMLN4vbEs=;
        b=OXk7JYbqJAnra2jenbxrz3H89yb9lkYSycZ5NXGiJlu0JAC/2axkCN3lfc/AzV6ZkA
         XDjObSmCRQIiHF5dT+p+OS/BoUh7CjL2WYEC8a9DM/sgKdm3Zc54PJ9j3e64QthoamL3
         wwTbCBwtoRSb1cN5Vr04pRv7VUZcAkBhjHNVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q3PnJbNuSyBNZDd5iQroinCQi2SQfpCz5wwMLN4vbEs=;
        b=s2xVVQO0L1EaJHRTaL4y5zoQOGLp/XCSz6DrBCOyFwaq4DAjx0sj9VTnWHX8QRakev
         dww8M1iH+Dev8y2k0AHRW5HM9/mTQuPH78uFsehc/lg8UaxfdCv115PEDrOeSc6EnIVl
         uapY70j1cl1OWs7ZoQajedgxWY//OnGWXKtTbLmkEgSK3g96S78UzNHzem+CIO/thaet
         Aycl09HzK2KCXwvMLqrirzXxNHQC70eUTdacQDQNfpw953NWeNR7E60xIWfnSDAP6uwn
         29zSK0tHJqKbiIhE/RQHIOfyF07CMYcwv8TOv3mKg2264/vRjcdSjzhV5prtvy84jaW4
         e+JA==
X-Gm-Message-State: APjAAAUAYwAkQXoL/LY18J5k77SspuoIp87TvbAGRifeuvOIWizK/1pj
        MlM9V+rCYaZ8ZrV2a9/FTfUgww==
X-Google-Smtp-Source: APXvYqxRviRcUNzUw0KXB56IdriHOI3PLaHvWvl0eq5ZmYeGr30zfhh1ug3MRdnw7/gTcAAHCoWUlA==
X-Received: by 2002:a65:5c42:: with SMTP id v2mr15358472pgr.360.1554753456068;
        Mon, 08 Apr 2019 12:57:36 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g4sm53789735pfm.115.2019.04.08.12.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 12:57:35 -0700 (PDT)
Date:   Mon, 8 Apr 2019 15:57:34 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck <paulmck@linux.ibm.com>, Rong Chen <rong.a.chen@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>
Subject: Re: [srcu] a365bb5f6e: leaking_addresses.proc.___srcu_struct_ptrs.
Message-ID: <20190408195734.GE133872@google.com>
References: <20190408135610.GN11264@shao2-debian>
 <20190408143037.GL14111@linux.ibm.com>
 <20190408145750.GO11264@shao2-debian>
 <20190408152112.GM14111@linux.ibm.com>
 <118257214.1376.1554743216233.JavaMail.zimbra@efficios.com>
 <20190408171041.GQ14111@linux.ibm.com>
 <1930819602.1467.1554744349263.JavaMail.zimbra@efficios.com>
 <20190408193514.GD133872@google.com>
 <1892400867.1780.1554752824625.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1892400867.1780.1554752824625.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 03:47:04PM -0400, Mathieu Desnoyers wrote:
> ----- On Apr 8, 2019, at 3:35 PM, Joel Fernandes, Google joel@joelfernandes.org wrote:
> 
> > On Mon, Apr 08, 2019 at 01:25:49PM -0400, Mathieu Desnoyers wrote:
> >> ----- On Apr 8, 2019, at 1:10 PM, paulmck paulmck@linux.ibm.com wrote:
> >> 
> >> > On Mon, Apr 08, 2019 at 01:06:56PM -0400, Mathieu Desnoyers wrote:
> >> >> ----- On Apr 8, 2019, at 11:21 AM, paulmck paulmck@linux.ibm.com wrote:
> >> >> 
> >> >> > On Mon, Apr 08, 2019 at 10:57:50PM +0800, Rong Chen wrote:
> >> >> >> On Mon, Apr 08, 2019 at 07:30:37AM -0700, Paul E. McKenney wrote:
> >> >> >> > On Mon, Apr 08, 2019 at 09:56:10PM +0800, kernel test robot wrote:
> >> >> >> > > FYI, we noticed the following commit (built with gcc-7):
> >> >> >> > > 
> >> >> >> > > commit: a365bb5f6eafb220a1448674054b05c250829313 ("srcu: Allocate per-CPU data
> >> >> >> > > for DEFINE_SRCU() in modules")
> >> >> >> > > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git
> >> >> >> > > tmp.2019.04.07a
> >> >> >> > > 
> >> >> >> > > in testcase: leaking_addresses
> >> >> >> > > with following parameters:
> >> >> >> > > 
> >> >> >> > > 
> >> >> >> > > 
> >> >> >> > > 
> >> >> >> > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 2G
> >> >> >> > > 
> >> >> >> > > caused below changes (please refer to attached dmesg/kmsg for entire
> >> >> >> > > log/backtrace):
> >> >> >> > > 
> >> >> >> > > 
> >> >> >> > > +-------------------------------------------------+------------+------------+
> >> >> >> > > |                                                 | a44a55abae | a365bb5f6e |
> >> >> >> > > +-------------------------------------------------+------------+------------+
> >> >> >> > > | boot_successes                                  | 0          | 3          |
> >> >> >> > > | boot_failures                                   | 4          | 6          |
> >> >> >> > > | BUG:kernel_reboot-without-warning_in_test_stage | 4          | 6          |
> >> >> >> > > | leaking_addresses.proc.___srcu_struct_ptrs.     | 0          | 6          |
> >> >> >> > > +-------------------------------------------------+------------+------------+
> >> >> >> > 
> >> >> >> > Please help me out here.  Without this commit, the kernel never succeeds
> >> >> >> > in booting, but with it the kernel sometimes succeeds in booting?  Or am
> >> >> >> > I misinterpreting the above table?
> >> >> >> > 
> >> >> >> > 							Thanx, Paul
> >> >> >> 
> >> >> >> Hi Paul,
> >> >> >> 
> >> >> >> The message "kernel_reboot-without-warning_in_test_stage" is from 0day,
> >> >> >> leaking addresses generated many dmesgs, so 0day thought some bootings may
> >> >> >> failed.
> >> >> > 
> >> >> [...]
> >> >> >> > 
> >> >> >> > > [1 .rodata.cst16.POLY] 0xffffffffc0498360
> >> >> >> > > [1 .rodata.cst32.byteshift_table] 0xffffffffc03f50f0
> >> >> >> > > [19 __bug_table] 0xffffffffc02be184
> >> >> >> > > [2 __tracepoints_ptrs] 0xffffffffc02f1cd0
> >> >> >> > > [15 .smp_locks] 0xffffffffc042b2cc
> >> >> >> > > [1 .rodata.cst16.enc] 0xffffffffc0498420
> >> >> >> > > [11 __ksymtab_gpl] 0xffffffffc042b028
> >> >> >> > > [8 __ex_table] 0xffffffffc04f13f4
> >> >> >> > > [1 .init.rodata] 0xffffffffc0316000
> >> >> >> > > [36 .note.gnu.build-id] 0xffffffffc03ed000
> >> >> >> > > [1 .rodata.cst16.dec] 0xffffffffc0498410
> >> >> >> > > [16 .parainstructions] 0xffffffffc03ed940
> >> >> >> > > [8 .text..refcount] 0xffffffffc04e2aaa
> >> >> >> > > [36 .gnu.linkonce.this_module] 0xffffffffc03f12c0
> >> >> >> > > [2 __bpf_raw_tp_map] 0xffffffffc03054a0
> >> >> >> > > [30 .orc_unwind_ip] 0xffffffffc03ee9f9
> >> >> >> > > [8 .altinstr_replacement] 0xffffffffc0497372
> >> >> >> > > [26 .rodata.str1.8] 0xffffffffc03ed1f0
> >> >> >> > > [11 __verbose] 0xffffffffc05c9398
> >> >> >> > > [1 .rodata.cst16.TWOONE] 0xffffffffc0498380
> >> >> >> > > [1 uevent] KEY=402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
> >> >> >> > > [1 .rodata.cst16.ONE] 0xffffffffc04983e0
> >> >> >> > > [8 .altinstructions] 0xffffffffc0498430
> >> >> >> > > [36 modules] crct10dif_pclmul 16384 1 - Live 0xffffffffc03f4000
> >> >> >> > > [1 ___srcu_struct_ptrs] 0xffffffffc03840d0
> >> >> >> > > 
> >> >> 
> >> >> This list of "leaked" memory seems to include the __tracepoint_ptrs
> >> >> as well. So at least you seem to have the same behavior as the tracepoint
> >> >> code, which was your source of inspiration for this implementation,
> >> >> which is a good start.
> >> >> 
> >> >> So the remaining question is: is this memory allocated for module sections
> >> >> really leaked for each module, or is it an issue with memory allocation
> >> >> tracking ?
> >> > 
> > 
> > It looks to me like this has nothing to do with memory allocation. This is
> > the leaking_addresses.pl script isn't it? It basically finds out if
> > any /proc filesystem entries or dmesg lines have kernel addresses which could
> > be "leaking" into userspace. I have no idea which filesystem entries leak
> > these addresses.
> > 
> > This commit that introduced the script is:
> > 
> > commit 136fc5c41f349296db1910677bb7402b0eeff376
> > Author: Tobin C. Harding <me@tobin.cc>
> > Date:   Mon Nov 6 16:19:27 2017 +1100
> > 
> >    scripts: add leaking_addresses.pl
> > 
> >    Currently we are leaking addresses from the kernel to user space. This
> >    script is an attempt to find some of those leakages. Script parses
> >    `dmesg` output and /proc and /sys files for hex strings that look like
> >    kernel addresses.
> 
> Then I suspect we have a likely culprit here:
> 
> root@thinkos:/sys# cat /sys/module/*/sections/__tracepoints_ptrs
> 0xffffffffc07865c0
> 0xffffffffc0bad3e8
> 0xffffffffc0b19808
> 0xffffffffc0847b80
> 0xffffffffc0ea7078
> 0xffffffffc07cb260
> 0xffffffffc0f32038
> 0xffffffffc055cc68
> 0xffffffffc10b1970
> 0xffffffffc0a209f0
> 0xffffffffc0612a00
> 0xffffffffc041df40
> 0xffffffffc0abe6a8
> 0xffffffffc09fb688
> 0xffffffffc0ce8c58
> 0xffffffffc08b7660
> 0xffffffffc092bd28
> 0xffffffffc04ccc90
> 
> Which seems to be a "feature" from module.c.
> 

Aha, it is a feature not a bug then ;-)

In Android, our security team disables access to all of these through
selinux.

thanks,

 - Joel
