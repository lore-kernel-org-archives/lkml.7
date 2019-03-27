Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB0CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD5E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfC0Uoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:44:55 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36382 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfC0Uoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:44:54 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7375A14CF8240;
        Wed, 27 Mar 2019 13:44:54 -0700 (PDT)
Date:   Wed, 27 Mar 2019 13:44:54 -0700 (PDT)
Message-Id: <20190327.134454.1623767882107215644.davem@davemloft.net>
To:     lifonghsu@synology.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: net: fix routing encapsulated packets when binding a socket to
 a tunnel interface
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1553236198-5955-1-git-send-email-lifonghsu@synology.com>
References: <1553236198-5955-1-git-send-email-lifonghsu@synology.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 27 Mar 2019 13:44:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lifonghsu <lifonghsu@synology.com>
Date: Fri, 22 Mar 2019 14:29:58 +0800

> From: LiFong Hsu <lifonghsu@synology.com>
> 
> When binding a socket to a 4in6/6in4 tunnel interface, the kernel sends
> the packet to the tunnel interface without any problem, e.g.,
> ping 8.8.8.8 -I 4in6. However, after the 4in6/6in4 tunnel encapsulation,
> the encapsulated packet could be sent to the tunnel interface again when
> some fields of the skb were changed in mangle table's output chain,
> such as skb->mark and src/dest IP address. Sending to the tunnel interface
> twice is unexpected, since there are no corresponding routing rules on
> the tunnel interface for the encapsulated packet. Eventually, the encapsulated
> packet will be dropped by the tunnel interface.
> 
> This commit stops referring to sk_bound_dev_if while re-routing a packet
> with skb_iif!=0 which indicates that the packet has already been sent to
> the interface specified by sk_bound_dev_if. Instead, this commit sends
> the packet to the underlying network device.
> 
> Signed-off-by: LiFong Hsu <lifonghsu@synology.com>
> Reviewed-by: JianJhen Chen <kchen@synology.com>

If you do not respond to my feedback, I am going to drop your patch.

You have 24 hours to respond before that happens.
