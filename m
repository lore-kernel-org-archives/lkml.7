Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57812C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6A620672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtWa9axG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfKUQrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:47:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51757 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726541AbfKUQq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574354818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Qn10hWiy8/uuGhAalu5dcn/1mOJukydQej1fnpUxnI=;
        b=PtWa9axGY/iI8kLfNNo1nOSUTVzZA3g13C+aY36NpOCyOHYgg7j5YRVHUu5Gp/VmMOtkPj
        K/2dEC55qBKtV7xtZ2JcHUyO57X+gY2xk2i41naH4xd1YMu8DAv8D21c+XRfvj+RRgJc71
        m0wDyKSF75BHV7Qet+c+qkowEm07ORo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-6h2M2xD7NiC0_q3MyI91Sg-1; Thu, 21 Nov 2019 11:46:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4899107ACCC;
        Thu, 21 Nov 2019 16:46:52 +0000 (UTC)
Received: from suzdal.zaitcev.lan (ovpn-117-3.phx2.redhat.com [10.3.117.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1DB310631CE;
        Thu, 21 Nov 2019 16:46:51 +0000 (UTC)
Date:   Thu, 21 Nov 2019 10:46:51 -0600
From:   Pete Zaitcev <zaitcev@redhat.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <jrdr.linux@gmail.com>, <keescook@chromium.org>,
        <kstewart@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <tglx@linutronix.de>,
        <viro@zeniv.linux.org.uk>, zaitcev@redhat.com
Subject: Re: possible deadlock in mon_bin_vma_fault
Message-ID: <20191121104651.0d50d2bd@suzdal.zaitcev.lan>
In-Reply-To: <Pine.LNX.4.44L0.1911211118450.1553-100000@iolanthe.rowland.org>
References: <20191121084842.095edf87@suzdal.zaitcev.lan>
        <Pine.LNX.4.44L0.1911211118450.1553-100000@iolanthe.rowland.org>
Organization: Red Hat, Inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 6h2M2xD7NiC0_q3MyI91Sg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 11:20:20 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Thu, 21 Nov 2019, Pete Zaitcev wrote:
>=20
> > Anyway... If you are looking at it too, what do you think about not usi=
ng
> > any locks in mon_bin_vma_fault() at all? Isn't it valid? I think I trie=
d
> > to be "safe", but it only uses things that are constants unless we're
> > opening and closing; a process cannot make page faults unless it has
> > some thing mapped; and that is only possible if device is open and stay=
s
> > open. Can you find a hole in this reasoning? =20
>=20
> I think you're right.  But one thing concerns me: What happens if the=20
> same buffer is mapped by more than one process?  Do you allow that?

Yes, we allow 2 processes reading from mmap in the same time.
They may miss events, but there should be no issue to the internal
consistency of any pointers in usbmon, and no crashes or deadlocks.
Also, we cannot prohibit that. Imagine a process that does open(),
mmap(), fork()/clone().

-- Pete

