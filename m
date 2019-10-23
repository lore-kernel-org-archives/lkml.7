Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5D7CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E60620659
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UBT/snkj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="U8WKUUGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391592AbfJWUbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 16:31:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:48505 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388677AbfJWUbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571862683; x=1603398683;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aPAXY7R7qCV/cC40y/BXzosCyCrUOiSfTgiJW4B394M=;
  b=UBT/snkjz8C8L1br5mWv1koNqAql7mt2UgaKjV2C3Vv5axUGfYokooQx
   N8eZdg9HfCQ1UpJ1/LIcFT8Ga7r7JvWXciNnNLNkYqxdBKTkHcGcX8Mg5
   mE8vqDW6UnGsP/kSDLnXgwff6mX7oUqq/BHQYbe4rcRt8gERYX0UHP+5G
   i9NYKU0b3HjrXWeZtZdXG/Oic7t4QPOETJ9630+Dw5qI8sZuSRnulHgHB
   DznTuU0U/O1o2PIG9PwxZEwe7KbQzXcIxRxNW+sbLwkWCpl/aSvGdAcSW
   ULRa5HZYKfVfrUKXuqd/ka5sACC2y7AiT0e+tLV66fbE5bz+Z6l854nbG
   g==;
IronPort-SDR: Z4Aq/DODSAANbNrx0m80egQCjvWPLa+CFmZtc1FrShdZzgORDtIS27CAzeZnMnd/566KqO49J/
 k30U3heRjcA91DItXlMfiFQbmKnIVhgTZwhvEUKuP4pffD/yktNc+VnN5VmXpYjgmV0IPNxf6n
 jmEcp5i+xF7bD7JuAQa2+pYGXz6GKVg7/wqTOem3GyXhh0W69qqK8XmDXKSem2o3e0TQXlUdmF
 mBM+BCn4Ri5MNXO/HFF6D2UgnvB6Ugx+6+5nWMk3AB8+TtUaoDlFr8liPXuq5vrPcVV+/CLT7I
 ZHc=
X-IronPort-AV: E=Sophos;i="5.68,222,1569254400"; 
   d="scan'208";a="121199418"
Received: from mail-sn1nam01lp2053.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.53])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2019 04:31:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FF14ctGTkm1vwKwDA9aU3Rcrx7dDUCA3cOJtMUGC7Du78FTzRuSqW81eC/tfcytTbRi13i7KMEePkfoJ6pKP05QXEOBj8EiGqXKHjOFQ3aRv91+2P/emrTgvO9PZ7aofvUEb2DoyucBXXuEKdYjeeJ0K53lG+BoAJ9l2o7UvRd7zv+ragh4nWQcEQDZeRQ6pK42n05QKu9CgYzUFe9KIgYf/k+RWwRZMsJzKf7tvX+Otim7Var4dD52/Jm3Ic5sJSOByMSIfGEWsIFPq/vmPipsQaJyIfiisjsOQRxzEuWrGloaNncTt3p2/3eC3Sv5MEDYU/Men09W6VGJY1+gx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3CNpUbnYvkOxOeCovSulGix+C6qDGJBuPTHGkfUV+E=;
 b=IkyGj5jjQGE7kLqVGf4gb/8YSD5t/BfLuma/yffXBptdZIA129nWkmANJ62rhsk0jtPyJmWU3h8gvyQ3hk+RmkvW4S140PgvVffpdvzKb0txtB3iD/YCqsfh7O/xRDtYPqaLXWGuWLM7/B1JeLlslD2tdl+c02OlgSat32WvTsj70GmC+x+BCFENt4Naf5Ei+ooDDnw+NqjNDw8u0yHefxSvHe9+Fbx89scoDB0bzF3KzcpWTsJhtATeCgxoZYYqDFsOmEmiLwmRkn/thUnEDRSRKIUeoYZ7cC0TLP2DpKtTByza+R5MD4X/dmkX+InYkGIDTp1toyrjcEMgiVCMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3CNpUbnYvkOxOeCovSulGix+C6qDGJBuPTHGkfUV+E=;
 b=U8WKUUGd9HKUbwTS+fbEAgLE4XSkk991G/JWXedOcAYLR6RcEv24sGo5gbsJltayynSWjwhvUrejvV5jT4r3l3guw5jzZLJ03csGoocK/4D/TQt0n7Dlp+X9ZMTiiauZlETkB1KICiOiB0E0fxj8iwiKGZBqbzJD+/uU+UHM3DA=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4742.namprd04.prod.outlook.com (52.135.239.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 23 Oct 2019 20:31:19 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2387.021; Wed, 23 Oct 2019
 20:31:18 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH 3/7] nvmet: Introduce common execute function for
 get_log_page and identify
Thread-Topic: [PATCH 3/7] nvmet: Introduce common execute function for
 get_log_page and identify
