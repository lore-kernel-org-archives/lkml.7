Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F2EC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2284721721
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfFNOzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:55:31 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:35253 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfFNOzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:55:31 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hbnc0-0003mm-3e; Fri, 14 Jun 2019 08:55:28 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hbnbo-0001cx-AE; Fri, 14 Jun 2019 08:55:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Ahern <dsahern@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matteo Croce <mcroce@redhat.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
References: <20190608125019.417-1-mcroce@redhat.com>
        <20190609.195742.739339469351067643.davem@davemloft.net>
        <d19abcd4-799c-ac2f-ffcb-fa749d17950c@infradead.org>
        <CAGnkfhyS15NPEO2ygkjazECULtUDkJgPk8wCYFhA9zL2+w27pg@mail.gmail.com>
        <49b58181-90da-4ee4-cbb0-80e226d040fc@infradead.org>
        <CAK8P3a1mwnDFeD3xnQ6bm1x8C6yX=YEccxN2jknvTbRiCfD=Bg@mail.gmail.com>
        <47f1889a-e919-e3fd-f90c-39c26cb1ccbb@gmail.com>
        <CAK8P3a0w3K1O23616g3Nz4XQdgw-xHDPWSQ+Rb_O3VAy-3FnQg@mail.gmail.com>
Date:   Fri, 14 Jun 2019 09:54:55 -0500
In-Reply-To: <CAK8P3a0w3K1O23616g3Nz4XQdgw-xHDPWSQ+Rb_O3VAy-3FnQg@mail.gmail.com>
        (Arnd Bergmann's message of "Fri, 14 Jun 2019 16:26:14 +0200")
Message-ID: <87r27wrzcw.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hbnbo-0001cx-AE;;;mid=<87r27wrzcw.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19xgdtHru1qF4+VUMChfP39qNf75uj1g9o=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH net] mpls: fix af_mpls dependencies
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Fri, Jun 14, 2019 at 4:07 PM David Ahern <dsahern@gmail.com> wrote:
>> On 6/14/19 8:01 AM, Arnd Bergmann wrote:
>> > On Wed, Jun 12, 2019 at 9:41 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> >> On 6/11/19 5:08 PM, Matteo Croce wrote:
>> >
>> > It clearly shouldn't select PROC_SYSCTL, but I think it should not
>> > have a 'depends on' statement either. I think the correct fix for the
>> > original problem would have been something like
>> >
>> > --- a/net/mpls/af_mpls.c
>> > +++ b/net/mpls/af_mpls.c
>> > @@ -2659,6 +2659,9 @@ static int mpls_net_init(struct net *net)
>> >         net->mpls.ip_ttl_propagate = 1;
>> >         net->mpls.default_ttl = 255;
>> >
>> > +       if (!IS_ENABLED(CONFIG_PROC_SYSCTL))
>> > +               return 0;
>> > +
>> >         table = kmemdup(mpls_table, sizeof(mpls_table), GFP_KERNEL);
>> >         if (table == NULL)
>> >                 return -ENOMEM;
>> >
>>
>> Without sysctl, the entire mpls_router code is disabled. So if sysctl is
>> not enabled there is no point in building this file.
>
> Ok, I see.
>
> There are a couple of other drivers that use 'depends on SYSCTL',
> which may be the right thing to do here. In theory, one can still
> build a kernel with CONFIG_SYSCTRL_SYSCALL=y and no
> procfs.

Which reminds me.  I really need to write the patch to remove
CONFIG_SYSCTL_SYSCALL.

Unless I have missed something we have finally reached default off in
all of the distributions so no one should care.

Eric
