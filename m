Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8638C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF43D20869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="r8AHGGv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfDRX3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:29:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34480 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfDRX3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 19:29:18 -0400
Received: from zn.tnic (p200300EC2F112E0014210E9402371E03.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:1421:e94:237:1e03])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 021331EC04CD;
        Fri, 19 Apr 2019 01:29:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555630156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ay1T9ReBZMUJMgiPJZ0pv2dr2BflY4bvWpYPQRd1YMc=;
        b=r8AHGGv/5jNxpWnBLKbDozuYs2nMWRpMnVCjFcYes6Hb4rIQqRVcnuZ/BH9AI1yIkhcJuj
        SI5/mEuuSw8y3dp43D1uvd6753llxsZt+cn4hJQAEpS/BE76FYqk0VByjO9O+JFWjPWNlE
        hO4mEn0MelNRqJNh17lOUaa0Nnwamuo=
Date:   Fri, 19 Apr 2019 01:29:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Message-ID: <20190418232910.GR27160@zn.tnic>
References: <20190418220229.32133-1-tony.luck@intel.com>
 <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 03:51:07PM -0700, Cong Wang wrote:
> On Thu, Apr 18, 2019 at 3:02 PM Tony Luck <tony.luck@intel.com> wrote:
> >
> > Useful when running error injection tests that want to
> > see all of the MCi_(STATUS|ADDR|MISC) data via /dev/mcelog.
> >
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> We saw the same problem, CONFIG_RAS hijacks all the
> correctable memory errors, which leaves mcelog "broken"
> silently. I know it is arguable, but until we can switch from
> mcelog to rasdaemon, mcelog should still work as before.

It is "arguable" because this is not how the CEC is supposed to be used.

If you want to collect errors with mcelog, you don't use the CEC at all.
And there's ras=cec_disable for that or you simply don't enable it in
your .config.

As Tony says in the commit message, the enable should be used only for
injection tests. Which is where that thing should only be used for -
debugging the CEC itself.

Which reminds me, Tony, I think all those debugging files "pfn"
and "array" and the one you add now, should all be under a
CONFIG_RAS_CEC_DEBUG which is default off and used only for development.
Mind adding that too pls?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
