Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F36CC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C382922296
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G2Y0hmDO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UeSeDNWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfGVHkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:40:09 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25851 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfGVHkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563781209; x=1595317209;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TtbWVk7sdTrBXpRjVybgYAIMDUOw/CZFPeHi3KLp0tQ=;
  b=G2Y0hmDOO19q1GqHhtgUnjOTXfp54YcUOOzipyS1myfUlys52hD0bQmS
   nyxu0nGtD5SsrPLOjOh1JgiseTtv0xqaoIXfXLgA8kdFbCKgRzw2ztffP
   QFnsAvAoceQE9y/LutS73l5RqJCIi2QhZrnYLd3iL5TZl7pJINYv/d2UT
   9SEkwa9Bw6/tN7GtB1aokeIB+LLRaMFzlrelR88CwwaCtYKcT4l0qBmqW
   +rhc330LJ++3tm964GsCo3sq4A8QU5clkrq3bqHlAhMDxXYne7CI2PC7m
   X+QRL+TSvHIaYzQfKjdgkTdcGutGgVoJWzwLd258BS5XHrWM32YPfX4xz
   A==;
IronPort-SDR: UrjPdX75le4VmdvVBoQ7x+bFjPxybjMf329cYVJ7DdlgTjJQUIIurxIr7RDZfo3MN6oMcP1Psl
 O9Ml2KDjRvhSdZ42wA4C8eO6MxxDq/9wK377u/+IYIR5ra2bK+MmDT1XgJHjOLvZ1d/7PiYCCZ
 V6wVZFznwBXnWnWp5NFsgPOlUa1A6UU1evWy2OAQ/SskVMK2gPLt7jzUG3bY2gS1dVFLRLv4AY
 uhtvv4IrC1UULAB/B2Of4bZn8WIF6dR1dx9VFss0KQM35YIevZzk1yauk03adWljsG2qy0CgXM
 Tws=
X-IronPort-AV: E=Sophos;i="5.64,294,1559491200"; 
   d="scan'208";a="118406829"
Received: from mail-dm3nam03lp2055.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.55])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2019 15:40:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzUn+dayv4WW4FpdBZVxFi9QCd+tlOUsTFi4OxkaijBr3dxM2Dya+vQnaiwvKfpw9nQQytIENotNpxalINOABcuue4ACKNKOTN/8k0VpYCQtLtWIC+QxQkoSUbRhSOM+K0ISDmAJW/ttEAvGrrkU3Pq7uLFQ94QVVkmGUwmliBRBqqBXBs6AGZ9t8uq9i+n1a11wFabkk6Kdvp8T1IyvsF4czpa19KT3WrPclgov7MsvH9ahCd0Ham/pfG+S+mfAcvD/tU+9zM/bvD89paujptl9xZJND27ureBR5OBj90TFf4ctraE2qogHn7i83Ey14dT2jRbwJ+tyvXMXbyAC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5iC0hTZet+bcRxz0v5Y8gE+MTZyPkFoYcGyUqcl4d8=;
 b=lJJVHtO5HG986u0czawy1UweSeOKTC2+pvCMtp8/S3Y7G1juCAmy0URU64BUgdeBnJ82o9rtog5IPN92ZXhDmJssNLhkiZo/4kjNb87h0Q8hKIKVLVxZ1L5zT52FDjEYG1fgeCaDf+phMvhFPG1yWUfwVaRi1WNYdM/7SrH+uRyIG58gHlmQFtYqwnKLc3rY8xpfSWbh6uGhAXHGpce1NTVE29FuU4mc4TsYb+BLwYfyRZnf7jUGkTLd1doxqlfMvTeAWbYXD/flJ/DOkgtV1WHNaFmFMe1oJOg+MF0sCyH4SlzULaSh3iH8eRLW4ldDVgY5rDNj1sNeO6HmbpLE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5iC0hTZet+bcRxz0v5Y8gE+MTZyPkFoYcGyUqcl4d8=;
 b=UeSeDNWz40qGHz/Hz6ezhvsLYcLoKELe/SRoulNJi2S+eDp8lPCUJ5+PTEBrQWxBjKWmG4kosn5FDhXHgceacPE6um0tQuRV0zXoNe9AAWT8RV/oHydtmg8YDvzq6QqUsXof6EXlPmz8URgSauXoXtBhwplVPn4jRDev5bF4JdQ=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4111.namprd04.prod.outlook.com (52.135.82.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 07:40:06 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::a102:1701:9c05:96b3]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::a102:1701:9c05:96b3%5]) with mapi id 15.20.2094.011; Mon, 22 Jul 2019
 07:40:06 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
