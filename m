Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB70C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B18121473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbfEMQLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:11:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39262 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbfEMQLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:11:03 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DA44F14E226D3;
        Mon, 13 May 2019 09:11:02 -0700 (PDT)
Date:   Mon, 13 May 2019 09:11:02 -0700 (PDT)
Message-Id: <20190513.091102.665714844591079680.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     hayashi.kunihiko@socionext.com, f.fainelli@gmail.com,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: realtek: Replace phy functions with
 non-locked version in rtl8211e_config_init()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190513125002.GB28969@lunn.ch>
References: <1557729705-6443-1-git-send-email-hayashi.kunihiko@socionext.com>
        <20190513125002.GB28969@lunn.ch>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 May 2019 09:11:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 13 May 2019 14:50:02 +0200

> On Mon, May 13, 2019 at 03:41:45PM +0900, Kunihiko Hayashi wrote:
>> After calling phy_select_page() and until calling phy_restore_page(),
>> the mutex 'mdio_lock' is already locked, so the driver should use
>> non-locked version of phy functions. Or there will be a deadlock with
>> 'mdio_lock'.
>> 
>> This replaces phy functions called from rtl8211e_config_init() to avoid
>> the deadlock issue.
>> 
>> Fixes: f81dadbcf7fd ("net: phy: realtek: Add rtl8211e rx/tx delays config")
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Applied.
