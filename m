Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD62C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46F221537
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfFMVdf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:33:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:57272 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfFMVde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:33:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 14:33:34 -0700
X-ExtLoop1: 1
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga007.jf.intel.com with ESMTP; 13 Jun 2019 14:33:33 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 13 Jun 2019 14:33:33 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.84]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.233]) with mapi id 14.03.0415.000;
 Thu, 13 Jun 2019 14:33:33 -0700
From:   "Bowers, AndrewX" <andrewx.bowers@intel.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH][next] i40e/i40e_virtchnl_pf: Use
 struct_size() in kzalloc()
Thread-Topic: [Intel-wired-lan] [PATCH][next] i40e/i40e_virtchnl_pf: Use
 struct_size() in kzalloc()
Thread-Index: AQHVG7fxogHfR0kmSkmtlC3JCwMGZqaaJ8Lw
Date:   Thu, 13 Jun 2019 21:33:33 +0000
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3ED69F@ORSMSX104.amr.corp.intel.com>
References: <20190605154052.GA7571@embeddedor>
In-Reply-To: <20190605154052.GA7571@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTk3MWY2ZGQtMWRjOS00MjYxLTkyOWMtMDcxZGQ1ZTZjOWQ5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVHgyUXRlR2Y2YzhvZHRxWjhZb3VmZFloWFdqODhDcDN5aiswcWU2RHB2N0lPckFtN3hRS1VSQVhoSnBIOG1lQiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> Behalf Of Gustavo A. R. Silva
> Sent: Wednesday, June 5, 2019 8:41 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S. Miller
> <davem@davemloft.net>
> Cc: netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH][next] i40e/i40e_virtchnl_pf: Use
> struct_size() in kzalloc()
> 
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct virtchnl_iwarp_qvlist_info {
> 	...
>         struct virtchnl_iwarp_qv_info qv_info[1]; };
> 
> size = sizeof(struct virtchnl_iwarp_qvlist_info) + (sizeof(struct
> virtchnl_iwarp_qv_info) * count; instance = kzalloc(size, GFP_KERNEL);
> 
> and
> 
> struct virtchnl_vf_resource {
> 	...
>         struct virtchnl_vsi_resource vsi_res[1]; };
> 
> size = sizeof(struct virtchnl_vf_resource) + sizeof(struct
> virtchnl_vsi_resource) * count; instance = kzalloc(size, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, qv_info, count), GFP_KERNEL);
> 
> and
> 
> instance = kzalloc(struct_size(instance, vsi_res, count), GFP_KERNEL);
> 
> Notice that, in the first case above, variable size is not necessary, hence it is
> removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c    | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


