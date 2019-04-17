Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5932C282DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FF421872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555538525;
	bh=fvwu0f5A9pM+5YFfwJwrmVl35+ZdYtMfyjCvcV8cbWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XAyAds1oO8l5G6vm9SSj+q6IJh4vU8g64tN81yBXHqTzWUpkV+MX6DWdaPtAOA0Sr
	 zyxMLp9fZJ9mqgE4xTJlRHkrndh7lMlrFBl32TDj0gRrL/d2sebL6wM315ZDETNYEn
	 O5TyMeSy1KSQ+nf+2MGNuFF/zIeJoaoWckrlIl4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbfDQWCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:02:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55126 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDQWCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:02:04 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 18633C2A;
        Wed, 17 Apr 2019 22:02:03 +0000 (UTC)
Date:   Wed, 17 Apr 2019 15:02:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     stable@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, david@redhat.com
Subject: Re: [PATCH v6 11/12] libnvdimm/pfn: Fix fsdax-mode namespace
 info-block zero-fields
Message-Id: <20190417150202.b7cec444cf81ed44a150ea9d@linux-foundation.org>
In-Reply-To: <155552639290.2015392.17304211251966796338.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
        <155552639290.2015392.17304211251966796338.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 11:39:52 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> At namespace creation time there is the potential for the "expected to
> be zero" fields of a 'pfn' info-block to be filled with indeterminate
> data. While the kernel buffer is zeroed on allocation it is immediately
> overwritten by nd_pfn_validate() filling it with the current contents of
> the on-media info-block location. For fields like, 'flags' and the
> 'padding' it potentially means that future implementations can not rely
> on those fields being zero.
> 
> In preparation to stop using the 'start_pad' and 'end_trunc' fields for
> section alignment, arrange for fields that are not explicitly
> initialized to be guaranteed zero. Bump the minor version to indicate it
> is safe to assume the 'padding' and 'flags' are zero. Otherwise, this
> corruption is expected to benign since all other critical fields are
> explicitly initialized.
> 
> Fixes: 32ab0a3f5170 ("libnvdimm, pmem: 'struct page' for pmem")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Buried at the end of a 12 patch series.  Should this be a standalone
patch, suitable for a prompt merge?
