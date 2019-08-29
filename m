Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A4CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E102189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567096940;
	bh=bRpqTp3EjTmLNhGd3WmD0wtWWTzJRaoQEOOaMMh/9qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r/hwqePwSfli9YPd4ym0zQAj4nzJNDWSJ5fSyv+nQvjNaXbWs0R5wI9i1ngNj8+JW
	 oCHpjCwp7ojo9UbxVTJ0Kab3ZR73csSm4ZPNXnmGc8vwwGIJnZzFhxeBsf7r2ffOlJ
	 AUcygxMD+TAT9ct4iUM5R3dpcnR1Ek465CW3sr4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfH2QmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfH2QmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:42:19 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 031752070B;
        Thu, 29 Aug 2019 16:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567096938;
        bh=bRpqTp3EjTmLNhGd3WmD0wtWWTzJRaoQEOOaMMh/9qU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KtLG/S2tSMFYc5IJeMsFlWVsyXjpRehwx+Mw4Cy0TBEsERF1DhBJvMZRxuTwnvkp1
         uVRPCVZrPmtgecc0hldS6Ie+52Q28fIDUhduZu7Z/L0nV18MC9bRH2qqx/a27YBkx6
         YQdw+rvueX/1l73Y6Gri7rMc/Vc/YyKvYOP05VCA=
Date:   Thu, 29 Aug 2019 12:42:17 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Tyler Hicks <tyhicks@canonical.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH AUTOSEL 4.14 05/14] binder: take read mode of mmap_sem in
 binder_alloc_free_page()
Message-ID: <20190829164217.GJ5281@sasha-vm>
References: <20190829105043.2508-1-sashal@kernel.org>
 <20190829105043.2508-5-sashal@kernel.org>
 <20190829151052.GB27650@elm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190829151052.GB27650@elm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 10:10:52AM -0500, Tyler Hicks wrote:
>Hello, Sasha!
>
>On 2019-08-29 06:50:34, Sasha Levin wrote:
>> From: Tyler Hicks <tyhicks@canonical.com>
>>
>> [ Upstream commit 60d4885710836595192c42d3e04b27551d30ec91 ]
>>
>> Restore the behavior of locking mmap_sem for reading in
>> binder_alloc_free_page(), as was first done in commit 3013bf62b67a
>> ("binder: reduce mmap_sem write-side lock"). That change was
>> inadvertently reverted by commit 5cec2d2e5839 ("binder: fix race between
>> munmap() and direct reclaim").
>>
>> In addition, change the name of the label for the error path to
>> accurately reflect that we're taking the lock for reading.
>>
>> Backporting note: This fix is only needed when *both* of the commits
>> mentioned above are applied. That's an unlikely situation since they
>> both landed during the development of v5.1 but only one of them is
>> targeted for stable.
>
>This patch isn't meant to be applied to 4.14 since commit 3013bf62b67a
>("binder: reduce mmap_sem write-side lock") was never brought back to
>4.14.
>
>My backporting note above isn't helpful for AUTOSEL purposes. Do you
>have a suggestion for what I could have done in the patch tags to convey
>that guidance to AUTOSEL?

Hey Tyler,

No, this is just me messing up. AUTOSEL actually handled this well.

What happened here you ask? This series is basically a set of patches
that fix a different fix that went into stable. It didn't go through the
regular AUTOSEL flow and I goofed up manually. Sorry for the noise, I've
dropped the patch.

--
Thanks,
Sasha
