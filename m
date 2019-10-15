Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DD5ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2952021A49
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571141887;
	bh=LSijIW2UdPsaBpA55qFZP6xR3ZnA7ko7WUaiGAO/o+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bJXWkXXVEZVzL1jYzT8Cc5156nb9xY7VECIJx9ssgSttAEu26qmOuGfGrIL+pyZVl
	 QQNbBOVkYKarpgslCf+m8/CjNPO17HP53EFefSfGkz3J9vW/CH7fpXggVTUZvN17hJ
	 ym9t6SwPRGEe+sMalBjeY9x2teGWUN+I9kXGfA00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfJOMSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 08:18:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:36302 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725810AbfJOMSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:18:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02C7CB3C4;
        Tue, 15 Oct 2019 12:18:03 +0000 (UTC)
Date:   Tue, 15 Oct 2019 14:18:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Guilherme Piccoli <gpiccoli@canonical.com>
Cc:     Qian Cai <cai@lca.pw>, linux-mm@kvack.org, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Subject: Re: [PATCH] hugetlb: Add nohugepages parameter to prevent hugepages
 creation
Message-ID: <20191015121803.GB24932@dhcp22.suse.cz>
References: <CAHD1Q_ynd6f2Jc54k1D9JjmtD6tGhkDcAHRzd5nZt5LUdQTvaw@mail.gmail.com>
 <4641B95A-6DD8-4E8A-AD53-06E7B72D956C@lca.pw>
 <CAHD1Q_x+m0ZT_xfLV3j6ma3Cc88fk9KnoS4yytS=PHBvJN7nnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHD1Q_x+m0ZT_xfLV3j6ma3Cc88fk9KnoS4yytS=PHBvJN7nnQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-10-19 21:41:01, Guilherme Piccoli wrote:
> On Fri, Oct 11, 2019 at 8:52 PM Qian Cai <cai@lca.pw> wrote:
> >
> >
> > It simply error-prone to reuse the sysctl.conf from the first kernel, as it could contains lots of things that will kill kdump kernel.
> 
> Makes sense, I agree with you. But still, there's no
> formal/right/single way to do kdump, so I don't think we should rely
> on "rootfs kdump is wrong" to refuse this patch's idea. If so, we
> should then formalize the right way of kdumping.
> Of course, this is only my opinion, let's see what people think about it!

I do agree with Qian Cai here. Kdump kernel requires a very tailored
environment considering it is running in a very restricted
configuration. The hugetlb pre-allocation sounds like a tooling problem
and should be fixed at that layer.
-- 
Michal Hocko
SUSE Labs
