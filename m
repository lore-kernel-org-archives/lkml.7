Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EE1C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1112B217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555491600;
	bh=KYJa/ajm1M4cHXbvRCvZ6z3YRiQWwmCaRi3R4Fo73Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VhqODVIyIqylicieoVokP5pdgixs2Uxnzn3cmEuwg7xfe9CN8TIlgSRU+gUjsJJU4
	 Xz+t10JvSLpyYy4P501g3WZKNlAPbU8jNlFM9INzXPgj1vIQafYi2sCgluJNuL/L7J
	 240ezgn7725ROdqOOo5Zl6PmAbzqPoea2SmHPe+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbfDQI76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfDQI76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:59:58 -0400
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6311A20693;
        Wed, 17 Apr 2019 08:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555491597;
        bh=KYJa/ajm1M4cHXbvRCvZ6z3YRiQWwmCaRi3R4Fo73Q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2gcdtSWBW6c8EjUfJwq3kxZZNNm9kdwUO5/VnRoZgb6vO5E3vGpgZlivBfQPKNfnM
         MYZNS8xgAvLcVTfYlQ3jb3URIzqRN51ovm2OjA9pdwIxrC5MHPJ6Ru40n0FSBDot/a
         utakIXj0oe7kL98FiBG9FmlynOl7FPZNd8U6v49A=
Date:   Wed, 17 Apr 2019 10:59:52 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tri Vo <trong@android.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Hackmann <ghackmann@android.com>, linux-mm@kvack.org,
        kbuild-all@01.org, Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petri Gynther <pgynther@google.com>, willy@infradead.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH v2] module: add stubs for within_module functions
Message-ID: <20190417085952.GB17099@linux-8ccs>
References: <20190415142229.GA14330@linux-8ccs>
 <20190415181833.101222-1-trong@android.com>
 <20190416152144.GA1419@linux-8ccs>
 <CANA+-vDxLy7A7aEDsHS4y7ujwN5atzkGrVwSvDs-U3Oa_5oLFg@mail.gmail.com>
 <CANA+-vAvLUFPhfXj_CxkV8Fgv+zmqvu=MxwtwFTbr5Nrn68E9g@mail.gmail.com>
 <20190416143813.4bac4f106930f6686164c11b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190416143813.4bac4f106930f6686164c11b@linux-foundation.org>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Andrew Morton [16/04/19 14:38 -0700]:
>On Tue, 16 Apr 2019 11:56:21 -0700 Tri Vo <trong@android.com> wrote:
>
>> On Tue, Apr 16, 2019 at 10:55 AM Tri Vo <trong@android.com> wrote:
>> >
>> > On Tue, Apr 16, 2019 at 8:21 AM Jessica Yu <jeyu@kernel.org> wrote:
>> > >
>> > > +++ Tri Vo [15/04/19 11:18 -0700]:
>> > > >Provide stubs for within_module_core(), within_module_init(), and
>> > > >within_module() to prevent build errors when !CONFIG_MODULES.
>> > > >
>> > > >v2:
>> > > >- Generalized commit message, as per Jessica.
>> > > >- Stubs for within_module_core() and within_module_init(), as per Nick.
>> > > >
>> > > >Suggested-by: Matthew Wilcox <willy@infradead.org>
>> > > >Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> > > >Reported-by: kbuild test robot <lkp@intel.com>
>> > > >Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
>> > > >Signed-off-by: Tri Vo <trong@android.com>
>> > >
>> > > Applied, thanks!
>> >
>> > Thank you!
>>
>> Andrew,
>> this patch fixes 8c3d220cb6b5 ("gcov: clang support"). Could you
>> re-apply the gcov patch? Sorry, if it's a dumb question. I'm not
>> familiar with how cross-tree patches are handled in Linux.
>
>hm, I wonder what Jessica applied this patch to?

I applied the patch that supplies the missing within_module() stubs to
the modules-next branch (a link to the repo is available in
MAINTAINERS), it's landed in linux-next by now, and it should fix the
build error reported by the kbuild test bot.

Thanks,

Jessica

