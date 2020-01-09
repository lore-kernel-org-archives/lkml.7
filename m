Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8EFC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FE020673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="pu7ZPFnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgAIJKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:10:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:26249 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbgAIJKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:10:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 01:10:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="218309625"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jan 2020 01:10:06 -0800
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 01:10:06 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 01:10:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 9 Jan 2020 01:10:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOE3+vLQD9YjWLukeaZHVTGqz1O73oCVS/9m4VLlVff3Rxb1v62EjL+rvf9hB5hpxKNPAUI3uMGCcdfUD5v9mBIUMvjuEeFo9oLrqs1OT3nJe0WEsj0J4TX2WOqD/s1qgeFh8I5kGV6sqbxID4fAsancHDe2ZxrpKvRhAbHED3GS+GWrtOimK5sGUjvGgX40zxPnKeYVpp3vkZllOnmvYAbE7XWcghxjj/uHY4brwE2P5vud+vNLClqz6oWyfE9AwfM48AxumwlEcZHYxcJalbHlu2kb6pmanC5CJyriPxv9KgIoeBwxD3Ya+AdRgNOzclxnWP8TQv1nohesLf9Ibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMYLDu1aayWtzGG52YnYC/SOz36wwAMfQ7Xioz6MAvg=;
 b=KumvwjZauHVmVGsjs6tm2yh8R29or7SYh7tTxYBydg+mMmfxhQZ/Tm2m/GMc80ebIxYZk+Xy1lVQ7GQpbbXpeDiLrFiPMI5q3aANVsFxbw4NPED0zNdOM4pcV7iz921q0AW5ZZGGMDxjGUYL8h4PDpBRJd7/D1KPRDM1F771B3reZbb+OlsejlREHs1uMvEsoQy2BtMHDaxq2i9Bf1RM5IwwbOohY0bKBnvwo/rIB+YQ+ER8mGa74vC6d0ni8kLaSAVnhRFERDZMRjjwKZKI+Wb/ZWniZiCuwwu25Z6Y3sctZt2XOoTDh82EKJlb+lkZtROWqY/HdEFCMKEqSKNe4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMYLDu1aayWtzGG52YnYC/SOz36wwAMfQ7Xioz6MAvg=;
 b=pu7ZPFnv+fRdQNvx9fkAm0t6xUyasOh7hXOE6pW9HQtsj+4zo0OVqyYJlOyXqoadOMppq8lgAtCmj/umamDmyvPE3B0WUfW0zuPbvl2Vl3oEtFoW89M7a3Qpd0NTBKpeC5blAykjQZzUP3wBtA6mwo5Tt9/cieA+TG3JyDOb/GE=
