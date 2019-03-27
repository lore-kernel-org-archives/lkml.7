Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE10BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92762075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfC0OAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:00:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55382 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfC0OAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:00:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53CCD80D;
        Wed, 27 Mar 2019 07:00:01 -0700 (PDT)
Received: from [10.162.40.146] (p8cg001049571a15.blr.arm.com [10.162.40.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB1803F59C;
        Wed, 27 Mar 2019 06:59:58 -0700 (PDT)
Subject: Re: [PATCH] mm/page-flags: Check enforce parameter in PF_ONLY_HEAD()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hannes@cmpxchg.org, david@redhat.com, vbabka@suse.cz,
        willy@infradead.org, akpm@linux-foundation.org,
        Nicholas Piggin <npiggin@gmail.com>
References: <1553689672-28343-1-git-send-email-anshuman.khandual@arm.com>
 <20190327131506.GI11927@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e84f6e20-ccf5-5779-2733-7b259dc2493a@arm.com>
Date:   Wed, 27 Mar 2019 19:29:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190327131506.GI11927@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/27/2019 06:45 PM, Michal Hocko wrote:
> [Cc Nick]
> 
> On Wed 27-03-19 17:57:52, Anshuman Khandual wrote:
>> Just check for enforce parameter in PF_ONLY_HEAD() wrapper before calling
>> VM_BUG_ON_PGFLAGS() for tail pages.
> Why is this an actual fix? Only TESTPAGEFLAG doesn't enforce the check
> but I suspect that Nick just wanted the check to be _always_ performed
> as the name suggests. What kind of problem are you trying to solve?

Did not hit any problem directly. Just from code inspection it seemed that
the enforce check was missing as compared to other wrappers there. I felt
that the commit could have probably omitted the check by mistake.
