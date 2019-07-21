Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF97C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20782085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfGUUde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 16:33:34 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34742 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfGUUde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 16:33:34 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5480215265E2B;
        Sun, 21 Jul 2019 13:33:33 -0700 (PDT)
Date:   Sun, 21 Jul 2019 13:33:32 -0700 (PDT)
Message-Id: <20190721.133332.437348204765200497.davem@davemloft.net>
To:     p.kosyh@gmail.com
Cc:     dsa@cumulusnetworks.com, shrijeet@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vrf: make sure skb->data contains ip header to make
 routing
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190719081148.11512-1-p.kosyh@gmail.com>
References: <213bada2-fe81-3c14-1506-11abf0f3ca22@cumulusnetworks.com>
        <20190719081148.11512-1-p.kosyh@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 21 Jul 2019 13:33:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Kosyh <p.kosyh@gmail.com>
Date: Fri, 19 Jul 2019 11:11:47 +0300

> vrf_process_v4_outbound() and vrf_process_v6_outbound() do routing
> using ip/ipv6 addresses, but don't make sure the header is available
> in skb->data[] (skb_headlen() is less then header size).
> 
> Case:
> 
> 1) igb driver from intel.
> 2) Packet size is greater then 255.
> 3) MPLS forwards to VRF device.
> 
> So, patch adds pskb_may_pull() calls in vrf_process_v4/v6_outbound()
> functions.
> 
> Signed-off-by: Peter Kosyh <p.kosyh@gmail.com>

Applied and queued up for -stable, thanks.
