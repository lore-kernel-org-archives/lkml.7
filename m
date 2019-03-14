Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E29C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35F62063F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="cCE0Y8Ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfCNLEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:04:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60838 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbfCNLEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:04:13 -0400
Received: from zn.tnic (p200300EC2F09800070FBD7F886F95E91.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:70fb:d7f8:86f9:5e91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 391BE1EC0104;
        Thu, 14 Mar 2019 12:04:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1552561451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NJQS2sFIjRwOjYwg80igZbvEwiXBxafGLNLtHjj4LXA=;
        b=cCE0Y8Ek/T7CC9mwqcg1kOz0MRNulKLUR2j1cAXlHepelLpB5YDLcz46UjDVvfoXUztvZu
        1Kk/gnAcnurVLjdk1cODyTRhY44qvpH6lHH/4YYKwzY8TUyFHOA2sPEr5iPmVlM6gT4U2p
        Ga/IunvX8Pa8xx1WlNPaGwFRmNaXRwA=
Date:   Thu, 14 Mar 2019 12:04:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@arndb.de>, "Luck, Tony" <tony.luck@intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error
Message-ID: <20190314110413.GA32277@zn.tnic>
References: <20190305132147.3739133-1-arnd@arndb.de>
 <20190305143453.GC8256@zn.tnic>
 <CAK8P3a2kSrTkTespcBGr6oYi8nvriS9pwtM2nQ7gCxVB+TzLog@mail.gmail.com>
 <20190306175808.GA30016@agluck-desk>
 <CAK8P3a3MV=0BbOpjwM+2q+7Oehc=4B+u0hka1YdBnJmikfqCig@mail.gmail.com>
 <20190313230137.GA12529@agluck-desk>
 <CAK8P3a0aDdEt323i=z4BGuh71ntPqm-L33U4q+FiQOdMUin6wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0aDdEt323i=z4BGuh71ntPqm-L33U4q+FiQOdMUin6wg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 08:09:06AM +0100, Arnd Bergmann wrote:
> > So where should we go. Proposed solutions are piling up:
> >
> > 1) Make skx_common a module
> >         [downside: have to EXPORT everything in it]
> > 2) Move module-ish bits out of skx_common
> >         [downside: perhaps fragile]
> > 3) #include skx_common.c into {skx,i10nm}_edac.c
> >         [downside: no patch yet, bigger code size]
> 
> Sorry to add on to the already long list, but one more idea after
> looking at the two files:
> 
> 4) Have a single driver module, with the skx_common.c containing
>     the top-level module_init/module_exit functions that call into the
>     hardware specific versions.
> 
> This is the opposite of the usual recommendation (the driver
> is already structured nicely otherwise), but it would be cheap
> way out here.

This is what I think right now: if this is going to become such a pain,
then we better keep those two drivers completely separate. Who cares if
there's some code duplication?! Better that than some obscure randconfig
build breakages and fixes introducing more ugliness. IOW, we should keep
it simple.

Unless, Tony, you want to be able to make changes to the common code in
one place and don't want to patch both. Then I'd librarize the common
functionality, i.e., do something along the lines of 2).

But having two completely separate drivers is the most robust variant,
IMO.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
