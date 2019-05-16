Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3EDC04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB4020843
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557971275;
	bh=sO7xZ8cfoy1kggXctOvv/jXsCa0XE2+Mn1JX3u1Ztrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h/8dC+Zw+bvuadAGp2+Zvgvh0ocZ4W5RBT0nYxiSWymch64WWejLTAOuUq/EX8AFN
	 gNw4lTtakLXZMrpFUemtwtossPmSuVNr//mQ09XXp4uN9MhCU5LD6ctHujYBm5NZvp
	 qQlZ+Q9P58ZfQVJZP3nkZpg61Bg/+D+CqEA2TJMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfEPBqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfEPAgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 20:36:51 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8621520862;
        Thu, 16 May 2019 00:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557967010;
        bh=sO7xZ8cfoy1kggXctOvv/jXsCa0XE2+Mn1JX3u1Ztrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cuRIzmu0rw0Tu/fTcMJkOlnk7CR0jH9qhtc87WHL6D/1UlVBy6nW+OIkvmQkUed0s
         RyezGH87LMjZFsD5FGjP9w8tdIOKip2Qg31PfJnCqTarbc0IevUtR3Iy5zZj3/087A
         Sd+kuEhb9w+M+CzqyH/kFnLErk4Pz7jHZB2c15hg=
Date:   Wed, 15 May 2019 20:36:49 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     shuah <shuah@kernel.org>
Cc:     Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        gustavo.padovan@collabora.co.uk,
        Dmitry Vyukov <dvyukov@google.com>, knut.omang@oracle.com
Subject: Re: Linux Testing Microconference at LPC
Message-ID: <20190516003649.GS11972@sasha-vm>
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <3c6c9405-7e90-fb03-aa1c-0ada13203980@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3c6c9405-7e90-fb03-aa1c-0ada13203980@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 04:44:19PM -0600, shuah wrote:
>Hi Sasha and Dhaval,
>
>On 4/11/19 11:37 AM, Dhaval Giani wrote:
>>Hi Folks,
>>
>>This is a call for participation for the Linux Testing microconference
>>at LPC this year.
>>
>>For those who were at LPC last year, as the closing panel mentioned,
>>testing is probably the next big push needed to improve quality. From
>>getting more selftests in, to regression testing to ensure we don't
>>break realtime as more of PREEMPT_RT comes in, to more stable distros,
>>we need more testing around the kernel.
>>
>>We have talked about different efforts around testing, such as fuzzing
>>(using syzkaller and trinity), automating fuzzing with syzbot, 0day
>>testing, test frameworks such as ktests, smatch to find bugs in the
>>past. We want to push this discussion further this year and are
>>interested in hearing from you what you want to talk about, and where
>>kernel testing needs to go next.
>>
>>Please let us know what topics you believe should be a part of the
>>micro conference this year.
>>
>>Thanks!
>>Sasha and Dhaval
>>
>
>A talk on KUnit from Brendan Higgins will be good addition to this
>Micro-conference. I am cc'ing Brendan on this thread.
>
>Please consider adding it.

FWIW, the topic of unit tests is already on the schedule. There seems to
be two different sub-topics here (kunit vs KTF) so there's a good
discussion to be had here on many levels.

--
Thanks,
Sasha
