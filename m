Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991EFC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729B020679
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfHER1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:27:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59536 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfHER1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:27:02 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7492715407F00;
        Mon,  5 Aug 2019 10:27:00 -0700 (PDT)
Date:   Mon, 05 Aug 2019 10:26:56 -0700 (PDT)
Message-Id: <20190805.102656.1576923178764860652.davem@davemloft.net>
To:     johan@kernel.org
Cc:     netdev@vger.kernel.org, linus.walleij@linaro.org,
        cuissard@marvell.com, andreyknvl@google.com, dvyukov@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        syzbot+cf35b76f35e068a1107f@syzkaller.appspotmail.com
Subject: Re: [PATCH] NFC: nfcmrvl: fix gpio-handling regression
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190805100055.10398-1-johan@kernel.org>
References: <20190805100055.10398-1-johan@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 05 Aug 2019 10:27:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>
Date: Mon,  5 Aug 2019 12:00:55 +0200

> Fix two reset-gpio sanity checks which were never converted to use
> gpio_is_valid(), and make sure to use -EINVAL to indicate a missing
> reset line also for the UART-driver module parameter and for the USB
> driver.
> 
> This specifically prevents the UART and USB drivers from incidentally
> trying to request and use gpio 0, and also avoids triggering a WARN() in
> gpio_to_desc() during probe when no valid reset line has been specified.
> 
> Fixes: e33a3f84f88f ("NFC: nfcmrvl: allow gpio 0 for reset signalling")
> Cc: stable <stable@vger.kernel.org>	# 4.13
> Reported-by: syzbot+cf35b76f35e068a1107f@syzkaller.appspotmail.com
> Tested-by: syzbot+cf35b76f35e068a1107f@syzkaller.appspotmail.com
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied and queued up for -stable.
