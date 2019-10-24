Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF576CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07822166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HuuA52as"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393813AbfJXN4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:56:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfJXN4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iQ+k/uiUU600gmmhxvDERL2mX3uxFYBS+kLNWX3h6ss=; b=HuuA52asl1NLA1grn9gyUMS2w
        61Z7jgUgnCXyjTZF/Gvsxy3TuIQh6N8k8SW9jV32up4gLUp/4sZ/j7T5aG11Mum4hK2SPrx+xX+/H
        c5Nks8VeUHKB4+Lr00NwYP1yQUC3uqAqnw3ub0KZopHY64CbByprC+EmITLCZEALkNrKhBrGtB9V+
        fsQBg5eopG6FImHakzh9Dnja6n1mnD6U20MHxNtpeTqqyqrQtsqTO5o+Z99YQbTaKiIiR8MXh8eCm
        opMUkfPhHupjJQNpukQ7JL09woWsIFXxEzi63OyEhWrTYZoL3uG3p7SJe62FEDAp3RGe63luyGlWI
        aEZjp0qtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNdbN-0005Hr-Vf; Thu, 24 Oct 2019 13:56:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFDB03056C0;
        Thu, 24 Oct 2019 15:55:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4EA812B1D7CA2; Thu, 24 Oct 2019 15:56:32 +0200 (CEST)
Date:   Thu, 24 Oct 2019 15:56:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com
Subject: Re: [PATCH v2 4/4] perf/x86/intel/pt: Opportunistically use single
 range output mode
Message-ID: <20191024135632.GE4114@hirez.programming.kicks-ass.net>
References: <20191022095812.67071-1-alexander.shishkin@linux.intel.com>
 <20191022095812.67071-5-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022095812.67071-5-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 12:58:12PM +0300, Alexander Shishkin wrote:
> Most of PT implementations support Single Range Output mode, which is
> an alternative to ToPA that can be used for a single contiguous buffer
> and if we don't require an interrupt, that is, in AUX snapshot mode.
> 
> Now that perf core will use high order allocations for the AUX buffer,
> in many cases the first condition will also be satisfied.
> 
> The two most obvious benefits of the Single Range Output mode over the
> ToPA are:
>  * not having to allocate the ToPA table(s),
>  * not using the ToPA walk hardware.
> 
> Make use of this functionality where available and appropriate.

This seems independent of the snapshot stuff, right?
