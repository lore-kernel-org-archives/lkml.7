Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EB3C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F91204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfCAUko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:40:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:42486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfCAUko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 15:40:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32B2EB16F;
        Fri,  1 Mar 2019 20:40:43 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 7F883E00AD; Fri,  1 Mar 2019 21:40:42 +0100 (CET)
Date:   Fri, 1 Mar 2019 21:40:42 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     netdev@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sasha Neftin <sasha.neftin@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Clang warning in drivers/net/ethernet/intel/igc/igc_ethtool.c
Message-ID: <20190301204042.GM29992@unicorn.suse.cz>
References: <20190208050921.GA8758@archlinux-ryzen>
 <20190208143403.GD7035@unicorn.suse.cz>
 <CAKwvOdkNv_HUREJhUdOgHBgmVghPvJUun5wYuknCfTO0zN5TAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkNv_HUREJhUdOgHBgmVghPvJUun5wYuknCfTO0zN5TAg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 10:28:35AM -0800, Nick Desaulniers wrote:
> On Fri, Feb 8, 2019 at 6:34 AM Michal Kubecek <mkubecek@suse.cz> wrote:
> >
> > On Thu, Feb 07, 2019 at 10:09:21PM -0700, Nathan Chancellor wrote:
> > > Hi all,
> > >
> > > After commit 8c5ad0dae93c ("igc: Add ethtool support"), Clang warns:
> > >
> > > drivers/net/ethernet/intel/igc/igc_ethtool.c:9:19: warning: variable 'igc_priv_flags_strings' is not needed and will not be emitted [-Wunneeded-internal-declaration]
> > > static const char igc_priv_flags_strings[][ETH_GSTRING_LEN] = {
> > >                   ^
> > > 1 warning generated.
> > >
> > > igc_priv_flags_strings is only used in an ARRAY_SIZE macro, which is a
> > > compile time evaluation, so no reference to it is being emitted in the
> > > final assembly. Is it actually needed and was forgotten to be used
> > > somewhere or could it be eliminated so that Clang no longer warns?
> >
> > That's because the driver provides get_priv_flags() and set_priv_flags()
> > callbacks in its ethtool_ops to allow querying and setting legacy-rx
> > private flag but it does not provide get_sset_count() and get_strings()
> > to provide list of private flags to userspace ethtool.
> 
> So the variable declaration should get a `__unused` annotation then
> (and maybe a comment)?

I would rather suggest to add missing ethtool_ops handlers so that the
flag can be actually shown and set using ethtool.

Michal Kubecek
