Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C77C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778DD23407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="OgnKYvKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH3PG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:06:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50552 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbfH3PG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:06:59 -0400
Received: from zn.tnic (p200300EC2F0AAA0001D832AAA778AB1D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:aa00:1d8:32aa:a778:ab1d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0E6E1EC08E5;
        Fri, 30 Aug 2019 17:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567177617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9k1f8mtsHGTd5plZBYyKV0oOAkCDQaOFW+kp3D3S8oY=;
        b=OgnKYvKcGy+zfy6MuWZovDCcArNH371zrg6SruD4rhUIXj+mzgkHy/bVQ2o81pShLivZyS
        V+O98LYi7AW8IHWhhSlgIQz0ii7rnLhqZ59ZGH87YOEgy8je9lLLUO5YWTyG1DrIs3vIeR
        7UbxppF+zL8m3j1ULhf6msf8kCCtKWo=
Date:   Fri, 30 Aug 2019 17:06:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Philip Li <philip.li@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <lkp@intel.com>,
        linux-input@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        x86-ml <x86@kernel.org>, linux-tip-commits@vger.kernel.org,
        pv-drivers@vmware.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        tip-bot2 for Thomas Hellstrom <tip-bot2@linutronix.de>,
        Doug Covelli <dcovelli@vmware.com>,
        Ingo Molnar <mingo@redhat.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        kbuild-all@01.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [kbuild-all] [tip: x86/vmware] input/vmmouse: Update the
 backdoor call with support for new instructions
Message-ID: <20190830150653.GD30413@zn.tnic>
References: <156699905611.5321.15444519862547054670.tip-bot2@tip-bot2>
 <201908292325.aLXyyzEx%lkp@intel.com>
 <20190829163353.GC2132@zn.tnic>
 <20190830010349.GD857@intel.com>
 <alpine.DEB.2.21.1908300802390.1938@nanos.tec.linutronix.de>
 <20190830062053.GA2598@intel.com>
 <20190830080650.GA30413@zn.tnic>
 <20190830143645.GA4784@intel.com>
 <20190830144628.GC30413@zn.tnic>
 <20190830150002.GA6931@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190830150002.GA6931@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 11:00:02PM +0800, Philip Li wrote:
> Early on, there's requirement to blacklist a few branches, which is configured
> as below
> 	blacklist_branch: auto-.*|tmp-.*|base-.*|test.*|.*-for-linus

Looks about right.

> Except the blacklist branches, we will monitor all other branches.

Ok, good to know. Just as an optimization to your workflow, in case
you're interested: the tip/master branch merges all tip branches so if
you're trying to prioritize which branches to test first due to resource
constraints, I'd go with tip/master first and then, when I have free
cycles, I'd do the topic branches.

Just as an idea...

> We also support pull request to update the
> configuration or email us to update. Refer to
> https://github.com/intel/lkp-tests/blob/master/repo/linux/tip.

Ok, cool. I'll talk to tglx about it and might even send you a pull
request.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
