Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE2BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3284F2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbfB1UvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:51:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38618 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfB1UvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:51:15 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B17E914BFC366;
        Thu, 28 Feb 2019 12:51:14 -0800 (PST)
Date:   Thu, 28 Feb 2019 12:51:14 -0800 (PST)
Message-Id: <20190228.125114.10822000460043710.davem@davemloft.net>
To:     igor.druzhinin@citrix.com
Cc:     xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.liu2@citrix.com,
        paul.durrant@citrix.com
Subject: Re: [PATCH] xen-netback: don't populate the hash cache on XenBus
 disconnect
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1551363086-29652-1-git-send-email-igor.druzhinin@citrix.com>
References: <1551363086-29652-1-git-send-email-igor.druzhinin@citrix.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Feb 2019 12:51:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Druzhinin <igor.druzhinin@citrix.com>
Date: Thu, 28 Feb 2019 14:11:26 +0000

> Occasionally, during the disconnection procedure on XenBus which
> includes hash cache deinitialization there might be some packets
> still in-flight on other processors. Handling of these packets includes
> hashing and hash cache population that finally results in hash cache
> data structure corruption.
> 
> In order to avoid this we prevent hashing of those packets if there
> are no queues initialized. In that case RCU protection of queues guards
> the hash cache as well.
> 
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>

Applied and queued up for -stable, thanks.
