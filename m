Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553D7C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3A3214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qNb/FxIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfDSA0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:26:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41890 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfDSA0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 20:26:54 -0400
Received: from zn.tnic (p200300EC2F112E00C9E732E76EE3BD2F.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:c9e7:32e7:6ee3:bd2f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 15A611EC0104;
        Fri, 19 Apr 2019 02:26:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555633611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1YZoxVL4nlCMCM9p35yh+VCDOgqqk+dpQwzBW2u7IBY=;
        b=qNb/FxIYDuO5FiGi4xiKmcihbcVoPIdEM4M8qeykACEKzSBix3wTxnWO4j4bDg2xEWTQ06
        gKAqGtk7yfAm4JnIW3crg/ayxCg/1KwoBjYw14KCmAh7TAbAnKZbZKGeugkODUn4bjWwKE
        ccSXvWJR4x8Xk+nCZKlTObUCW01wDXI=
Date:   Fri, 19 Apr 2019 02:26:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Message-ID: <20190419002645.GA559@zn.tnic>
References: <20190418220229.32133-1-tony.luck@intel.com>
 <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic>
 <CAM_iQpVWvg-U6hzKsCPXdObiwKJhQ=BkGDDeP+p671cCWK7QFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM_iQpVWvg-U6hzKsCPXdObiwKJhQ=BkGDDeP+p671cCWK7QFA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 04:58:22PM -0700, Cong Wang wrote:
> No, it is all about whether we should break users' expectation.

What user expectation?

> This doesn't sounds like a valid reason for us to break users'
> expectation.

I think it is *you* who has some sort of "expectation" but that
"expectation" is wrong.

> Prior to CONFIG_RAS, mcelog just works fine for users (at least Intel
> users). Suddenly after enabling CONFIG_RAS in kernel, mcelog will
> no longer receive any correctable memory errors _silently_.

That is, of course, wrong too.

> What's more, we don't even have rasdaemon running in our system, so

Are you saying "we" to mean "we the users" or some company "we"?

And that is wrong too, there's at least one rasdaemon:

  http://git.infradead.org/users/mchehab/rasdaemon.git

> there is no consumer of RAS CEC,

RAS CEC doesn't need a consumer. You're misunderstanding the whole
concept of the error collector.

> these errors just simply disappear from users' expected place.

They "disappear" because you have CONFIG_RAS_CEC enabled. But they
don't really disappear - they're collected by the thing to filter out
only the pages which keep generating errors constantly and those get
soft-offlined.

The sporadic ones simply get ignored because they don't happen again
and are only result of alpha particles or overheating conditions or
whatever.

Now here's the CEC help text:

config RAS_CEC
        bool "Correctable Errors Collector"
        depends on X86_MCE && MEMORY_FAILURE && DEBUG_FS
        ---help---
          This is a small cache which collects correctable memory errors per 4K
          page PFN and counts their repeated occurrence. Once the counter for a
          PFN overflows, we try to soft-offline that page as we take it to mean
          that it has reached a relatively high error count and would probably
          be best if we don't use it anymore.

          Bear in mind that this is absolutely useless if your platform doesn't
          have ECC DIMMs and doesn't have DRAM ECC checking enabled in the BIOS.

you can tell me what in that text is not clear so that I can make it
more clear and obvious what that thing is.

> I know CONFIG_RAS is new feature supposed to replace MCELOG,

No, it isn't. CONFIG_RAS is supposed to collect all the RAS-related
functionality in the kernel and it looks like you have some
misconceptions about it.

> but they can co-exist in kernel config, which means mcelog should
> continue to work as before until it gets fully replaced.

For that you need to enable X86_MCELOG_LEGACY.

And let me repeat it again - if you want to collect errors in userspace,
do not enable RAS_CEC at all.

> Even the following PoC change could make this situation better,
> because with this change when we enable CONFIG_RAS,mcelog
> will break _loudly_ rather than just silently, users will notice mcelog
> is no longer supported and will look for its alternative choice.

You have somehow put in your head that CONFIG_RAS is the counterpart of
CONFIG_X86_MCELOG_LEGACY. Which is *simply* *not* *true*.

And the moment you realize that, then you'll be a step further in the
right direction.

So enable X86_MCELOG_LEGACY and you can collect all the errors you wish.
And there's a rasdaemon which you can use too, as I pointed above, if
you don't want mcelog.

CEC is something *completely* different and its purpose is to run in the
kernel and prevent users and admins from upsetting unnecessarily with
every sporadic correctable error and just because an alpha particle flew
through their DIMMs, they all start running in headless chicken mode,
trying to RMA perfectly good hardware.

Now, if any of that above still doesn't make it clear, please state what
you're trying to achieve and I'll try to help.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
