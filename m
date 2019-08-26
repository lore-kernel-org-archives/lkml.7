Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2F8C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B110A217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfHZGUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 02:20:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58974 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbfHZGUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 02:20:05 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 363C915249296;
        Sun, 25 Aug 2019 23:20:04 -0700 (PDT)
Date:   Sun, 25 Aug 2019 23:20:03 -0700 (PDT)
Message-Id: <20190825.232003.1145950065287854577.davem@davemloft.net>
To:     loyou85@gmail.com
Cc:     edumazet@google.com, dsterba@suse.com, dbanerje@akamai.com,
        fw@strlen.de, davej@codemonkey.org.uk, tglx@linutronix.de,
        matwey@sai.msu.ru, sakari.ailus@linux.intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaojunzhao141@gmail.com
Subject: Re: [PATCH v2] net: fix skb use after free in netpoll
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1566800020-10007-1-git-send-email-loyou85@gmail.com>
References: <1566577920-20956-1-git-send-email-loyou85@gmail.com>
        <1566800020-10007-1-git-send-email-loyou85@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 25 Aug 2019 23:20:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feng Sun <loyou85@gmail.com>
Date: Mon, 26 Aug 2019 14:13:40 +0800

> +static inline bool netpoll_xmit_complete(int rc)
> +{
> +	return dev_xmit_complete(rc);
> +}

There is no need for this useless indirection, just call dev_xmit_complete()
staright.

Also, even if it was suitable, never use the inline keyword in foo.c files.
