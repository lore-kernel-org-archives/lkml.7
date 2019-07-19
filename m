Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB87C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C14F2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VwtXSWCJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="joyjXpPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfGSEn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:43:58 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:39261 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfGSEn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563511437; x=1595047437;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gjbty5vD9rM8SOzuvMO6ltoSI6pEnL0paS9hWo1vpgw=;
  b=VwtXSWCJICCHYbXv6cEHG+hZ+GtQGwXf8a3FTkCWAkSTqrw2CnypiUis
   WYWPqtzt9utYDKOARDbwi7BgEx+LDoZ/xMfee3on5WxEpVWiJVKcGtgh3
   MqJ3m/1D82kQSwkXZ3JgszJxb3QoKJQPVbOJPiYjBhkbdUBD48S1KIWWp
   jfDC0OSI7984HHa4qPS0pnxm2jajkFyfwqKCmdbhisuWmJKxFPps/qUKp
   ADx99cjq9Kgg/IrD5a1HiLkTM1QVaOaDybXe87WJHR12RnmQck5JXzvwu
   f6c0U75llVa6fR1r+XEanYRgJswFf3F/Jl4d6L2N5sW1lXYbJnAZ6RphU
   w==;
IronPort-SDR: QrmPgR/YL6tqPWoTCClcHRFWWNHqx/Zm2Wr0182Vgnv5otZRucskbffji05OQMdc3UVffsmUBm
 3RzFUFlpfO1gd6zNhD2b6q/QzZYArZO8MavTuvMtBFYBB+6b6+7rGGY/bXAPArS7ny/w7oUNsn
 mz+k8ZrYSjPntMSUfIum5EPL78kvjSsklxjOm8ItyWqn4LWchBD7oaIlVQ5xqSLdF01+AyhKwz
 Csd/NbQfTSpNl4Nh4FwbUNJCd333IpKQfn154rKrU7I88HntptFKVlL3uOBHnxOnCuJmufP/62
 9YQ=
X-IronPort-AV: E=Sophos;i="5.64,280,1559491200"; 
   d="scan'208";a="115065731"
