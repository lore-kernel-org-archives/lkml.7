Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ED0C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7D6214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552409889;
	bh=bHeGqShGPruou1YKAve3pey2B42yc3Mk+lLs6dokcDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=byH+iwtNsBZIGQPcq7z8cST6NDAaNDdNPH0r0GwkqM9UnLKLf8PGjisaVfx/JIPp8
	 UiPkeTMX0I1MNIqGQeh7qNMyifgU8LvFITNXs1B6AWgjzaPRxt1ig/R3ONRkMV/IQ+
	 lECHiD4ToQk6Q8n8m027kWbgmkYNF7Q7p43iwMCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfCLQ6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:58:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:60460 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbfCLQ6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:58:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83920AEA9;
        Tue, 12 Mar 2019 16:58:06 +0000 (UTC)
Date:   Tue, 12 Mar 2019 17:58:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        linux-mm <linux-mm@kvack.org>, Tim Murray <timmurray@google.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190312165805.GF5721@dhcp22.suse.cz>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz>
 <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain>
 <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
 <20190312080532.GE5721@dhcp22.suse.cz>
 <20190312163741.GA2762@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312163741.GA2762@sultan-box.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-03-19 09:37:41, Sultan Alsawaf wrote:
> I have not had a chance to look at PSI yet, but
> unless a PSI-enabled solution allows allocations to reach the same point as when
> the OOM killer is invoked (which is contradictory to what it sets out to do),
> then it cannot take advantage of all of the alternative memory-reclaim means
> employed in the slowpath, and will result in killing a process before it is
> _really_ necessary.

One more note. The above is true, but you can also hit one of the
thrashing reclaim behaviors and reclaim last few pages again and again
with the whole system really sluggish. That is what PSI is trying to
help with.
-- 
Michal Hocko
SUSE Labs
