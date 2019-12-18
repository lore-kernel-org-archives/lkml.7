Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD5FC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F12206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfLRG36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 01:29:58 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47278 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfLRG36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 01:29:58 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0DEC41500796D;
        Tue, 17 Dec 2019 22:29:57 -0800 (PST)
Date:   Tue, 17 Dec 2019 22:29:56 -0800 (PST)
Message-Id: <20191217.222956.2055609890870202125.davem@davemloft.net>
To:     vincent.cheng.xh@renesas.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, richardcochran@gmail.com,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] ptp: clockmatrix: Remove IDT references
 or replace with Renesas.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1576558988-20837-3-git-send-email-vincent.cheng.xh@renesas.com>
References: <1576558988-20837-1-git-send-email-vincent.cheng.xh@renesas.com>
        <1576558988-20837-3-git-send-email-vincent.cheng.xh@renesas.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 17 Dec 2019 22:29:57 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: vincent.cheng.xh@renesas.com
Date: Tue, 17 Dec 2019 00:03:07 -0500

> From: Vincent Cheng <vincent.cheng.xh@renesas.com>
> 
> Renesas Electronics Corporation completed acquisition of IDT in 2019.
> 
> This patch removes IDT references or replaces IDT with Renesas.
> Renamed idt8a340_reg.h to clockmatrix_reg.h.
> There were no functional changes.
> 
> Signed-off-by: Vincent Cheng <vincent.cheng.xh@renesas.com>

Sorry, we don't do stuff like this.

The driver shall keep the reference to it's old vendor name, and
this is how we've handled similar situations in the past.

And do you know the worst part about this?  You DID in fact
functionally change this driver:

> -#define FW_FILENAME	"idtcm.bin"
> +#define FW_FILENAME	"cm_tcs.bin"

Now everyone would have missing firmware.

So not only is this unacceptable on precedence grounds, and how we
always handle situations like this, it's functionally wrong and would
break things for users.

Please remove this patch and resubmit #1 and #3 as a series for
re-review.

Thank you.
