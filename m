Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F64C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2CB213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561470088;
	bh=LOjVR/zCOOavzyfdkONnkNBnRswHHfgS5xi+h5FfHwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cmgsfPOBDBOcz3OinsnXDXUeTS82Cl3ZBFMxL7mDmS6PLYdh1sM1hgtkxbRmZwH+m
	 2Hmemj791t3PwcjfPVzDcunFDMSYYvvpvnJyHouyO/v5JlpJNq6YdpLwqVFWLiLca3
	 PE710920oDE6CW52N104b63OyHZZJYsfXY69wqFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfFYNl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730852AbfFYNlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:23 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5982133F;
        Tue, 25 Jun 2019 13:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561470082;
        bh=LOjVR/zCOOavzyfdkONnkNBnRswHHfgS5xi+h5FfHwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhzue9w2YA2B/nApeUVqoiZqwDaU/BSbEY6fr/5HABCG6oVHY5M4Ap85fAtv+LK1V
         xNKDjwolFglKpTC0T5vk8hp+EJFchPrZ4IBAFlIcYAJYbi8j7uQEykSrJno7My7eFv
         X/wbBxgZzPbkXTgyOYpwNrQ8ktERyqOeJ4kssy8g=
Date:   Tue, 25 Jun 2019 14:41:18 +0100
From:   Will Deacon <will@kernel.org>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, will.deacon@arm.com,
        peterz@infradead.org, catalin.marinas@arm.com,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        mathieu.desnoyers@efficios.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/7] perf: arm64: Use rseq to test userspace access to
 pmu counters
Message-ID: <20190625134117.r3gysn7mvzzdrytj@willie-the-truck>
References: <20190611125315.18736-1-raphael.gault@arm.com>
 <20190611125315.18736-4-raphael.gault@arm.com>
 <20190611143346.GB28689@kernel.org>
 <20190611165755.GG29008@lakrids.cambridge.arm.com>
 <ff5897eb-ae6c-482f-148b-947a661fde4f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff5897eb-ae6c-482f-148b-947a661fde4f@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raphael,

On Tue, Jun 25, 2019 at 02:29:56PM +0100, Raphael Gault wrote:
> Now that we have a better idea what enabling this feature for heterogeneous
> systems would look like (both with or without using rseqs), it might be
> worth discussing if this is in fact a desirable thing in term of
> performance-complexity trade off.

Agreed; it's one of those things that I think is *definitely* worth
prototyping, but it's not obviously something we should commit to at this
stage.

> Indeed, while not as scary as first thought, maybe the rseq method would
> still dissuade users from using this feature. It is also worth noting that
> if we only enable this feature on homogeneous system, the `mrs`
> hook/emulation would not be necessary.
> If because of the complexity of the setup we need to consider whether we
> want to upstream this and have to maintain it afterward.

Given that we don't currently support userspace access to the counters at
all, I think upstreaming support only for homogeneous systems makes sense
initially as long as (a) we fail gracefully on heterogeneous systems and (b)
we don't close the door to using the rseq-based mechanism in future if we
choose to (i.e. it would be nice if this was an extension to the ABI rather
than a break). That also gives us a chance to assess the wider adoption of
rseq before throwing our weight behind it.

Sound reasonable?

Will
