Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C47C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1F92067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbfGOOwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:52:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:36524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391784AbfGOOwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:52:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6CA2B0B8;
        Mon, 15 Jul 2019 14:52:12 +0000 (UTC)
Subject: Re: [PATCH] x86/paravirt: Drop {read,write}_cr8() hooks
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        FengTang <feng.tang@intel.com>, X86 ML <x86@kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J.Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Alok Kataria <akataria@vmware.com>,
        Nadav Amit <namit@vmware.com>
References: <20190715130056.10627-1-andrew.cooper3@citrix.com>
 <a04918d1-975e-5869-1ecd-c9df4ae5b1c1@suse.com>
 <CALCETrX0T=vzyN8gqoBmA72xwzS45d5bDTfcZQJayht9n9ijPA@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <f51ce980-599b-cae3-e3fa-4a67443ea128@suse.com>
Date:   Mon, 15 Jul 2019 16:52:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CALCETrX0T=vzyN8gqoBmA72xwzS45d5bDTfcZQJayht9n9ijPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.19 16:26, Andy Lutomirski wrote:
> On Mon, Jul 15, 2019 at 6:23 AM Juergen Gross <jgross@suse.com> wrote:
>>
>> On 15.07.19 15:00, Andrew Cooper wrote:
>>> There is a lot of infrastructure for functionality which is used
>>> exclusively in __{save,restore}_processor_state() on the suspend/resume
>>> path.
>>>
>>> cr8 is an alias of APIC_TASKPRI, and APIC_TASKPRI is saved/restored
>>> independently by lapic_{suspend,resume}().
>>
>> Aren't those called only with CONFIG_PM set?
>>
> 
> 
> Unless I'm missing something, we only build any of the restore code
> (including the write_cr8() call) if CONFIG_PM_SLEEP is set, and that
> selects CONFIG_PM, so we should be fine, I think.
> 

Okay, in that case I'd suggest to remove "cr8" from struct saved_context
as it won't be used any longer.


Juergen
