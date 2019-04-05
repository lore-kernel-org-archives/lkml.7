Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7844C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823742171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfDEAoU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:44:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55454 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbfDEAoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:44:20 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 75518147386CD;
        Thu,  4 Apr 2019 17:44:19 -0700 (PDT)
Date:   Thu, 04 Apr 2019 17:44:19 -0700 (PDT)
Message-Id: <20190404.174419.1813732301965311345.davem@davemloft.net>
To:     olivier.tilmans@nokia-bell-labs.com
Cc:     research@bobbriscoe.net, koen.de_schepper@nokia-bell-labs.com,
        edumazet@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: Accept ECT on SYN in the presence of
 RFC8311
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190403134915.6616-1-olivier.tilmans@nokia-bell-labs.com>
References: <20190403134915.6616-1-olivier.tilmans@nokia-bell-labs.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 04 Apr 2019 17:44:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tilmans, Olivier (Nokia - BE/Antwerp)" <olivier.tilmans@nokia-bell-labs.com>
Date: Wed, 3 Apr 2019 13:49:42 +0000

> Linux currently disable ECN for incoming connections when the SYN
> requests ECN and the IP header has ECT(0)/ECT(1) set, as some
> networks were reportedly mangling the ToS byte, hence could later
> trigger false congestion notifications.
> 
> RFC8311 §4.3 relaxes RFC3168's requirements such that ECT can be set
> one TCP control packets (including SYNs). The main benefit of this
> is the decreased probability of losing a SYN in a congested
> ECN-capable network (i.e., it avoids the initial 1s timeout).
> Additionally, this allows the development of newer TCP extensions,
> such as AccECN.
> 
> This patch relaxes the previous check, by enabling ECN on incoming
> connections using SYN+ECT if at least one bit of the reserved flags
> of the TCP header is set. Such bit would indicate that the sender of
> the SYN is using a newer TCP feature than what the host implements,
> such as AccECN, and is thus implementing RFC8311. This enables
> end-hosts not supporting such extensions to still negociate ECN, and
> to have some of the benefits of using ECN on control packets.
> 
> Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia-bell-labs.com>
> Suggested-by: Bob Briscoe <research@bobbriscoe.net>

Applied, thanks.
