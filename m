Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A2AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3041721900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ee1zMbWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfCVUzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:55:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40578 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfCVUzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:55:00 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F4E21EC00FF;
        Fri, 22 Mar 2019 21:54:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553288099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=y38eK4RT/O/1H9PIjuKB36OAgVJizs2CWDaa5tbgAQI=;
        b=Ee1zMbWGt4kCH+pX9GSZTK/iNOjRJ0KDCYzwTKoGJlruOWgRAfvitwPFbdbdGjTpSf/zky
        Ll+Kh96APKwLM6GgHykGlf/rzxHCBSEMLoOzvLo95z0KOqTw2dsueqNtvr4owOb22Mvvdi
        8M7ocrdBdla84g1giAGwRqXTBDbHEc0=
Date:   Fri, 22 Mar 2019 21:55:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: Re: [PATCH v3 2/3] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
Message-ID: <20190322205500.GP12472@zn.tnic>
References: <20190322202848.20749-1-Yazen.Ghannam@amd.com>
 <20190322202848.20749-2-Yazen.Ghannam@amd.com>
 <bbcce693-496e-0ab9-f01e-66bc67347715@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbcce693-496e-0ab9-f01e-66bc67347715@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 08:37:08PM +0000, Ghannam, Yazen wrote:
> Sorry, I forgot to mention this. I went with "filter_mce_amd" because
> amd_filter_mce() is already defined in edac/mce_amd.c and there was
> a conflict when building. Is there another way to avoid these naming
> conflicts?

Yuck, we're clearly filtering too much. :)

So let's rename that amd_filter_mce() to something else since it is
static and only used in that file. Maybe something like

        if (ignore_mce(m))
                return NOTIFY_STOP;

so that we can keep the "filter" notion all reserved to the core MCA
code and there's no confusion.

And then amd_filter_mce() is free to be used in the core code.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
