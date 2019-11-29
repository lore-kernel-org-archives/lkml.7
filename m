Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF618C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 17:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85372216F4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 17:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575050279;
	bh=vJOOfAq3Itw/Da/jBhb+gwC+mqd4jGT+yyfYWoBfvIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FPh0RS9PF5O2hDClyPd2P6aQ5mJtsN+MiRx81G1g2faSAgYPg72t0Wkb/AihPLoXZ
	 FjkItsPU006pnAEPdDuaWQIt+upFJhL0J6Zx+h9HNh0T3CQDBFdOqtXM9frTD44Fy/
	 cIPElRhwRXLhBSFzgk1/7iRlr7Jw2VvhRR6nY6OA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfK2R56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 12:57:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbfK2R56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 12:57:58 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48EF52158A;
        Fri, 29 Nov 2019 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575050277;
        bh=vJOOfAq3Itw/Da/jBhb+gwC+mqd4jGT+yyfYWoBfvIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JiaaasDmwLWpaT4HcbZdvzWAQu8WbCJzug4hwNE77iy5qXSzcwV+Q4WEPEji8woKM
         16Y3mO9CSK4VZuH2Yy0p7rEkVqWMOd+J/y4Z55Nv6AwyBWJUvdT4Z4/wdLEn1A9zfS
         woNgtdfkmeLyXqNGiNE+a/+uTg++rjz5fTfK2xF4=
Date:   Fri, 29 Nov 2019 17:57:53 +0000
From:   Will Deacon <will@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, bsingharora@gmail.com,
        dvyukov@google.com, elver@google.com, parri.andrea@gmail.com,
        stable@vger.kernel.org,
        syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v6] taskstats: fix data-race
Message-ID: <20191129175752.GB29789@willie-the-truck>
References: <20191009114809.8643-1-christian.brauner@ubuntu.com>
 <20191021113327.22365-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021113327.22365-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 01:33:27PM +0200, Christian Brauner wrote:
> When assiging and testing taskstats in taskstats_exit() there's a race
> when writing and reading sig->stats when a thread-group with more than
> one thread exits:
> 
> cpu0:
> thread catches fatal signal and whole thread-group gets taken down
>  do_exit()
>  do_group_exit()

Nit: I don't think this is the signal-handling path.

>  taskstats_exit()
>  taskstats_tgid_alloc()
> The tasks reads sig->stats without holding sighand lock.
> 
> cpu1:
> task calls exit_group()
>  do_exit()
>  do_group_exit()

Nit: These ^^ seem to be the wrong way round.

Will