Received: from SN6PR11MB2750.namprd11.prod.outlook.com (52.135.89.148) by
 SN6PR11MB3182.namprd11.prod.outlook.com (52.135.110.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 09:10:05 +0000
Received: from SN6PR11MB2750.namprd11.prod.outlook.com
 ([fe80::f044:6625:17ff:3c83]) by SN6PR11MB2750.namprd11.prod.outlook.com
 ([fe80::f044:6625:17ff:3c83%3]) with mapi id 15.20.2602.017; Thu, 9 Jan 2020
 09:10:05 +0000
From:   "Loh, Tien Hock" <tien.hock.loh@intel.com>
To:     "Ooi, Joyce" <joyce.ooi@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Rob Herring" <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "See, Chin Liang" <chin.liang.see@intel.com>,
        "Tan, Ley Foon" <ley.foon.tan@intel.com>,
        Ooi <IMCEAINVALID-Ooi@namprd11.prod.outlook.com>
Subject: RE: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO
 maintainer
Thread-Topic: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO
 maintainer
Thread-Index: AQHVwley8VxKb1ZtM0q5x6Av+ymvqafiFDlQ
Date:   Thu, 9 Jan 2020 09:10:04 +0000
Message-ID: <SN6PR11MB27508E57D63DD660ACC8ABECBD390@SN6PR11MB2750.namprd11.prod.outlook.com>
References: <20200103170155.100743-1-joyce.ooi@intel.com>
In-Reply-To: <20200103170155.100743-1-joyce.ooi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjZmMjAzMTAtZWQ1My00OTdkLWJjYzMtN2YwNjE1YjlkMzQxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTTRDUDNKTndpNGY1NXhTZERVVSszRVwvdWEya3Z6ZVNPKzgxTllzYWJGbVR4V285Qk9zUm9QaXNOTDVhWE9KSXgifQ==
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tien.hock.loh@intel.com; 
x-originating-ip: [192.198.147.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab32329b-85fd-43fb-1068-08d794e3b74e
x-ms-traffictypediagnostic: SN6PR11MB3182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3182B27631249A7B13478C73BD390@SN6PR11MB3182.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:313;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(136003)(13464003)(199004)(189003)(2906002)(107886003)(55016002)(76116006)(9686003)(316002)(33656002)(8936002)(71200400001)(81166006)(54906003)(110136005)(8676002)(81156014)(66446008)(66556008)(7696005)(64756008)(66476007)(53546011)(6506007)(26005)(478600001)(86362001)(186003)(4326008)(5660300002)(52536014)(66946007)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB3182;H:SN6PR11MB2750.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZahcKgFJ4A0fJh/DuOB94ZgXY0I8v3px0I7xYJDizItTp/wbdmfzySp6LFtXxHqgifgiDURjJCYC3KzGTIl2cgFb7qNgrLTQolbfpmbZ+w0fBsMD0lSyE8NRQG/JTuAvkxsQEh/wYdTEyw6b/HzFvkZjFd9m4rBRnea6OqVcaI2DMGZQLiPppEdYF6rDia7a4cjTAnrhui/t+R7D3PqWnr9/bx6A4Kpg3e9QZQ7mUQKSmeqb3mrXCVZSY4fjeqYDvl4+NtflQGirh3aw7984QHjfVyQarZiQIyAk9WuSLXwZVFjwXqP95J8kD5HljsO3veTLpMJLo2bf70VwPysn+4Tm+/oQZ6PiydKMQvzzxe3A5DrdrEfdpSBNkEEn7ARnYd9LFAk2raXKk2GCc50O85kiOcu6qswG/rcVXGIyeuTUNw0ib6HSVG3g/7h9tE+gNPIcO5O6IARdoBHQTgFwbPVG+jVz26ipUWhdcKfYMF+KM8nub8K5rfU9hiKHpT+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ab32329b-85fd-43fb-1068-08d794e3b74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 09:10:04.9058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2zLtJlNuICnT7EmJBHUA3M6Ah5gYpGX1HnAQzReNrLPw+PHPA+JqNvC1cnDFQqOGcPGsHXR8pFN54fshnUFk6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3182
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ooi, Joyce <joyce.ooi@intel.com>
> Sent: Saturday, January 4, 2020 1:02 AM
> To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>; David S .
> Miller <davem@davemloft.net>; Rob Herring <robh@kernel.org>; Greg
> Kroah-Hartman <gregkh@linuxfoundation.org>; Jonathan Cameron
> <Jonathan.Cameron@huawei.com>
> Cc: linux-kernel@vger.kernel.org; Ooi, Joyce <joyce.ooi@intel.com>; Loh,
> Tien Hock <tien.hock.loh@intel.com>; See, Chin Liang
> <chin.liang.see@intel.com>; Tan, Ley Foon <ley.foon.tan@intel.com>; Ooi
> Subject: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO
> maintainer
>=20
> This patch is to replace Tien Hock Loh as Altera PIO maintainer as he has
> moved to a different role.
>=20

ACK. Thanks Joyce.=20

> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
> ---
>  MAINTAINERS |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a049abc..3401c4a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -726,7 +726,7 @@ S:	Maintained
>  F:	drivers/mailbox/mailbox-altera.c
>=20
>  ALTERA PIO DRIVER
> -M:	Tien Hock Loh <thloh@altera.com>
> +M:	Joyce Ooi <joyce.ooi@intel.com>
>  L:	linux-gpio@vger.kernel.org
>  S:	Maintained
>  F:	drivers/gpio/gpio-altera.c
> --
> 1.7.1

