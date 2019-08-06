Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D7CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764792086D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="E6PqIWDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbfHFScu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:32:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60212 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbfHFSct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:32:49 -0400
Received: from zn.tnic (p200300EC2F1369001D2C1334F0CDB20E.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:6900:1d2c:1334:f0cd:b20e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF6541EC0503;
        Tue,  6 Aug 2019 20:32:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565116368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/l9VW0w4uCu16D3f5mJOrOKOlGq/I6xHwmMbd4lMFWY=;
        b=E6PqIWDxKsMdip2+UpzkKRhk0TairgFhYExErCT9qvrOrQsJmKnrQCMeS9/1ZNqmdHTSxQ
        PlPbpWeag0ZjofSNuhZqgrV39jMpENR5p2hxcQFnPS05ppqikHEC+lbNLIBQpQ5g2W79OS
        8qP5T3jE8skvcVkF05PMF63U+FQ2fx0=
Date:   Tue, 6 Aug 2019 20:33:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 01/10] x86/CPU: Expose if cache is inclusive of lower
 level caches
Message-ID: <20190806183333.GA4698@zn.tnic>
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <6c78593207224014d6a9d43698a3d1a0b3ccf2b6.1564504901.git.reinette.chatre@intel.com>
 <20190802180352.GE30661@zn.tnic>
 <e532ab90-196c-8b58-215a-f56f5e409512@intel.com>
 <20190803094423.GA2100@zn.tnic>
 <122b005a-46b1-2b1e-45a8-7f92a5dba2d9@intel.com>
 <20190806155716.GE25897@zn.tnic>
 <151002be-33e6-20d6-7699-bc9be7e51f33@intel.com>
 <20190806173300.GF25897@zn.tnic>
 <d0c04521-ec1a-3468-595c-6929f25f37ff@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0c04521-ec1a-3468-595c-6929f25f37ff@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 11:13:22AM -0700, Reinette Chatre wrote:
> Some platforms being enabled in this round have SKUs with inclusive
> cache and also SKUs with non-inclusive cache. The non-inclusive cache
> SKUs do not support cache pseudo-locking and cannot be made to support
> cache pseudo-locking with software changes. Needing to know if cache is
> inclusive or not will thus remain a requirement to distinguish between
> these different SKUs. Supporting cache pseudo-locking on platforms with
> non inclusive cache will require new hardware features.

Is there another way/CPUID bit or whatever to tell us whether the
platform supports cache pseudo-locking or is the cache inclusivity the
only one?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
