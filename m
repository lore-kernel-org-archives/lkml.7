Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CE9C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C442082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfHSIXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 04:23:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfHSIXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 04:23:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49A39195C2E8;
        Mon, 19 Aug 2019 08:23:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24DF8104B4ED;
        Mon, 19 Aug 2019 08:23:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190819071101.5796-1-hdanton@sina.com>
References: <20190819071101.5796-1-hdanton@sina.com> 
To:     Hillf Danton <hdanton@sina.com>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+1e0edc4b8b7494c28450@syzkaller.appspotmail.com>,
        davem@davemloft.net, dvyukov@google.com, ebiggers@kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at net/rxrpc/local_object.c:LINE!
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21981.1566202980.1@warthog.procyon.org.uk>
Date:   Mon, 19 Aug 2019 09:23:00 +0100
Message-ID: <21982.1566202980@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Mon, 19 Aug 2019 08:23:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

There are some commits in net/master that ought to fix this and conflict with
your longer patch:

	730c5fd42c1e3652a065448fd235cb9fafb2bd10
	rxrpc: Fix local endpoint refcounting

	68553f1a6f746bf860bce3eb42d78c26a717d9c0
	rxrpc: Fix local refcounting

	b00df840fb4004b7087940ac5f68801562d0d2de
	rxrpc: Fix local endpoint replacement

	06d9532fa6b34f12a6d75711162d47c17c1add72
	rxrpc: Fix read-after-free in rxrpc_queue_local()

After the first one, you should never see local->usage == 0 in
rxrpc_input_packet() as the UDP socket gets closed before the refcount is
reduced to 0 (there's now a second "usage" count that counts how many times
the local endpoint is in use and local->usage is the refcount for the struct
itself).

Thanks,
David
