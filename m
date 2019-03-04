Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4B2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755A420815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfCDOr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:47:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfCDOr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:47:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 447CD8123A;
        Mon,  4 Mar 2019 14:47:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id E064051F0A;
        Mon,  4 Mar 2019 14:47:55 +0000 (UTC)
Date:   Mon, 4 Mar 2019 15:47:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 10/11] perf tools report: Implement browsing of
 individual samples
Message-ID: <20190304144755.GF30476@krava>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-11-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228183550.14126-11-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 04 Mar 2019 14:47:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:35:49AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Now report can show whole time periods with perf script,
> but the user still has to find individual samples of interest
> manually.
> 
> It would be expensive and complicated to search for the
> right samples in the whole perf file. Typically users
> only need to look at a small number of samples for useful
> analysis.
> 
> Also the full scripts tend to show samples of all CPUs and all
> threads mixed up, which can be very confusing on larger systems.
> 
> Add a new --samples option to save a small random number of samples
> per hist entry
> 
> Use a reservoir sample technique to select a representatve
> number of samples.
> 
> Then allow browsing the samples using perf script
> as part of the hist entry context menu. This automatically
> adds the right filters, so only the thread or cpu of the sample
> is displayed. Then we use less' search functionality
> to directly jump the to the time stamp of the selected
> sample.

I'm getting this error for workload sampling:

File does not contain CPU events. Remove -C option to proceed.


jirka
