Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F44C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7F820850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbfDJO1H convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:27:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:57806 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731557AbfDJO1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:27:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 07:27:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="133092435"
Received: from irsmsx105.ger.corp.intel.com ([163.33.3.28])
  by orsmga008.jf.intel.com with ESMTP; 10 Apr 2019 07:27:02 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 irsmsx105.ger.corp.intel.com ([169.254.7.31]) with mapi id 14.03.0415.000;
 Wed, 10 Apr 2019 15:26:34 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>
CC:     "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 1/1] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Topic: [PATCH 1/1] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU74+O1bcswLOEykmlT3LGNz7aj6Y1NTSAgAA9NAA=
Date:   Wed, 10 Apr 2019 14:26:33 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C4915F@IRSMSX102.ger.corp.intel.com>
References: <20190410112103.15170-1-elena.reshetova@intel.com>
 <20190410112103.15170-2-elena.reshetova@intel.com>
 <20190410114259.GB9293@gmail.com>
In-Reply-To: <20190410114259.GB9293@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmI1ZmY1OTQtZGM2OC00YTc4LTk1NjEtNWE4YmE2ZWIzMTA4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYjM1bzNDeTB2clVzeXUrS0pLTHhJSmV0NXU4Ymt3K2ZoZUJZOTdiM3J0dnFJTTFrdjBLcHdyNURJb0NoaUt0ciJ9
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> * Elena Reshetova <elena.reshetova@intel.com> wrote:
> 
> > 2)  Andy's tests, misc-tests: ./timing_test_64 10M sys_enosys
> >     base:                                        10000000 loops in 1.62224s = 162.22 nsec / loop
> >     random_offset (prandom_u32() every syscall): 10000000 loops in 1.64660s =
> 166.26 nsec / loop
> 
> Stupid question, how did you manage to buil timing_test_64? Here it fails
> with a bog standard gcc 7.3.0 x86-64 distro toolchain:
> 
>  dagon:~/luto-misc-tests.git> make timing_test_64
>  g++ -m64 -o timing_test_64 -O2 -g -std=gnu++11 -pthread -Wall  timing_test.cc -lrt -
> ldl
>  /usr/bin/ld: /tmp/cc8VRkuV.o: relocation R_X86_64_32S against `.text.startup' can
> not be used when making a PIE object; recompile with -fPIC
>  /usr/bin/ld: final link failed: Nonrepresentable section on outputcollect2: error: ld
> returned 1 exit status
>  Makefile:39: recipe for target 'timing_test_64' failed

I used -no-pie on CFLAGS/CCFLAGS for the whole set of tools.

Unfortunately, this was only the first problem. After it complains about 
rdwrgsbase asm case... That one I didn't quite understand, but because I could see that
this case wasn't used for particular measurements I was doing, I just commented that particular
case out. 

> 
> 
> I'm using cb7f9f0592f8, which is like 1.5 years old - is this still the
> latest and greatest:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/luto/misc-tests.git

Yes, same for me. 

Best Regards,
Elena.
