Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66D1FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC0D2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394327AbfJPSmA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:42:00 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49620 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfJPSmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:42:00 -0400
Received: from surfer-172-29-2-69-hotspot.internet-for-guests.com (p2E5701B0.dip0.t-ipconnect.de [46.87.1.176])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8AEBBCECDE;
        Wed, 16 Oct 2019 20:50:56 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] RFC: Bluetooth: missed cpu_to_le16 conversion in
 hci_init4_req
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191016113943.19256-1-ben.dooks@codethink.co.uk>
Date:   Wed, 16 Oct 2019 20:41:57 +0200
Cc:     linux-kernel@lists.codethink.co.uk,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C87AB3FC-D613-4974-8FAF-99DAD156410C@holtmann.org>
References: <20191016113943.19256-1-ben.dooks@codethink.co.uk>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

> It looks like in hci_init4_req() the request is being
> initialised from cpu-endian data but the packet is specified
> to be little-endian. This causes an warning from sparse due
> to __le16 to u16 conversion.
> 
> Fix this by using cpu_to_le16() on the two fields in the packet.
> 
> net/bluetooth/hci_core.c:845:27: warning: incorrect type in assignment (different base types)
> net/bluetooth/hci_core.c:845:27:    expected restricted __le16 [usertype] tx_len
> net/bluetooth/hci_core.c:845:27:    got unsigned short [usertype] le_max_tx_len
> net/bluetooth/hci_core.c:846:28: warning: incorrect type in assignment (different base types)
> net/bluetooth/hci_core.c:846:28:    expected restricted __le16 [usertype] tx_time
> net/bluetooth/hci_core.c:846:28:    got unsigned short [usertype] le_max_tx_time
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> net/bluetooth/hci_core.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

