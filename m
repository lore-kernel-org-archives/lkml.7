Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF970C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D3023402
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567581464;
	bh=O7gd31mCUn7hGnnq9Vb4w9PGZAT1XR/l+yS7ir1reAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ON/AAWRjDn1KEiEjL6DGVChdzq00CZEC/EpNPT/NTYk41Z8afz24k9ELqcdq0jkGQ
	 xyfI6LI8LmN9Qm2Tduog8vzRR3W+dvUENbZFPnzVtPJixGxxMSfYBXR/GSGkI73dVj
	 n7DMLgYJhERdeut7yN5azeetav4F5tJLhH5i/qOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfIDHRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfIDHRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:17:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0DB32339D;
        Wed,  4 Sep 2019 07:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567581462;
        bh=O7gd31mCUn7hGnnq9Vb4w9PGZAT1XR/l+yS7ir1reAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NOhoz5G6GCo9WxNgbO+kAr9X58RxNU01X7KDOlCUdKrFrqKWCUaFCPbPw7tZM2iIn
         CPiyKY361fFEVx2mqCKpmYP678axzOBUqb92hV6f2hOh2VkrGTFYeGiuN0l6e2b0Ox
         uFLEMyB208cKexrDxkSbnJ4TrFkqYtEdFJxTLEns=
Date:   Wed, 4 Sep 2019 09:17:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org,
        Sean =?iso-8859-1?Q?Nyekj=E6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH] tty: n_gsm: avoid recursive locking with async port
 hangup
Message-ID: <20190904071740.GE18791@kroah.com>
References: <20190822215601.9028-1-martin@geanix.com>
 <4fd2d737-14a8-6fe6-16a1-c5e6d924f9e6@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fd2d737-14a8-6fe6-16a1-c5e6d924f9e6@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 09:42:31PM +0200, Martin Hundebøll wrote:
> On 22/08/2019 23.56, Martin Hundebøll wrote:
> > When tearing down the n_gsm ldisc while one or more of its child ports
> > are open, a lock dep warning occurs:
> > 
> > [   56.254258] ======================================================
> > [   56.260447] WARNING: possible circular locking dependency detected
> > [   56.266641] 5.2.0-00118-g1fd58e20e5b0 #30 Not tainted
> > [   56.271701] ------------------------------------------------------
> > [   56.277890] cmux/271 is trying to acquire lock:
> > [   56.282436] 8215283a (&tty->legacy_mutex){+.+.}, at: __tty_hangup.part.0+0x58/0x27c
> > [   56.290128]
> > [   56.290128] but task is already holding lock:
> > [   56.295970] e9e2b842 (&gsm->mutex){+.+.}, at: gsm_cleanup_mux+0x9c/0x15c
> > [   56.302699]
> > [   56.302699] which lock already depends on the new lock.
> > [   56.302699]
> > [   56.310884]
> > [   56.310884] the existing dependency chain (in reverse order) is:
> > [   56.318372]
> > [   56.318372] -> #2 (&gsm->mutex){+.+.}:
> > [   56.323624]        mutex_lock_nested+0x1c/0x24
> > [   56.328079]        gsm_cleanup_mux+0x9c/0x15c
> > [   56.332448]        gsmld_ioctl+0x418/0x4e8
> > [   56.336554]        tty_ioctl+0x96c/0xcb0
> > [   56.340492]        do_vfs_ioctl+0x41c/0xa5c
> > [   56.344685]        ksys_ioctl+0x34/0x60
> > [   56.348535]        ret_fast_syscall+0x0/0x28
> > [   56.352815]        0xbe97cc04
> > [   56.355791]
> > [   56.355791] -> #1 (&tty->ldisc_sem){++++}:
> > [   56.361388]        tty_ldisc_lock+0x50/0x74
> > [   56.365581]        tty_init_dev+0x88/0x1c4
> > [   56.369687]        tty_open+0x1c8/0x430
> > [   56.373536]        chrdev_open+0xa8/0x19c
> > [   56.377560]        do_dentry_open+0x118/0x3c4
> > [   56.381928]        path_openat+0x2fc/0x1190
> > [   56.386123]        do_filp_open+0x68/0xd4
> > [   56.390146]        do_sys_open+0x164/0x220
> > [   56.394257]        kernel_init_freeable+0x328/0x3e4
> > [   56.399146]        kernel_init+0x8/0x110
> > [   56.403078]        ret_from_fork+0x14/0x20
> > [   56.407183]        0x0
> > [   56.409548]
> > [   56.409548] -> #0 (&tty->legacy_mutex){+.+.}:
> > [   56.415402]        __mutex_lock+0x64/0x90c
> > [   56.419508]        mutex_lock_nested+0x1c/0x24
> > [   56.423961]        __tty_hangup.part.0+0x58/0x27c
> > [   56.428676]        gsm_cleanup_mux+0xe8/0x15c
> > [   56.433043]        gsmld_close+0x48/0x90
> > [   56.436979]        tty_ldisc_kill+0x2c/0x6c
> > [   56.441173]        tty_ldisc_release+0x88/0x194
> > [   56.445715]        tty_release_struct+0x14/0x44
> > [   56.450254]        tty_release+0x36c/0x43c
> > [   56.454365]        __fput+0x94/0x1e8
> > 
> > Avoid the warning by doing the port hangup asynchronously.
> 
> Any comments?

Sorry, was waiting to see if anyone would review this, I'll go do it
later today...
