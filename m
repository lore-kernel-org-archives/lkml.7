Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C3FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64209223FE
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555424403;
	bh=g5E1OPmR8Gw2ZjHq1qSspGp28cWaC6FtpbE3LnYJRpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hE3Idf6YRZQg0Yxd7tUopTMBZd4tz6ElKaxPUPsehIxCaVInw3pKGfqw6s1OSMA3L
	 gNI6lewhXBU1lZzVVJFXa0uGqvbWA9Fhp4wfavFtC8hE9ZjDJ2oZvpOocLSg6RAxcY
	 JaAvsVX/Xrqq/x5fDR7GtxqnkTyCH0MnPckEZuSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfDPOUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfDPOUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:20:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0232F223FA;
        Tue, 16 Apr 2019 14:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555424399;
        bh=g5E1OPmR8Gw2ZjHq1qSspGp28cWaC6FtpbE3LnYJRpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0fMHZKqZgeTRDXPzXSsiViPFPxa5podP5HqZmgloc36TfStCzguY46HqMv/nrgtAC
         V6p8k6a0CJmj8KuW3NHY1ghutu4PfoJD17F2I5xJ8Ns8/s3tp7cqBRd72/mVgLiEmT
         sWZwSb87GQ98aOgQYRY6d7S0FRf0prOEV5nk8AQk=
Date:   Tue, 16 Apr 2019 15:29:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 4/9] driver core: Let dev_of_node() accept a NULL dev
Message-ID: <20190416132955.GB17483@kroah.com>
References: <20190412183150.102131-1-sboyd@kernel.org>
 <20190412183150.102131-5-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412183150.102131-5-sboyd@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 11:31:45AM -0700, Stephen Boyd wrote:
> We'd like to chain this in places where the 'dev' argument might be
> NULL. Let this function take a NULL 'dev' so this can work.
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
> 
> Please ack/review so I can take this through clk tree.
> 
>  include/linux/device.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index b425a7ee04ce..0370dd0b3ae7 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1231,7 +1231,7 @@ static inline void device_lock_assert(struct device *dev)
>  
>  static inline struct device_node *dev_of_node(struct device *dev)
>  {
> -	if (!IS_ENABLED(CONFIG_OF))
> +	if (!IS_ENABLED(CONFIG_OF) || !dev)
>  		return NULL;
>  	return dev->of_node;
>  }

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
