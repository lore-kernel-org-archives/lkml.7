Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF9AC606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE0C217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbfGHTl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:41:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57240 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbfGHTl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:41:27 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 29EF5133E9BDB;
        Mon,  8 Jul 2019 12:41:26 -0700 (PDT)
Date:   Mon, 08 Jul 2019 12:41:25 -0700 (PDT)
Message-Id: <20190708.124125.1938757647213542470.davem@davemloft.net>
To:     Jose.Abreu@synopsys.com
Cc:     netdev@vger.kernel.org, Joao.Pinto@synopsys.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ben@decadent.org.uk
Subject: Re: [PATCH net] net: stmmac: Re-work the queue selection for TSO
 packets
From:   David Miller <davem@davemloft.net>
In-Reply-To: <36018491f47206728e04d67a9e6263635e64f721.1562588640.git.joabreu@synopsys.com>
References: <36018491f47206728e04d67a9e6263635e64f721.1562588640.git.joabreu@synopsys.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 08 Jul 2019 12:41:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Mon,  8 Jul 2019 14:26:28 +0200

> Ben Hutchings says:
> 	"This is the wrong place to change the queue mapping.
> 	stmmac_xmit() is called with a specific TX queue locked,
> 	and accessing a different TX queue results in a data race
> 	for all of that queue's state.
> 
> 	I think this commit should be reverted upstream and in all
> 	stable branches.  Instead, the driver should implement the
> 	ndo_select_queue operation and override the queue mapping there."
> 
> Fixes: c5acdbee22a1 ("net: stmmac: Send TSO packets always from Queue 0")
> Suggested-by: Ben Hutchings <ben@decadent.org.uk>
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>

Applied and queued up for -stable.
