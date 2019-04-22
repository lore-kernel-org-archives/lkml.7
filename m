Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969D5C10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461E0206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="idbqoSt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfDWCDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 22:03:03 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:44018 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729592AbfDWCDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 22:03:03 -0400
X-Greylist: delayed 16397 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Apr 2019 22:03:02 EDT
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3MLKS9V032581;
        Mon, 22 Apr 2019 17:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=bOr2E7L0ppFrR7wIZ2fRNL6PXT8mDF3RzIfYIYvp/qk=;
 b=idbqoSt76g16kvi2uHNRP/NugNxDgorWVAphGamVsG4gqnGNElwCmwqKkraXReLjFlPO
 5FaT75NvK1nnP/629iTUU6k5ZuC14rzxTNWk/zAveh0XCeXX3nPU9Gwl8GKCdyh4lMZE
 UEik5by6mYhPZh3tap/IzZgscAHTjwXtWzqUifQw/W6cvcCMz8kToQbEH3cgOezPuqDD
 N26vMbaZNMSryxCfAj8Pm1aonvg+3+XxamBjCRopfax2FVN+TMQf2qyVD2kvAA+R1aES
 WoWP3xXC6RWDa3Kx81ugIIE/IrgYDBqIFHH6yd2lkaa53fIImjRsBY5NkuLTlRc66RUT cw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2ryxrg5nr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Apr 2019 17:29:45 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3MLHiT1083187;
        Mon, 22 Apr 2019 17:29:44 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 2s1kdusr71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Apr 2019 17:29:44 -0400
X-LoopCount0: from 10.166.137.67
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="345889032"
From:   <Mario.Limonciello@dell.com>
To:     <crag0715@gmail.com>, <linux-usb@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <hayeswang@realtek.com>,
        <Crag.Wang@dell.com>, <davem@davemloft.net>, <sjg@chromium.org>,
        <grundler@chromium.org>, <seanpaul@chromium.org>,
        <David.Chen7@Dell.com>, <kai.heng.feng@canonical.com>,
        <gustavo@embeddedor.com>,
        <charles.hyde@dell.corp-partner.google.com>,
        <bigeasy@linutronix.de>, <zhongjiang@huawei.com>
Subject: RE: [PATCH v2 1/1] r8152: sync sa_family with the media type of
 network device
Thread-Topic: [PATCH v2 1/1] r8152: sync sa_family with the media type of
 network device
Thread-Index: AQHU+MjgKSyFOMW2wUS7aSLiRqzwkqZIstlw
Date:   Mon, 22 Apr 2019 21:29:36 +0000
Message-ID: <e6c274bbd120446fb58ceb6ba9528b4b@ausx13mpc124.AMER.DELL.COM>
References: <20190422050344.24513-1-crag0715@gmail.com>
In-Reply-To: <20190422050344.24513-1-crag0715@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904220161
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904220161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: crag0715@gmail.com <crag0715@gmail.com>
> Sent: Monday, April 22, 2019 12:04 AM
> To: linux-usb@vger.kernel.org; netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; hayeswang@realtek.com; Limonciello, Mar=
io;
> crag0715@gmail.com; Wang, Crag; David S. Miller; Simon Glass; Grant Grund=
ler;
> Sean Paul; Chen7, David; Kai-Heng Feng; Gustavo A. R. Silva; Charles Hyde=
;
> Sebastian Andrzej Siewior; zhong jiang
> Subject: [PATCH v2 1/1] r8152: sync sa_family with the media type of netw=
ork
> device
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> From: "Crag.Wang" <crag.wang@dell.com>
>=20
> Without this patch the socket address family sporadically gets wrong
> value ends up the dev_set_mac_address() fails to set the desired MAC
> address.

Ah yes, this is because of an uninitialized struct sockaddr, so random garb=
age.
I didn't catch it during my testing, good catch.

>=20
> Signed-off-by: Crag.Wang <crag.wang@dell.com>
> ---
>  drivers/net/usb/r8152.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 4c63b40d5e00..41fb39ce69c9 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -1225,6 +1225,8 @@ static int determine_ethernet_addr(struct r8152 *tp=
,
> struct sockaddr *sa)
>  	struct net_device *dev =3D tp->netdev;
>  	int ret;
>=20
> +	sa->sa_family =3D dev->type;
> +
>  	if (tp->version =3D=3D RTL_VER_01) {
>  		ret =3D pla_ocp_read(tp, PLA_IDR, 8, sa->sa_data);
>  	} else {
> --
> 2.20.1

Reviewed-By: Mario Limonciello <mario.limonciello@dell.com>
