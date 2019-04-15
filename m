Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBB8C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E292120880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555366083;
	bh=b2cuajjF73VQmsKO5wsxLH6+hE4W9NTDx57OxKqZIlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uucqy1W96LlkI75sOmozS1LO/6AidCqjCTsEaNtB8V+rOaS8jqnCC2V/xhwupNFkv
	 T4VUevPA6xeMfSYMbxd28M/usQCKPIVvmHUg3SjX7PEyu6A0PVGdhB/obnui0TFi4C
	 AKrLmcvc2DWhYNm6DC8teyWIURpJn0vStD4+oUx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfDOWIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbfDOWIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:08:01 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 124152075B;
        Mon, 15 Apr 2019 22:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555366080;
        bh=b2cuajjF73VQmsKO5wsxLH6+hE4W9NTDx57OxKqZIlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0CqOZAdroPzZR8Vzt2wv1Ye/473yZUpyLPl1l8G2MdZcqfQDy9q3w7bHHdbr10a5B
         HqrZE0RyUfDfYV9MJUCpeHUCR3g2g7JbRE3VQpRMciOKlHVx+F1rlBEFjxcCb06NKo
         +XaMvk3nuUcYLUGBL9HCJklTCkypoXt3LzqPFskE=
Date:   Mon, 15 Apr 2019 18:07:55 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bpetkov@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4.14 04/69] x86/power/32: Move SYSENTER MSR restoration
 to fix_processor_context()
Message-ID: <20190415220755.GW11568@sasha-vm>
References: <20190415183726.036654568@linuxfoundation.org>
 <20190415183727.431075450@linuxfoundation.org>
 <20190415200747.GC25908@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190415200747.GC25908@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:07:47PM +0200, Pavel Machek wrote:
>On Mon 2019-04-15 20:58:22, Greg Kroah-Hartman wrote:
>> [ Upstream commit 896c80bef4d3b357814a476663158aaf669d0fb3 ]
>>
>> x86_64 restores system call MSRs in fix_processor_context(), and
>> x86_32 restored them along with segment registers.  The 64-bit
>> variant makes more sense, so move the 32-bit code to match the
>> 64-bit code.
>>
>> No side effects are expected to runtime behavior.
>
>Again, this is cleanup, not a bugfix.

Indeed, these two are just preparatory patches rather than fixes.
Patches that come later need these.

--
Thanks,
Sasha
