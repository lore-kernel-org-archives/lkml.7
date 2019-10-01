Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A8AC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C4F2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="K3GRbL+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbfJARFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:05:14 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:59990 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726080AbfJARFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:05:14 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91GsnHa006736;
        Tue, 1 Oct 2019 13:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=jUH94XgfeTwunSBeDtwCP+0mvxv0U2LwW/qIYlD6oHg=;
 b=K3GRbL+qwVeYmwujTbRcRUYnbV0elBmhXwTQoTOZzNFf/QwcTCCuEd6Evc+EbREDovUG
 aXp/QDFXxn6zIHGwHXpQNqdFGcW58LQpZZk4TIl3vHf/fBdAbJkLShroU6p25albtGcg
 pHBIgMpCXWik9d6leLBEF2wY7xGkNIEokl8Edp48KiV5goFHdb9BOuQL571H7Nn5ebto
 tDUybP+e6azwLZGCmOSIvV1Tk18nF3NQrxyXyy1B5ol27kbNKaYNTJtTfLjdiINb6bbX
 gt5KvDcZl9ZOVx0CH+pGmNaSOxdOvRGjACF7B6SRCduoV88h47bRWWTE7two9UwB+hgp /g== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2va2386tby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 13:05:11 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91GrSp2124289;
        Tue, 1 Oct 2019 13:05:11 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0b-00154901.pphosted.com with ESMTP id 2vby3cn6w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 13:05:11 -0400
X-LoopCount0: from 10.166.132.132
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="403855534"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>, <linux-usb@vger.kernel.org>
CC:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <YehezkelShB@gmail.com>, <rajmohan.mani@intel.com>,
        <nicholas.johnson-opensource@outlook.com.au>, <lukas@wunner.de>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <anthony.wong@canonical.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Thread-Topic: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Thread-Index: AQHVeEzShOhklesInk+gx9St4A7986dGAqig
Date:   Tue, 1 Oct 2019 17:05:09 +0000
Message-ID: <184c95fc476146939b240557e54ee2c9@AUSX13MPC105.AMER.DELL.COM>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com>
In-Reply-To: <20191001113830.13028-18-mika.westerberg@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-10-01T17:05:07.4414478Z;
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-01_08:2019-10-01,2019-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=733
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910010142
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=835 priorityscore=1501 mlxscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910010142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -322,9 +398,21 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
>  	u32 val;
>  	int ret;
>=20
> -	if (!sw->dma_port)
> +	if (!nvm_readable(sw))
>  		return 0;
>=20
> +	/*
> +	 * The NVM format of non-Intel hardware is not known so
> +	 * currently restrict NVM upgrade for Intel hardware. We may
> +	 * relax this in the future when we learn other NVM formats.
> +	 */
> +	if (sw->config.vendor_id !=3D PCI_VENDOR_ID_INTEL) {
> +		dev_info(&sw->dev,
> +			 "NVM format of vendor %#x is not known, disabling NVM
> upgrade\n",
> +			 sw->config.vendor_id);
> +		return 0;
> +	}
> +

Don't you actually have an attribute you can use here for this exact purpos=
e that you
could  be setting rather than returning immediately?
sw->no_nvm_upgrade

Then potentially you can at least let users "dump out" the nvm on !Intel bu=
t don't let
it be written until ready to relax further.

>  	nvm =3D kzalloc(sizeof(*nvm), GFP_KERNEL);
>  	if (!nvm)
>  		return -ENOMEM;

