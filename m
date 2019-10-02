Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042F9C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0A121D81
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfJBRD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:03:58 -0400
Received: from excelsior.roeckx.be ([195.234.45.115]:47097 "EHLO
        excelsior.roeckx.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbfJBRDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:03:55 -0400
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Oct 2019 13:03:55 EDT
Received: from intrepid.roeckx.be (localhost [127.0.0.1])
        by excelsior.roeckx.be (Postfix) with ESMTP id C5ECCA8A0291;
        Wed,  2 Oct 2019 16:55:37 +0000 (UTC)
Received: by intrepid.roeckx.be (Postfix, from userid 1000)
        id AC1F61FE0C11; Wed,  2 Oct 2019 18:55:34 +0200 (CEST)
Date:   Wed, 2 Oct 2019 18:55:33 +0200
From:   Kurt Roeckx <kurt@roeckx.be>
To:     linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>
Subject: Stop breaking the CSRNG
Message-ID: <20191002165533.GA18282@roeckx.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As OpenSSL, we want cryptograhic secure random numbers. Before
getrandom(), Linux never provided a good API for that, both
/dev/random and /dev/urandom have problems. getrandom() fixed
that, so we switched to it were available.

It was possible to combine /dev/random and /dev/urandom, and get
something that worked properly. You could call select() on
/dev/random and know that both were initialized when it returned.
But then select() started returning before /dev/random was
initialized, so that if you switch to /dev/urnadom, it's still
uninitialized.

A solution for that was that you could instead read 1 byte from
/dev/random, and then switch to /dev/urandom. But that also stopped
working, /dev/urandom can still be uninitialized when you can read from
/dev/random. So there no longer is a way to wait for /dev/urandom
to be initialized.

As a result of that, we now refuse to use /dev/urandom on recent
kernels, and require to use of getrandom(). (To make this work with
older userspace, this means we need to import all the different
__NR_getrandom defines, and do the system call ourself.)

But it seems people are now thinking about breaking getrandom() too,
to let it return data when it's not initialized by default. Please
don't.

If you think such a mode is useful for some applications, let them set
a flag, instead of the reverse.


Kurt

