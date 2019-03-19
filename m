Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7755C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A6020700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfCSQrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:47:03 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:37644 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfCSQrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:47:03 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id x2JGkpEh026185;
        Tue, 19 Mar 2019 16:46:51 GMT
Date:   Tue, 19 Mar 2019 16:46:51 +0000
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Alexander Pateenok <pateenoc@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Indirect call in vesafb driver
Message-ID: <20190319164651.4ec9e3d1@alans-desktop>
In-Reply-To: <20190313145418.bwta37cogo7a4qtt@K55DR>
References: <20190313145418.bwta37cogo7a4qtt@K55DR>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 17:54:18 +0300
Alexander Pateenok <pateenoc@gmail.com> wrote:

> Hi,
> 
> There're several indirect calls in inline assembly in vesafb driver
> (drivers/video/fbdev/vesafb.c), and these calls cannot be automatically
> changed to retpolines. It's in vesafb_pan_display():
> 
>    73        __asm__ __volatile__(
>    74                "call *(%%edi)"
> 
> and in vesa_setpalette():
> 
>   113        __asm__ __volatile__(
>   114         "call *(%%esi)"
> 
> Is there need to use CALL_NOSPEC ?

Vesafb is from the time on the dinosaurs but yes any vesa bios code will
not be speculatively hardened. I'd also doubt anyone is actually using
vesafb in the first place but it should use nospec

Alan
