Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C10C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E222186A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552820692;
	bh=Ly+J4Z6Dq25YOFCa/OR3v5B01n9/VzcGTcpISwqf8L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IS/dQ/h66kM4aaAZtyAmjwBXxwPlBU0mqvhGbuZ/rhAFGbqpWGbd7E7FIEqrFSqX8
	 +OtXEub5XHtX6MqFcviPh2WhZ6FaoBqlGXTAGLzXnQzuUkkOI2yNoUthiusqVY4yoM
	 6NTb261EU3KNqei4F4HmMHNBKfrnw9Kid3jyPaZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCQLEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbfCQLEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 07:04:50 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53BD221019;
        Sun, 17 Mar 2019 11:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552820690;
        bh=Ly+J4Z6Dq25YOFCa/OR3v5B01n9/VzcGTcpISwqf8L0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ky1660ZF5IxRYo3+e93lTKzAkVsPxlxhT+j/f51FHnIctlZGL5a+JjcFSv6mLBxVo
         awsVMkrnM6QxycAUk8YyhRmj7uqDapyinZVkW7kViogWxE0Wbg/v5Sclspoioo0PQH
         LrxpgScU/GEdSh51tbK+6wnJ/3SuMZUlxsaoRA/I=
Date:   Sun, 17 Mar 2019 12:04:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+111bc509cd9740d7e4aa@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, devel@driverdev.osuosl.org,
        douly.fnst@cn.fujitsu.com, dvyukov@google.com,
        forest@alittletooquiet.net, hpa@zytor.com, konrad.wilk@oracle.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mingo@redhat.com, peterz@infradead.org,
        puwen@hygon.cn, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, tvboxspy@gmail.com, wang.yi59@zte.com.cn,
        x86@kernel.org
Subject: Re: WARNING in rcu_check_gp_start_stall
Message-ID: <20190317110447.GA3885@kroah.com>
References: <0000000000007da94e05827ea99a@google.com>
 <0000000000009b8d8a058447efc5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009b8d8a058447efc5@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 03:43:01AM -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit f1e3e92135202ff3d95195393ee62808c109208c
> Author: Malcolm Priestley <tvboxspy@gmail.com>
> Date:   Wed Jul 22 18:16:42 2015 +0000
> 
>     staging: vt6655: fix tagSRxDesc -> next_desc type
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111856cf200000
> start commit:   f1e3e921 staging: vt6655: fix tagSRxDesc -> next_desc type
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=131856cf200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=151856cf200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
> dashboard link: https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d4966cc00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c492d0c00000
> 
> Reported-by: syzbot+111bc509cd9740d7e4aa@syzkaller.appspotmail.com
> Fixes: f1e3e921 ("staging: vt6655: fix tagSRxDesc -> next_desc type")

I think syzbot is a bit confused here, how can this simple patch, where
you do not have the hardware for this driver, cause this problem?

thanks,

greg k-h
