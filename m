Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFA4C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0791E206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfDWR24 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:28:56 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49419 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbfDWR24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:28:56 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7A04CCF2DA;
        Tue, 23 Apr 2019 19:37:04 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Fix empty regulator supplies for
 Intel Macs
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190401034312.27475-1-wens@kernel.org>
Date:   Tue, 23 Apr 2019 19:28:53 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Imre Kaloz <kaloz@dune.hu>,
        stable@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1989EF87-D91F-4672-8DC4-C5A67F5C1331@holtmann.org>
References: <20190401034312.27475-1-wens@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

> The code path for Macs goes through bcm_apple_get_resources(), which
> skips over the code that sets up the regulator supplies. As a result,
> the call to regulator_bulk_enable() / regulator_bulk_disable() results
> in a NULL pointer dereference.
> 
> This was reported on the kernel.org Bugzilla, bug 202963.
> 
> Unbreak Broadcom Bluetooth support on Intel Macs by checking if the
> supplies were set up before enabling or disabling them.
> 
> The same does not need to be done for the clocks, as the common clock
> framework API checks for NULL pointers.
> 
> Fixes: 75d11676dccb ("Bluetooth: hci_bcm: Add support for regulator supplies")
> Cc: <stable@vger.kernel.org> # 5.0.x
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> I do not own a Mac, so this needs to be tested by someone else.
> 
> ---
> drivers/bluetooth/hci_bcm.c | 20 ++++++++++++++++----
> 1 file changed, 16 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

