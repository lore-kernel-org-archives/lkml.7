Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3BCC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 07:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847C520840
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 07:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NPy22j3H";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pXp53bRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfFWHpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 03:45:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59011 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfFWHpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 03:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561275957; x=1592811957;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RgevRYWrx/E1WrkkmT+SCP1L+/1NNy7ZKg/uf30S7MQ=;
  b=NPy22j3HMw4qiDqMl4kHizKQFtmjpWNPF13a3oqddaLwGOHpdWN8wOc2
   wUMhUctcmmIWmhJNz+C3snxJL7hztk0r1sOCH6odX1UScMIRmAnE9GOcm
   wUGTJ+VVojUdfZ4Lrgb3GZ3WguTHhcVSCKuQyP/7d94YQkCXASdWRLZer
   ZOeyIwD1jZrstzkWYRUNudWpAf+UNtTc5ROi1r50zf1urSZQMVzJGopoK
   /E86P+0tw0Vrn1CZj5IRr2qN5/EoYqyvkHhlDPlzhzAxdL8IeQXDqhUc3
   HWAxpQ2gY6qRp+iFXVxOtKoowGk77CWNumwkIQI/anTLM/nmUNo1erRTQ
   g==;
X-IronPort-AV: E=Sophos;i="5.63,407,1557158400"; 
   d="scan'208";a="211049314"
Received: from mail-sn1nam01lp2052.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.52])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2019 15:45:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1246p0f2f4ednuL+bHUfyz/hWs7kFqYXhyHRfIOC4Sw=;
 b=pXp53bRprooQa6sEIVDvI09io2gIUh9rrdWlq44888L5yzy2OE+Do7Qm9x8z/e/toxBLyn/Ymfrklle9cSQTpQw88myAozscOE60/+qTVkD+l6GIvp+PCW7TCCkznJ3pOZYy3njuJEx8064AMGUsHM7Xn2psw5tqLI6CDJbCbno=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB3789.namprd04.prod.outlook.com (52.135.81.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.16; Sun, 23 Jun 2019 07:45:48 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c5b2:c213:37f6:819a]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c5b2:c213:37f6:819a%7]) with mapi id 15.20.2008.014; Sun, 23 Jun 2019
 07:45:48 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Evan Green <evgreen@chromium.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH V1] scsi: ufs-bsg: complete ufs-bsg job only if no error
Thread-Topic: [PATCH V1] scsi: ufs-bsg: complete ufs-bsg job only if no error
Thread-Index: AdUpN0xws5PLgzbgS5mtBc6EeX8pxwAX/MsQ
Date:   Sun, 23 Jun 2019 07:45:48 +0000
Message-ID: <SN6PR04MB4925EDC53B49B2E5DDD9368DFCE10@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <BN7PR08MB5684DDCA5C96794DAD71A1F9DBE60@BN7PR08MB5684.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB5684DDCA5C96794DAD71A1F9DBE60@BN7PR08MB5684.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e8ace81-d54b-48ba-f0c8-08d6f7aecee8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB3789;
x-ms-traffictypediagnostic: SN6PR04MB3789:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB378939FD31596DA9239A804AFCE10@SN6PR04MB3789.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00770C4423
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(76176011)(446003)(102836004)(86362001)(54906003)(229853002)(110136005)(486006)(5660300002)(11346002)(81156014)(7736002)(6116002)(33656002)(74316002)(26005)(6506007)(186003)(3846002)(8936002)(305945005)(476003)(7696005)(99286004)(316002)(81166006)(71190400001)(478600001)(71200400001)(4326008)(8676002)(53936002)(2906002)(68736007)(73956011)(6246003)(9686003)(25786009)(66476007)(72206003)(66946007)(55016002)(64756008)(6436002)(66066001)(76116006)(66556008)(256004)(14444005)(52536014)(14454004)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3789;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: odFQu8/EW7vI5sxNB8YdJnelBwHXHB6IVeMnbs34+rwj/oKhFBQDNjL3oD3GlO/sdW7JcZEmBj4ZhgBFdvhoer9EnTzwNidhT/8EzURrW8m8baqTer8GnFy65Bqd2HChOP4ulZmJz8I36qDX6jKG2Ozd3UXW6O7EhfveYYiyyxbqn3dOzizioRBlo0/eQ2/BaLVZQMBGc5YC7Hn4x+1JgVMcVipPsytsPekyM6C/A/xFoLxHbSYJAS+bbrc9qpe5xzzA9OVlrAZlxJIWsfgosTFVq2hTUBZwBz+wIpOwFtYGOrckBYNBbA04mXk7s7YsQFFci2TeJw0QrCADaOratAqDF3u7TGP0ANXKoMk2uD9q0nuuG895/lUE7MWKTpUaoDoQ0AWewaOzTkgkBrtb5v5I4Rd4mYX5ZsLAYNn0JhQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8ace81-d54b-48ba-f0c8-08d6f7aecee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2019 07:45:48.5747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Avri.Altman@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3789
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bean,
Thank you for fixing this.

