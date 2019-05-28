Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E5CC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CC52081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfE1Ku0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:50:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54988 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfE1Ku0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:50:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 090F8341;
        Tue, 28 May 2019 03:50:26 -0700 (PDT)
Received: from [10.162.40.141] (p8cg001049571a15.blr.arm.com [10.162.40.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC2493F59C;
        Tue, 28 May 2019 03:50:21 -0700 (PDT)
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <dbe801f0-4bbe-5f6e-9053-4b7deb38e235@arm.com>
 <CAEe=Sxka3Q3vX+7aWUJGKicM+a9Px0rrusyL+5bB1w4ywF6N4Q@mail.gmail.com>
 <1754d0ef-6756-d88b-f728-17b1fe5d5b07@arm.com>
 <20190521103433.GL32329@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <719d3ebf-c6c2-2468-4f04-0ba54b74b054@arm.com>
Date:   Tue, 28 May 2019 16:20:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190521103433.GL32329@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/21/2019 04:04 PM, Michal Hocko wrote:
> On Tue 21-05-19 08:25:55, Anshuman Khandual wrote:
>> On 05/20/2019 10:29 PM, Tim Murray wrote:
> [...]
>>> not seem to introduce a noticeable hot start penalty, not does it
>>> cause an increase in performance problems later in the app's
>>> lifecycle. I've measured with and without process_madvise, and the
>>> differences are within our noise bounds. Second, because we're not
>>
>> That is assuming that post process_madvise() working set for the application is
>> always smaller. There is another challenge. The external process should ideally
>> have the knowledge of active areas of the working set for an application in
>> question for it to invoke process_madvise() correctly to prevent such scenarios.
> 
> But that doesn't really seem relevant for the API itself, right? The
> higher level logic the monitor's business.

Right. I was just wondering how the monitor would even decide what areas of the
target application is active or inactive. The target application is still just an
opaque entity for the monitor unless there is some sort of communication. But you
are right, this not relevant to the API itself.
