Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D86C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316B120821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555420927;
	bh=b+hZZXkghxVJ0R/7hRLTSdMoo41Ex8NN8b1hb1zTjNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sxr5+2777dDSQh9fwXZpLiJxCJpSDdxtyTdc4+H5wE77VYgR0Ncu239wKke4KAJZR
	 6PEVNtDsTSpXOApF0eAAlE41GWPmo9Mv9QKDPXzjTLSsoJE/313gKMofqKP7Fbu6Dq
	 LTV5aaZCZ3+njVMncTaHeWODXgLP/QN5at62jpYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfDPNWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfDPNWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:22:06 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD8372077C;
        Tue, 16 Apr 2019 13:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555420925;
        bh=b+hZZXkghxVJ0R/7hRLTSdMoo41Ex8NN8b1hb1zTjNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmauViKrdzdc0nz4Szt87QdgFkgNih2tYaRpMyJUs95ACybZ2BJZF7tOnu+5fC4lO
         NHiS6yDUOHQlT9pD/FGzAlgT4rTtKaAHk/lAUsQvhLPSU1LQYSGci5lHLlhd3E6dNv
         l0pF1FCkOoiouGnIglXYgSn9TW0CZKewrMobxH54=
Date:   Tue, 16 Apr 2019 09:22:03 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bpetkov@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.14 05/69] x86/power: Make restore_processor_context()
 sane
Message-ID: <20190416132203.GY11568@sasha-vm>
References: <20190415183726.036654568@linuxfoundation.org>
 <20190415183727.581656002@linuxfoundation.org>
 <20190415200452.GA25908@amd>
 <CALCETrW9E8Y1vxn377jU_P2cQBw0oR2VDJGUkUKKH3RJEByiPQ@mail.gmail.com>
 <20190416115644.GA7009@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190416115644.GA7009@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 01:56:44PM +0200, Pavel Machek wrote:
>On Mon 2019-04-15 13:18:56, Andy Lutomirski wrote:
>> On Mon, Apr 15, 2019 at 1:04 PM Pavel Machek <pavel@denx.de> wrote:
>> >
>> > On Mon 2019-04-15 20:58:23, Greg Kroah-Hartman wrote:
>> > > [ Upstream commit 7ee18d677989e99635027cee04c878950e0752b9 ]
>> > >
>> > > My previous attempt to fix a couple of bugs in __restore_processor_context():
>> > >
>> > >   5b06bbcfc2c6 ("x86/power: Fix some ordering bugs in __restore_processor_context()")
>> > >
>> > > ... introduced yet another bug, breaking suspend-resume.
>> > >
>> > > Rather than trying to come up with a minimal fix, let's try to clean it up
>> > > for real.  This patch fixes quite a few things:
>> >
>> > 5b06bbcfc2c6 fixed theoretical bug; rather than porting it to stable
>> > than fixing it up, it would be better not to port it to stable in the
>> > first place or simply revert it there.
>>
>> Are you sure about that?  The bug was reported by real users who had
>> their systems really crash:
>>
>> https://lore.kernel.org/lkml/?q=0fede9f9-88b0-a6e7-1027-dfb2019b8ef2%40linux.intel.com
>>
>> https://lore.kernel.org/lkml/CA+55aFwsMuHUBQz5kDNwRf17JnasXMWjvmLq5qXGH-694yeq1w@mail.gmail.com/
>>
>> And we had a report that the bug got backported:
>>
>> https://lore.kernel.org/stable/20190407160005.djiw4reapwvbxmgo@debian/
>>
>> And if we're going to backport some of the fix, we should definitely
>> backport the whole set to avoid having the -stable kernels be in a
>> state that was never in any released kernel.
>
>I agree it should be all or nothing. And I may have been slightly
>confused.
>
>Anyway: 5b06bbcfc2c6 is fix for ca37e57bbe0cf, and that one is for
>"mostly harmless warning" (quoting changelog). ca37e57bbe0cf is not
>present in 4.4.178, I believe best solution is not to add that one in
>the first place, so we don't have to fix it up.

5b06bbcfc2c6 describes in it's commit message two bugs that it fixes:
one, as you pointed out, is fixing an issue introduced by ca37e57bbe0cf.
The other one which to my understanding is unrelated to ca37e57bbe0cf,
is fixing "resume when the userspace process that initiated suspect had
funny segments", and provides a straightforward test case for that
issue.


--
Thanks,
Sasha

