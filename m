Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB6BC28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AA226217
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfE3Vxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 17:53:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60834 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfE3Vxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:53:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B069C14DB1C74;
        Thu, 30 May 2019 14:34:45 -0700 (PDT)
Date:   Thu, 30 May 2019 14:34:45 -0700 (PDT)
Message-Id: <20190530.143445.293369224441787273.davem@davemloft.net>
To:     mcroce@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: avoid indirect calls in L4 checksum
 calculation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190529151348.31311-1-mcroce@redhat.com>
References: <20190529151348.31311-1-mcroce@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 May 2019 14:34:45 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>
Date: Wed, 29 May 2019 17:13:48 +0200

> Commit 283c16a2dfd3 ("indirect call wrappers: helpers to speed-up
> indirect calls of builtin") introduces some macros to avoid doing
> indirect calls.
> 
> Use these helpers to remove two indirect calls in the L4 checksum
> calculation for devices which don't have hardware support for it.
> 
> As a test I generate packets with pktgen out to a dummy interface
> with HW checksumming disabled, to have the checksum calculated in
> every sent packet.
> The packet rate measured with an i7-6700K CPU and a single pktgen
> thread raised from 6143 to 6608 Kpps, an increase by 7.5%
> 
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Applied.
