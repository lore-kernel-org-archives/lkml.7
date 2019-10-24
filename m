Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EFFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C7120659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHGKBeKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439752AbfJXQQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:16:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53847 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436642AbfJXQQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571933805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WrXRA91ehMR0EzuxH1to9rpY9XdaZv5EaEIpkHE/k+E=;
        b=BHGKBeKvEFcueCgTCabNqJHKHhYnM/wFHerReqCnDnDpCfEABJXsSCP/6VwIBGL/VBRv5J
        Z8hL4aPSBNwljgvrTr38+2F44ySOTwJexghUFPR/AmKgVStcGAmoN/uQrVzg9NT2NRxot3
        wMxrhRRfFWmQoOt7u5qxJq+4QFzc76w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-XIdfVkwhOSmqJ6Ejx3r1Tw-1; Thu, 24 Oct 2019 12:16:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B520800D5A;
        Thu, 24 Oct 2019 16:16:39 +0000 (UTC)
Received: from llong.remote.csb (ovpn-125-205.rdu2.redhat.com [10.10.125.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CE85452B;
        Thu, 24 Oct 2019 16:16:34 +0000 (UTC)
Subject: Re: [RFC PATCH 0/2] mm/vmstat: Reduce zone lock hold time when
 reading /proc/pagetypeinfo
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20191023095607.GE3016@techsingularity.net>
 <20191023102737.32274-1-mhocko@kernel.org>
 <20191024082042.GS17610@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <55c08581-a9c8-27cc-9710-b2bfe1934c8e@redhat.com>
Date:   Thu, 24 Oct 2019 12:16:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191024082042.GS17610@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: XIdfVkwhOSmqJ6Ejx3r1Tw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/19 4:20 AM, Michal Hocko wrote:
> On Wed 23-10-19 12:27:35, Michal Hocko wrote:
> [...]
>> I went with a bound to the pages iteratred over in the free_list. See
>> patch 2.
> I will fold http://lkml.kernel.org/r/20191023180121.GN17610@dhcp22.suse.c=
z
> to patch 2 unless there are any objections. If there are no further
> comments I will send the two patches without an RFC tomorrow.
>
> Thanks for all the feedback.

I am fine with your change. My concern is to make sure that there is a
reasonable bound to the worst case scenario. With that change, the upper
bound is iterating 100,000 list entries. I think Andrew suggested
lowering it to 1024. That I think may be too low, but I don't mind if it
is lowered somewhat from the current value.

Cheers,
Longman

