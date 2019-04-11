Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B043C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589DA2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="F0L55h5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfDKNzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:55:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54106 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfDKNzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:55:50 -0400
Received: from zn.tnic (p200300EC2F0ABD00B0506403E4AFEFF4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:bd00:b050:6403:e4af:eff4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C0391EC0A8F;
        Thu, 11 Apr 2019 15:55:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554990949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rkntOee5g3xkJYexZSyo3BNC8rZj3+qsADKLtaGhfIY=;
        b=F0L55h5Bk/NM8ppyHPZ1J4iYYL+x/6NIhUHQ3dkRyhLry7M8DKUdDJoEhHbY3KC3DAOs1R
        c+zgVT5fFQpZWxpsnF4enTrZA/oF23QECfzSXCTb1wjwf/PTkxW5ynuXkHVzAaJDLCwt7g
        niaO+wJfAkDD4/WaGHWs1ytDvUL9v8Q=
Date:   Thu, 11 Apr 2019 15:55:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v3 3/4] x86: Use HYPERVISOR_CALLBACK_VECTOR for
 acrn_guest upcall vector
Message-ID: <20190411135547.GH30080@zn.tnic>
References: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
 <1554711131-21514-4-git-send-email-yakui.zhao@intel.com>
 <20190408150011.GH15689@zn.tnic>
 <36ff9827-da90-0736-f0a4-2f38b9c8bf3b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36ff9827-da90-0736-f0a4-2f38b9c8bf3b@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 03:57:08PM +0800, Zhao, Yakui wrote:
> It is used to avoid that one function declaration has no definition
> when asm/acrnhyper.h is included and ACRN_GUEST is not enabled.

And that is a problem because...?

> Do you have any suggestion about the header order?
> > 
> > linux/ path includes still need to come first, of course.

As said above:

linux/ path first, then asm/

Feel free to look around the tree for inspiration :)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
