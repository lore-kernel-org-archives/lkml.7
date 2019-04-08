Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA127C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A92E208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NeT+eosT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfDHJfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:35:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56260 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfDHJff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:35:35 -0400
Received: from zn.tnic (p200300EC2F07270078D24834D7DDA826.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2700:78d2:4834:d7dd:a826])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB47D1EC014B;
        Mon,  8 Apr 2019 11:35:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554716134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6nkgZsdQ9Pef28Su5QI5/nzZVjL6vjZCsi5ncyht6h4=;
        b=NeT+eosTAr4uwKjydWH/1pa+0uT0DzTWvFO/oDd204CBaCsg7Tj2cSCwHUPqVdI8rD79H1
        4luKmzHY8I6Lm2gwfEIphZcKsGrlgXo6BwbTeAybLktTrcSNR9/unLamUqrdPa1llD1JAI
        Bqw0ANDIY0t6QR/hXj2Xlh99UWo9VGU=
Date:   Mon, 8 Apr 2019 11:35:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de
Subject: Re: [RFC PATCH v3 1/4] x86: Add new config symbol to unify
 conditional definition of hv_irq_callback_count
Message-ID: <20190408093526.GD15689@zn.tnic>
References: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
 <1554711131-21514-2-git-send-email-yakui.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554711131-21514-2-git-send-email-yakui.zhao@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: x86/kconfig: Add ...

On Mon, Apr 08, 2019 at 04:12:08PM +0800, Zhao Yakui wrote:
> Now the CONFIG_HYPERV and CONFIG_XEN can be used to control the definition
> /usage of hv_irq_callback_count. If another linux guest also needs to use
> the hv_irq_callback_count, current conditional definition looks unreadable.

Rewrite that to:

"Add a special Kconfig symbol X86_HV_CALLBACK_VECTOR which guests using
the hypervisor interrupt callback counter can select and thus enable
that counter. Select it when xen or hyperv support is enabled.

No functional changes."

with that fixed you can add:

Reviewed-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
