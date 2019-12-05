Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11787C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66E420675
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwBIax3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfLEMCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:02:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34443 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729290AbfLEMCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575547351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=f2NmUbKKC6FoYnRToVZjacoBIsWU7+vk8fbrKuYYHUc=;
        b=NwBIax3DmMrUMBA+560yXokOjrr4CXJFuXDpUTYwbBS6+/cxmKio/0B2l0ObhDtsfRVyrO
        eGKSt0yQdNW7Xo0YGo5YPqgyDLsBB+p1CnxLVdpCwz1g6oaT4tRJVRUAelOIZQ2/Zp9KKV
        xUNTSUGMwnBBXjrFGTAfyJaClqA7XdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-bUeE24_SOeWu9ZYa8Y6vSA-1; Thu, 05 Dec 2019 07:02:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A62FE593A0;
        Thu,  5 Dec 2019 12:02:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96BC410013A1;
        Thu,  5 Dec 2019 12:02:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra (Intel) <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Problem with WARN_ON in mutex_trylock() and rxrpc
MIME-Version: 1.0
Content-ID: <26228.1575547344.1@warthog.procyon.org.uk>
Date:   Thu, 05 Dec 2019 12:02:24 +0000
Message-ID: <26229.1575547344@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: bUeE24_SOeWu9ZYa8Y6vSA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davidlohr,

commit a0855d24fc22d49cdc25664fb224caee16998683 ("locking/mutex: Complain u=
pon
mutex API misuse in IRQ contexts") is a bit of a problem for rxrpc, though
nothing that shouldn't be reasonably easy to solve, I think.

What happens is that rxrpc_new_incoming_call(), which is called in softirq
context, calls mutex_trylock() to prelock a new incoming call:

=09/* Lock the call to prevent rxrpc_kernel_send/recv_data() and
=09 * sendmsg()/recvmsg() inconveniently stealing the mutex once the
=09 * notification is generated.
=09 *
=09 * The BUG should never happen because the kernel should be well
=09 * behaved enough not to access the call before the first notification
=09 * event and userspace is prevented from doing so until the state is
=09 * appropriate.
=09 */
=09if (!mutex_trylock(&call->user_mutex))
=09=09BUG();

before publishing it.  This used to work fine, but now there are big splash=
y
warnings every time a new call comes in.

No one else can see the lock at this point, but I need to lock it so that
lockdep doesn't complain later.  However, I can't lock it in the preallocat=
or
- again because that upsets lockdep.

David

