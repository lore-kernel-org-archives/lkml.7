Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E059BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 05:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC7520872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 05:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfCRFWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 01:22:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:17040 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbfCRFWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 01:22:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Mar 2019 22:22:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,492,1544515200"; 
   d="scan'208";a="153273005"
Received: from unknown (HELO localhost.localdomain) ([10.10.37.186])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2019 22:22:09 -0700
Message-ID: <1552888060.22480.197.camel@intel.com>
Subject: Re: scif_insert_vma()
From:   Sudeep Dutt <sudeep.dutt@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Sudeep Dutt <sudeep.dutt@intel.com>, ashutosh.dixit@intel.com,
        linux-kernel@vger.kernel.org
Date:   Sun, 17 Mar 2019 22:47:40 -0700
In-Reply-To: <20190311064514.GA10833@linux.intel.com>
References: <20190311064514.GA10833@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Mailer: Evolution 3.12.11 (3.12.11-15.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 08:45 +0200, Jarkko Sakkinen wrote:
> Hi
> 
> Just wondering what will happen if kzalloc() fails in scif_mmap.c. How
> it is recovered? I don't see anything in the VMA callbacks taking care
> of this.

Hi Jarkko,

scif_insert_vma(..) is called from scif_mmap(..) and scif_vma_open(..).
scif_mmap(..) checks for allocation failures but scif_vma_open(..) does
not on purpose.

The vm_operations_struct open(..)/close(..) callbacks do not allow
returning errors. The driver will take a reference to the VMA private
data structure irrespective of whether the allocation during the
open(..) callback succeeds or fails. The close(..) callback cleans up
the data structures from the mmap(..) or open(..) callbacks if any.

Thanks,
Sudeep Dutt

