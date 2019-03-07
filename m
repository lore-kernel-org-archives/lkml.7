Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0140DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C622063F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfCGR3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:29:31 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51974 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGR3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:29:31 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 530501479DEDC;
        Thu,  7 Mar 2019 09:29:30 -0800 (PST)
Date:   Thu, 07 Mar 2019 09:29:29 -0800 (PST)
Message-Id: <20190307.092929.277930617530301779.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     jeffrey.t.kirsher@intel.com, ndesaulniers@google.com,
        sasha.neftin@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] igc: remove unused igc_priv_flags_strings array
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190307093014.3293229-1-arnd@arndb.de>
References: <20190307093014.3293229-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Mar 2019 09:29:30 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu,  7 Mar 2019 10:29:57 +0100

> clang points out that the igc_priv_flags_strings[] array is never
> referenced, aside from being used for calculating its length:
> 
> drivers/net/ethernet/intel/igc/igc_ethtool.c:9:19: error: variable 'igc_priv_flags_strings' is not needed and will not
>       be emitted [-Werror,-Wunneeded-internal-declaration]
> static const char igc_priv_flags_strings[][ETH_GSTRING_LEN] = {
> 
> A similar array is present in several other intel ethernet drivers,
> but all the others use it in their .get_strings() callback, which
> igc does not implement (yet).
> 
> Probably it should be implemented, but as I have no way of testing
> it, this does the simpler alternative of removing the array to
> get rid of the warning.
> 
> Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Jeff, I assume you will pick this up.