Thread-Index: AQHVib/9UOiReJn9AkSMsa7C5dVEEw==
Date:   Wed, 23 Oct 2019 20:31:18 +0000
Message-ID: <BYAPR04MB57492DE452441E784E88DBAA866B0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191023163545.4193-1-logang@deltatee.com>
 <20191023163545.4193-4-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 740b0541-c65a-465c-4e3d-08d757f7f5d1
x-ms-traffictypediagnostic: BYAPR04MB4742:
x-microsoft-antispam-prvs: <BYAPR04MB474273BA853F3EC804BE4659866B0@BYAPR04MB4742.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(189003)(199004)(76116006)(64756008)(66946007)(66556008)(66446008)(6506007)(66476007)(7696005)(8936002)(26005)(53546011)(66066001)(76176011)(102836004)(55016002)(99286004)(256004)(229853002)(186003)(498600001)(14454004)(2201001)(86362001)(6246003)(110136005)(6436002)(81166006)(81156014)(52536014)(9686003)(305945005)(2906002)(2501003)(4326008)(5660300002)(3846002)(6116002)(8676002)(486006)(71200400001)(71190400001)(54906003)(74316002)(446003)(33656002)(25786009)(7736002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4742;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6IsOLCgamFDX3VduWf/HHySq8MeNkETcYXhcnys+wLBQZBDAldMKn6vJ58s22XNtSQ00EDc1MG1yQ6N5a04TYsxWqA7OsUrdCJdz3dX+JQQeAtL2nvyX8aFQaok60z5yVL8wR5YbQXalRDfEYU+SDC4PTEmo6r6qvJjuzAnOkzVqFQT3nevqREMC2wyQWASkNE/DMBiSiln+lQKJwgZtEmXEc5UE8U8tjhLS9rH4hf5etYylI84Ju5SEneB3y6lOLXVImqSOBfhd9BtnWLAZBdi5zEnIhABLmGoHUEU5ZIVsICsSlTK8ugb/FY2X1UoSR6diTSCh6xpgQDqBtpf6QgeBO9sl4MlG4m7FTeN31oGewA+BEP0mRoZVl5HEnwD+3bG6/BEJdbt40IzZYtt+VqXXzpK5yfWvrgCsCkYwifg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740b0541-c65a-465c-4e3d-08d757f7f5d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 20:31:18.7818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqQEWABrYBYXGrdLJVmL8tZjAhp8T5NngZfHYrWwjDFYWuavR3JpixUt0HWFf7byi8jkMc513/yGaNJozfBxcO+RKMzDday8fBQBkSeCAqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4742
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for this patch.=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 10/23/2019 09:36 AM, Logan Gunthorpe wrote:=0A=
> Instead of picking the sub-command handler to execute in a nested=0A=
> switch statement introduce a landing functions that calls out=0A=
> to the appropriate sub-command handler.=0A=
>=0A=
> This will allow us to have a common place in the handler to check=0A=
> the transfer length in a future patch.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> [logang@deltatee.com: separated out of a larger draft patch from hch]=0A=
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>=0A=
> ---=0A=
>   drivers/nvme/target/admin-cmd.c | 93 ++++++++++++++++++---------------=
=0A=
>   1 file changed, 50 insertions(+), 43 deletions(-)=0A=
>=0A=
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c=0A=
> index 831a062d27cb..3665b45d6515 100644=0A=
> --- a/drivers/nvme/target/admin-cmd.c=0A=
> +++ b/drivers/nvme/target/admin-cmd.c=0A=
> @@ -282,6 +282,33 @@ static void nvmet_execute_get_log_page_ana(struct nv=
met_req *req)=0A=
>   	nvmet_req_complete(req, status);=0A=
>   }=0A=
>=0A=
> +static void nvmet_execute_get_log_page(struct nvmet_req *req)=0A=
> +{=0A=
> +	switch (req->cmd->get_log_page.lid) {=0A=
> +	case NVME_LOG_ERROR:=0A=
> +		return nvmet_execute_get_log_page_error(req);=0A=
> +	case NVME_LOG_SMART:=0A=
> +		return nvmet_execute_get_log_page_smart(req);=0A=
> +	case NVME_LOG_FW_SLOT:=0A=
> +		/*=0A=
> +		 * We only support a single firmware slot which always is=0A=
> +		 * active, so we can zero out the whole firmware slot log and=0A=
> +		 * still claim to fully implement this mandatory log page.=0A=
> +		 */=0A=
> +		return nvmet_execute_get_log_page_noop(req);=0A=
> +	case NVME_LOG_CHANGED_NS:=0A=
> +		return nvmet_execute_get_log_changed_ns(req);=0A=
> +	case NVME_LOG_CMD_EFFECTS:=0A=
> +		return nvmet_execute_get_log_cmd_effects_ns(req);=0A=
> +	case NVME_LOG_ANA:=0A=
> +		return nvmet_execute_get_log_page_ana(req);=0A=
> +	}=0A=
> +	pr_err("unhandled lid %d on qid %d\n",=0A=
> +	       req->cmd->get_log_page.lid, req->sq->qid);=0A=
> +	req->error_loc =3D offsetof(struct nvme_get_log_page_command, lid);=0A=
> +	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);=0A=
> +}=0A=
> +=0A=
>   static void nvmet_execute_identify_ctrl(struct nvmet_req *req)=0A=
>   {=0A=
>   	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;=0A=
> @@ -565,6 +592,25 @@ static void nvmet_execute_identify_desclist(struct n=
vmet_req *req)=0A=
>   	nvmet_req_complete(req, status);=0A=
>   }=0A=
>=0A=
> +static void nvmet_execute_identify(struct nvmet_req *req)=0A=
> +{=0A=
> +	switch (req->cmd->identify.cns) {=0A=
> +	case NVME_ID_CNS_NS:=0A=
> +		return nvmet_execute_identify_ns(req);=0A=
> +	case NVME_ID_CNS_CTRL:=0A=
> +		return nvmet_execute_identify_ctrl(req);=0A=
> +	case NVME_ID_CNS_NS_ACTIVE_LIST:=0A=
> +		return nvmet_execute_identify_nslist(req);=0A=
> +	case NVME_ID_CNS_NS_DESC_LIST:=0A=
> +		return nvmet_execute_identify_desclist(req);=0A=
> +	}=0A=
> +=0A=
> +	pr_err("unhandled identify cns %d on qid %d\n",=0A=
> +	       req->cmd->identify.cns, req->sq->qid);=0A=
> +	req->error_loc =3D offsetof(struct nvme_identify, cns);=0A=
> +	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);=0A=
> +}=0A=
> +=0A=
>   /*=0A=
>    * A "minimum viable" abort implementation: the command is mandatory in=
 the=0A=
>    * spec, but we are not required to do any useful work.  We couldn't re=
ally=0A=
> @@ -819,52 +865,13 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)=0A=
>=0A=
>   	switch (cmd->common.opcode) {=0A=
>   	case nvme_admin_get_log_page:=0A=
> +		req->execute =3D nvmet_execute_get_log_page;=0A=
>   		req->data_len =3D nvmet_get_log_page_len(cmd);=0A=
> -=0A=
> -		switch (cmd->get_log_page.lid) {=0A=
> -		case NVME_LOG_ERROR:=0A=
> -			req->execute =3D nvmet_execute_get_log_page_error;=0A=
> -			return 0;=0A=
> -		case NVME_LOG_SMART:=0A=
> -			req->execute =3D nvmet_execute_get_log_page_smart;=0A=
> -			return 0;=0A=
> -		case NVME_LOG_FW_SLOT:=0A=
> -			/*=0A=
> -			 * We only support a single firmware slot which always=0A=
> -			 * is active, so we can zero out the whole firmware slot=0A=
> -			 * log and still claim to fully implement this mandatory=0A=
> -			 * log page.=0A=
> -			 */=0A=
> -			req->execute =3D nvmet_execute_get_log_page_noop;=0A=
> -			return 0;=0A=
> -		case NVME_LOG_CHANGED_NS:=0A=
> -			req->execute =3D nvmet_execute_get_log_changed_ns;=0A=
> -			return 0;=0A=
> -		case NVME_LOG_CMD_EFFECTS:=0A=
> -			req->execute =3D nvmet_execute_get_log_cmd_effects_ns;=0A=
> -			return 0;=0A=
> -		case NVME_LOG_ANA:=0A=
> -			req->execute =3D nvmet_execute_get_log_page_ana;=0A=
> -			return 0;=0A=
> -		}=0A=
> -		break;=0A=
> +		return 0;=0A=
>   	case nvme_admin_identify:=0A=
> +		req->execute =3D nvmet_execute_identify;=0A=
>   		req->data_len =3D NVME_IDENTIFY_DATA_SIZE;=0A=
> -		switch (cmd->identify.cns) {=0A=
> -		case NVME_ID_CNS_NS:=0A=
> -			req->execute =3D nvmet_execute_identify_ns;=0A=
> -			return 0;=0A=
> -		case NVME_ID_CNS_CTRL:=0A=
> -			req->execute =3D nvmet_execute_identify_ctrl;=0A=
> -			return 0;=0A=
> -		case NVME_ID_CNS_NS_ACTIVE_LIST:=0A=
> -			req->execute =3D nvmet_execute_identify_nslist;=0A=
> -			return 0;=0A=
> -		case NVME_ID_CNS_NS_DESC_LIST:=0A=
> -			req->execute =3D nvmet_execute_identify_desclist;=0A=
> -			return 0;=0A=
> -		}=0A=
> -		break;=0A=
> +		return 0;=0A=
>   	case nvme_admin_abort_cmd:=0A=
>   		req->execute =3D nvmet_execute_abort;=0A=
>   		req->data_len =3D 0;=0A=
>=0A=
=0A=
