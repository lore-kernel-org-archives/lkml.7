Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B3BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 06:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D31320B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 06:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="sbIhRX2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732815AbfJJGPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 02:15:12 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:49439 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfJJGPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 02:15:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 1772C3F669;
        Thu, 10 Oct 2019 08:15:09 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=sbIhRX2J;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yF_BPEmU0Hjj; Thu, 10 Oct 2019 08:15:08 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 9B3E83F382;
        Thu, 10 Oct 2019 08:15:04 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id D1CAF360162;
        Thu, 10 Oct 2019 08:15:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570688103; bh=4ue4EqSxzXPPi4ag3sKg2WTH3PY+hWrK79ED1yBsa+0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sbIhRX2JQ+of5RLA1KLI3iQ7xs3ubZLmjQuAA5owJXkEMaAF+3Wgh6UKoEZkI7KJo
         66hjoJLEsbvXDc87+xAg1IhFKaHJEBhnegJnUKu4vAx/NNDexVYH+TUbDBPK5B2Vsd
         ohUzQ8JecXUJerZgrz2/9c6Rzc0OdurkQyVquwHk=
Subject: Re: [PATCH v4 3/9] mm: pagewalk: Don't split transhuge pmds when a
 pmd_entry is present
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191008091508.2682-1-thomas_os@shipmail.org>
 <20191008091508.2682-4-thomas_os@shipmail.org>
 <20191009152737.p42w7w456zklxz72@box>
 <CAHk-=wh4waroKr-Xtcv+5pTxBcHxGEj-g73eQvXVawML_C0EXw@mail.gmail.com>
 <03d85a6a-e24a-82f4-93b8-86584b463471@shipmail.org>
 <CAHk-=whhdRSqjX5wy1LzFYnOG58UztpifkNvbxBcTVbT3Mzv4g@mail.gmail.com>
 <MN2PR05MB6141B981C2CAB4955D59747EA1950@MN2PR05MB6141.namprd05.prod.outlook.com>
 <CAHk-=wgy-ULe8UmEDn9gCCmTtw65chS0h309WrTaQhK3RAXM-A@mail.gmail.com>
 <c054849e-1e24-6b27-6a54-740ea9d17054@shipmail.org>
 <CAHk-=wgmr-BPMTnSuKrAMoHL_A0COV_sZkdcNB9aosYfouA_fw@mail.gmail.com>
 <80f25292-585c-7729-2a23-7c46b3309a1a@shipmail.org>
 <CAHk-=wg6n_nGRtJd4MeXZrA5QrrVViJeO4x2w37KDbcDmTh3dg@mail.gmail.com>
 <6d3ef513-ca9d-9778-10da-86f368a57cd0@shipmail.org>
 <CAHk-=wimOMuhBVrxYneQ5bawFNeGW1h_D3cxN80pitDKgfBx0A@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <2899bd30-ca8a-3b44-8946-a69de8db7b93@shipmail.org>
Date:   Thu, 10 Oct 2019 08:15:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wimOMuhBVrxYneQ5bawFNeGW1h_D3cxN80pitDKgfBx0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/19 4:07 AM, Linus Torvalds wrote:
> On Wed, Oct 9, 2019 at 6:10 PM Thomas Hellström (VMware)
> <thomas_os@shipmail.org> wrote:
>> Your original patch does exactly the same!
> Oh, no. You misread my original patch.
>
> Look again.
>
> The logic in my original patch was very different. It said that
>
>   - *if* we have a pmd_entry function, then we obviously call that one.
>
>      And if - after calling the pmd_entry function - we are still a
> hugepage, then we skip the pte_entry case entirely.
>
>     And part of skipping is obviously "don't split" - but it never had
> that "don't split and then call the pte walker" case.
>
>   - and if we *don't* have a pmd_entry function, but we do have a
> pte_entry function, then we always split before calling it.
>
> Notice the difference?

 From what I can tell, my patch is doing the same. At least that always 
was the intention. To determine whether to skip pte and skip split, your 
patch uses

                         /* No pte level at all? */
                         if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)
|| pmd_devmap(*pmd))
                                 continue;

whereas my patch does

                         if (pmd_trans_unstable(pmd))
                                 goto again;
			/* Fall through */

which is the same (pmd_trans_unstable() is the same test as you do, but 
not racy). Yes, it's missing the test for pmd_devmap() but I think 
that's an mm bug been discussed elsewhere, and we also rerun because a 
huge / none pmd at this (FALLBACK) point is probably a race and unintended.

>
> But I think the "change pmd_entry to have a sane return code" is a
> simpler and more flexible model, and then the pmd_entry code can just
> let the pte walker split the pmd if needed.

OK, let's aim for that then.

Thanks,

Thomas


>
> So I liked that part of your patch.
>
>             Linus


