Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F66C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B0B21670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfFZNEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:04:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47883 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZNEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:04:01 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hg7ac-0000Wg-Tf; Wed, 26 Jun 2019 15:03:55 +0200
Date:   Wed, 26 Jun 2019 15:03:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     x86@kernel.org, Robert Hodaszi <Robert.Hodaszi@digi.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [patch 2/5] genirq: Add optional hardware synchronization for
 shutdown
In-Reply-To: <20190625112405.666964552@linutronix.de>
Message-ID: <alpine.DEB.2.21.1906261502450.32342@nanos.tec.linutronix.de>
References: <20190625111353.863718167@linutronix.de> <20190625112405.666964552@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019, Thomas Gleixner wrote:
>   *	Returns: false if a threaded handler is active.
>   *
>   *	This function may be called - with care - from IRQ context.
> + *
> + *	It does not check whether there is an interrupt on flight at the
> + *	hardware level, but not serviced yet, as this might deadlock.

  + when invoked from an interrupt disabled region.

