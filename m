Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F968C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF41B2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558561382;
	bh=60s6i7ZPAUH/aiozdFF7rMwm5CZ8TMHw1jtVxnjH01w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VJoJ4nu9JHzcdkCQA3OT6fvOzgFLcaH8AkKHfH3Vuh7Mv9s4hkCuVYP7d66OhZ/pX
	 7I8r1u+f0MdfAOQuT92G6aMcs6G3S/mK40v4G25b6MmZYV0xEXrqmzDt6IDOaV+vd4
	 0GoB+4Wzms3K0MzowXKIZDUoXwugGxIf1I1R1C8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbfEVVnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbfEVVnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:43:01 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59A3920868;
        Wed, 22 May 2019 21:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558561380;
        bh=60s6i7ZPAUH/aiozdFF7rMwm5CZ8TMHw1jtVxnjH01w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NJXskw4phL5ky5Z27RGfDZk0R6PZF7DtAxjuEglD1Mi/fGRFgstwnsaKfwXlPzjaQ
         rrielmX+m+rdao6bd9maekiqCYGiI9Ny4SRleRSqNmNaM1QIhs1xb6qyKHxUFjhAvD
         AcICSCqO0X+omxpaCDWh77qRUt+XOttg9UQ1mVqo=
Date:   Wed, 22 May 2019 14:43:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Liu Chuansheng <chuansheng.liu@intel.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] kernel/hung_task.c: Monitor killed tasks.
Message-Id: <20190522144300.5ea06345efd9a831803105b7@linux-foundation.org>
In-Reply-To: <20190523073925.169563ed@canb.auug.org.au>
References: <1557745331-10367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
        <20190515105540.vyzh6n62rqi5imqv@pathway.suse.cz>
        <ee7501c6-d996-1684-1652-f0f838ba69c3@i-love.sakura.ne.jp>
        <20190516115758.6v7oitg3vbkfhh5j@pathway.suse.cz>
        <a3d9de97-46e8-aa43-1743-ebf66b434830@i-love.sakura.ne.jp>
        <a6b6a5ef-c65c-6999-2bc1-7aaf9dd19fe8@i-love.sakura.ne.jp>
        <20190522234134.44327256@canb.auug.org.au>
        <03b5834d-5f8f-9c7e-20df-cfdf5395d245@i-love.sakura.ne.jp>
        <abbfb5df-40da-63c8-0333-805083397533@i-love.sakura.ne.jp>
        <20190523073925.169563ed@canb.auug.org.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019 07:39:25 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> > I put an example patch into my subversion repository:
> > 
> >   svn checkout https://svn.osdn.net/svnroot/tomoyo/branches/syzbot-patches/
> > 
> > To fetch up-to-date debug printk() patches:
> > 
> >   cd syzbot-patches
> >   svn update
> > 
> > Does this work for you?
> 
> Neither will fit into my normal workflow.
> 
> So, tell me, what are you trying to do?  What does you work depend on?
> Just Linus' tree, or something already in linux-next?  Why would you
> want to keep moving your patch(es) on top of linux-next?

um, I can carry developer-only linux-next debug patches.
