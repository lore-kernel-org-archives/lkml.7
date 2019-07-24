Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD58AC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1DF21BF6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfGXHtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 03:49:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfGXHte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:49:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3266F83F51;
        Wed, 24 Jul 2019 07:49:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D378919C58;
        Wed, 24 Jul 2019 07:49:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1563914986-26502-1-git-send-email-cai@lca.pw>
References: <1563914986-26502-1-git-send-email-cai@lca.pw>
To:     Qian Cai <cai@lca.pw>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        davem@davemloft.net, arnd@arndb.de, jakub@redhat.com,
        ndesaulniers@google.com, morbo@google.com, jyknight@google.com,
        natechancellor@gmail.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: fix -Wtype-limits compiler warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31572.1563954571.1@warthog.procyon.org.uk>
Date:   Wed, 24 Jul 2019 08:49:31 +0100
Message-ID: <31573.1563954571@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 24 Jul 2019 07:49:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <cai@lca.pw> wrote:

> Fix it by moving almost all of this multi-line macro into a proper
> function __get_order(), and leave get_order() as a single-line macro in
> order to avoid compilation errors.

The idea was that you could compile-time initialise a global variable with
get_order():

	int a = get_order(SOME_MACRO);

This is the same reason that ilog2() is a macro:

	int a = ilog2(SOME_MACRO);

See the banner comment on get_order():

 * This function may be used to initialise variables with compile time
 * evaluations of constants.

If you're moving the constant branch into __get_order(), an inline function,
then we'll no longer be able to do this and you need to modify the comment
too.  In fact, would there still be a point in having the get_order() macro?

Also, IIRC, older versions of gcc see __builtin_constant_p(n) == 0 inside an
function, inline or otherwise, even if the passed-in argument *is* constant.

David
