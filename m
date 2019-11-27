Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED29C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44409206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfK0WFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:05:30 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:55432 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727105AbfK0WFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 17:05:30 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ia5R7-0006H0-W4; Wed, 27 Nov 2019 23:05:26 +0100
Date:   Wed, 27 Nov 2019 23:05:25 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Florian Westphal <fw@strlen.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        pablo@netfilter.org, jeffrin@rajagiritech.edu.in,
        horms@verge.net.au, yanhaishuang@cmss.chinamobile.com,
        lkft-triage@lists.linaro.org
Subject: Re: selftests:netfilter: nft_nat.sh: internal00-0 Error Could not
 open file \"-\" No such file or directory
Message-ID: <20191127220525.GH795@breakpoint.cc>
References: <CA+G9fYtgEfa=bq5C8yZeF6P563Gw3Fbs+-h_oy1e4G_1G0jrgw@mail.gmail.com>
 <20191126155632.GF795@breakpoint.cc>
 <CA+G9fYur6RHnz2nzy9RwZ64yUDv0bRs4eP9odLud0mDP9SAA-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYur6RHnz2nzy9RwZ64yUDv0bRs4eP9odLud0mDP9SAA-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> On Tue, 26 Nov 2019 at 21:26, Florian Westphal <fw@strlen.de> wrote:
> >
> > Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > Do you see the following error while running selftests netfilter
> > > nft_nat.sh test ?
> > > Are we missing any kernel config fragments ? We are merging configs
> > > from the directory.
> > >
> > > # selftests netfilter nft_nat.sh
> > > netfilter: nft_nat.sh_ #
> > > # Cannot create namespace file \"/var/run/netns/ns1\" File exists
> >
> > 'ns1' is not a good name.
> > What is the output of nft --version?
> 
> nftables v0.7 (Scrooge McDuck)

Oh, that explains it.  "-" only works
since 0.8.4 ...

I will submit another patch that uses /dev/stdin instead.
