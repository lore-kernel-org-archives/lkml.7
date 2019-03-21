Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A992EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854DD21902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbfCURDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:03:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfCURDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:03:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E59688AB1;
        Thu, 21 Mar 2019 17:03:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89AEA19C57;
        Thu, 21 Mar 2019 17:03:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAGXu5jJvSk=sJbjE+-6USvr4qXHxxwEOK64_FAWh74-eBkm+YQ@mail.gmail.com>
References: <CAGXu5jJvSk=sJbjE+-6USvr4qXHxxwEOK64_FAWh74-eBkm+YQ@mail.gmail.com> <155316885201.29437.3428987891437242750.stgit@warthog.procyon.org.uk> <155316888615.29437.17558157678296689830.stgit@warthog.procyon.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/8] vfs: Convert pstore to fs_context
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26698.1553187790.1@warthog.procyon.org.uk>
Date:   Thu, 21 Mar 2019 17:03:10 +0000
Message-ID: <26699.1553187790@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 21 Mar 2019 17:03:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> wrote:

> Why the separation between parse and apply now? Is this due to the
> reconfigure calls? (i.e. why not call pstore_set_kmsg_bytes() in
> pstore_parse_param()?

Because parameter parsing is now done up front, before the creation of the
superblock of the invocation of the reconfigure method - so there's still a
bunch of places that can error out before you know you're going to be
successful in creating/reconfiguring the superblock.

David
