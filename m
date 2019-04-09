Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA1AC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED07E2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554846744;
	bh=zRD0n+4BpSV0+7CuNp/SlfcmVfV7ZNV1oEI/W5m/Qxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LEwsVSi/MlF11+T4kJKCM/A9bdIg5nWNTcFv/bqqIvtU8oOXxI0y0LvAox70wG/5s
	 Ke6BB8FbRF3jNuFyprCU69GQ2bnI/cEdxQuxT7ivlmYj5FVcqcuKvj8qwmCfPdo+7d
	 Bvmee8mnK9FFj47q0JHKVIgT0/llBGH/3agO9p5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfDIVwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:52:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36336 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfDIVwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:52:22 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B4D161009;
        Tue,  9 Apr 2019 21:52:21 +0000 (UTC)
Date:   Tue, 9 Apr 2019 14:52:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/hmm: fix hmm_range_dma_map()/hmm_range_dma_unmap()
Message-Id: <20190409145220.d3a0a48872fcd9106846664c@linux-foundation.org>
In-Reply-To: <20190409175340.26614-1-jglisse@redhat.com>
References: <20190409175340.26614-1-jglisse@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Apr 2019 13:53:40 -0400 jglisse@redhat.com wrote:

> Was using wrong field and wrong enum for read only versus read and
> write mapping.

For thos who were wondering, this fixes
mm-hmm-add-an-helper-function-that-fault-pages-and-map-them-to-a-device-v3.patch,
which is presently queued in -mm.

