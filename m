Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50DCC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906B52176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfLRHBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:01:13 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47628 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRHBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:01:13 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3D2A1150379EF;
        Tue, 17 Dec 2019 23:01:12 -0800 (PST)
Date:   Tue, 17 Dec 2019 23:01:11 -0800 (PST)
Message-Id: <20191217.230111.26076810894427486.davem@davemloft.net>
To:     Jose.Abreu@synopsys.com
Cc:     netdev@vger.kernel.org, Joao.Pinto@synopsys.com,
        jakub.kicinski@netronome.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, mcoquelin.stm32@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/7] net: stmmac: Always arm TX Timer at
 end of transmission start
From:   David Miller <davem@davemloft.net>
In-Reply-To: <c76b0d51238192f81a52231b214f252b20be55c6.1576586602.git.Jose.Abreu@synopsys.com>
References: <cover.1576586602.git.Jose.Abreu@synopsys.com>
        <cover.1576586602.git.Jose.Abreu@synopsys.com>
        <c76b0d51238192f81a52231b214f252b20be55c6.1576586602.git.Jose.Abreu@synopsys.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 17 Dec 2019 23:01:12 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Tue, 17 Dec 2019 13:46:06 +0100

> If TX Coalesce timer is enabled we should always arm it, otherwise we
> may hit the case where an interrupt is missed and the TX Queue will
> timeout.
> 
> Arming the timer does not necessarly mean it will run the tx_clean()
> because this function is wrapped around NAPI launcher.
> 
> Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>

This is a bug fix and thus appropriate for net not net-next.
