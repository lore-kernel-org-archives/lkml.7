Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C2FC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BDF20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDHXfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:35:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42022 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfDHXfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:35:00 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A4DCF1454D5B9;
        Mon,  8 Apr 2019 16:34:59 -0700 (PDT)
Date:   Mon, 08 Apr 2019 16:34:59 -0700 (PDT)
Message-Id: <20190408.163459.2250841426705244439.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net: netrom: Fix error cleanup path of nr_proto_init
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190408151200.14984-1-yuehaibing@huawei.com>
References: <20190408151200.14984-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 08 Apr 2019 16:34:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Mon, 8 Apr 2019 23:12:00 +0800

> From: YueHaibing <yuehaibing@huawei.com>
> 
> Syzkaller report this:

This doesn't compile:

WARNING: net/netrom/netrom.o(.init.text+0x404): Section mismatch in reference from the function init_module() to the function .exit.text:nr_loopback_clear()
The function __init init_module() references
a function __exit nr_loopback_clear().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __exit annotation of
nr_loopback_clear() so it may be used outside an exit section.

WARNING: net/netrom/netrom.o(.init.text+0x409): Section mismatch in reference from the function init_module() to the function .exit.text:nr_rt_free()
The function __init init_module() references
a function __exit nr_rt_free().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __exit annotation of
nr_rt_free() so it may be used outside an exit section.
