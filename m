Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9490AC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A60620B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559072869;
	bh=2x/kpWjIrXx7i4V/S0MSF7WalHAWI9P4iRFFKUB/dcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nM75itCHXfHSy8Np+iQ/Q0YIWB4kxISkHU12wHXloDTMar+M3MCn12L4O49yJ1Xxs
	 xeNotbs70r3UbH23K78dM+qcjlzFh6ARza7ulidneJ0Y/3Br0pUcPpkfRszKO3Wp/o
	 p1lujtmv+ThceqmIhwISvGq5ba8i8ZF+obIWAzDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfE1Trs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:47:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfE1Trs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:47:48 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 485D0208CB;
        Tue, 28 May 2019 19:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559072867;
        bh=2x/kpWjIrXx7i4V/S0MSF7WalHAWI9P4iRFFKUB/dcY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UPb72648xLz21Qw2AVX98fJIu3AXvw9tJ7cry8ZJmNR3QxIhMsP7F7vl7d2f1EfOM
         3TSg4RdszWr/CbE1VHmV6otJZdH3vrQJxCqWmj2BICi45SPjYxmB9eOj+lhEGPGz14
         wd4DgARUpY9sAm0I/eBf7C5wd3X7Z/QInGOhWkxc=
Date:   Tue, 28 May 2019 12:47:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     arnd@arndb.de, christian@brauner.io, deepa.kernel@gmail.com,
        glider@google.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        Oleg Nesterov <oleg@redhat.com>,
        syzbot <syzbot+0d602a1b0d8c95bdf299@syzkaller.appspotmail.com>
Subject: Re: KMSAN: kernel-infoleak in copy_siginfo_to_user (2)
Message-Id: <20190528124746.ac703cd668ca9409bb79100b@linux-foundation.org>
In-Reply-To: <87woia5vq3.fsf@xmission.com>
References: <000000000000410d500588adf637@google.com>
        <87woia5vq3.fsf@xmission.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 12:34:28 -0500 ebiederm@xmission.com (Eric W. Biederman) wrote:

> Didn't someone already provide a fix for this one?
> 
> I thought  I saw that hit your tree a while ago.  I am looking in
> ptrace.c and I don't see anything that would have fixed this issue.

I can't find anything which might have addressed this.

> If there isn't a fix in the queue I will take a stab at it.

Thanks.
