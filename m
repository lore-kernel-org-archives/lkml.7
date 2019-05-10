Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E751CC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1040217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557523022;
	bh=WrSi5jHV6SOltHTRjAOARni7OmFLSEe0K6ep9p6h53s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lMWM2mhEfZCT1A+O1up7ua38CmVTiDwGO3dI77l4Df/EgmaolwzbXUbPiudebJ6Hz
	 yM32YlaG9BqXRAE61VWYDiiIOxD2++Gp5+Mb4kFa6aZXLySOFr/lRz/hQXwN1vrmmV
	 xIBiSFdYcNhD1n2nAUYZVGln8qdwOpcA0psxAhzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfEJVRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 17:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfEJVRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 17:17:01 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9735520896;
        Fri, 10 May 2019 21:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557523020;
        bh=WrSi5jHV6SOltHTRjAOARni7OmFLSEe0K6ep9p6h53s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YNxRIaYgHUo1dWlD85ZFCIL5YSk3Cha+eYCoGs5AgoCUDVCBzesDOqhW3oY60AP1O
         ARNXJwykVG2EbSSoceQDX3qlwp0wm3LhS+fgUA3xdDskZL1P1OY/wToCjOfz7XYwk9
         n4L/v528+OlY1WjeYvlQLjXiYKlFWEp6Kr2gzaJs=
Date:   Fri, 10 May 2019 14:16:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Schatzberg <dschatzberg@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH] psi: Expose pressure metrics on root cgroup
Message-Id: <20190510141659.08f58679c2eb3d321092dc23@linux-foundation.org>
In-Reply-To: <20190510174938.3361741-1-dschatzberg@fb.com>
References: <20190510174938.3361741-1-dschatzberg@fb.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2019 10:49:34 -0700 Dan Schatzberg <dschatzberg@fb.com> wrote:

> Pressure metrics are already recorded and exposed in procfs for the
> entire system, but any tool which monitors cgroup pressure has to
> special case the root cgroup to read from procfs. This patch exposes
> the already recorded pressure metrics on the root cgroup.
> 

Documentation/admin-guide/cgroup-v2.rst says "A read-only nested-key
file which exists on non-root cgroups". 
Documentation/accounting/psi.txt could do woth some clarification as
well.

