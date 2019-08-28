Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3805C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D73B20679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfH1XJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 19:09:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38530 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfH1XJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 19:09:38 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B0616153B0C96;
        Wed, 28 Aug 2019 16:09:37 -0700 (PDT)
Date:   Wed, 28 Aug 2019 16:09:37 -0700 (PDT)
Message-Id: <20190828.160937.1788181909547435040.davem@davemloft.net>
To:     tiwai@suse.de
Cc:     mlindner@marvell.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, swm@swm1.com
Subject: Re: [PATCH] sky2: Disable MSI on yet another ASUS boards (P6Xxxx)
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190828063119.22248-1-tiwai@suse.de>
References: <20190828063119.22248-1-tiwai@suse.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 28 Aug 2019 16:09:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 28 Aug 2019 08:31:19 +0200

> A similar workaround for the suspend/resume problem is needed for yet
> another ASUS machines, P6X models.  Like the previous fix, the BIOS
> doesn't provide the standard DMI_SYS_* entry, so again DMI_BOARD_*
> entries are used instead.
> 
> Reported-and-tested-by: SteveM <swm@swm1.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Applied, but this is getting suspicious.

It looks like MSI generally is not restored properly on resume on these
boards, so maybe there simply needs to be a generic PCI quirk for that?