> From: Bean Huo <beanhuo@micron.com>
>=20
> In the case of UPIU/DME request execution failed in UFS device,
> ufs_bsg_request() will complete this failed bsg job by calling
> bsg_job_done(). Meanwhile, it returns this error status to blk-mq
> layer, then trigger blk-mq complete this request again, this will
> cause below panic.
>=20
> [   68.673050] Call trace:
> [   68.675491]  __ll_sc___cmpxchg_case_acq_32+0x4/0x20
> [   68.680369]  complete+0x28/0x70
> [   68.683510]  blk_end_sync_rq+0x24/0x30
> [   68.687255]  blk_mq_end_request+0xb8/0x118
> [   68.691350]  bsg_job_put+0x4c/0x58
> [   68.694747]  bsg_complete+0x20/0x30
> [   68.698231]  blk_done_softirq+0xb4/0xe8
> [   68.702066]  __do_softirq+0x154/0x3f0
> [   68.705726]  run_ksoftirqd+0x4c/0x68
> [   68.709298]  smpboot_thread_fn+0x22c/0x268
> [   68.713394]  kthread+0x130/0x138
> [   68.716619]  ret_from_fork+0x10/0x1c
> [   68.720193] Code: f84107fe d65f03c0 d503201f f9800011 (885ffc10)
> [   68.726298] ---[ end trace d92825bff6326e66 ]---
> [   68.730913] Kernel panic - not syncing: Fatal exception in interrupt
Please add a 'fixes:' tag

=20
> This patch is to fix this issue. The solution is we complete
> the ufs-bsg job only if no error happened.
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/scsi/ufs/ufs_bsg.c | 7 ++++---
>  drivers/scsi/ufs/ufshcd.c  | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
> index 869e71f..d5516dc 100644
> --- a/drivers/scsi/ufs/ufs_bsg.c
> +++ b/drivers/scsi/ufs/ufs_bsg.c
> @@ -122,7 +122,7 @@ static int ufs_bsg_request(struct bsg_job *job)
>  		memcpy(&uc, &bsg_request->upiu_req.uc, UIC_CMD_SIZE);
>  		ret =3D ufshcd_send_uic_cmd(hba, &uc);
>  		if (ret)
> -			dev_dbg(hba->dev,
> +			dev_err(hba->dev,
>  				"send uic cmd: error code %d\n", ret);
Please send a different patch fixing typos (also in ufshcd_uic_change_pwr_m=
ode)
>=20
>  		memcpy(&bsg_reply->upiu_rsp.uc, &uc, UIC_CMD_SIZE);
> @@ -143,13 +143,14 @@ static int ufs_bsg_request(struct bsg_job *job)
>  			sg_copy_from_buffer(job->request_payload.sg_list,
>  					    job->request_payload.sg_cnt,
>  					    desc_buff, desc_len);
> -
Keep this one line space please

>  	kfree(desc_buff);
>=20
>  out:
>  	bsg_reply->result =3D ret;
>  	job->reply_len =3D sizeof(struct ufs_bsg_reply);
> -	bsg_job_done(job, ret, bsg_reply->reply_payload_rcv_len);
> +	/* complete the job here only if no error */
> +	if (ret =3D=3D 0)
> +		bsg_job_done(job, ret, bsg_reply->reply_payload_rcv_len);
>=20
>  	return ret;
>  }
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 04d3686..4718041 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -3776,7 +3776,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba,
> struct uic_command *cmd)
>  }
>=20
>  /**
> - * ufshcd_uic_change_pwr_mode - Perform the UIC power mode chage
> + * ufshcd_uic_change_pwr_mode - Perform the UIC power mode change
Please send a different patch fixing typos

Thanks,
Avri

>   *				using DME_SET primitives.
>   * @hba: per adapter instance
>   * @mode: powr mode value
> --
> 2.7.4
