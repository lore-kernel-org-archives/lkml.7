Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE187C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 19:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981B221883
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 19:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfIBTDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 15:03:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35780 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfIBTDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 15:03:01 -0400
Received: from localhost (unknown [63.64.162.234])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A571C15404E28;
        Mon,  2 Sep 2019 12:03:00 -0700 (PDT)
Date:   Mon, 02 Sep 2019 12:03:00 -0700 (PDT)
Message-Id: <20190902.120300.174900457187536042.davem@davemloft.net>
To:     benwei@fb.com
Cc:     sam@mendozajonas.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH net-next] net/ncsi: support unaligned payload size in
 NC-SI cmd handler
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CH2PR15MB368619179F403EAE47FD61F7A3BE0@CH2PR15MB3686.namprd15.prod.outlook.com>
References: <CH2PR15MB368619179F403EAE47FD61F7A3BE0@CH2PR15MB3686.namprd15.prod.outlook.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 02 Sep 2019 12:03:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Wei <benwei@fb.com>
Date: Mon, 2 Sep 2019 02:46:52 +0000

> Update NC-SI command handler (both standard and OEM) to take into
> account of payload paddings in allocating skb (in case of payload
> size is not 32-bit aligned).
> 
> The checksum field follows payload field, without taking payload
> padding into account can cause checksum being truncated, leading to
> dropped packets.
> 
> Signed-off-by: Ben Wei <benwei@fb.com>

If you have to align and add padding, I do not see where you are
clearing out that padding memory to make sure it is initialized.

You do comparisons with 'payload' but make adjustments to 'len'.

The logic is very confusing.
