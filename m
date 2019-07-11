Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E34C74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D454208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfGKJ3W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 05:29:22 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:63720 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726088AbfGKJ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 05:29:21 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17217972-1500050 
        for multiple; Thu, 11 Jul 2019 10:29:19 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <1561834612.3071.6.camel@HansenPartnership.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <1561834612.3071.6.camel@HansenPartnership.com>
Message-ID: <156283735757.12757.8954391372130933707@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: screen freeze with 5.2-rc6 Dell XPS-13 skylake  i915
Date:   Thu, 11 Jul 2019 10:29:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Bottomley (2019-06-29 19:56:52)
> The symptoms are really weird: the screen image is locked in place. 
> The machine is still functional and if I log in over the network I can
> do anything I like, including killing the X server and the display will
> never alter.  It also seems that the system is accepting keyboard input
> because when it freezes I can cat information to a file (if the mouse
> was over an xterm) and verify over the network the file contents. 
> Nothing unusual appears in dmesg when the lockup happens.
> 
> The last kernel I booted successfully on the system was 5.0, so I'll
> try compiling 5.1 to narrow down the changes.

It's likely this is panel self-refresh going haywire.

commit 8f6e87d6d561f10cfa48a687345512419839b6d8
Author: José Roberto de Souza <jose.souza@intel.com>
Date:   Thu Mar 7 16:00:50 2019 -0800

    drm/i915: Enable PSR2 by default

    The support for PSR2 was polished, IGT tests for PSR2 was added and
    it was tested performing regular user workloads like browsing,
    editing documents and compiling Linux, so it is time to enable it by
    default and enjoy even more power-savings.

Temporary workaround would be to set i915.enable_psr=0
-Chris
