Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571BAC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179042063F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552324952;
	bh=4WobMUYFGKGZdwYwZpQOeHolrobeK8r4wqoeuD1Qo9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qLoLykt3X8xzlw0A0Wa5sViGhFVCyo02Y4EglNDxhWnT5vvcms2j4Ik8E/LgivrRY
	 t8XDCUvAoV0+CFEnTq1q4zpNQCPkBBiM4fbFgQSpNSBN74GxZl3XFsnhBHh9m8FJbA
	 TB1KYrE6VVzyqFHvaUXT86zZR2E5130j0+cNlpAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfCKRWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbfCKRWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:22:30 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7F962063F;
        Mon, 11 Mar 2019 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552324949;
        bh=4WobMUYFGKGZdwYwZpQOeHolrobeK8r4wqoeuD1Qo9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Xo96x4v77CMe8V7cCCXdbHD5idyRn5RFwkks9XClEiw6KT1vRLAtMeIo65xj7IEp
         V5XJ+5wv8mef2BKVJuaTYsoesqQT8OoAEK0i0xQc54Ln3ZhnuulhJ7s0J7amXu1bTJ
         v54WOFhnB9ifBYbrhdDyImihjkZ14iWbCh2/2gpc=
Date:   Mon, 11 Mar 2019 13:22:28 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.20 34/81] debugfs: return error values, not NULL
Message-ID: <20190311172228.GG158926@sasha-vm>
References: <20190228150813.10256-1-sashal@kernel.org>
 <20190228150813.10256-34-sashal@kernel.org>
 <20190228152501.GC8481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190228152501.GC8481@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 04:25:01PM +0100, Greg Kroah-Hartman wrote:
>On Thu, Feb 28, 2019 at 10:07:26AM -0500, Sasha Levin wrote:
>> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> [ Upstream commit ff9fb72bc07705c00795ca48631f7fffe24d2c6b ]
>>
>> When an error happens, debugfs should return an error pointer value, not
>> NULL.  This will prevent the totally theoretical error where a debugfs
>> call fails due to lack of memory, returning NULL, and that dentry value
>> is then passed to another debugfs call, which would end up succeeding,
>> creating a file at the root of the debugfs tree, but would then be
>> impossible to remove (because you can not remove the directory NULL).
>>
>> So, to make everyone happy, always return errors, this makes the users
>> of debugfs much simpler (they do not have to ever check the return
>> value), and everyone can rest easy.
>>
>> Reported-by: Gary R Hook <ghook@amd.com>
>> Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
>> Reported-by: Michal Hocko <mhocko@kernel.org>
>> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
>> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  fs/debugfs/inode.c | 39 ++++++++++++++++++++++-----------------
>>  1 file changed, 22 insertions(+), 17 deletions(-)
>
>As much as I would love to backport this patch, no, please do not, I did
>not mark it for stable on purpose.  It can cause regressions with code
>that is not expecting this behavior (I have a fix that needs to go into
>5.0 for this very reason.)
>
>Please drop it from all queues.

I've dropped this and the rest of the debugfs related patches you've
pointed out, thank you.

--
Thanks,
Sasha
