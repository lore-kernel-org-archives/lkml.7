Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50F4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834A2206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="SAHNYq4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfC2DJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:09:24 -0400
Received: from mail.nic.cz ([217.31.204.67]:36252 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbfC2DJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:09:24 -0400
Received: from localhost (unknown [172.20.6.218])
        by mail.nic.cz (Postfix) with ESMTPS id D2E1F605FC;
        Fri, 29 Mar 2019 04:09:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1553828962; bh=Tk23hEB/1TTt4hP5H/u+0Krkjo239ofnkxeV5XtX+iA=;
        h=Date:From:To;
        b=SAHNYq4Krwkp5/2MMMNFxJSUrH8OXrXRtRdJdCAmDLPxLvmpbqATwPQpcbHZxAa56
         +PoPwIAF+zzSJtZe4IWOYbkO7lu+vtU4Zf20PgThSF0oJkyRRjYa+Lka2QhUQCdZIf
         v31yst7t+oATojlsIU8C9TNjNUD8mBtGvxtFxn+8=
Date:   Fri, 29 Mar 2019 04:09:22 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: kernfs: can read/write method grow buffer size?
Message-ID: <20190329040922.34ab01c6@nic.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun and Greg,

kernfs_fop_open/read/write allocates a buffer for the ->read, ->write,
or ->seq_read methods. This buffer is either preallocated or allocated
on the spot, with minimum size being PAGE_SIZE, if ->atomic_write_len
is not given.

There is a question/problem currently in the led-trigger API, that the
PAGE_SIZE buffer can in some specific scenarios be too short.
(The trigger file on read returns space separated list of all supported
triggers, and the currently chosen one is marked specially. The cpu
activity trigger lists "cpu%i" for all CPU cores, which actually broke
on some machines with very large number of CPUs. Granted, this could
have been solved another way (and maybe will be), but we are now
discussing API for HW LED triggers, which can raise the problem anyway,
if a specific LED controller supports too many HW LED triggers.)

Is it allowed to grow this buffer if needed, either via krealloc or by
creating a special function in kernfs API which does this so that
led-trigger could use it?

Or is this completely forbidden?

Thank you.

Marek
