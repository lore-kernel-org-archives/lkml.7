Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A2FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1246218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="pmg8gON8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfB1Xnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:43:51 -0500
Received: from esa8.dell-outbound.iphmx.com ([68.232.149.218]:11700 "EHLO
        esa8.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729146AbfB1Xnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1551397430; x=1582933430;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QOSdfByuhtkPKEJ0cSJSD4649XeXi7jkI4EcoSByiAg=;
  b=pmg8gON89LffyZAmbi5dal4Q1tPlf8MO/7fhRuTgp/TaNVAHQXGG0ha6
   oCy6YV8pTpK4Cb5PF+dJm/OWxQdveQ2GiVAKCRmA9TSwCqqKaTA025BTA
   +pAbBsdlfrwqU79pGR1SFV1lQVvpb9JCWG77PiY0deXyYXJvhKncfjw82
   0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FMAADgcXhchieV50NlHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBVAQBAQsBgVWBBoECEhUSCox3jH2BfZY3gWcLAQGEbIQ5NwYNAQMBAQM?=
 =?us-ascii?q?BAwIBAQIQAQEBCgkLCCkvgjoigm8BAQEBAgESKD8FCwIBCBgeEFcCBAENBQg?=
 =?us-ascii?q?agn6BawifQj0Cb4EBiQcBAQGCHoozjl6BEYJkLoROARIBCBeFYQKJaYIpl1g?=
 =?us-ascii?q?HApJiIZMch2+CbpIXAgQCBAUCFIFdgQhxcIM8gjaOJ0ABMY1mgR+BHwEB?=
X-IPAS-Result: =?us-ascii?q?A2FMAADgcXhchieV50NlHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VWBBoECEhUSCox3jH2BfZY3gWcLAQGEbIQ5NwYNAQMBAQMBAwIBAQIQAQEBC?=
 =?us-ascii?q?gkLCCkvgjoigm8BAQEBAgESKD8FCwIBCBgeEFcCBAENBQgagn6BawifQj0Cb?=
 =?us-ascii?q?4EBiQcBAQGCHoozjl6BEYJkLoROARIBCBeFYQKJaYIpl1gHApJiIZMch2+Cb?=
 =?us-ascii?q?pIXAgQCBAUCFIFdgQhxcIM8gjaOJ0ABMY1mgR+BHwEB?=
Received: from mx0a-00154901.pphosted.com (HELO mx0b-00154901.pphosted.com) ([67.231.149.39])
  by esa8.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2019 17:43:49 -0600
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SNhnif127358
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 18:43:49 -0500
Received: from esa6.dell-outbound2.iphmx.com (esa6.dell-outbound2.iphmx.com [68.232.154.99])
        by mx0b-00154901.pphosted.com with ESMTP id 2qxp1ghpsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 18:43:49 -0500
From:   <Austin.Bolen@dell.com>
To:     <kbusch@kernel.org>, <Austin.Bolen@dell.com>
Received: from ausxipps310.us.dell.com ([143.166.148.211])
  by esa6.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 01 Mar 2019 05:43:48 +0600
X-LoopCount0: from 10.166.134.87
X-IronPort-AV: E=Sophos;i="5.58,425,1544508000"; 
   d="scan'208";a="324989107"
CC:     <hch@infradead.org>, <Alex_Gagniuc@Dellteam.com>,
        <torvalds@linux-foundation.org>, <keith.busch@intel.com>,
        <sagi@grimberg.me>, <linux-kernel@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <axboe@fb.com>,
        <mr.nuke.me@gmail.com>, <hch@lst.de>, <jonathan.derrick@intel.com>
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Topic: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Index: AQHUyksezlXXaxBLsUa+kQskBqUhAw==
Date:   Thu, 28 Feb 2019 23:43:46 +0000
Message-ID: <680f55f95e7547bdaffddce49772a5b7@AUSX13MPC131.AMER.DELL.COM>
References: <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
 <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
 <f6704855445b44639f023a48f3003309@AUSX13MPC131.AMER.DELL.COM>
 <443262761d0e41fbb46a46dab28759c2@AUSX13MPC131.AMER.DELL.COM>
 <20190228141655.GA18319@infradead.org>
 <883e2fad8f6e4791bfee2ec08992da39@AUSX13MPC131.AMER.DELL.COM>
 <20190228232020.GB22003@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/2019 5:20 PM, Keith Busch wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> On Thu, Feb 28, 2019 at 11:10:11PM +0000, Austin.Bolen@dell.com wrote:=0A=
>> I'd also note that in PCIe, things that intentionally take the link down=
=0A=
>> like SBR or Link Disable suppress surprise down error reporting.  But=0A=
>> NSSR doesn't have this requirement to suppress surprise down reporting.=
=0A=
>> I think that's a gap on the part of the NVMe spec.=0A=
> =0A=
> SBR and Link Disable are done from the down stream port, though, so the=
=0A=
> host can still communicate with the function that took the link down.=0A=
> That's entirely different than taking the link down from the end device,=
=0A=
> so I'm not sure how NVMe can fix that.=0A=
> =0A=
=0A=
Agreed it is different.  Here is one way they could have solved it: host =
=0A=
writes magic value to NSSRC but device latches this instead of =0A=
resetting.  Then require host to do SBR.  When device sees SBR with =0A=
magic value in NSSRC it does an NSSR.=0A=
=0A=
> But I can't even recall why NVMe defined NSSR to require PCIe LTSSM=0A=
> Detect. That seems entirely unnecessary and is just asking for trouble.=
=0A=
> =0A=
=0A=
Not sure why but maybe they wanted a full reset of everything including =0A=
the PCIe block.  I can ask around.  Also agree it is asking for trouble =0A=
to have device take the link down without parent bridge knowing what's =0A=
going on.  There are new mechanism being proposed in NVMe that would =0A=
also allow the device to initiate link down with no co-ordination with =0A=
the parent bridge so may need to think on ways to avoid this issue for =0A=
these new similar mechanisms.=0A=
=0A=
-Austin=0A=
