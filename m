Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AB4C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B1621BE6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfGVFVj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:21:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:15257 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfGVFVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:21:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jul 2019 22:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,293,1559545200"; 
   d="scan'208";a="174125977"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2019 22:21:37 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 21 Jul 2019 22:21:37 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.96]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.34]) with mapi id 14.03.0439.000;
 Sun, 21 Jul 2019 22:21:37 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH 1/1] iommu/vt-d: Correctly check format of page table in
 debugfs
Thread-Topic: [PATCH 1/1] iommu/vt-d: Correctly check format of page table
 in debugfs
Thread-Index: AQHVPp8ipwYNQGhYs0KyxJ8SpXgi1qbWGSVg
Date:   Mon, 22 Jul 2019 05:21:37 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4F9354AF@ORSMSX114.amr.corp.intel.com>
References: <20190720020126.9974-1-baolu.lu@linux.intel.com>
In-Reply-To: <20190720020126.9974-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjg4NWZmYjQtYjJlZS00NWM1LTlhZWMtYjRkN2Q3MWE0OGFiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWkw4aDBPbTZ2NklUZFwvUDFjdkNXWk9VQWNkWlMxa2F1QitpSm5WazRLRmhJRXkwQWhzeFBPNjRudFwvRllCdUVCIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

> diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-
> iommu-debugfs.c
> index 73a552914455..e31c3b416351 100644
> --- a/drivers/iommu/intel-iommu-debugfs.c
> +++ b/drivers/iommu/intel-iommu-debugfs.c
> @@ -235,7 +235,7 @@ static void ctx_tbl_walk(struct seq_file *m, struct
> intel_iommu *iommu, u16 bus)
>  		tbl_wlk.ctx_entry = context;
>  		m->private = &tbl_wlk;
> 
> -		if (pasid_supported(iommu) && is_pasid_enabled(context)) {
> +		if (dmar_readq(iommu->reg + DMAR_RTADDR_REG) &
> DMA_RTADDR_SMT) {

Thanks for adding this, I do believe this is a good addition but I also think that we might 
need "is_pasid_enabled()" as well. It checks if PASIDE bit in context entry is enabled or not.

I am thinking that even though DMAR might be using scalable root and context table, the entry 
itself should have PASIDE bit set. Did I miss something here?

And I also think a macro would be better so that it could reused elsewhere (if need be).

Regards,
Sai
