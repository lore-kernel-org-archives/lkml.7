Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9216C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F95521848
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="BqXv8Z2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfIRQwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:52:35 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:11120 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbfIRQwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:52:35 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8IGjEIi018850
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=DebxrvDkPOPl5o9r3Q/QwerjDzRWkrn+XWpyhcIJBYc=;
 b=BqXv8Z2Cq7t5kzV/nONjsQh26/dZcecChCBSmM0JuPhy73KtwhZ/QHFXKq6haGZGpcsc
 rhcyCzIKInGsGVDScbXV8p8LLAPrRSnc4sm36g5mpNfQ7KTrH/865F4TZ1X+CX57q5FN
 /lu4T79rbXvaUpG1IyAWLah/q4d5Ni/W+hZgBmageqFlnhJpuGT/wbj0MwFsjtLgC1oj
 us9kct5xGk6jNVPsMHOpWbls3SBllT4WvcfuWFR+Uzs9HR0YQeFfaL4Gw5+LUg3NuTmV
 Ws21sNgtAMLsfvgM1k7kiqAuneDpSjNbXwfae1QVsEkzAzcOXyhbAdPFZddvue65Qjx4 vw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2v37swdc0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:52:33 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8ID2Go9193867
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:52:33 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2v23xxwrsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:52:33 -0400
X-LoopCount0: from 10.166.132.23
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="461996549"
From:   <Mario.Limonciello@dell.com>
To:     <rjw@rjwysocki.net>, <kbusch@kernel.org>
CC:     <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Ryan.Hong@Dell.com>, <Crag.Wang@dell.com>, <sjg@google.com>,
        <Jared.Dominguez@dell.com>
Subject: RE: [PATCH] nvme-pci: Save PCI state before putting drive into
 deepest state
Thread-Topic: [PATCH] nvme-pci: Save PCI state before putting drive into
 deepest state
Thread-Index: AQHVaPqcVa1BaYWKPkaPLLLTJYPQjqcwvl4AgAADOoCAAO8DAA==
Date:   Wed, 18 Sep 2019 16:52:31 +0000
Message-ID: <706f61c67b354f3d8f841a82e3d48541@AUSX13MPC105.AMER.DELL.COM>
References: <1568245353-13787-1-git-send-email-mario.limonciello@dell.com>
 <20190917212414.GB39848@C02WT3WMHTD6.wdl.wdc.com>
 <10773060.Xg13aEV830@kreacher>
In-Reply-To: <10773060.Xg13aEV830@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-09-18T16:52:29.8361315Z;
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_02:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909160054
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909180157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rafael J. Wysocki <rjw@rjwysocki.net>
> Sent: Tuesday, September 17, 2019 4:36 PM
> To: Keith Busch
> Cc: Limonciello, Mario; Jens Axboe; Christoph Hellwig; Sagi Grimberg; lin=
ux-
> nvme@lists.infradead.org; LKML; Hong, Ryan; Wang, Crag; sjg@google.com;
> Dominguez, Jared
> Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into d=
eepest
> state
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Tuesday, September 17, 2019 11:24:14 PM CEST Keith Busch wrote:
> > On Wed, Sep 11, 2019 at 06:42:33PM -0500, Mario Limonciello wrote:
> > > The action of saving the PCI state will cause numerous PCI configurat=
ion
> > > space reads which depending upon the vendor implementation may cause
> > > the drive to exit the deepest NVMe state.
> > >
> > > In these cases ASPM will typically resolve the PCIe link state and AP=
ST
> > > may resolve the NVMe power state.  However it has also been observed
> > > that this register access after quiesced will cause PC10 failure
> > > on some device combinations.
> > >
> > > To resolve this, move the PCI state saving to before SetFeatures has =
been
> > > called.  This has been proven to resolve the issue across a 5000 samp=
le
> > > test on previously failing disk/system combinations.
> > >
> > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > ---
> > >  drivers/nvme/host/pci.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > index 732d5b6..9b3fed4 100644
> > > --- a/drivers/nvme/host/pci.c
> > > +++ b/drivers/nvme/host/pci.c
> > > @@ -2894,6 +2894,13 @@ static int nvme_suspend(struct device *dev)
> > >  	if (ret < 0)
> > >  		goto unfreeze;
> > >
> > > +	/*
> > > +	 * A saved state prevents pci pm from generically controlling the
> > > +	 * device's power. If we're using protocol specific settings, we do=
n't
> > > +	 * want pci interfering.
> > > +	 */
> > > +	pci_save_state(pdev);
> > > +
> > >  	ret =3D nvme_set_power_state(ctrl, ctrl->npss);
> > >  	if (ret < 0)
> > >  		goto unfreeze;
> > > @@ -2908,12 +2915,6 @@ static int nvme_suspend(struct device *dev)
> > >  		ret =3D 0;
> > >  		goto unfreeze;
> > >  	}
> > > -	/*
> > > -	 * A saved state prevents pci pm from generically controlling the
> > > -	 * device's power. If we're using protocol specific settings, we do=
n't
> > > -	 * want pci interfering.
> > > -	 */
> > > -	pci_save_state(pdev);
> > >  unfreeze:
> > >  	nvme_unfreeze(ctrl);
> > >  	return ret;
> >
> > In the event that something else fails after the point you've saved
> > the state, we need to fallback to the behavior for when the driver
> > doesn't save the state, right?
>=20
> Depending on whether or not an error is going to be returned.
>=20
> When returning an error, it is not necessary to worry about the saved sta=
te,
> because that will cause the entire system-wide suspend to be aborted.

It looks like in this case an error would be returned.

>=20
> Otherwise it is sufficient to clear the state_saved flag of the PCI devic=
e
> before returning 0 to make the PCI layer take over.