Received: from mail-co1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.53])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2019 12:43:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eypB9UUhPtCB49pukUaJKwLLra0xZVjqXTTJ9MTeVFmlAQ3ANjWXDqjwrfNHwSS5W8thBsLoGmO+Oe+G+cy9fJsKoXUlgWQaWBH4SlvyZNc6aTTSHLsDfRS8hYwJaOpywzGXhkSlWcc8a7F2vxMJ5/GaW7AJWyPHuT7Op2Z+HT8M74PHyB4myPVV3dJ70ADGhqJe+hkCSGjndA3q+RjLtdHQQGySgc12iP6bpuKUBuBaNkXdPLpcCTzNGHh8FSlTAGxJsF5wPmoWFR91tulQGMTNIIfSLjfEotW02EMEny9GDmbccRYVoHYKL3dFg/IDSJw1vVyoQTuCROOGpSWyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6SUP+IhPh2QkKoDU/Tag7ESMJhFWaw/To9vx+e8iBo=;
 b=NbrjN1IYwvwsSOQnUZM1OvTL0+BijOjagdb9dc2iTF/2EbvtIR4TRpLZPbeAUCcrddluAA8KjlWlq4ShKj1DPMF1s6ccheVGbWUiAt4y9kAkWbvtf1fnKlMcbfFz2wV81ggFAKe7trb80qpn7PvhWqP5CEfOE2DH+A2/0hZWSgyJa/BppIOht4vFn0r74Re+gNKB6o7dJLGDUC157P6IB13sr03Hfy7GKjy8AaqTAz6fnq71Z7r6gs1mjqTi2r9md2HP83QszlDHGwnd0AkbluWzWSQUbFroJvsHwDNWJEtYLFaE8ZTPKq6pajnAbZI/6IUPURYbMxuSZQB1atar2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6SUP+IhPh2QkKoDU/Tag7ESMJhFWaw/To9vx+e8iBo=;
 b=joyjXpPTMZ6rCwfQKv9BYLJylLAMD6fOuzKHV1XBW2cMAs4/Y8TKVU3qv+9byOPYb5SDs3U8tS5uHdeaWDzPUmpaPl+VfkOK7n49VzjHBGIQS8cr8dszudUgTh3fQGWS2NZRVTF2OD+38nEFQFsA9fnkK8fVelXauacmu7XWJFM=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5109.namprd04.prod.outlook.com (52.135.235.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Fri, 19 Jul 2019 04:43:55 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 04:43:55 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Pawlowski <paul@mrarm.io>, Jens Axboe <axboe@fb.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
Thread-Topic: [PATCH v2] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
Thread-Index: AQHVPeud+CKl01N5fESdJwM9xjcYQQ==
Date:   Fri, 19 Jul 2019 04:43:54 +0000
Message-ID: <BYAPR04MB58168C42A68712287F734242E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <f19ac710b4dc28fb3b59ef11bd06d341bc939f3d.camel@kernel.crashing.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 043c1f5b-f90d-4877-09a8-08d70c03b49b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5109;
x-ms-traffictypediagnostic: BYAPR04MB5109:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB5109E8BE6B65A203F5E17456E7CB0@BYAPR04MB5109.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(47660400002)(189003)(199004)(66556008)(66446008)(76116006)(64756008)(74316002)(91956017)(66476007)(99286004)(478600001)(86362001)(25786009)(316002)(66946007)(81166006)(229853002)(71200400001)(54906003)(33656002)(68736007)(486006)(7736002)(3846002)(6436002)(2501003)(55016002)(6246003)(53546011)(110136005)(76176011)(71190400001)(7696005)(186003)(53936002)(6306002)(9686003)(81156014)(256004)(476003)(14444005)(14454004)(2906002)(5660300002)(52536014)(4326008)(102836004)(8936002)(6506007)(66066001)(6116002)(26005)(966005)(305945005)(8676002)(446003)(46800400005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5109;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uCfaqw9BDNky7oSsW2pouU0Xt54QAevraPmm08Qlwr7kIpS//ocLTWmi+nqr3pnIOYWFQI6Y5jBoRlpBtWJydT5Q/6UbSdshFkNipt7shjW3iFTSCBoYpg7nA4hk6R+76xXFsntlGBvq8NMJoIsUmd4SZl/v416yv7euIkHyhLzi0y9cPpGTwEaeIRhKtMfJLsbdnpWjNvGPKAHB2WTVgle7QoSU3g+fI3FhUfvGAf7GJlpISSiTsJj1238ui5HusA/MExccognqu5j0EAb4T1gB46dxbEG11AXC3pewbZiZe3FVtmneY3ZhSb7cyWJHgvX9F1LaCecI3kv9zj7LSg9Cr6jcrkBzYgej+W88VgpBjFYGKcajBwuFCCs8pQeBgb/H/C187p/KF14FcwFNQvO2fBqaqHEo6tan8dOTbak=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043c1f5b-f90d-4877-09a8-08d70c03b49b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 04:43:54.9579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/07/19 13:37, Benjamin Herrenschmidt wrote:=0A=
> Another issue with the Apple T2 based 2018 controllers seem to be=0A=
> that they blow up (and shut the machine down) if there's a tag=0A=
> collision between the IO queue and the Admin queue.=0A=
> =0A=
> My suspicion is that they use our tags for their internal tracking=0A=
> and don't mix them with the queue id. They also seem to not like=0A=
> when tags go beyond the IO queue depth, ie 128 tags.=0A=
> =0A=
> This adds a quirk that offsets all the tags in the IO queue by 32=0A=
> to avoid those collisions. It also limits the number of IO queues=0A=
> to 1 since the code wouldn't otherwise make sense (the device=0A=
> supports only one queue anyway but better safe than sorry) and=0A=
> reduces the size of the IO queue=0A=
=0A=
What about keeping the IO queue QD at 128, but marking the first 32 tags as=
=0A=
"allocated" when the device is initialized ? This way, these tags numbers a=
re=0A=
never used for regular IOs and you can avoid the entire tag +/- offset danc=
e at=0A=
runtime. The admin queue uses tags 0-31 and the IO queue uses tags 32-127. =
No ?=0A=
=0A=
> =0A=
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>=0A=
> ---=0A=
> =0A=
> Note: One thing I noticed is how we have nvme_completion as volatile.=0A=
> =0A=
> I don't think we really need that, it's forcing the compiler to constantl=
y=0A=
> reload things which makes no sense once we have established that an=0A=
> entry is valid.=0A=
> =0A=
> And since we have a data & control dependency from nvme_cqe_pending(),=0A=
> we know that reading the CQE is going to depend on it being valid. I=0A=
> don't really see what volatile is buying us here other than cargo culting=
.=0A=
> =0A=
> Cheers,=0A=
> Ben.=0A=
> =0A=
>  drivers/nvme/host/nvme.h |  5 ++++=0A=
>  drivers/nvme/host/pci.c  | 52 +++++++++++++++++++++++++++++++++-------=
=0A=
>  2 files changed, 49 insertions(+), 8 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h=0A=
> index ced0e0a7e039..7c6de398de7d 100644=0A=
> --- a/drivers/nvme/host/nvme.h=0A=
> +++ b/drivers/nvme/host/nvme.h=0A=
> @@ -102,6 +102,11 @@ enum nvme_quirks {=0A=
>  	 * Use non-standard 128 bytes SQEs.=0A=
>  	 */=0A=
>  	NVME_QUIRK_128_BYTES_SQES		=3D (1 << 11),=0A=
> +=0A=
> +	/*=0A=
> +	 * Prevent tag overlap between queues=0A=
> +	 */=0A=
> +	NVME_QUIRK_SHARED_TAGS			=3D (1 << 12),=0A=
>  };=0A=
>  =0A=
>  /*=0A=
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
> index 7088971d4c42..c38e946ad8ca 100644=0A=
> --- a/drivers/nvme/host/pci.c=0A=
> +++ b/drivers/nvme/host/pci.c=0A=
> @@ -178,6 +178,7 @@ struct nvme_queue {=0A=
>  	u16 cq_head;=0A=
>  	u16 last_cq_head;=0A=
>  	u16 qid;=0A=
> +	u16 tag_offset;=0A=
>  	u8 cq_phase;=0A=
>  	u8 sqes;=0A=
>  	unsigned long flags;=0A=
> @@ -490,6 +491,7 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq,=
 struct nvme_command *cmd,=0A=
>  			    bool write_sq)=0A=
>  {=0A=
>  	spin_lock(&nvmeq->sq_lock);=0A=
> +	cmd->common.command_id +=3D nvmeq->tag_offset;=0A=
>  	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),=0A=
>  	       cmd, sizeof(*cmd));=0A=
>  	if (++nvmeq->sq_tail =3D=3D nvmeq->q_depth)=0A=
> @@ -951,9 +953,10 @@ static inline void nvme_ring_cq_doorbell(struct nvme=
_queue *nvmeq)=0A=
>  static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)=0A=
>  {=0A=
>  	volatile struct nvme_completion *cqe =3D &nvmeq->cqes[idx];=0A=
> +	u16 ctag =3D cqe->command_id - nvmeq->tag_offset;=0A=
>  	struct request *req;=0A=
>  =0A=
> -	if (unlikely(cqe->command_id >=3D nvmeq->q_depth)) {=0A=
> +	if (unlikely(ctag >=3D nvmeq->q_depth)) {=0A=
>  		dev_warn(nvmeq->dev->ctrl.device,=0A=
>  			"invalid id %d completed on queue %d\n",=0A=
>  			cqe->command_id, le16_to_cpu(cqe->sq_id));=0A=
> @@ -966,14 +969,13 @@ static inline void nvme_handle_cqe(struct nvme_queu=
e *nvmeq, u16 idx)=0A=
>  	 * aborts.  We don't even bother to allocate a struct request=0A=
>  	 * for them but rather special case them here.=0A=
>  	 */=0A=
> -	if (unlikely(nvmeq->qid =3D=3D 0 &&=0A=
> -			cqe->command_id >=3D NVME_AQ_BLK_MQ_DEPTH)) {=0A=
> +	if (unlikely(nvmeq->qid =3D=3D 0 && ctag >=3D NVME_AQ_BLK_MQ_DEPTH)) {=
=0A=
>  		nvme_complete_async_event(&nvmeq->dev->ctrl,=0A=
>  				cqe->status, &cqe->result);=0A=
>  		return;=0A=
>  	}=0A=
>  =0A=
> -	req =3D blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);=0A=
> +	req =3D blk_mq_tag_to_rq(*nvmeq->tags, ctag);=0A=
>  	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);=0A=
>  	nvme_end_request(req, cqe->status, cqe->result);=0A=
>  }=0A=
> @@ -1004,7 +1006,10 @@ static inline int nvme_process_cq(struct nvme_queu=
e *nvmeq, u16 *start,=0A=
>  =0A=
>  	*start =3D nvmeq->cq_head;=0A=
>  	while (nvme_cqe_pending(nvmeq)) {=0A=
> -		if (tag =3D=3D -1U || nvmeq->cqes[nvmeq->cq_head].command_id =3D=3D ta=
g)=0A=
> +		u16 ctag =3D nvmeq->cqes[nvmeq->cq_head].command_id;=0A=
> +=0A=
> +		ctag -=3D nvmeq->tag_offset;=0A=
> +		if (tag =3D=3D -1U || ctag =3D=3D tag)=0A=
>  			found++;=0A=
>  		nvme_update_cq_head(nvmeq);=0A=
>  	}=0A=
> @@ -1487,6 +1492,10 @@ static int nvme_alloc_queue(struct nvme_dev *dev, =
int qid, int depth)=0A=
>  	nvmeq->qid =3D qid;=0A=
>  	dev->ctrl.queue_count++;=0A=
>  =0A=
> +	if (qid && (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS))=0A=
> +		nvmeq->tag_offset =3D NVME_AQ_DEPTH;=0A=
> +	else=0A=
> +		nvmeq->tag_offset =3D 0;=0A=
>  	return 0;=0A=
>  =0A=
>   free_cqdma:=0A=
> @@ -2106,6 +2115,14 @@ static int nvme_setup_io_queues(struct nvme_dev *d=
ev)=0A=
>  	unsigned long size;=0A=
>  =0A=
>  	nr_io_queues =3D max_io_queues();=0A=
> +=0A=
> +	/*=0A=
> +	 * If tags are shared with admin queue (Apple bug), then=0A=
> +	 * make sure we only use one queue.=0A=
> +	 */=0A=
> +	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)=0A=
> +		nr_io_queues =3D 1;=0A=
> +=0A=
>  	result =3D nvme_set_queue_count(&dev->ctrl, &nr_io_queues);=0A=
>  	if (result < 0)=0A=
>  		return result;=0A=
> @@ -2300,6 +2317,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)=0A=
>  {=0A=
>  	int result =3D -ENOMEM;=0A=
>  	struct pci_dev *pdev =3D to_pci_dev(dev->dev);=0A=
> +	unsigned int mqes;=0A=
>  =0A=
>  	if (pci_enable_device_mem(pdev))=0A=
>  		return result;=0A=
> @@ -2325,8 +2343,8 @@ static int nvme_pci_enable(struct nvme_dev *dev)=0A=
>  =0A=
>  	dev->ctrl.cap =3D lo_hi_readq(dev->bar + NVME_REG_CAP);=0A=
>  =0A=
> -	dev->q_depth =3D min_t(int, NVME_CAP_MQES(dev->ctrl.cap) + 1,=0A=
> -				io_queue_depth);=0A=
> +	mqes =3D NVME_CAP_MQES(dev->ctrl.cap);=0A=
> +	dev->q_depth =3D min_t(int, mqes + 1, io_queue_depth);=0A=
>  	dev->db_stride =3D 1 << NVME_CAP_STRIDE(dev->ctrl.cap);=0A=
>  	dev->dbs =3D dev->bar + 4096;=0A=
>  =0A=
> @@ -2340,6 +2358,23 @@ static int nvme_pci_enable(struct nvme_dev *dev)=
=0A=
>  	else=0A=
>  		dev->io_sqes =3D NVME_NVM_IOSQES;=0A=
>  =0A=
> +	/*=0A=
> +	 * Another Apple one: If we're going to offset the IO queue tags,=0A=
> +	 * we still want to make sure they are no bigger than MQES,=0A=
> +	 * it *looks* like otherwise, bad things happen (I suspect some=0A=
> +	 * of the tag tracking in that device is limited).=0A=
> +	 */=0A=
> +	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS) {=0A=
> +		if (mqes <=3D NVME_AQ_DEPTH) {=0A=
> +			dev_err(dev->ctrl.device, "Apple shared tags quirk"=0A=
> +				" not compatible with device mqes %d\n", mqes);=0A=
> +			result =3D -ENODEV;=0A=
> +			goto disable;=0A=
> +		}=0A=
> +		dev->q_depth =3D min_t(int, dev->q_depth,=0A=
> +				     mqes - NVME_AQ_DEPTH + 1);=0A=
> +	}=0A=
> +=0A=
>  	/*=0A=
>  	 * Temporary fix for the Apple controller found in the MacBook8,1 and=
=0A=
>  	 * some MacBook7,1 to avoid controller resets and data loss.=0A=
> @@ -3057,7 +3092,8 @@ static const struct pci_device_id nvme_id_table[] =
=3D {=0A=
>  	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },=0A=
>  	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),=0A=
>  		.driver_data =3D NVME_QUIRK_SINGLE_VECTOR |=0A=
> -				NVME_QUIRK_128_BYTES_SQES },=0A=
> +				NVME_QUIRK_128_BYTES_SQES |=0A=
> +				NVME_QUIRK_SHARED_TAGS },=0A=
>  	{ 0, }=0A=
>  };=0A=
>  MODULE_DEVICE_TABLE(pci, nvme_id_table);=0A=
> =0A=
> =0A=
> =0A=
> _______________________________________________=0A=
> Linux-nvme mailing list=0A=
> Linux-nvme@lists.infradead.org=0A=
> http://lists.infradead.org/mailman/listinfo/linux-nvme=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
