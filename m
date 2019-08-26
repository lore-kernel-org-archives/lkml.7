Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FBEC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A37E217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lhgOeG2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfHZNDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:03:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56760 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfHZNDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:03:31 -0400
Received: from zn.tnic (p200300EC2F065700581748F40A194E01.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5700:5817:48f4:a19:4e01])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 023091EC04CD;
        Mon, 26 Aug 2019 15:03:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566824610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QlOvhUjEWFcecHq6dGxltxi0WGK3n/knfF77Pc9C6n0=;
        b=lhgOeG2ToXM2JvzruOnDJd6oap3ve6Q8Jx5m2XgNsyhoMQeUhJ0FUYY9t1LhB4ZXFtQksB
        vlu/QL20umlx6Mvu6L01shQr3FMPVob2X7nQ6dAQYofYl8/NinampCAy5gzDs1Xxa4W1eu
        OEqkJmodDaTt6LFitvnO+GFNtpahubw=
Date:   Mon, 26 Aug 2019 15:03:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        kanth.ghatraju@oracle.com, Jon.Grimm@amd.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 1/2] x86/microcode: Update late microcode in parallel
Message-ID: <20190826130329.GE27636@zn.tnic>
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
 <1566506627-16536-2-git-send-email-mihai.carabas@oracle.com>
 <20190824085156.GA16813@zn.tnic>
 <20190824085300.GB16813@zn.tnic>
 <2242cc6c-720d-e1bc-817b-c4bb7fddd420@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2242cc6c-720d-e1bc-817b-c4bb7fddd420@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 08:53:05AM -0400, Boris Ostrovsky wrote:
> What is the advantage of having those other threads go through
> find_patch() and (in Intel case) intel_get_microcode_revision() (which
> involves two MSR accesses) vs. having the master sibling update slaves'
> microcode revisions? There are only two things that need to be updated,
> uci->cpu_sig.rev and c->microcode.

Less code churn and simplicity.

I accept non-ugly patches, of course. :-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
