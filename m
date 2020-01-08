Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BFEC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24FA206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgAHVLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:11:17 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47908 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgAHVLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:11:16 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A4E891584D0C9;
        Wed,  8 Jan 2020 13:11:15 -0800 (PST)
Date:   Wed, 08 Jan 2020 13:11:15 -0800 (PST)
Message-Id: <20200108.131115.1879538107195635308.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     3chas3@gmail.com, oleksandr@redhat.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, jonathan.lemon@gmail.com,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: eni: fix uninitialized variable warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200107204405.1422392-1-arnd@arndb.de>
References: <20200107204405.1422392-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 Jan 2020 13:11:16 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue,  7 Jan 2020 21:43:59 +0100

> With -O3, gcc has found an actual unintialized variable stored
> into an mmio register in two instances:
> 
> drivers/atm/eni.c: In function 'discard':
> drivers/atm/eni.c:465:13: error: 'dma[1]' is used uninitialized in this function [-Werror=uninitialized]
>    writel(dma[i*2+1],eni_dev->rx_dma+dma_wr*8+4);
>              ^
> drivers/atm/eni.c:465:13: error: 'dma[3]' is used uninitialized in this function [-Werror=uninitialized]
> 
> Change the code to always write zeroes instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
