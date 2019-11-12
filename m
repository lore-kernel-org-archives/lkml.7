Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C174C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A7421783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573548679;
	bh=xVuHsd5FrW/1NBZMS6M5SiG7WySSW1lpvyVcSPVGWQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DxBJKgBivTp7HKujusvqZSUKdLdT5GD3cJccBs3IEDz9RreSFq6PmXK/mJt6eQd/i
	 0k/CQxotr7w1OVbXURPblRT+ym4Nje4+34QEShb4vdi5sKFc1R2sQXdfgB2cCJDHw+
	 PFPLZKSRmWwUt46QSGNujih2lrMK8Cpu0eexeFHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKLIvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:51:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:34970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfKLIvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:51:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36C1A21783;
        Tue, 12 Nov 2019 08:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573548677;
        bh=xVuHsd5FrW/1NBZMS6M5SiG7WySSW1lpvyVcSPVGWQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iArFUsk71ZySc9dmetkqDi6AeICtIv7SJuzQdOUKWhI+eSH2JEYqxkq2dpOBEWyLK
         HFL5qvK1GekzR3x9af/jF6bj5bXwU7wYDMxNfT/GGsOgm/p/1JN+ytdjQOlB2D25l4
         okpTou/021ud2i7VsqBK7lbyZWf4F4LzD84ZsQqo=
Date:   Tue, 12 Nov 2019 09:51:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Sasha Levin <sashal@kernel.org>, lkft-triage@lists.linaro.org,
        Dan Rue <dan.rue@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: stable-rc 4.14.154-rc1/0d12dcf336c6: regressions detected in
 project stable v.4.14.y on OE - sanity
Message-ID: <20191112085114.GB1265858@kroah.com>
References: <0100016e5ae0878e-7b9d1bef-b3be-4350-8823-440929ca4a81-000000@email.amazonses.com>
 <CA+G9fYt=+ymENJg1-m=F3BF8dn7mzxvt5Di34Jw5qFLBHXA5bA@mail.gmail.com>
 <20191111183059.GA1140707@kroah.com>
 <CAEUSe7-d35WPJnx1hduji80_aym53ztQi-EkCkvu7Kf3S0Wjwg@mail.gmail.com>
 <20191112051713.GB1160519@kroah.com>
 <CA+G9fYubrM2Qc9JxnfWkt1n=wYk1hbVL9UGEvQcXtB9kK=C7gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYubrM2Qc9JxnfWkt1n=wYk1hbVL9UGEvQcXtB9kK=C7gg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 12:50:39PM +0530, Naresh Kamboju wrote:
> On Tue, 12 Nov 2019 at 11:02, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > > > Any chance you can bisect?
> > >
> > > Reverting 61dbb1f20417 ("mm, meminit: recalculate pcpu batch and high
> > > limits after init completes") got the system working again.
> >
> > Yeah, I messed that one up :(
> >
> > I'm pushing out a -rc2 now to hopefully fix this up, thanks!
> 
> The -rc2 boot pass.

Great!
