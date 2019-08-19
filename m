Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB424C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980E12085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566216826;
	bh=137sSSOEp6KiHSBJY2r1KUBJJJxCYi5yMX0pHLaH1e4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=bCW5zMHGyL/tDxvwKEFmtdk1gFXHu/rTe6/Z2myi8nQ0hdxG/DPC+WDwg9quvnMQ+
	 qqZAYhgOqmjmuCEHMSN6QEMblC20NdJTA6XH8MBlJWyali6ePj0nzipc4TNCmURsmC
	 hFiV51+4e/PsZMO/VSlX0Mxnxmc/C5iWzSs7Ha0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfHSMNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfHSMNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 08:13:45 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7BD520851;
        Mon, 19 Aug 2019 12:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566216824;
        bh=137sSSOEp6KiHSBJY2r1KUBJJJxCYi5yMX0pHLaH1e4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=EXo4KzhZ2h1dl9OkhgqJAgKIkkW0NgwSuw9fUdc/WJFL8WlkzoHlly/8CtP9GjjqB
         UE+vV3+u4rOaaEePqtuGSFqdU37TCa31jMDhA/qQQmxbgkXsbREaDLvmR1smNlY1n0
         Kp74kX11liC3J+v2qUv0nA9TdJKPPEYek8wfc49Q=
Date:   Mon, 19 Aug 2019 14:13:35 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     David Barksdale <dbarksdale@uplogix.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: cp2112: prevent sleeping function called from
 invalid context
In-Reply-To: <20190812160444.10402-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.1908191413200.27147@cbobk.fhfr.pm>
References: <20190812160444.10402-1-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019, Benjamin Tissoires wrote:

> When calling request_threaded_irq() with a CP2112, the function
> cp2112_gpio_irq_startup() is called in a IRQ context.
> 
> Therefore we can not sleep, and we can not call
> cp2112_gpio_direction_input() there.
> 
> Move the call to cp2112_gpio_direction_input() earlier to have a working
> driver.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Pushed out to for-5.3/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

