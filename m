Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3782BC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083B72072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgAFJY3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:24:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:33548 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgAFJY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:24:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 01:24:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,402,1571727600"; 
   d="scan'208";a="420649735"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jan 2020 01:24:28 -0800
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jan 2020 01:24:28 -0800
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jan 2020 01:24:27 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.30]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.245]) with mapi id 14.03.0439.000;
 Mon, 6 Jan 2020 17:24:26 +0800
From:   "Liu, Chuansheng" <chuansheng.liu@intel.com>
To:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH] x86/mce/therm_throt: Fix the access of uninitialized
 therm_work
Thread-Topic: [PATCH] x86/mce/therm_throt: Fix the access of uninitialized
 therm_work
Thread-Index: AQHVxFzlxQRcQtSYTE6XKuL77zdvEafcsTeAgAAA4ICAAKrY0A==
Date:   Mon, 6 Jan 2020 09:24:25 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A615FC310@SHSMSX101.ccr.corp.intel.com>
References: <20200106064155.64-1-chuansheng.liu@intel.com>
 <20200106070759.GB12238@zn.tnic> <20200106071107.GA95725@gmail.com>
In-Reply-To: <20200106071107.GA95725@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ingo Molnar <mingo.kernel.org@gmail.com> On Behalf Of Ingo Molnar
> Sent: Monday, January 6, 2020 3:11 PM
> To: Borislav Petkov <bp@alien8.de>
> Cc: Liu, Chuansheng <chuansheng.liu@intel.com>; linux-kernel@vger.kernel.org;
> Luck, Tony <tony.luck@intel.com>; tglx@linutronix.de; mingo@redhat.com;
> hpa@zytor.com
> Subject: Re: [PATCH] x86/mce/therm_throt: Fix the access of uninitialized
> therm_work
> 
> * Borislav Petkov <bp@alien8.de> wrote:
> 
> > On Mon, Jan 06, 2020 at 06:41:55AM +0000, Chuansheng Liu wrote:
> > > In ICL platform, it is easy to hit bootup failure with panic
> > > in thermal interrupt handler during early bootup stage.
> > >
> > > Such issue makes my platform almost can not boot up with
> > > latest kernel code.
> > >
> > > The call stack is like:
> > > kernel BUG at kernel/timer/timer.c:1152!
> > >
> > > Call Trace:
> > > __queue_delayed_work
> > > queue_delayed_work_on
> > > therm_throt_process
> > > intel_thermal_interrupt
> > > ...
> > >
> > > When one CPU is up, the irq is enabled prior to CPU UP
> > > notification which will then initialize therm_worker.
> >
> > You mean the unmasking of the thermal vector at the end of
> > intel_init_thermal()?
> >
> > If so, why don't you move that to the end of the notifier and unmask it
> > only after all the necessary work like setting up the workqueues etc, is
> > done, and save yourself adding yet another silly bool?
> 
> A debugging WARN_ON_ONCE() when the workqueue is not initialized yet
> would also be useful I suspect. This would turn any remaining race-crash
> boot failure in this area into a warning.
> 
Thanks Ingo.
That's a good suggestion, I can try to make another patch about it later.

Best Regards
Chuansheng
