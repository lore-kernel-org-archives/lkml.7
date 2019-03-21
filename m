Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551BAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2833421916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfCUWcu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:32:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:5858 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfCUWct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:32:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:32:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="142746386"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Mar 2019 15:32:48 -0700
Received: from orsmsx125.amr.corp.intel.com (10.22.240.125) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 21 Mar 2019 15:32:48 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.204]) by
 ORSMSX125.amr.corp.intel.com ([169.254.3.65]) with mapi id 14.03.0415.000;
 Thu, 21 Mar 2019 15:32:48 -0700
From:   "Bowers, AndrewX" <andrewx.bowers@intel.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH net] ixgbe: fix mdio bus registration
Thread-Topic: [Intel-wired-lan] [PATCH net] ixgbe: fix mdio bus registration
Thread-Index: AQHU2035ZLA7+Fy1r0SThbLM+B9IgaYWtUYA
Date:   Thu, 21 Mar 2019 22:32:47 +0000
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D376AA9@ORSMSX104.amr.corp.intel.com>
References: <20190315084515.22983-1-ivecera@redhat.com>
In-Reply-To: <20190315084515.22983-1-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjY1OGJiOTktNmFmOC00MDIwLWI5OWQtMjJiNmYyOThhYWEyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiU01RNk5LaWQ5VUtLUjBkNjZlZEdEVm1MQjYzVTNkWDl2TzRjaXdab09VYTlIa0dpZFExSzBxS1wvR1FUMVF3XC93In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> Behalf Of Ivan Vecera
> Sent: Friday, March 15, 2019 1:45 AM
> To: netdev@vger.kernel.org
> Cc: open list <linux-kernel@vger.kernel.org>; moderated list:INTEL
> ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>; David S. Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix mdio bus registration
> 
> The ixgbe ignores errors returned from mdiobus_register() and leaves
> adapter->mii_bus non-NULL and MDIO bus state as MDIOBUS_ALLOCATED.
> This triggers a BUG from mdiobus_unregister() during ixgbe_remove() call.
> 
> Fixes: 8fa10ef01260 ("ixgbe: register a mdiobus")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


