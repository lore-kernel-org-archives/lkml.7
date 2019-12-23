Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB1AC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 22:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B005A206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 22:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577139954;
	bh=5aMaM5UVt54PsEDXZJzFRawKZxOG0oyvOuZbI/OOOGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=evycTYYs8EAUNUrNPx5DJJI+q+qaRdIB0664W9KGaaqWDYOuFVaotn1OnnLhHxu7r
	 FPUSk8ZY+wFONot4mgH15bsXlKEKh7oBo6R2mrnGMxQHxLK3Sjl1bvQnmdQQ1yVTve
	 +qbFq+3hI5heye0+BGwSPdpYU3cERZ8HQTs4sXKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfLWWZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 17:25:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfLWWZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 17:25:53 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC643206CB;
        Mon, 23 Dec 2019 22:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577139953;
        bh=5aMaM5UVt54PsEDXZJzFRawKZxOG0oyvOuZbI/OOOGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wolt0qChOLq8tmz5oBNi17H9c7dvEGVOx9+4veDYvCwtoC0bz9UAWX1nKyhXGZjeH
         k+3OVfD7KJ5VjAgKFpLnjj65qa2B4VmsK5uvIbCht/e4F50eP5R53/w0gy7u8w0v9+
         rgBmAOO1xjaoZQgYilKT3pJ2XsCDxBPxhZRqCWkM=
Date:   Mon, 23 Dec 2019 14:25:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Willhalm, Thomas" <thomas.willhalm@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Bruggeman, Otto G" <otto.g.bruggeman@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 0/2] Fix two above-47bit hint address vs. THP bugs
Message-Id: <20191223142552.d9bd85e588196d17fb90ee2e@linux-foundation.org>
In-Reply-To: <20191220142548.7118-1-kirill.shutemov@linux.intel.com>
References: <20191220142548.7118-1-kirill.shutemov@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019 17:25:46 +0300 "Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> The two get_unmapped_area() implementations have to be fixed to provide
> THP-friendly mappings if above-47bit hint address is specified.
> 

Do we need a cc:stable for these?
