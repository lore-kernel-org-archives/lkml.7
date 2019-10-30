Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61611CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5D120856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfJ3Vwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:52:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47144 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfJ3Vwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:52:36 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5DB1114CFAAEA;
        Wed, 30 Oct 2019 14:52:35 -0700 (PDT)
Date:   Wed, 30 Oct 2019 14:52:34 -0700 (PDT)
Message-Id: <20191030.145234.1629187794527849559.davem@davemloft.net>
To:     Jose.Abreu@synopsys.com
Cc:     netdev@vger.kernel.org, Joao.Pinto@synopsys.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 4/9] net: stmmac: selftests: Must remove UC/MC
 addresses to prevent false positives
From:   David Miller <davem@davemloft.net>
In-Reply-To: <36d9af9080068c4e38cf50e80b6f2a5eafc9ed99.1572355609.git.Jose.Abreu@synopsys.com>
References: <cover.1572355609.git.Jose.Abreu@synopsys.com>
        <cover.1572355609.git.Jose.Abreu@synopsys.com>
        <36d9af9080068c4e38cf50e80b6f2a5eafc9ed99.1572355609.git.Jose.Abreu@synopsys.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 30 Oct 2019 14:52:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>
Date: Tue, 29 Oct 2019 15:14:48 +0100

> @@ -499,9 +501,18 @@ static int stmmac_test_hfilt(struct stmmac_priv *priv)
>  	if (netdev_mc_count(priv->dev) >= priv->hw->multicast_filter_bins)
>  		return -EOPNOTSUPP;

This test above...

> +	dummy_dev = alloc_etherdev(0);
> +	if (!dummy_dev)
> +		return -ENOMEM;
> +
> +	/* Remove all MC addresses */
> +	netdev_for_each_mc_addr(ha, priv->dev)
> +		dev_mc_add(dummy_dev, ha->addr);
> +	dev_mc_flush(priv->dev);

No longer makes any sense now that you're removing all of the MC
addresses.

Also I know it seems that it should be guaranteed that re-adding all of
the previously configured MC addresses should succeed.  But I am always
wary when I see error codes ignored like this.

This test makes destructure changes to the device's configuration,
perhaps in a non-restorable fashion if errors occur re-adding the MC
list entries.

Running a test should never even remotely introduce a change in the
device state like that.

I really don't like this, to be honest.  I'd hate to be the user who
had this somehow trigger on them and then have to diagnose it. :-/

