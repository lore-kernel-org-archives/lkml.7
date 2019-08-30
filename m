Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0FFC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61E523426
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfH3OBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 10:01:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbfH3OBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:01:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35BAA18F350D;
        Fri, 30 Aug 2019 14:01:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BFF16012C;
        Fri, 30 Aug 2019 14:01:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190830104912.1090-1-colin.king@canonical.com>
References: <20190830104912.1090-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: use BIT_ULL for shifting to fix integer overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3078.1567173701.1@warthog.procyon.org.uk>
Date:   Fri, 30 Aug 2019 15:01:41 +0100
Message-ID: <3079.1567173701@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Fri, 30 Aug 2019 14:01:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> The expression 1 << nr_slots is evaluated with 32 bit integer arithmetic
> and can overflow before it is widened.

If it does, it's an error on the part of the caller.  See the banner comment:
1 <= nr_slots <= 9.

And, in any case, if nr_slots >= 64, using BIT_ULL wouldn't help...

David
