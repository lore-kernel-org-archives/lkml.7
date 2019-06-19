Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1075C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8451020657
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kId/SFK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfFSRSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:18:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37228 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfFSRSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:18:51 -0400
Received: from zn.tnic (p200300EC2F109900C181231BF4D53555.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:9900:c181:231b:f4d5:3555])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E1011EC066F;
        Wed, 19 Jun 2019 19:18:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560964730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ggRRYdkKkfmhyv/np4PPi7tGevSYxcJxDaYDKMXdSS8=;
        b=kId/SFK1o044GN+jJV5DAStCXJbkkDNejLXI+8jEEjWd3LEezORSxtAJRc8KLQWbkibzSl
        WqzOPVMHLWX8/nqGNjkyqpwg4neQGrWTZmQA+IbN4wVrtZRZ9GEyoZdJV5xb/Cg1/ZnveJ
        mUdhMNrrchjvBHDU5qZFM7ocPJ9Cjlg=
Date:   Wed, 19 Jun 2019 19:18:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Qian Cai <cai@lca.pw>, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cacheinfo: fix a -Wtype-limits warning
Message-ID: <20190619171842.GG9574@zn.tnic>
References: <1559763654-5155-1-git-send-email-cai@lca.pw>
 <20190605200703.GD26328@linux.intel.com>
 <20190619170127.GF9574@zn.tnic>
 <20190619171249.GG1203@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190619171249.GG1203@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 10:12:49AM -0700, Sean Christopherson wrote:
> Ha, no.  My comment was that it'd be worth explaining that the original
> 'c->x86_model >= 0' check was completely bogus, even if the intent was
> something like 'c->x86_model != 0'.

Nah, the intent was, I believe, to convert a model range into a
conditional. If ->x86_model is not set we have bigger problems.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
