Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D84C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C402133D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfFMVaj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:30:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:17200 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfFMVaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:30:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 14:30:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,370,1557212400"; 
   d="scan'208";a="184757505"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2019 14:30:38 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 13 Jun 2019 14:30:38 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.84]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.84]) with mapi id 14.03.0415.000;
 Thu, 13 Jun 2019 14:30:38 -0700
From:   "Bowers, AndrewX" <andrewx.bowers@intel.com>
To:     "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH] ixgbevf: fix possible divide by zero
 in ixgbevf_update_itr
Thread-Topic: [Intel-wired-lan] [PATCH] ixgbevf: fix possible divide by zero
 in ixgbevf_update_itr
Thread-Index: AQHVFf5r7xrgWhY4+UWyPbZJL5Ro+KaaMmgw
Date:   Thu, 13 Jun 2019 21:30:37 +0000
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3ED68F@ORSMSX104.amr.corp.intel.com>
References: <1559044682-23446-1-git-send-email-92siuyang@gmail.com>
In-Reply-To: <1559044682-23446-1-git-send-email-92siuyang@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjFmYjk0MzEtNWY0YS00N2UwLTg5NDQtNDliM2E4NzczM2FhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZkJRSXZEOFBHZTdrczdiXC9NSmZHSHA3ek5CWU1PcmtGcXZ4T1JcL3loZU5xVjBVNk81dmFnNll3WnBNUVozSWN3In0=
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
> Behalf Of Young Xiao
> Sent: Tuesday, May 28, 2019 4:58 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem@davemloft.net;
> intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Young Xiao <92siuyang@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix possible divide by zero in
> ixgbevf_update_itr
> 
> The next call to ixgbevf_update_itr will continue to dynamically update ITR.
> 
> Copy from commit bdbeefe8ea8c ("ixgbe: fix possible divide by zero in
> ixgbe_update_itr")
> 
> Signed-off-by: Young Xiao <92siuyang@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


