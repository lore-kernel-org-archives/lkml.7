Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20648C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A97206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKURRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:17:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:56554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfKURRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:17:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 092FBB1B9;
        Thu, 21 Nov 2019 17:17:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 586B1DAAD7; Thu, 21 Nov 2019 18:17:52 +0100 (CET)
Date:   Thu, 21 Nov 2019 18:17:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Kees Cook <keescook@chromium.org>
Cc:     dsterba@suse.cz, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [RESEND PATCH v4 03/10] lib/refcount: Remove unused
 refcount_*_checked() variants
Message-ID: <20191121171752.GA3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>
References: <20191121115902.2551-1-will@kernel.org>
 <20191121115902.2551-4-will@kernel.org>
 <20191121145533.GZ3001@twin.jikos.cz>
 <201911210910.81231377F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911210910.81231377F@keescook>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:11:58AM -0800, Kees Cook wrote:
> On Thu, Nov 21, 2019 at 03:55:33PM +0100, David Sterba wrote:
> > On Thu, Nov 21, 2019 at 11:58:55AM +0000, Will Deacon wrote:
> > > The full-fat refcount implementation is exposed via a set of functions
> > > suffixed with "_checked()", the idea being that code can choose to use
> > > the more expensive, yet more secure implementation on a case-by-case
> > > basis.
> > > 
> > > In reality, this hasn't happened, so with a grand total of zero users,
> > > let's remove the checked variants for now by simply dropping the suffix
> > > and predicating the out-of-line functions on CONFIG_REFCOUNT_FULL=y.
> > 
> > I am still interested in the _checked versions and have a WIP patch that
> > adds that to btrfs (that was my original plan) but haven't had enough
> > time to finalize it. The patch itself is simple, the missing part is to
> > understand and document what the saturated counters would do with the
> > structures.
> 
> The good news is that this series removes the case of refcount_t _not_
> being checked, so there's no need for _checked helpers.
> CONFIG_REFCOUNT_FULL gets removed because all refcount_t ends up being
> checked on all architectures. No extra work needed! :) (See patch 8)

Oh I see, that's great. Thanks.
