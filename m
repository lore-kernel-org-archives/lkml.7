Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BA8C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 21:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F339421D56
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 21:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbfIRVpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 17:45:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:49924 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388087AbfIRVpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 17:45:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 14:45:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; 
   d="scan'208";a="338457730"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga004.jf.intel.com with ESMTP; 18 Sep 2019 14:45:07 -0700
Date:   Wed, 18 Sep 2019 14:45:07 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] libnvdimm/nfit_test: Fix acpi_handle redefinition
Message-ID: <20190918214506.GA20171@iweiny-DESK2.sc.intel.com>
References: <20190918042148.77553-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918042148.77553-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 09:21:49PM -0700, Nathan Chancellor wrote:
> After commit 62974fc389b3 ("libnvdimm: Enable unit test infrastructure
> compile checks"), clang warns:
> 
> In file included from
> ../drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:15:
> ../drivers/nvdimm/../../tools/testing/nvdimm/test/nfit_test.h:206:15:
> warning: redefinition of typedef 'acpi_handle' is a C11 feature
> [-Wtypedef-redefinition]
> typedef void *acpi_handle;
>               ^
> ../include/acpi/actypes.h:424:15: note: previous definition is here
> typedef void *acpi_handle;      /* Actually a ptr to a NS Node */
>               ^
> 1 warning generated.
> 
> The include chain:
> 
> iomap.c ->
>     linux/acpi.h ->
>         acpi/acpi.h ->
>             acpi/actypes.h
>     nfit_test.h
> 
> Avoid this by including linux/acpi.h in nfit_test.h, which allows us to
> remove both the typedef and the forward declaration of acpi_object.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/660
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> 
> I know that every maintainer has their own thing with the number of
> includes in each header file; this issue can be solved in a various
> number of ways, I went with the smallest diff stat. Please solve it in a
> different way if you see fit :)
> 
>  tools/testing/nvdimm/test/nfit_test.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/testing/nvdimm/test/nfit_test.h b/tools/testing/nvdimm/test/nfit_test.h
> index 448d686da8b1..0bf5640f1f07 100644
> --- a/tools/testing/nvdimm/test/nfit_test.h
> +++ b/tools/testing/nvdimm/test/nfit_test.h
> @@ -4,6 +4,7 @@
>   */
>  #ifndef __NFIT_TEST_H__
>  #define __NFIT_TEST_H__
> +#include <linux/acpi.h>
>  #include <linux/list.h>
>  #include <linux/uuid.h>
>  #include <linux/ioport.h>
> @@ -202,9 +203,6 @@ struct nd_intel_lss {
>  	__u32 status;
>  } __packed;
>  
> -union acpi_object;
> -typedef void *acpi_handle;
> -
>  typedef struct nfit_test_resource *(*nfit_test_lookup_fn)(resource_size_t);
>  typedef union acpi_object *(*nfit_test_evaluate_dsm_fn)(acpi_handle handle,
>  		 const guid_t *guid, u64 rev, u64 func,
> -- 
> 2.23.0
> 
