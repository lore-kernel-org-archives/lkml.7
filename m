Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BD9C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 23:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D586218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 23:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfDLX6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:58:15 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50964 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfDLX6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 19:58:14 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1EC861407660B;
        Fri, 12 Apr 2019 16:58:14 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:58:13 -0700 (PDT)
Message-Id: <20190412.165813.1409453216111845470.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/6] rxrpc: Fixes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <155508321298.11035.7196100250886302901.stgit@warthog.procyon.org.uk>
References: <155508321298.11035.7196100250886302901.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 12 Apr 2019 16:58:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Fri, 12 Apr 2019 16:33:33 +0100

> Here is a collection of fixes for rxrpc:
> 
>  (1) rxrpc_error_report() needs to call sock_error() to clear the error
>      code from the UDP transport socket, lest it be unexpectedly revisited
>      on the next kernel_sendmsg() call.  This has been causing all sorts of
>      weird effects in AFS as the effects have typically been felt by the
>      wrong RxRPC call.
> 
>  (2) Allow a kernel user of AF_RXRPC to easily detect if an rxrpc call has
>      completed.
> 
>  (3) Allow errors incurred by attempting to transmit data through the UDP
>      socket to get back up the stack to AFS.
> 
>  (4) Make AFS use (2) to abort the synchronous-mode call waiting loop if
>      the rxrpc-level call completed.
> 
>  (5) Add a missing tracepoint case for tracing abort reception.
> 
>  (6) Fix detection and handling of out-of-order ACKs.
> 
> For the patch series:
> 
> Tested-by: Jonathan Billings <jsbillin@umich.edu>

Series applied, thanks.
