Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C946C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F42F21537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hm26gu7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfGHOxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:53:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55220 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfGHOxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9ftJ7VWcpNR0grEWjo6ASfMiZO9yIE0GTV7kBvdsg4Q=; b=Hm26gu7luUBtRLjj/bf39QXCr
        vFQCnCO/fsa/+UOvsq3DTiwhOu7/Oskn+3tNSBwvuE1jAFMpkVK602l4RRudDWHDbZWinJACDF1zw
        RSqIxqGBvF8D7YbAWuW/mAatvbQvfs0khOTvpu7fYJbAbvibmXfnAyRaxcIEiXak4+pwHaHBYq/O0
        njf837YEXiq+Iio3TbP4AXXaCm/XNOte3+yoTQZYDJd3wAD0VbQZrIVi70ODpjIVcJ4Fv35R4wIIm
        Yf+E9dnMMlAjXp9Kb5WqPyHsPjDrqXl+BhSTg/fd+SOH6HrEodI8th+wZNoYX3BO29VxtFyYn5BEb
        VOTNpajXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkV1E-0007oo-Nr; Mon, 08 Jul 2019 14:53:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B028D20976D8A; Mon,  8 Jul 2019 16:53:26 +0200 (CEST)
Date:   Mon, 8 Jul 2019 16:53:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com, jmattson@google.com
Subject: Re: [PATCH v7 10/12] KVM/x86/lbr: lazy save the guest lbr stack
Message-ID: <20190708145326.GO3402@hirez.programming.kicks-ass.net>
References: <1562548999-37095-1-git-send-email-wei.w.wang@intel.com>
 <1562548999-37095-11-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562548999-37095-11-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 09:23:17AM +0800, Wei Wang wrote:
> When the vCPU is scheduled in:
> - if the lbr feature was used in the last vCPU time slice, set the lbr
>   stack to be interceptible, so that the host can capture whether the
>   lbr feature will be used in this time slice;
> - if the lbr feature wasn't used in the last vCPU time slice, disable
>   the vCPU support of the guest lbr switching.
> 
> Upon the first access to one of the lbr related MSRs (since the vCPU was
> scheduled in):
> - record that the guest has used the lbr;
> - create a host perf event to help save/restore the guest lbr stack;
> - pass the stack through to the guest.

I don't understand a word of that.

Who cares if the LBR MSRs are touched; the guest expects up-to-date
values when it does reads them.

