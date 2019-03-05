Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0DCC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713DF205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551820665;
	bh=3AUGwLf/Df49AYpnX8SBEQhJfE9uHoW4NaAcdgHMYJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SFCfDZT9qj/hR3ma2qDJ4mMC7TOhe0PITI0OFE+1mXUi+r1lX2Qyi5uOUTUsdkcKD
	 Uq2iAlD0Lcb5cIXLhAARQ5wRuPw6OqUzMg5EuZwYUI8JygEoLim3S9JO1skGlG/20V
	 YWau74etkj6hRnAGAlZSCAi/RlpsxlCzqHllgV+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfCEVRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:17:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54182 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfCEVQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:16:45 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5AB6CF89B;
        Tue,  5 Mar 2019 21:16:44 +0000 (UTC)
Date:   Tue, 5 Mar 2019 13:16:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
Message-Id: <20190305131643.94aa32165fecdb53a1109028@linux-foundation.org>
In-Reply-To: <8f3aede3-c07e-ac15-1577-7667e5b70d2f@oracle.com>
References: <388cbbf5-7086-1d04-4c49-049021504b9d@oracle.com>
        <alpine.DEB.2.21.1902241913000.34632@chino.kir.corp.google.com>
        <8c167be7-06fa-a8c0-8ee7-0bfad41eaba2@oracle.com>
        <13400ee2-3d3b-e5d6-2d78-a770820417de@oracle.com>
        <alpine.DEB.2.21.1902251116180.167839@chino.kir.corp.google.com>
        <5C74A2DA.1030304@huawei.com>
        <alpine.DEB.2.21.1902252220310.40851@chino.kir.corp.google.com>
        <e2bded2f-40ca-c308-5525-0a21777ed221@oracle.com>
        <20190226143620.c6af15c7c897d3362b191e36@linux-foundation.org>
        <086c4a4b-a37d-f144-00c0-d9a4062cc5fe@oracle.com>
        <20190305000402.GA4698@hori.linux.bs1.fc.nec.co.jp>
        <8f3aede3-c07e-ac15-1577-7667e5b70d2f@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2019 20:15:40 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> Andrew, this is on top of Alexandre Ghiti's "hugetlb: allow to free gigantic
> pages regardless of the configuration" patch.  Both patches modify
> __nr_hugepages_store_common().  Alex's patch is going to change slightly
> in this area.

OK, thanks, I missed that.  Are the changes significant?