CC:     Alex Lemberg <Alex.Lemberg@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND] scsi: ufs: revamp string descriptor reading
Thread-Topic: [PATCH RESEND] scsi: ufs: revamp string descriptor reading
Thread-Index: AQHVP86OATkNgP8VI0yd2doF2aPW86bWNd9Q
Date:   Mon, 22 Jul 2019 07:40:06 +0000
Message-ID: <SN6PR04MB4925FFBFEC979062E07DC6B8FCC40@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20190721140212.8980-1-tomas.winkler@intel.com>
In-Reply-To: <20190721140212.8980-1-tomas.winkler@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dc93cde-7c89-4ba2-0c7b-08d70e77d0d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4111;
x-ms-traffictypediagnostic: SN6PR04MB4111:
x-microsoft-antispam-prvs: <SN6PR04MB4111D8A8277C26AE481C1E98FCC40@SN6PR04MB4111.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(199004)(189003)(6436002)(476003)(11346002)(86362001)(66066001)(14454004)(8936002)(52536014)(66446008)(64756008)(66556008)(66476007)(2906002)(76116006)(66946007)(3846002)(110136005)(6116002)(68736007)(54906003)(81156014)(81166006)(5660300002)(486006)(316002)(256004)(53936002)(74316002)(25786009)(99286004)(7696005)(8676002)(71190400001)(71200400001)(33656002)(186003)(6506007)(102836004)(7736002)(305945005)(76176011)(55016002)(446003)(9686003)(4326008)(229853002)(26005)(6246003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4111;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uwumVZHO5D7CrKAU824x3Wvnx9xJwTceM/+tjwLsVJUlvzD95VsmXPK2ALppTrcAPTNdrVO1vuyaVKy7sGsR2cnjyYx1aQSBe4g19uUGLuGipnNZGi6Hnf7Q0GSjO6XJsP6AGHpDx9a1diPRDxQOKaX+Ux8X7l7xheKnmGM6iC88925PjvIAOt2bPLsmJuZcyhWtx7rSAhkr6Gl0iX6Hgt2nHDtlc/9EWYsYu4Vj75zJqi5CHHy/6XWYcJJmnSYBxgfHfw3TkiaUY+uuUOrj883M2A1Pd+1fNlvJROjJuakEuBXFy7ZdVexyfFUVQTXSIcSdEi36063dT6AZ2mnK7QuwP6SzE0KvzwsNMDd/kb4o4ATvIhfxKeP9K5ZbN4EJrgzdOUTDi/E2jAPJN2uPmtrv5TW2ZFI4y3ly3UiCD18=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc93cde-7c89-4ba2-0c7b-08d70e77d0d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 07:40:06.2242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Avri.Altman@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

>=20
> Define new a type: uc_string_id for easier string
> handling and less casting. Reduce number or string
> copies in price of a dynamic allocation.
>=20
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Tested-by: Avri Altman <avri.altman@wdc.com>
> ---
>=20
> Resend: It was reviewed by not merged.
>=20
>  drivers/scsi/ufs/ufs-sysfs.c |  20 ++---
>  drivers/scsi/ufs/ufs.h       |   2 +-
>  drivers/scsi/ufs/ufshcd.c    | 164 +++++++++++++++++++++--------------
>  drivers/scsi/ufs/ufshcd.h    |   9 +-
>  4 files changed, 115 insertions(+), 80 deletions(-)
>=20
> diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
> index f478685122ff..13e357f01025 100644
> --- a/drivers/scsi/ufs/ufs-sysfs.c
> +++ b/drivers/scsi/ufs/ufs-sysfs.c
> @@ -570,10 +570,11 @@ static ssize_t _name##_show(struct device *dev,
> 				\
>  	struct ufs_hba *hba =3D dev_get_drvdata(dev);			\
>  	int ret;							\
>  	int desc_len =3D QUERY_DESC_MAX_SIZE;				\
> -	u8 *desc_buf;							\
> +	char *desc_buf;							\
> +									\
Leaving it a u8 * here, will assure it would be utf-8,
And save you making param_read_buf opaque,
in ufshcd_read_desc  and ufshcd_read_desc_param.
A fare tradeoff, don't you think?


> diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
> index 99a9c4d16f6b..b3e1b2a0f463 100644
> --- a/drivers/scsi/ufs/ufs.h
> +++ b/drivers/scsi/ufs/ufs.h
> @@ -541,7 +541,7 @@ struct ufs_dev_info {
>   */
>  struct ufs_dev_desc {
>  	u16 wmanufacturerid;
> -	char model[MAX_MODEL_LEN + 1];
> +	char *model;
>  };
Belongs to a different patch?

>  /**
>   * ufshcd_read_string_desc - read string descriptor
>   * @hba: pointer to adapter instance
>   * @desc_index: descriptor index
> - * @buf: pointer to buffer where descriptor would be read
> - * @size: size of buf
> + * @buf: pointer to buffer where descriptor would be read,
> + *       the caller should free the memory.
>   * @ascii: if true convert from unicode to ascii characters
> + *         null terminated string.
Since ascii is always true, maybe omit this argument altogether,
and group the if (asci) clause in some handler?

>  /**
> @@ -6452,6 +6478,9 @@ static int ufs_get_device_desc(struct ufs_hba
> *hba,
>  	u8 model_index;
>  	u8 *desc_buf;
>=20
> +	if (!dev_desc)
> +		return -EINVAL;
> +
A different patch?

>=20
> +static void ufs_put_device_desc(struct ufs_dev_desc *dev_desc)
> +{
> +	kfree(dev_desc->model);
> +	dev_desc->model =3D NULL;
> +}
A different patch?

While it's true that dev_desc->model conclude its part after ufs_fixup_devi=
ce_setup,
Why are you releasing specifically this part of card?


>=20
>  	ufs_fixup_device_setup(hba, &card);
> +	ufs_put_device_desc(&card);
A different patch?

> +
>  	ufshcd_tune_unipro_params(hba);
>=20
>  	/* UFS device is also active now */
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 994d73d03207..10935548d1fc 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -885,14 +885,17 @@ int ufshcd_read_desc_param(struct ufs_hba
> *hba,
>  			   enum desc_idn desc_id,
>  			   int desc_index,
>  			   u8 param_offset,
> -			   u8 *param_read_buf,
> +			   void *param_read_buf,
>  			   u8 param_size);
>  int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
>  		      enum attr_idn idn, u8 index, u8 selector, u32
> *attr_val);
>  int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
>  	enum flag_idn idn, bool *flag_res);
> -int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
> -			    u8 *buf, u32 size, bool ascii);
> +
> +#define SD_ASCII_STD true
> +#define SD_RAW false
Not really needed?

Thanks,
Avri

