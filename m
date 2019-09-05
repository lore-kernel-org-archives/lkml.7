Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7146CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E432082C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567698284;
	bh=7a2Kh0bbur1P82JOpkA0aiw3kRggM0voFXBHaO7YY/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xe90QhMLR+s8O/ZtS6IisRcOGlSsbgPEB1A2xTtJHem5dk10Dhme4N8WFjMx0oXaa
	 FQkI2ld+J/93wwXC+o2wbX/RVtL8jJw/FgYr9+MtyTBkdO5A3pOTV1NTt1ZfK0HXbX
	 um/2xT6/7lZhc2e+WN6gkxOnvBeca+re07YlnEvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390734AbfIEPom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390713AbfIEPoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:44:32 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B69C2082C;
        Thu,  5 Sep 2019 15:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567698272;
        bh=7a2Kh0bbur1P82JOpkA0aiw3kRggM0voFXBHaO7YY/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ml7qLSuNqjg1UBZnkxl1oKa+hyxi1Xdf8QCcw+SUVhrjATDzr427/gLMAq+X2bDHS
         n22hdd5dr+OpDLiJq5UldHzbbuWQVKWwKRF+LOfUje8LV6P6XND14QvUI/bEh3hxWT
         vVFnWnDlWgZlQZ1nYS5wxamIpSqlZhvt4YvBIi3o=
Date:   Thu, 5 Sep 2019 11:44:29 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/12] x86/hyper-v: Suspend/resume the hypercall page
 for hibernation
Message-ID: <20190905154429.GC1616@sasha-vm>
References: <1567470139-119355-1-git-send-email-decui@microsoft.com>
 <1567470139-119355-2-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1567470139-119355-2-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 12:23:16AM +0000, Dexuan Cui wrote:
>This is needed for hibernation, e.g. when we resume the old kernel, we need
>to disable the "current" kernel's hypercall page and then resume the old
>kernel's.
>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Hi Dexuan,

When sending patches upstream, please make sure you send them to all
maintainers and mailing lists that it needs to go to according to
MAINTAINERS/get_maintainers.py rather than cherry-picking names off the
list.

This is specially important in subsystems like x86 where it's a group
maintainers model, and it's very possible that Thomas is sipping
margaritas on a beach while one of the other x86 maintainers is covering
the tree.

This is quite easy with git-send-email and get_maintainers.py, something
like this:

	git send-email --cc-cmd="scripts/get_maintainer.pl --separator=, --no-rolestats" your-work.patch

Will do all of that automatically for you.

--
Thanks,
Sasha
