Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C443FC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08A4218B8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389983AbfHHPTQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:19:16 -0400
Received: from 68.66.241.172.static.a2webhosting.com ([68.66.241.172]:55760
        "EHLO vps.redhazel.co.uk" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1732680AbfHHPTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:19:16 -0400
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Aug 2019 11:19:15 EDT
Received: from [100.121.56.177] (unknown [213.205.240.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vps.redhazel.co.uk (Postfix) with ESMTPSA id 1A2EB1C02183;
        Thu,  8 Aug 2019 16:10:09 +0100 (BST)
Date:   Thu, 08 Aug 2019 16:10:07 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20190808114826.GC18351@dhcp22.suse.cz>
References: <ce102f29-3adc-d0fd-41ee-e32c1bcd7e8d@suse.cz> <20190805193148.GB4128@cmpxchg.org> <CAJuCfpHhR+9ybt9ENzxMbdVUd_8rJN+zFbDm+5CeE2Desu82Gg@mail.gmail.com> <398f31f3-0353-da0c-fc54-643687bb4774@suse.cz> <20190806142728.GA12107@cmpxchg.org> <20190806143608.GE11812@dhcp22.suse.cz> <CAJuCfpFmOzj-gU1NwoQFmS_pbDKKd2XN=CS1vUV4gKhYCJOUtw@mail.gmail.com> <20190806220150.GA22516@cmpxchg.org> <20190807075927.GO11812@dhcp22.suse.cz> <20190807205138.GA24222@cmpxchg.org> <20190808114826.GC18351@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's inability to gracefully handle low memory pressure
To:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
CC:     Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
From:   ndrw.xf@redhazel.co.uk
Message-ID: <806F5696-A8D6-481D-A82F-49DEC1F2B035@redhazel.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 August 2019 12:48:26 BST, Michal Hocko <mhocko@kernel.org> wrote:
>> 
>> Per default, the OOM killer will engage after 15 seconds of at least
>> 80% memory pressure. These values are tunable via sysctls
>> vm.thrashing_oom_period and vm.thrashing_oom_level.
>
>As I've said earlier I would be somehow more comfortable with a kernel
>command line/module parameter based tuning because it is less of a
>stable API and potential future stall detector might be completely
>independent on PSI and the current metric exported. But I can live with
>that because a period and level sounds quite generic.

Would it be possible to reserve a fixed (configurable) amount of RAM for caches, and trigger OOM killer earlier, before most UI code is evicted from memory? In my use case, I am happy sacrificing e.g. 0.5GB and kill runaway tasks _before_ the system freezes. Potentially OOM killer would also work better in such conditions. I almost never work at close to full memory capacity, it's always a single task that goes wrong and brings the system down.

The problem with PSI sensing is that it works after the fact (after the freeze has already occurred). It is not very different from issuing SysRq-f manually on a frozen system, although it would still be a handy feature for batched tasks and remote access. 

Best regards, 
ndrw


