Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EF8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CB7216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbfHFJgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 05:36:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:48414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfHFJgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:36:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2BE57AE2E;
        Tue,  6 Aug 2019 09:36:49 +0000 (UTC)
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
To:     Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Artem S. Tashkinov" <aros@gmx.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com>
 <ce102f29-3adc-d0fd-41ee-e32c1bcd7e8d@suse.cz>
 <20190805193148.GB4128@cmpxchg.org>
 <CAJuCfpHhR+9ybt9ENzxMbdVUd_8rJN+zFbDm+5CeE2Desu82Gg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <398f31f3-0353-da0c-fc54-643687bb4774@suse.cz>
Date:   Tue, 6 Aug 2019 11:36:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpHhR+9ybt9ENzxMbdVUd_8rJN+zFbDm+5CeE2Desu82Gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/19 3:08 AM, Suren Baghdasaryan wrote:
>> @@ -1280,3 +1285,50 @@ static int __init psi_proc_init(void)
>>         return 0;
>>  }
>>  module_init(psi_proc_init);
>> +
>> +#define OOM_PRESSURE_LEVEL     80
>> +#define OOM_PRESSURE_PERIOD    (10 * NSEC_PER_SEC)
> 
> 80% of the last 10 seconds spent in full stall would definitely be a
> problem. If the system was already low on memory (which it probably
> is, or we would not be reclaiming so hard and registering such a big
> stall) then oom-killer would probably kill something before 8 seconds
> are passed.

If oom killer can act faster, than great! On small embedded systems you probably
don't enable PSI anyway?

> If my line of thinking is correct, then do we really
> benefit from such additional protection mechanism? I might be wrong
> here because my experience is limited to embedded systems with
> relatively small amounts of memory.

Well, Artem in his original mail describes a minutes long stall. Things are
really different on a fast desktop/laptop with SSD. I have experienced this as
well, ending up performing manual OOM by alt-sysrq-f (then I put more RAM than
8GB in the laptop). IMHO the default limit should be set so that the user
doesn't do that manual OOM (or hard reboot) before the mechanism kicks in. 10
seconds should be fine.

