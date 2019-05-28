Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD67DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E5720989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559067695;
	bh=XvZMhD52dlAThlGGEJMxb8/MFEOcoOv/AWYbcM5DCPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vewOa/b77ya/XURU2PdIn/8h20+ksTN6XEWPZ4oYHPw4G4xcvO0w83E7B7KJjCwrt
	 yZHTOnPYKQL9adWcQCQIVCIIlcMAY4BOTmjh3Jw4I4CK+KQkr7UE1kFAB9fFxvpSJr
	 se4QDjEPwQ27sKvyyL7vAI2ryEqEIAkJ/t37X5AA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfE1SVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:21:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:52568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727752AbfE1SVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:21:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33F7CAEA0;
        Tue, 28 May 2019 18:21:33 +0000 (UTC)
Date:   Tue, 28 May 2019 20:21:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Barret Rhoden <brho@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@elte.hu>,
        Oscar Salvador <osalvador@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA
 boot
Message-ID: <20190528182132.GH1658@dhcp22.suse.cz>
References: <20190512054829.11899-1-cai@lca.pw>
 <20190513124112.GH24036@dhcp22.suse.cz>
 <1557755039.6132.23.camel@lca.pw>
 <20190513140448.GJ24036@dhcp22.suse.cz>
 <1557760846.6132.25.camel@lca.pw>
 <20190513153143.GK24036@dhcp22.suse.cz>
 <CAFgQCTt9XA9_Y6q8wVHkE9_i+b0ZXCAj__zYU0DU9XUkM3F4Ew@mail.gmail.com>
 <20190522111655.GA4374@dhcp22.suse.cz>
 <CAFgQCTuKVif9gPTsbNdAqLGQyQpQ+gC2D1BQT99d0yDYHj4_mA@mail.gmail.com>
 <CAFgQCTvKZU1B0e4Bg3hQedMJ4Oq2uiOshnsBQCjKinmrGdKcYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTvKZU1B0e4Bg3hQedMJ4Oq2uiOshnsBQCjKinmrGdKcYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-05-19 12:00:46, Pingfan Liu wrote:
[...]
> > Yes, but maybe it will pay great effort on it.
> >
> And as a first step, we can find a way to fix the bug reported by me
> and the one reported by Barret

Can we try http://lkml.kernel.org/r/20190513140448.GJ24036@dhcp22.suse.cz
for starter?
-- 
Michal Hocko
SUSE Labs
