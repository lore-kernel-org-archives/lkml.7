Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0FEC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7FC223CA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfKTHNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 02:13:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:39472 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbfKTHNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 02:13:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BFE04B2E0;
        Wed, 20 Nov 2019 07:13:12 +0000 (UTC)
Subject: Re: [Xen-devel] Ping: [PATCH 0/2] x86/Xen/32: xen_iret_crit_fixup
 adjustments
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <d66b1da4-8096-9b77-1ca6-d6b9954b113c@suse.com>
 <09359c00-5769-0e0d-4af9-963897d3b498@suse.com>
 <40267a5b-8f1b-6463-72cd-f8f354c58bc4@oracle.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <c5988a7d-4cc0-390d-92a3-98e00038c3ea@suse.com>
Date:   Wed, 20 Nov 2019 08:13:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <40267a5b-8f1b-6463-72cd-f8f354c58bc4@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.2019 18:50, Boris Ostrovsky wrote:
> On 11/19/19 7:58 AM, Jan Beulich wrote:
>> On 11.11.2019 15:30, Jan Beulich wrote:
>>> The first patch here fixes another regression from 3c88c692c287
>>> ("x86/stackframe/32: Provide consistent pt_regs"), besides the
>>> one already addressed by
>>> https://lists.xenproject.org/archives/html/xen-devel/2019-10/msg01988.html.
>>> The second patch is a minimal bit of cleanup on top.
>>>
>>> 1: make xen_iret_crit_fixup independent of frame layout
>>> 2: simplify xen_iret_crit_fixup's ring check
>> Seeing that the other regression fix has been taken into -tip,
>> what is the situation here? Should 5.4 really ship with this
>> still unfixed?
> 
> 
> I am still unable to boot a 32-bit guest with those patches, crashing in
> int3_exception_notify with regs->sp zero.
> 
> When I revert to 3c88c692c287 the guest actually boots so my (?) problem
> was introduced somewhere in-between.

In order to even get as far as the patches here taking effect
you first need "x86/stackframe/32: repair 32-bit Xen PV" (which
is what "the other regression fix" in my ping refers to).

Jan
