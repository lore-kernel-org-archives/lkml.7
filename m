Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D27C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3442053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557246586;
	bh=HydT7mdg9YKE0YlCquV+jJBxsbV6UX7TylyFZiB787c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bxajdOMN6L5Cb0N+hRRpn3KNQZ6dVBNbnLqFZJFfEw+qwpzUiae7SyolUyBbwvMFr
	 /CdQ7csnbgdUSG/AMqJSix4ihLRgLv94hgszcEjZDHeOoZJ3Jax58Q9B605549l6MH
	 7GreCh5lk0ICFOL//7LomCX988DjhVrI1z1KLAD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfEGQ3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:29:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfEGQ3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:29:45 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04D8D205C9;
        Tue,  7 May 2019 16:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557246584;
        bh=HydT7mdg9YKE0YlCquV+jJBxsbV6UX7TylyFZiB787c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrnMyRwMwRudUklA0mNBpQhSPIbk8Ay3W6bMnDCplhfOXhHVlWsu/KgILCn1MWHOu
         7kWlnFV5M2vFJG1btZnYN6qbtuBKcl7ZNBkd+FmuScm50o32qbacxlLrbR7LIDQiqh
         Z17WhDYrHB+lXwryq9robNVX9U2qqfrZUl3WB8d4=
Date:   Tue, 7 May 2019 12:29:42 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 50/95] fsnotify: generalize handling of
 extra event flags
Message-ID: <20190507162942.GD1747@sasha-vm>
References: <20190507053826.31622-1-sashal@kernel.org>
 <20190507053826.31622-50-sashal@kernel.org>
 <20190507132330.GB4635@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190507132330.GB4635@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 03:23:30PM +0200, Jan Kara wrote:
>On Tue 07-05-19 01:37:39, Sasha Levin wrote:
>> From: Amir Goldstein <amir73il@gmail.com>
>>
>> [ Upstream commit 007d1e8395eaa59b0e7ad9eb2b53a40859446a88 ]
>>
>> FS_EVENT_ON_CHILD gets a special treatment in fsnotify() because it is
>> not a flag specifying an event type, but rather an extra flags that may
>> be reported along with another event and control the handling of the
>> event by the backend.
>>
>> FS_ISDIR is also an "extra flag" and not an "event type" and therefore
>> desrves the same treatment. With inotify/dnotify backends it was never
>> possible to set FS_ISDIR in mark masks, so it did not matter.
>> With fanotify backend, mark adding code jumps through hoops to avoid
>> setting the FS_ISDIR in the commulative object mask.
>>
>> Separate the constant ALL_FSNOTIFY_EVENTS to ALL_FSNOTIFY_FLAGS and
>> ALL_FSNOTIFY_EVENTS, so the latter can be used to test for specific
>> event types.
>>
>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>> Signed-off-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>
>Sasha, why did you select this patch? It is just a cleanup with no user
>visible effect and was done mostly to simplify implementing following
>features...

Sigh, my script picked up the patch after this one (by mistake). I've
dropped that one but missed this one twice(!). Thanks for the heads-up,
I'll drop it.

--
Thanks,
Sasha
