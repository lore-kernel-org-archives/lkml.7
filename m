Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB9EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 19:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F18F2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 19:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="c3acLBXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfHNTvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 15:51:51 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:40554 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbfHNTvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 15:51:50 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7EJnWpX017594
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 15:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=8Q43YGR3tfZ4a9VaNxsgSZhTryTR5oYY2YB8ljQh0Kc=;
 b=c3acLBXJbVW4FcrfhBV22F4l36zucjtue4UPcdEvtWJDwqu1AoSWTg8uU6uHKCbuDj4R
 uwjpybk+CffpxPW462Tk1urE/jPzzaEXHLu7C9p1GmywP5+8+S1XGjpXv8WHdfn13qvw
 e5BdhR/KgWmSbptHFZzQNoIk/6FjM9jz9D86N9yHZNjByopHCjHgg7qY6TfFNobWHMcR
 q55qvQvVmv0ZvoSByYgHc+LNP5zs4nxRiyDwY7EqBtirbqwMIxwFi4dWzPiKiw/QS/eO
 SeW46GWQ16Bqyy9dawOH8oCqQDgNDRJ6YTWJPNcVATTrUBF/zwJQYxtbDu8Ae0saoqtf /Q== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2uc15n61pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 15:51:49 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7EJhS2x130904
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 15:51:48 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2ucqw18tyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 15:51:48 -0400
X-LoopCount0: from 10.166.132.55
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="360757861"
From:   <Mario.Limonciello@dell.com>
To:     <kbusch@kernel.org>
CC:     <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Ryan.Hong@Dell.com>, <Crag.Wang@dell.com>, <sjg@google.com>,
        <Charles.Hyde@dellteam.com>, <Jared.Dominguez@dell.com>
Subject: RE: [PATCH] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
Thread-Topic: [PATCH] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
Thread-Index: AQHVUro4qx6m+BDuG0mXVmnmQvARiqb7XB4A//+u5dA=
Date:   Wed, 14 Aug 2019 19:51:46 +0000
Message-ID: <3f5dec208f334839b56ae63bb1a3e6f3@AUSX13MPC105.AMER.DELL.COM>
References: <1565798749-15672-1-git-send-email-mario.limonciello@dell.com>
 <20190814193132.GD3256@localhost.localdomain>
In-Reply-To: <20190814193132.GD3256@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-08-14T19:51:44.4791540Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140178
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>
> Sent: Wednesday, August 14, 2019 2:32 PM
> To: Limonciello, Mario
> Cc: Jens Axboe; Christoph Hellwig; Sagi Grimberg; linux-
> nvme@lists.infradead.org; LKML; Hong, Ryan; Wang, Crag; sjg@google.com;
> Hyde, Charles - Dell Team; Dominguez, Jared
> Subject: Re: [PATCH] nvme: Add quirk for LiteON CL1 devices running FW
> 22301111
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Wed, Aug 14, 2019 at 09:05:49AM -0700, Mario Limonciello wrote:
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 8f3fbe5..47c7754 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2251,6 +2251,29 @@ static const struct nvme_core_quirk_entry
> core_quirks[] =3D {
> >  		.vid =3D 0x1179,
> >  		.mn =3D "THNSF5256GPUK TOSHIBA",
> >  		.quirks =3D NVME_QUIRK_NO_APST,
> > +	},
> > +	/*
> > +	 * This LiteON CL1 firmware version has a race condition associated w=
ith
> > +	 * actions related to suspend to idle.  LiteON has resolved the probl=
em
> > +	 * in future firmware.
> > +	 */
> > +	{
> > +		.vid =3D 0x14a4,
> > +		.mn =3D "CL1-3D128-Q11 NVMe LITEON 128GB",
> > +		.fr =3D "22301111",
> > +		.quirks =3D NVME_QUIRK_SIMPLE_SUSPEND,
> > +	},
> > +	{
> > +		.vid =3D 0x14a4,
> > +		.mn =3D "CL1-3D256-Q11 NVMe LITEON 256GB",
> > +		.fr =3D "22301111",
> > +		.quirks =3D NVME_QUIRK_SIMPLE_SUSPEND,
> > +	},
> > +	{
> > +		.vid =3D 0x14a4,
> > +		.mn =3D "CL1-3D512-Q11 NVMe LITEON 512GB",
> > +		.fr =3D "22301111",
> > +		.quirks =3D NVME_QUIRK_SIMPLE_SUSPEND,
> >  	}
> >  };
>=20
> Are there models from this vendor with this same 'fr' that don't need
> this quirk? If not, you can leave .mn blank and just use a single entry.

Yes, I confirmed this firmware version string is only used on the CL1 famil=
y
of devices.

I will send a v2 modifying this.  I also noticed that the
(ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND)

is unnecessary in nvme_resume because ndev->last_ps is set to U32_MAX
in nvme_suspend, so I will remove that second modification.
