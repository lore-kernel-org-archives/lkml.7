Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9DDCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D802064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="cdEy3TTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389990AbfJWHnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:43:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55148 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389298AbfJWHnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:43:22 -0400
Received: from zn.tnic (p200300EC2F11E8005961F1FA34C94581.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:e800:5961:f1fa:34c9:4581])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9B5D1EC0C97;
        Wed, 23 Oct 2019 09:43:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571816601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jTCcCEyTWzLsA6PZt0F/iewZdpPjA6PgMOIuBrdzh3I=;
        b=cdEy3TToYVeoDXvYhfp+VeBQPjb9VRyyz6QpXjK783pWJfrUP0z4le2zjQGLZeomi4SP9v
        b+PUlvkkKoHXtvxtNGkCULnMrZJ5Hfpug6PA3jsOHLKTpSFaX2JLJIQOu7Sbo6B1Q3rUR3
        00q04azm4SlI3Jp3T0JjVWpel658k+k=
Date:   Wed, 23 Oct 2019 09:43:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, bhe@redhat.com, dyoung@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, kexec@lists.infradead.org
Subject: Re: [PATCH 1/3 v4] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
Message-ID: <20191023074316.GA16060@zn.tnic>
References: <20191017094347.20327-1-lijiang@redhat.com>
 <20191017094347.20327-2-lijiang@redhat.com>
 <20191022083015.GB31700@zn.tnic>
 <0e657965-6f97-84ce-e51d-42d4978c4d88@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e657965-6f97-84ce-e51d-42d4978c4d88@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 01:23:33PM +0800, lijiang wrote:
> Kdump kernel will reuse the first 640k region because the real mode
> trampoline has to work in this area. When the vmcore is dumped, the
> old memory in this area may be accessed, therefore, kernel has to
> copy the contents of the first 640k area to a backup region so that
> kdump kernel can read the old memory from the backup area of the
> first 640k area, which is done in the purgatory().

That sounds better. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
