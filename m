Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C050C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0512081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558335802;
	bh=63r9BLz2SlEFadDywWVMhR7P4kqkRTUqGZSXkwDtMko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UlhGRdlZLFQrMoTUQXjWyZKR8Ehh4+XMgX3mXK8CZgh8O1M/shRTBWXXKecRPav7X
	 jgZXd1amgQRwrqoXA0Cvx/N8e8S1mVaiEuu9uGOJ+YK+e7/tsAZe9phb1N/+nuDhts
	 Hq/7dFaIIgE1yIpaNta5izsq+3QRemh+rdKtoghM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfETHDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:03:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:39790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbfETHDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:03:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6293CAE48;
        Mon, 20 May 2019 07:03:19 +0000 (UTC)
Date:   Mon, 20 May 2019 09:03:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>, "bp@suse.de" <bp@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>
Subject: Re: NULL pointer dereference during memory hotremove
Message-ID: <20190520070317.GU6836@dhcp22.suse.cz>
References: <CA+CK2bBeOJPnnyWBgj0CJ7E1z9GVWVg_EJAmDs07BSJDp3PYfQ@mail.gmail.com>
 <20190517143816.GO6836@dhcp22.suse.cz>
 <CA+CK2bA+2+HaV4GWNUNP04fjjTPKbEGQHSPrSrmY7HLD57au1Q@mail.gmail.com>
 <CA+CK2bDq+2qu28afO__4kzO4=cnLH1P4DcHjc62rt0UtYwLm0A@mail.gmail.com>
 <CA+CK2bCgF7z5UHqrGCYu4JgG=5o6uXbjutTo9VSYAkqu3dqn5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCgF7z5UHqrGCYu4JgG=5o6uXbjutTo9VSYAkqu3dqn5w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-05-19 13:33:25, Pavel Tatashin wrote:
> On Fri, May 17, 2019 at 1:24 PM Pavel Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On Fri, May 17, 2019 at 1:22 PM Pavel Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > >
> > > On Fri, May 17, 2019 at 10:38 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Fri 17-05-19 10:20:38, Pavel Tatashin wrote:
> > > > > This panic is unrelated to circular lock issue that I reported in a
> > > > > separate thread, that also happens during memory hotremove.
> > > > >
> > > > > xakep ~/x/linux$ git describe
> > > > > v5.1-12317-ga6a4b66bd8f4
> > > >
> > > > Does this happen on 5.0 as well?
> > >
> > > Yes, just reproduced it on 5.0 as well. Unfortunately, I do not have a
> > > script, and have to do it manually, also it does not happen every
> > > time, it happened on 3rd time for me.
> >
> > Actually, sorry, I have not tested 5.0, I compiled 5.0, but my script
> > still tested v5.1-12317-ga6a4b66bd8f4 build. I will report later if I
> > am able to reproduce it on 5.0.
> 
> OK, confirmed on 5.0 as well, took 4 tries to reproduce:

What is the last version that survives? Can you bisect?
-- 
Michal Hocko
SUSE Labs
