Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8C2C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E8720857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="GKbsnM9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfDHUu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:50:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42054 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfDHUu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:50:28 -0400
Received: from zn.tnic (p200300EC2F07270055F9EC31A4C987AB.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2700:55f9:ec31:a4c9:87ab])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B34BB1EC058A;
        Mon,  8 Apr 2019 22:50:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554756626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=W9F3mZ3I7PPAMth6rxuWjcq7V2LJMrFHmRGb+axTv8w=;
        b=GKbsnM9RtPkjpz9V+jFITpBOmSaOf9d4kUVKUvliU0kCs5MLW4ji2dXy9yJrAVYMJgzQYS
        6khYyMwciebiMTh/XbzjHSjabYD94nAhPJGzO6yrSlpEuYkY2UZApGX3Okx6gmjtsCx/ha
        /oVWApyc6wOQWjND5+4Eeot2q8ymFec=
Date:   Mon, 8 Apr 2019 22:50:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RESEND 4/5] x86/MCE: Make number of MCA banks per_cpu
Message-ID: <20190408205013.GN15689@zn.tnic>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
 <20190408141205.12376-5-Yazen.Ghannam@amd.com>
 <20190408202659.GA5232@agluck-desk>
 <20190408203431.GM15689@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7E8F6A61@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7E8F6A61@ORSMSX104.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 08:42:36PM +0000, Luck, Tony wrote:
> > Actually, it should not be exported at all. A function returning the num
> > banks is better instead.
> 
> Are all the places it is used in non-pre-emptible sections of code? Looping
> in the CMCI and #MC handlers should be fine. But do we need get_cpu()/put_cpu()
> in any places?

That export is needed only in the mce injector. Actually, it would be
much cleaner if the injector would find out the count straight from the
MSR as it does now, but be changed to do rdmsr_on_cpu() now, since can
have different num_banks on a CPU.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
