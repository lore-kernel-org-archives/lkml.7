Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E359CC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 03:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14A721848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 03:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbfHVDtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 23:49:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37838 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfHVDtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 23:49:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4FC92151A20BB;
        Wed, 21 Aug 2019 20:49:49 -0700 (PDT)
Date:   Wed, 21 Aug 2019 20:49:48 -0700 (PDT)
Message-Id: <20190821.204948.907885435812375741.davem@davemloft.net>
To:     h.feurstein@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, richardcochran@gmail.com, mlichvar@redhat.com,
        vivien.didelot@gmail.com, f.fainelli@gmail.com,
        hkallweit1@gmail.com, olteanv@gmail.com, fugang.duan@nxp.com
Subject: Re: [PATCH net-next v3 0/4] Improve phc2sys precision for
 mv88e6xxx switch in combination with imx6-fec
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190820084833.6019-1-hubert.feurstein@vahle.at>
References: <20190820084833.6019-1-hubert.feurstein@vahle.at>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 21 Aug 2019 20:49:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hubert Feurstein <h.feurstein@gmail.com>
Date: Tue, 20 Aug 2019 10:48:29 +0200

> From: Hubert Feurstein <h.feurstein@gmail.com>
> 
> Changelog:
>  v3: mv88e6xxx_smi_indirect_write: forward ptp_sts only on the last write
>      Copied Miroslav Lichvar because of PTP offset compensation patch
>  v2: Added patch for PTP offset compensation
>      Removed mdiobus_write_sts as there was no user
>      Removed ptp_sts_supported-boolean and introduced flags instead
> 
> With this patchset the phc2sys synchronisation precision improved to +/-555ns on
> an IMX6DL with an MV88E6220 switch attached.
> 
> This patchset takes into account the comments from the following discussions:
> - https://lkml.org/lkml/2019/8/2/1364
> - https://lkml.org/lkml/2019/8/5/169
> 
> Patch 01 adds the required infrastructure in the MDIO layer.
> Patch 02 adds additional PTP offset compensation.
> Patch 03 adds support for the PTP_SYS_OFFSET_EXTENDED ioctl in the mv88e6xxx driver.
> Patch 04 adds support for the PTP system timestamping in the imx-fec driver.

It looks like there is still some active discussion about these changes and
there will likely be another spin.
