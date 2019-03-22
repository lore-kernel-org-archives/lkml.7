Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D425C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2E120870
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="O6bBmAWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfCVTcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:32:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56886 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfCVTcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:32:22 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55A4A1EC0AB1;
        Fri, 22 Mar 2019 20:32:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553283140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=V5/WZAJ8t8yho7qC2Psd6EUeYyQeDOb4NsnknyCq2VI=;
        b=O6bBmAWsCFmGOdV4QOzH8u3V4eOn7blSA9jLZmoxq556VnG2MNEw8Da7utY5Ekbe+8Gn9y
        jiF9FDT2mKD3Z9UnipC1qJGRzJM+LAPH405iOq8OUgujqCvRR6z0YBozdKi452A8OQX7IH
        rCDP1FmTN/9L0kReWqYrXKQgBOJf+Rc=
Date:   Fri, 22 Mar 2019 20:32:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: Re: [PATCH v2 2/2] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
Message-ID: <20190322193228.GN12472@zn.tnic>
References: <20190321202505.5553-1-Yazen.Ghannam@amd.com>
 <20190321202505.5553-2-Yazen.Ghannam@amd.com>
 <20190322173436.GK12472@zn.tnic>
 <feea1978-04ef-82f9-933e-4ae280391aea@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <feea1978-04ef-82f9-933e-4ae280391aea@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 07:24:01PM +0000, Ghannam, Yazen wrote:
> Generally, the model groups share the same hardware design and so the
> same quirks. So I'm thinking that it'd be more efficient to have a
> filter function that targets a specific group of models rather than
> one that checks all known quirks on all models.

Or simply start with a amd_filter_mce() function and when it grows big
and unwieldy, only *then* start thinking about splitting it into models
and families. For now, you're fine with a single AMD-specific function.

> Most of the quirks are dealt with at init time, but this needs be to
> done during run time for each MCE that is logged. So I didn't want to
> add unnecessary checks to the MCE handlers. We have quirk_no_way_out()
> that does something similar.

I don't think a couple of instructions checking vendor and family would
be at all noticeable so let's start simple.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
