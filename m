Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055B6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F2820656
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfLCXtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:49:22 -0500
Received: from foss.arm.com ([217.140.110.172]:50758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfLCXtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 18:49:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50FC130E;
        Tue,  3 Dec 2019 15:49:21 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAD213F718;
        Tue,  3 Dec 2019 15:49:19 -0800 (PST)
Subject: Re: Null pointer crash at find_idlest_group on db845c w/ linus/master
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     John Stultz <john.stultz@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
 <c61cf647-ecb6-b9fa-51f2-8efa36134757@arm.com>
Message-ID: <14a8e456-1f89-0dff-ae89-61e8b6d5593b@arm.com>
Date:   Tue, 3 Dec 2019 23:49:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <c61cf647-ecb6-b9fa-51f2-8efa36134757@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2019 23:20, Valentin Schneider wrote:
> Looking at the code, I think I got it. In find_idlest_group() we do
> initialize 'idlest_sgs' (just like busiest_stat in LB) but 'idlest' is just
> NULL. The latter is dereferenced in update_pick_idlest() just for the misfit
> case, which goes boom. And I reviewed the damn thing... Bleh.
> 
> Fixup looks easy enough, lemme write one up.
> 

Wait no, that can't be right. We can only get in there if both 'group' and
'idlest' have the same group_type, which can't be true on the first pass.
So if we go through the misfit stuff, idlest *has* to be set to something.
Bah.
