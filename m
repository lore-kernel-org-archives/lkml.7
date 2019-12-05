Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8152FC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571E420707
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFAhQkOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfLENGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:06:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43179 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729441AbfLENGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575551200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pIbfnsWyjUzYuMMUtvP8cBzLFVnihHBsEg4LNJqdKgI=;
        b=VFAhQkOliGfW0YrTIpq45VNIS6YzkAjf04TVvwaK3DxhQSIVqJvchDydPEGe+LsdstTBE6
        nCBpucYKeSNa0sKenKTV2CLUvjfh5sz8sfZ0q2q3Gd6MF0DhbC+OHFLcxx1UAE0FYrWdfZ
        fN6fTMl9tgwUD9RS+luCUFU5LTo4/4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-7hcZwkCJNWex1a5zYOwlZw-1; Thu, 05 Dec 2019 08:06:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EC6CDB35;
        Thu,  5 Dec 2019 13:06:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6179260135;
        Thu,  5 Dec 2019 13:06:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20191205072838.GA3237@sol.localdomain>
References: <20191205072838.GA3237@sol.localdomain> <000000000000a376820598b2eb97@google.com> <20191205054023.GA772@sol.localdomain>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     dhowells@redhat.com, amit@kernel.org, arnd@arndb.de,
        syzbot <syzbot+d37abaade33a934f16f2@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, jannh@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        virtualization@lists.linux-foundation.org, willy@infradead.org
Subject: Re: kernel BUG at fs/pipe.c:LINE!
MIME-Version: 1.0
Content-ID: <27080.1575551190.1@warthog.procyon.org.uk>
Date:   Thu, 05 Dec 2019 13:06:30 +0000
Message-ID: <27081.1575551190@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 7hcZwkCJNWex1a5zYOwlZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:

> static __poll_t
> pipe_poll(struct file *filp, poll_table *wait)
> {
>         __poll_t mask;
>         struct pipe_inode_info *pipe =3D filp->private_data;
>         unsigned int head =3D READ_ONCE(pipe->head);
>         unsigned int tail =3D READ_ONCE(pipe->tail);
>=20
>         poll_wait(filp, &pipe->wait, wait);
>=20
>         BUG_ON(pipe_occupancy(head, tail) > pipe->ring_size);
>=20
> It's not holding the pipe mutex, right?  So 'head', 'tail' and 'ring_size=
' can
> all be changed concurrently, and they aren't read atomically with respect=
 to
> each other.
>=20
> How do you propose to implement poll() correctly with the new head + tail
> approach?  Just take the mutex?

Firstly, the BUG_ON() check probably isn't necessary here - the same issue
with occupancy being seen to be greater than the queue depth existed
previously (there was no locking around the read of pipe->nrbufs and
pipe->buffers).  I added a sanity check.

Secondly, it should be possible to make it such that just the spinlock
suffices.  The following few patches make the main pipe read/write routines
use the spinlock so as not to be interfered with by notification insertion.

I didn't roll the spinlock out to splice and suchlike since I prohibit
splicing to a notifications pipe because of the iov_iter_revert() fun.

David

