Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E4BC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 04:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D19E21BE6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 04:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfGVEtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 00:49:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:61490 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfGVEtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 00:49:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jul 2019 21:49:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,293,1559545200"; 
   d="scan'208";a="170755148"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jul 2019 21:49:48 -0700
Date:   Sun, 21 Jul 2019 21:49:48 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     arnd@arndb.de, sivanich@sgi.com, gregkh@linuxfoundation.org,
        jhubbard@nvidia.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] sgi-gru: get_user_page changes
Message-ID: <20190722044947.GA6157@iweiny-DESK2.sc.intel.com>
References: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 09:28:02PM +0530, Bharath Vedartham wrote:
> This patch series incorporates a few changes in the get_user_page usage 
> of sgi-gru.
> 
> The main change is the first patch, which is a trivial one line change to 
> convert put_page to put_user_page to enable tracking of get_user_pages.
> 
> The second patch removes an uneccessary ifdef of CONFIG_HUGETLB.
> 
> The third patch adds __get_user_pages_fast in atomic_pte_lookup to retrive
> a physical user page in an atomic context instead of manually walking up
> the page tables like the current code does. This patch should be subject to 
> more review from the gup people.
> 
> drivers/misc/sgi-gru/* builds after this patch series. But I do not have the 
> hardware to verify these changes. 
> 
> The first patch implements gup tracking in the current code. This is to be tested
> as to check whether gup tracking works properly. Currently, in the upstream kernels
> put_user_page simply calls put_page. But that is to change in the future. 
> Any suggestions as to how to test this code?
> 
> The implementation of gup tracking is in:
> https://github.com/johnhubbard/linux/tree/gup_dma_core
> 
> We could test it by applying the first patch to the above tree and test it.
> 
> More details are in the individual changelogs.
> 
> Bharath Vedartham (3):

I don't have an opinion on the second patch regarding any performance concerns
since I'm not familiar with this hardware.

But from a GUP POV For the series.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

>   sgi-gru: Convert put_page() to get_user_page*()
>   sgi-gru: Remove CONFIG_HUGETLB_PAGE ifdef
>   sgi-gru: Use __get_user_pages_fast in atomic_pte_lookup
> 
>  drivers/misc/sgi-gru/grufault.c | 50 +++++++----------------------------------
>  1 file changed, 8 insertions(+), 42 deletions(-)
> 
> -- 
> 2.7.4
> 
