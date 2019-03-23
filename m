Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E13C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 09:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B96218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 09:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gInSVE8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfCWJPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 05:15:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58778 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfCWJPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 05:15:04 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B97B51EC0104;
        Sat, 23 Mar 2019 10:15:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553332502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FWG8fg16n6kJEb0gBcO8DVjVPWqH60Ih6bWewVTbp9I=;
        b=gInSVE8G7w+oUyk2JoSM2/6OynEEy0NYrM7dQc3lSUPB9XeSoN8e42a8XeP0dQDlfAE2BR
        oWknZBmG8k7Kx+pt2/ly4mgrWTX03rdQFqqpWvH62iyh3cIoq7TU3H19+46jiKAR4b7W2+
        b39MaPWGEe/S25nyv5m0qPtCezKURNo=
Date:   Sat, 23 Mar 2019 10:15:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     thor.thayer@linux.intel.com
Cc:     mchehab@kernel.org, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, altera: Fix S10 Double Bit Error Notification
Message-ID: <20190323091505.GC23698@zn.tnic>
References: <1552490842-25440-1-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1552490842-25440-1-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 10:27:22AM -0500, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Stratix10 Double Bit Error Address was always read from
> SDRAM Address register instead of each device's Address
> register.
> To determine which device had the DBE, cycle through
> the EDAC devices comparing the DBE value to the db_irq
> value. Once found, report the DBE Address from the device
> registers as well as the device name.
> Finally, notify the system via an SMC call and indicate
> the panic should result in a system reboot.
> Change a run-time check to a Stratix10 compile-time check
> for a clean SMC notification.
> 
> Fixes: d5fc9125566c ("EDAC, altera: Combine Stratix10 and Arria10 probe functions")
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>  drivers/edac/altera_edac.c | 69 ++++++++++++++++++++++++++++++++++------------
>  drivers/edac/altera_edac.h | 20 ++++++++++++++
>  2 files changed, 72 insertions(+), 17 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
