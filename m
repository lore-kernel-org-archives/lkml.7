Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226F8C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E829A218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388232AbfDYGvv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:51:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:33373 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfDYGvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:51:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 23:51:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; 
   d="scan'208";a="164904061"
Received: from kmsmsx153.gar.corp.intel.com ([172.21.73.88])
  by fmsmga004.fm.intel.com with ESMTP; 24 Apr 2019 23:51:49 -0700
Received: from pgsmsx114.gar.corp.intel.com ([169.254.4.194]) by
 KMSMSX153.gar.corp.intel.com ([169.254.5.36]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 14:51:48 +0800
From:   "Ong, Boon Leong" <boon.leong.ong@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>,
        "Voon, Weifeng" <weifeng.voon@intel.com>
Subject: RE: [PATCH 4/7] net: stmmac: introducing support for DWC xPCS logics
Thread-Topic: [PATCH 4/7] net: stmmac: introducing support for DWC xPCS
 logics
Thread-Index: AQHU+n5xnGC+MCh/Wkicfj2ArDC6bKZKy8YAgAFKaOD//5qfAIAAsw+A
Date:   Thu, 25 Apr 2019 06:51:47 +0000
Message-ID: <AF233D1473C1364ABD51D28909A1B1B75C0B0E38@pgsmsx114.gar.corp.intel.com>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
 <1556126241-2774-5-git-send-email-weifeng.voon@intel.com>
 <20190424134136.GO28405@lunn.ch>
 <AF233D1473C1364ABD51D28909A1B1B75C0B0244@pgsmsx114.gar.corp.intel.com>
 <20190425032120.GJ3371@lunn.ch>
In-Reply-To: <20190425032120.GJ3371@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzY0MjM4NzAtNDdlNy00YjkxLTlmOWQtOGZkZTE5MTI0YzRhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibDM4bGQ0UlFINHI0Y2N0azFwYzJWUVwvU3RSblJVVEN3NFRLVk5OU1R0NFo2TjFmXC9pOWNwTDQ1SjJEd21oUUxnIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Andrew Lunn [mailto:andrew@lunn.ch]
>Sent: Thursday, April 25, 2019 11:21 AM
>To: Ong, Boon Leong <boon.leong.ong@intel.com>
>Cc: David S. Miller <davem@davemloft.net>; netdev@vger.kernel.org; linux-
>kernel@vger.kernel.org; Kweh, Hock Leong <hock.leong.kweh@intel.com>;
>Voon, Weifeng <weifeng.voon@intel.com>
>Subject: Re: [PATCH 4/7] net: stmmac: introducing support for DWC xPCS
>logics
>
>> >> +/* MII MMD AN Status defines for C37 AN SGMII Status */
>> >> +#define AN_STAT_C37_AN_CMPLT		BIT(0)	/* AN
>Complete Intr */
>> >> +#define AN_STAT_C37_AN_FD		BIT(1)	/* Full Duplex */
>> >> +#define AN_STAT_C37_AN_SPEED_SHIFT	2	/* AN Speed shift */
>> >> +#define AN_STAT_C37_AN_SPEED		GENMASK(3, 2)	/* AN
>Speed */
>> >> +#define AN_STAT_C37_AN_10MBPS		0x0	/* 10 Mbps */
>> >> +#define AN_STAT_C37_AN_100MBPS		0x1	/* 100 Mbps
>> >*/
>> >> +#define AN_STAT_C37_AN_1000MBPS		0x2	/* 1000 Mbps
>> >*/
>> >> +#define AN_STAT_C37_AN_LNKSTS		BIT(4)	/* Link Status
>*/
>> >
>> >Is these are standardized, not proprietary, consider adding them to
>> >include/uapi/linux/mii.h so similar.
>>
>> Yeah, it does look very standardized. However, per DW spec, they are
>> vendor-specific register set which uses MDIO_MMD_VEND2 to access.
>
>Maybe you can go get the 802.3 standard and check section 37. If these
>registers are the same, they could still be placed in mii.h. What MMD
>you use is a different matter.
>
I cross-checked on 802.3 section 37.2.5.1 Management registers, the spec only
talks about BMSR and extended status. I also checked on 802.3 section 45.2
MDIO interface registers, section 45.2.7 AN registers, section 45.2.9 &
45.2.10 Vendor specific MMD1 & MMD2, there are no field format that
matches the above bit fields. So, it should be reasonable to park these #defines
in this local file for now.  

Thanks.
Boon Leong

