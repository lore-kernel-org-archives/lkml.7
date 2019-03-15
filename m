Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E99C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDF621872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="A263IK5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfCOJnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:43:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55222 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbfCOJnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:43:46 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 10EB41EC05A1;
        Fri, 15 Mar 2019 10:43:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1552643025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bGXmHGVR8irXRYK4gq9aXb658OFG1F618HVyMOHe9sU=;
        b=A263IK5J7l5yH0N5h2CF4tWLWjkmdFThre93VlPONoPlq7/mcs3MsgFIkAQjtpWUHdeaqb
        k7H/We38Qy3ttg13zpfUS6pJSxftfrUS9jDznfZLWgCkLCG3eKosdFRKh88lJqBlLbIKur
        AiffshEzwG0n8PfBQZL3q+V1pcl9fvg=
Date:   Fri, 15 Mar 2019 10:43:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error
Message-ID: <20190315094341.GA12523@zn.tnic>
References: <20190305132147.3739133-1-arnd@arndb.de>
 <20190305143453.GC8256@zn.tnic>
 <CAK8P3a2kSrTkTespcBGr6oYi8nvriS9pwtM2nQ7gCxVB+TzLog@mail.gmail.com>
 <20190306175808.GA30016@agluck-desk>
 <CAK8P3a3MV=0BbOpjwM+2q+7Oehc=4B+u0hka1YdBnJmikfqCig@mail.gmail.com>
 <20190313230137.GA12529@agluck-desk>
 <CAK8P3a0aDdEt323i=z4BGuh71ntPqm-L33U4q+FiQOdMUin6wg@mail.gmail.com>
 <20190314110413.GA32277@zn.tnic>
 <20190314215952.GA303@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190314215952.GA303@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 02:59:52PM -0700, Luck, Tony wrote:
> I made a patch based on option #3. Rough steps were:
> 
> $ cat skx_common.c >> skx_common.h

That doesn't look real clean to me. So we have fsl_ddr_edac.c which
gets linked in in two drivers and I think you could librarize that
skx_common.c the same way and have the function exports in the wrapper
drivers skx_edac and i10nm_edac calling those "library" functions in
skx_common.c. IMNSVHO.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
