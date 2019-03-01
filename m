Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E068DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD44F20842
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="PxQKpver"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbfCACAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:00:31 -0500
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:7645 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725967AbfCACAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:00:30 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Feb 2019 21:00:30 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1551405621; x=1582941621;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UNOe3iYPkyPcdjWQdNwxGCWUlhYAKWuSZlW1UnE6k8o=;
  b=PxQKpverEd+1xYkbwIA5wX0PEsCxClz6tkOjWXlPdalTfhbhvaj1gw9e
   XFbGXAN248FZyz8dEUzQ2TKLL3l/2cfdHayvxKxT/HxM++isvGI6K2cM6
   2b9plNddkIpWXPAXDXOr2IQcmUZFaVZWugo0E5+8AS0fCysAJBGlpN/57
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FGAADhj3hchyWd50NlHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUwUBAQsBgluBFBUcjHeMfZggFIFnCwEBhGyEFyI2Bw0BAwEBAwEDAgE?=
 =?us-ascii?q?BAhABAQEVCQgpL4I6IoJwAQEBAxIoPxACAQgYHhBXAgQBDQ0agn6Bc59MPQJ?=
 =?us-ascii?q?vgQGJBwEBAYIeijWMSIIWg3UuhGoXhWECjBOXWQcCkmIhgWSRO4dwgm6SGAI?=
 =?us-ascii?q?EAgQFAhSBTgcpgVhwgz2CNY4nQAGPNoEfAQE?=
X-IPAS-Result: =?us-ascii?q?A2FGAADhj3hchyWd50NlHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?luBFBUcjHeMfZggFIFnCwEBhGyEFyI2Bw0BAwEBAwEDAgEBAhABAQEVCQgpL?=
 =?us-ascii?q?4I6IoJwAQEBAxIoPxACAQgYHhBXAgQBDQ0agn6Bc59MPQJvgQGJBwEBAYIei?=
 =?us-ascii?q?jWMSIIWg3UuhGoXhWECjBOXWQcCkmIhgWSRO4dwgm6SGAIEAgQFAhSBTgcpg?=
 =?us-ascii?q?Vhwgz2CNY4nQAGPNoEfAQE?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa7.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2019 19:52:01 -0600
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x211i5b4077839
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 20:52:07 -0500
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0a-00154901.pphosted.com with ESMTP id 2qu1pj92hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 20:52:07 -0500
From:   <Austin.Bolen@dell.com>
To:     <kbusch@kernel.org>, <Austin.Bolen@dell.com>
Received: from ausc60ps301.us.dell.com ([143.166.148.206])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 01 Mar 2019 07:52:05 +0600
X-LoopCount0: from 10.166.134.88
X-IronPort-AV: E=Sophos;i="5.58,425,1544508000"; 
   d="scan'208";a="1263462182"
CC:     <hch@infradead.org>, <Alex_Gagniuc@Dellteam.com>,
        <torvalds@linux-foundation.org>, <keith.busch@intel.com>,
        <sagi@grimberg.me>, <linux-kernel@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <axboe@fb.com>,
        <mr.nuke.me@gmail.com>, <hch@lst.de>, <jonathan.derrick@intel.com>
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Topic: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Index: AQHUyksezlXXaxBLsUa+kQskBqUhAw==
Date:   Fri, 1 Mar 2019 01:52:02 +0000
Message-ID: <06eb10e5a7324bb5ac537fd57e015d73@AUSX13MPC131.AMER.DELL.COM>
References: <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
 <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
 <f6704855445b44639f023a48f3003309@AUSX13MPC131.AMER.DELL.COM>
 <443262761d0e41fbb46a46dab28759c2@AUSX13MPC131.AMER.DELL.COM>
 <20190228141655.GA18319@infradead.org>
 <883e2fad8f6e4791bfee2ec08992da39@AUSX13MPC131.AMER.DELL.COM>
 <20190228232020.GB22003@localhost.localdomain>
 <680f55f95e7547bdaffddce49772a5b7@AUSX13MPC131.AMER.DELL.COM>
 <20190301003026.GA22712@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=925 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903010008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/2019 6:30 PM, Keith Busch wrote:=0A=
> =0A=
> For single port drives, yes, but that wouldn't work so well for multi-por=
t=0A=
> devices connected to different busses, maybe even across multiple hosts.=
=0A=
> The equivalent of an FLR across all ports should have been sufficient,=0A=
> IMO.=0A=
> =0A=
=0A=
In that case I'd argue that it really is a surprise down to the other =0A=
host and escalating as such is appropriate.  Agree that something like =0A=
FLR that reset everything in the subsystem but kept link up may have =0A=
been sufficient.=0A=
