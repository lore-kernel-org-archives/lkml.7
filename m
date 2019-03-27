Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14A6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752B52075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fhChnJI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbfC0T3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:29:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39722 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729654AbfC0T3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:29:42 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C4AC81EC086F;
        Wed, 27 Mar 2019 20:29:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553714980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9l3fjwthdZM7fP/Cyljo0WviyXDglXFhMesBRe0qTSM=;
        b=fhChnJI44ALn7QvWCLQB6xOZIuUemhQT0mIkCpovqivvR/Kf4Ha07J4SKNTIrqt+Uv79WB
        sqa1+h2KDks9ReyePYraIvrSuR2ci1KtR8mREuQGkJj/3I6dZ+HWYz7gBvCFXgmbtQj4ME
        U9rN0UBNPVyyhp0jiUKHPS/KnhCde+s=
Date:   Wed, 27 Mar 2019 20:29:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: Re: [PATCH v4 2/2] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
Message-ID: <20190327192940.GJ32571@zn.tnic>
References: <20190325163410.171021-1-Yazen.Ghannam@amd.com>
 <20190325163410.171021-2-Yazen.Ghannam@amd.com>
 <alpine.DEB.2.21.1903272019190.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903272019190.1789@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 08:19:57PM +0100, Thomas Gleixner wrote:
> > Cc: <stable@vger.kernel.org> # 5.0.x: c95b323dcd35: x86/MCE/AMD: Turn off MC4_MISC thresholding on all family 0x15 models
> 
> What is this supposed to tell us?

That's stable speak from Documentation/process/stable-kernel-rules.rst
for patch prerequisites:

"Additionally, some patches submitted via :ref:`option_1` may have additional
patch prerequisites which can be cherry-picked. This can be specified in the
following format in the sign-off area:

.. code-block:: none

     Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
     Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
     Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
     Cc: <stable@vger.kernel.org> # 3.3.x
     Signed-off-by: Ingo Molnar <mingo@elte.hu>"

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
