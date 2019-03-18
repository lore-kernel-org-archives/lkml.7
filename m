Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CADDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C70C2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfCRJZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:25:11 -0400
Received: from albireo.enyo.de ([5.158.152.32]:51904 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfCRJZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:25:09 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1h5oVx-0000eE-QH; Mon, 18 Mar 2019 09:25:01 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.89)
        (envelope-from <fw@deneb.enyo.de>)
        id 1h5oSW-0007fc-Oe; Mon, 18 Mar 2019 10:21:28 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Josh Boyer <jwboyer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Law <law@redhat.com>
Subject: Re: [PATCH] y2038: fix socket.h header inclusion
References: <20190311153857.563743-1-arnd@arndb.de>
        <87k1h1fgkk.fsf@mid.deneb.enyo.de>
        <CAK8P3a1r8GRC7GTHHqWY-PUn=9rWB-7+Qo=7txanbEjGZ-wppw@mail.gmail.com>
        <87a7hvded7.fsf@mid.deneb.enyo.de>
        <CABeXuvrEecSAkBuN-SmAbGwhLWNCC+bA1=X78fm8xMyw8=hm6Q@mail.gmail.com>
        <CAK8P3a22n5L45Gknqd=2zinVGqRovkk0OABmGLJbGcmg8xXd+A@mail.gmail.com>
Date:   Mon, 18 Mar 2019 10:21:28 +0100
In-Reply-To: <CAK8P3a22n5L45Gknqd=2zinVGqRovkk0OABmGLJbGcmg8xXd+A@mail.gmail.com>
        (Arnd Bergmann's message of "Mon, 18 Mar 2019 09:27:46 +0100")
Message-ID: <87o968y1uv.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann:

> Should we just remove __kernel_fd_set from the exported headers and
> define the internal fd_set directly in include/linux/types.h? (Adding the
> folks from the old thread to Cc).

The type is used in the sanitizers, but incorrectly.  They assume that
FD_SETSIZE is always 1024.  (The existence of __kernel_fd_set is
itself somewhat questionable because it leads to such bugs.)  Moving
around the type could cause a build failure in the sanitizers, but I'm
not entirely clear how the UAPI headers are included there.

Otherwise, I couldn't find any uses.
