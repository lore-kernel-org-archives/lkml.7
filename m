Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57C4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B11A2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552836959;
	bh=GqOX3umgDNPYGhM8JDsAIcNRpSvBRzejmHVpC/n40r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mncMrymBKLus0kGWKwzeqTdX02wMvos2wwvdcrsG57GjZo15TLuNdZy0wG3UeI64o
	 SPxx7U/tih0n89RsPovBVN+Vn0UyELEXfg7KjBDITusVWwon3qw42UMrg+6iV4R0BR
	 LJvJmTOdidpIVhh9LG5He26t4/UI1o02EQd10O7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfCQPf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 11:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfCQPf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 11:35:57 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A4F2087C;
        Sun, 17 Mar 2019 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552836957;
        bh=GqOX3umgDNPYGhM8JDsAIcNRpSvBRzejmHVpC/n40r0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y5uzDWvOzxfcSK4i/2OeMtLsDaDif87nE9EQcXGOLFrB0H9VrrITh2foSpTgDPDzG
         /2/DvI41GkZGwocsiqdJA2XaSe/711fv4VkcgssbpPH7/RcEr+Po5AxzIe2ZK0ABdm
         qMPTF6qDerPvMcWzzonfsVVQN56wor3J7c8+R5Xw=
Date:   Sun, 17 Mar 2019 16:35:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATHv3] staging: rtl8723bs: do not use __constant_cpu_to_le16
Message-ID: <20190317153553.GA8298@kroah.com>
References: <20190317152014.28694-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190317152014.28694-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 12:20:14AM +0900, Sergey Senozhatsky wrote:
> cpu_to_le16() is capable enough to detect __builtin_constant_p()
> and to use an appropriate compile time ___constant_swahbXX()
> function.
> 
> So we can use cpu_to_le16() instead of __constant_cpu_to_le16().
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  drivers/staging/rtl8723bs/include/wifi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

What changed from the previous versions of this patch?

That always has to go below the --- line.

v4?  :)

thanks,

greg k-h
