Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D514EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A140921897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567166801;
	bh=h4NN9a2T8DqLmatt6itTbHbXgwma3IAOuyxfowNmtk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aZpM0sU47zQ31UXm+f6HKlUYC23Uz+4vw3288M4fr5oysvs9vb3sC2tpoQa1n1HiC
	 xXhcV2q8ONuodhbj7nfA7rEaefE16iUyn7y4hHRqhj8uh0LTZi9rdFfn45YX/8jBvx
	 nwWB8cLTaL1leHKJBleZEe4WS6fNQlfHZzv7FIV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfH3MGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbfH3MGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:06:40 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C56D21721;
        Fri, 30 Aug 2019 12:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567166799;
        bh=h4NN9a2T8DqLmatt6itTbHbXgwma3IAOuyxfowNmtk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E1GLbcF0a7cqDh0hfT0zlQlkRAI0swhBVHJ/GHvgDI8nASZzV5YceuQllv+9nVTN2
         H38bMEugduIeyxjV2jWG5ucaVv+iE3N05ibUlM5USJKtECjCQ1opwKBA1MMdEgMapR
         M07Gz2B4utQYP4+Fb5pWMUQc4pG1HenJDNXbz2LA=
Date:   Fri, 30 Aug 2019 08:06:38 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.2 51/76] x86/boot/compressed/64: Fix boot on
 machines with broken E820 table
Message-ID: <20190830120638.GW5281@sasha-vm>
References: <20190829181311.7562-1-sashal@kernel.org>
 <20190829181311.7562-51-sashal@kernel.org>
 <20190829221723.eicsws3q7gp6nx37@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190829221723.eicsws3q7gp6nx37@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 01:17:23AM +0300, Kirill A. Shutemov wrote:
>On Thu, Aug 29, 2019 at 02:12:46PM -0400, Sasha Levin wrote:
>> From: "Kirill A. Shutemov" <kirill@shutemov.name>
>>
>> [ Upstream commit 0a46fff2f9108c2c44218380a43a736cf4612541 ]
>>
>> BIOS on Samsung 500C Chromebook reports very rudimentary E820 table that
>> consists of 2 entries:
>>
>>   BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] usable
>>   BIOS-e820: [mem 0x00000000fffff000-0x00000000ffffffff] reserved
>>
>> It breaks logic in find_trampoline_placement(): bios_start lands on the
>> end of the first 4k page and trampoline start gets placed below 0.
>>
>> Detect underflow and don't touch bios_start for such cases. It makes
>> kernel ignore E820 table on machines that doesn't have two usable pages
>> below BIOS_START_MAX.
>>
>> Fixes: 1b3a62643660 ("x86/boot/compressed/64: Validate trampoline placement against E820")
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Borislav Petkov <bp@suse.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: x86-ml <x86@kernel.org>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203463
>> Link: https://lkml.kernel.org/r/20190813131654.24378-1-kirill.shutemov@linux.intel.com
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Please postpone backporting the patch (and into other trees). There's a
>fixup for it:
>
>http://lore.kernel.org/r/20190826133326.7cxb4vbmiawffv2r@box

Sure. Should I just queue it up for a week or two later (along with the
fixes), or do you want to let me know when?

--
Thanks,
Sasha
