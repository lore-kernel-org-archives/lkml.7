Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E7AC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A26520815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570540461;
	bh=+u+cQxm8JdKrCxdpcSAMzhnyHTqxMj49DMlRcdTVypE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M7BDJ+hQPEwtqp/yOIvR0mCQDUHJkXRKA8Qv76RCDRVTEr1OLk/3SizsAwsUuGC2o
	 oJbV3feTU2zJLVpQdfYGfUMJneUrV+kWIXAlx+opxD5M/1V8k5rpQ0MazTYDdwWFgm
	 Xiv4U33kRbClHXNGjkSTSmazAR4twFG8v0c6Jrwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfJHNOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:14:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730332AbfJHNOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:14:20 -0400
Received: from localhost (unknown [89.205.136.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1974206BB;
        Tue,  8 Oct 2019 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570540459;
        bh=+u+cQxm8JdKrCxdpcSAMzhnyHTqxMj49DMlRcdTVypE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7IdQRdCuoVQPBLHBE/wFlWAXSiz3PulERsfbY7K3SllRrGQrk5I0PPHrlqgzVCM2
         qnW9f8bri5cmEQaGA8jU368KV87F3NM3zEqungOR2miW1fAcLoEKSPLJXk4jLD4/UQ
         9XtLQsSWfHA/y9ijL+KvAf5w9uYmMdlv78MwvD3M=
Date:   Tue, 8 Oct 2019 15:14:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191008131416.GA2860109@kroah.com>
References: <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
 <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk>
 <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk>
 <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk>
 <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <20191008045712.GR26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008045712.GR26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 05:57:12AM +0100, Al Viro wrote:
> 
> 	OK...  BTW, do you agree that the use of access_ok() in
> drivers/tty/n_hdlc.c:n_hdlc_tty_read() is wrong?  It's used as an early
> cutoff, so we don't bother waiting if user has passed an obviously bogus
> address.  copy_to_user() is used for actual copying there...

Yes, it's wrong, and not needed.  I'll go rip it out unless you want to?

thanks,

greg k-h
