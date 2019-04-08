Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97395C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC8720855
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jTzRhbc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfDHUel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:34:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39844 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfDHUek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:34:40 -0400
Received: from zn.tnic (p200300EC2F07270055F9EC31A4C987AB.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2700:55f9:ec31:a4c9:87ab])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 423881EC027B;
        Mon,  8 Apr 2019 22:34:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554755679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TPqi7h0munMeWfZRr9bSgRDKX3OvyLwJ+gDgU4dTD1k=;
        b=jTzRhbc7OpvFF89URjvKV6eDDaH77FvTTRLbgFhL6pgbu/t1HpZdNib3nRkfzgvFORrCK3
        BmqCv0nBQJ5+JIG0raRyYvOhgf/Asqu7f9w8DjeERGURhwXlmK2sqpnx2ol7m9OBDprMpw
        69kbEOx/ZKB97HlD7VOfJDXjJNA3dgI=
Date:   Mon, 8 Apr 2019 22:34:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RESEND 4/5] x86/MCE: Make number of MCA banks per_cpu
Message-ID: <20190408203431.GM15689@zn.tnic>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
 <20190408141205.12376-5-Yazen.Ghannam@amd.com>
 <20190408202659.GA5232@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190408202659.GA5232@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 01:26:59PM -0700, Luck, Tony wrote:
> On Mon, Apr 08, 2019 at 02:12:17PM +0000, Ghannam, Yazen wrote:
> > +DEFINE_PER_CPU_READ_MOSTLY(u8, num_banks);
> > +EXPORT_PER_CPU_SYMBOL_GPL(num_banks);
> 
> The name "num_banks" is a bit generic for an exported symbol.
> I think it should have a "mce_" prefix.

Actually, it should not be exported at all. A function returning the num
banks is better instead.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
