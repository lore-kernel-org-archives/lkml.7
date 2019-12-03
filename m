Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E346FC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7ADC205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfLCP5F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:57:05 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:32314 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLCP5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:57:05 -0500
IronPort-SDR: VxIQnOTTdlXd9liSPgcQK4Whyx+1NIppr0A3wHI5WoX7I7PM5yV6yk6SCqceLt7ygC/eZp5RdU
 3igOzQ+YnnDs2QNVsxcadO3eiPTyJzuD2FLLw7BttT6G5PmRzt9x70GnR7pQvWaWdmPv08ylJQ
 5xE9iZt5HpPLw21Rm8AEvP+2Oh5WFHAuywNy9c7/F/oa3XzBYufKrHoU3Qg/aaidJ+bApL9bvc
 +zerpKsMC9kJA+SlWMzZ8Bcu3iPXvZJXA6b6/CzpbgOCCO/Hl72lNM+yJkW5+edRT35pVMQlll
 ZYY=
X-IronPort-AV: E=Sophos;i="5.69,273,1571731200"; 
   d="scan'208";a="43664870"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 03 Dec 2019 07:57:04 -0800
IronPort-SDR: c1ll72oAVbrRtpN2MlMAv85kuHIg3Pr27RPIejF7/YT9Xhbihy7FV7ZULzNIJVc70ueP+dXMt3
 Qo9PGeJF0/sfI8kQW9J1WGAVQT10rQ47zKyNwyUsdKC+sJuzDQZnLI7U8ZjBTGy254lfwyIjBG
 /kJ8C8cEpFspjfpTtDhVJnWLgS99uuRf6NjJwL/LuWdE/Nd4se3czy6Cp842rA0u9/mfCA1CB2
 DSBhMhcSd73GZev26ztxqSIR8HgVLFie0sVs4LChY4VNTBQ2Oi9GWkIwpYrvlRo0J2iTgmNRW3
 RW0=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: Crash in fair scheduler
Thread-Topic: Crash in fair scheduler
Thread-Index: AQHVqbfg64Wqju89WkedWbWijDxswKeoNeoAgAACxACAAAgggIAAQtOAgAAMFgA=
Date:   Tue, 3 Dec 2019 15:57:00 +0000
Message-ID: <db86427565354261b1cbb5c2c4e7e2b1@SVR-IES-MBX-03.mgc.mentorg.com>
References: <1575364273836.74450@mentor.com>
 <564e45cb-8230-9c3d-24a8-b58e6e88349f@arm.com>
 <944927a7-b578-c6f9-a73d-25c5b0a39adb@arm.com>
 <e6178a95-c02e-4fe9-49ee-7446e0d73882@arm.com>
 <f4e810c0-c99a-e78f-a249-9d7efcb37806@arm.com>
In-Reply-To: <f4e810c0-c99a-e78f-a249-9d7efcb37806@arm.com>
Accept-Language: de-DE, en-IE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 03/12/2019 12:09, Valentin Schneider wrote:
> > On 03/12/2019 10:40, Dietmar Eggemann wrote:
> >> On 03/12/2019 11:30, Valentin Schneider wrote:
> >>> On 03/12/2019 09:11, Schmid, Carsten wrote:
> >>
> >> [...]
> 
> I can't reproduce it on Arm64 Juno running 4.14.86. I suppose that there
> is no extra reproducer testcase since the issue happened with
> prev->sched_class eq. &idle_sched_class [prev eq. swapper/X 0] in the
> simple path of pick_next_task_fair().
> 
> I'm running with CONFIG_SCHED_AUTOGROUP=y and
> CONFIG_FAIR_GROUP_SCHED=y
> some taskgroup related tests for hours now. So the sched_entity (se) can
> be a task, an autogroup or a taskgroup in the simple path. pref is
> either swapper/X or migration/X.

We have the same kernel config settings.
However, as i stated in the analysis, we had
prev->sched_class ne. &fair_sched_class
and, unfortunately, no reproducer.

Looks like we need to find out why rb_leftmost is 0x0/NULL.

