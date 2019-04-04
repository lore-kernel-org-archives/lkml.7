Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410E6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1894E206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfDDTTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:19:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52718 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfDDTTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:19:12 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hC7tE-0004ul-JE; Thu, 04 Apr 2019 19:19:08 +0000
Date:   Thu, 4 Apr 2019 20:19:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v2] acct: fix possible deadlock in acct_pin_kill
Message-ID: <20190404191908.GF2217@ZenIV.linux.org.uk>
References: <20190404105255.12189-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404105255.12189-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 01:52:55PM +0300, Amir Goldstein wrote:

> If new file is on the same fs as old file, acct_pin_kill(old) fail to
> file_start_write_trylock() and skip writing the old file, because
> sb_writers (of new) is already taken by acct_on().

	The above is BS, BTW.  sb_start_write() does *not*
make file_start_write_trylock() to fail.  It's basically
percpu_down_read() vs. percpu_down_read_trylock().

sb_wait_write() would have file_start_write_trylock() fail (as it
should - its caller is freeze_super(); we want an exclusion with
attempts to start extra writes there).  sb_start_write() sure as
hell doesn't - if it would have, we would get its failures from
things like e.g. truncate(2) somewhere on the same fs.

We don't want to mess with anything freeze-related in acct_on(), but
the bug you are refering to in this part really doesn't exist.
