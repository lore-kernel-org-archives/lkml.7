Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0110C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4B320870
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="B0eLQoA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405861AbfHWPhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:37:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53482 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfHWPhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:37:48 -0400
Received: from zn.tnic (p200300EC2F0BC5003C7EECCB3B09C289.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:c500:3c7e:eccb:3b09:c289])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AEF401EC0ABC;
        Fri, 23 Aug 2019 17:37:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566574662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tPd7cxcXtF6Z+Vts+kIedJB73gp3fadMQe5eBBiTFdE=;
        b=B0eLQoA+9WuNOnW3WSnHEDtLu1fHqrDJNPmfsJfcOO5HhfuCMTgmMMhovAKvsgDageJFo9
        L+gT/Gt/KchCGxZ+paP00XbphVe/1DT2RwOibkTuSQ+NKyx+GkUaSom9RTnS4KLBQHJvpJ
        0Ce3QfPiezSDLesZQHnf3te02Tn8TuU=
Date:   Fri, 23 Aug 2019 17:37:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] AMD64 EDAC fixes
Message-ID: <20190823153739.GC28379@zn.tnic>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190822005020.GA403@angband.pl>
 <SN6PR12MB2639CD6D755B6FFCF5C4B756F8A50@SN6PR12MB2639.namprd12.prod.outlook.com>
 <SN6PR12MB263989CCDCC0F74138B6B747F8A40@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB263989CCDCC0F74138B6B747F8A40@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 03:28:59PM +0000, Ghannam, Yazen wrote:
> Boris, Do you think it'd be appropriate to change the return values
> for some cases?
>
> For example, ECC disabled is a hardware configuration. This doesn't
> mean that the module failed any operations in this case.
>
> In other words, the module checks for a feature. If the feature is not
> present, then return without failure (and maybe give a message).

That makes sense but AFAICT if probe_one_instance() sees that ECC is not
enabled, it returns 0.

The "if (!edac_has_mcs())" check later is to verify that at least once
instance was loaded successfully and, if not, then return an error.

So where does it return failure?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
