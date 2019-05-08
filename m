Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17025C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB8B21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TU2wVG3U";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZvleBewS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfEHTPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:15:36 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10650 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfEHTPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557342933; x=1588878933;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xg4463s9bHQKU8Q3pkJ3v11SND30ozruqYY9o/PZKbY=;
  b=TU2wVG3UuGXEkNKZSQSS+f0bhR1Ls/SSkEzmImxv1Xobw5sb4t/T5nk8
   TGZKStHbWDkdLdCfHm2JiGfICz4JHIFEVm3eb6Eu2oeB7po+3V9ZC2KvV
   UOkiJNGGS4WSfnKgB0WGw/5/fyRQiz5oDhLFfi0Xu0iI6C6D14WkO/uxj
   K5ZQz2/DkgKxcKuOkQC6lDUKfnRzvJozJ3iMqwr2k/N0Yr2lI8bDWSVt+
   wY0dx0sdQGFnnmOcJGUNLodIdrZnaKiGfIDA0q0yDjC4fk06VkSQbUqjN
   Rmwv7vKp4w5tdGMsnR/u0us0j1GwPfELHkVyof16ZlmqIHZc1ffZBdipG
   w==;
X-IronPort-AV: E=Sophos;i="5.60,447,1549900800"; 
   d="scan'208";a="109044063"
Received: from mail-co1nam05lp2056.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.56])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2019 03:15:32 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ5Ig3Lh/STFq+hsiTH/whuwBsKWnEbA57Rc6OV3rlg=;
 b=ZvleBewS34LZBQRyVrkSCFbSaE0Rz6GlT8y/yIhMPc4n/NKQb+4bw7nRq/kfCqUP+VytKyCs7BUP9if8q3cAUzsAJniekfeUPJoHNlb99TkbYu1sJDFyLPt9oKmrQspZGENSlbdKZo63zQnBe7A1IBpi0CA2UQZa3Vnn+coXA0Q=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4031.namprd04.prod.outlook.com (52.135.82.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Wed, 8 May 2019 19:15:29 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 19:15:29 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Thread-Topic: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Thread-Index: AQHVBdBXtVKbO4BKO0CgVRCYMBsfQw==
Date:   Wed, 8 May 2019 19:15:29 +0000
Message-ID: <SN6PR04MB45275A4CACABF6CBF6077C3486320@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bba5a97-710e-4a98-e08b-08d6d3e988be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4031;
x-ms-traffictypediagnostic: SN6PR04MB4031:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4031F73E0E3097C1854C34EB86320@SN6PR04MB4031.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(346002)(136003)(396003)(199004)(189003)(51444003)(73956011)(86362001)(66946007)(478600001)(8676002)(66446008)(81166006)(66476007)(8936002)(14454004)(966005)(305945005)(72206003)(53936002)(76116006)(2906002)(74316002)(5660300002)(4326008)(3846002)(66556008)(64756008)(52536014)(6116002)(81156014)(25786009)(7736002)(71190400001)(71200400001)(15650500001)(53546011)(102836004)(26005)(66066001)(54906003)(316002)(110136005)(6436002)(9686003)(6306002)(486006)(91956017)(68736007)(55016002)(2201001)(6246003)(186003)(2501003)(99286004)(33656002)(256004)(76176011)(6506007)(14444005)(476003)(446003)(7696005)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4031;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /YsIu7Qfpr6YddnHpv3IUWVzPSK+lC12W4h2C4wV8zaYTxY4dy2+I1O5y22tgubJJ9LyBQ3NzqvvVcL+my5BmheadyZ12fCREW2sXc+Cjbjov8/sQN1jor1eNuCbG35kSKznMgE6H1UeiosOqG/x0hNMWTGgPyQExOgIsN5Srih1KLQgG9x2B05Kp3QZlpr443oaxAY26/siM9Nx4jjX03VOiNv8Dyv7dGD2lRgnfUcQx6kvPYCDbr8FuJ7K/dW5qVofUs48isFuVMNOAU7V6QvTiZ2eXbNuBicMlzP8EsmBiZ8uPbxanpmZQwEBMbrXUUj3FBkFQOxMGIJzx1CmlwxCMK6Jq1Ojeyg3eTlUbvGbTLXIeCtLo1c9Ur5lEo0RwZme8rCPkIp18l3JELcqpZg/624aKl2o/clIIJ8kqf0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bba5a97-710e-4a98-e08b-08d6d3e988be
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 19:15:29.3054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Did you get a chance to run this patch through checkpatch.pl ?=0A=
=0A=
On 05/08/2019 12:00 PM, Kai-Heng Feng wrote:=0A=
> Several NVMes consume lots of power during Suspend-to-Idle.=0A=
>=0A=
> According to the NVMe vendors, APST should be used and there are two=0A=
> things that should be prevented:=0A=
> - Controller shutdown (CC.SHN)=0A=
> - PCI D3=0A=
>=0A=
> I think that's because the Windows Modern Standby design document [1]=0A=
> states below as a requirement:=0A=
> "=0A=
> Akin to AHCI PCIe SSDs, NVMe SSDs need to provide the host with a=0A=
> non-operational power state that is comparable to DEVSLP (<5mW draw,=0A=
> <100ms exit latency) in order to allow the host to perform appropriate=0A=
> transitions into Modern Standby. Should the NVMe SSD not expose such a=0A=
> non-operational power state, autonomous power state transitions (APST)=0A=
> is the only other option to enter Modern Standby successfully.=0A=
> "=0A=
>=0A=
> D3 wasn't mentioned at all, though for some vendors D3 still put the=0A=
> device into a low power state, others disable APST after trasition to=0A=
> D3.=0A=
>=0A=
> So instead of disabling NVMe controller in suspend callback we do the=0A=
> following instead:=0A=
> - Make sure all IRQs are quiesced=0A=
> - Stop all queues=0A=
> - Prevent the device entering D3=0A=
> - Use memory barrier to make sure DMA operations are flushed on HMB devic=
es=0A=
>=0A=
> This patch has been verified on several different NVMes:=0A=
> - Intel=0A=
> - Hynix=0A=
> - LiteOn=0A=
> - Micron=0A=
> - WDC=0A=
> - Samsung=0A=
> - Tohiba=0A=
>=0A=
> With the new suspend routine, the laptop I tested use roughly 0.8W=0A=
> under Suspend-to-Idle, and resume time is faster than the original=0A=
> D3 scheme.=0A=
>=0A=
> The only one exception so far is Toshiba XG5, which works with the old=0A=
> suspend routine, so introduce a new quirk for XG5.=0A=
> We are working with Toshiba to root cause the issue on XG5.=0A=
>=0A=
> [1] https://docs.microsoft.com/en-us/windows-hardware/design/device-exper=
iences/part-selection#ssd-storage=0A=
>=0A=
> Tested-by: Lucien Kao <Lucien_kao@compal.com>=0A=
> Tested-by: Mice Lin <mice_lin@wistron.com>=0A=
> Tested-by: Jason Tan <LiangChuan.Tan@wdc.com>=0A=
> Tested-by: Cody Liu (codyliu) <codyliu@micron.com>=0A=
> Tested-by: Theodore Ts'o <tytso@mit.edu>=0A=
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>=0A=
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>=0A=
> ---=0A=
>   drivers/nvme/host/core.c |   8 +++=0A=
>   drivers/nvme/host/nvme.h |   8 +++=0A=
>   drivers/nvme/host/pci.c  | 102 +++++++++++++++++++++++++++++++++++++--=
=0A=
>   3 files changed, 115 insertions(+), 3 deletions(-)=0A=
>=0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index a6644a2c3ef7..929db749da98 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -3903,6 +3903,14 @@ static inline void _nvme_check_size(void)=0A=
>   	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) !=3D 64);=0A=
>   }=0A=
>=0A=
> +void nvme_enter_deepest(struct nvme_ctrl *ctrl)=0A=
> +{=0A=
> +	int ret =3D nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, ctrl->npss,=
=0A=
> +				    NULL, 0, NULL);=0A=
> +	if (ret)=0A=
> +		dev_warn(ctrl->device, "failed to set deepest non-operational state (%=
d)\n", ret);=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(nvme_enter_deepest);=0A=
>=0A=
>   static int __init nvme_core_init(void)=0A=
>   {=0A=
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h=0A=
> index 5ee75b5ff83f..ea40a83314ae 100644=0A=
> --- a/drivers/nvme/host/nvme.h=0A=
> +++ b/drivers/nvme/host/nvme.h=0A=
> @@ -92,6 +92,11 @@ enum nvme_quirks {=0A=
>   	 * Broken Write Zeroes.=0A=
>   	 */=0A=
>   	NVME_QUIRK_DISABLE_WRITE_ZEROES		=3D (1 << 9),=0A=
> +=0A=
> +	/*=0A=
> +	 * Use D3 on S2I regardless of NPSS.=0A=
> +	 */=0A=
> +	NVME_QUIRK_USE_D3_ON_S2I		=3D (1 << 10),=0A=
>   };=0A=
>=0A=
>   /*=0A=
> @@ -229,6 +234,7 @@ struct nvme_ctrl {=0A=
>   	/* Power saving configuration */=0A=
>   	u64 ps_max_latency_us;=0A=
>   	bool apst_enabled;=0A=
> +	bool suspend_to_idle;=0A=
>=0A=
>   	/* PCIe only: */=0A=
>   	u32 hmpre;=0A=
> @@ -467,6 +473,8 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl);=0A=
>   int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,=
=0A=
>   		void *log, size_t size, u64 offset);=0A=
>=0A=
> +void nvme_enter_deepest(struct nvme_ctrl *ctrl);=0A=
> +=0A=
>   extern const struct attribute_group *nvme_ns_id_attr_groups[];=0A=
>   extern const struct block_device_operations nvme_ns_head_ops;=0A=
>=0A=
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
> index 3e4fb891a95a..dea42b41f9a8 100644=0A=
> --- a/drivers/nvme/host/pci.c=0A=
> +++ b/drivers/nvme/host/pci.c=0A=
> @@ -23,6 +23,7 @@=0A=
>   #include <linux/io-64-nonatomic-lo-hi.h>=0A=
>   #include <linux/sed-opal.h>=0A=
>   #include <linux/pci-p2pdma.h>=0A=
> +#include <linux/suspend.h>=0A=
>=0A=
>   #include "trace.h"=0A=
>   #include "nvme.h"=0A=
> @@ -2828,12 +2829,98 @@ static void nvme_remove(struct pci_dev *pdev)=0A=
>   }=0A=
>=0A=
>   #ifdef CONFIG_PM_SLEEP=0A=
> +static void nvme_do_suspend_to_idle(struct pci_dev *pdev)=0A=
> +{=0A=
> +	struct nvme_dev *ndev =3D pci_get_drvdata(pdev);=0A=
> +=0A=
> +	pdev->dev_flags |=3D PCI_DEV_FLAGS_NO_D3;=0A=
> +	ndev->ctrl.suspend_to_idle =3D true;=0A=
> +=0A=
> +	nvme_start_freeze(&ndev->ctrl);=0A=
> +	nvme_wait_freeze_timeout(&ndev->ctrl, NVME_IO_TIMEOUT);=0A=
> +	nvme_stop_queues(&ndev->ctrl);=0A=
> +=0A=
> +	nvme_enter_deepest(&ndev->ctrl);=0A=
> +=0A=
> +	if (ndev->ctrl.queue_count > 0) {=0A=
> +		nvme_disable_io_queues(ndev);=0A=
> +		nvme_poll_irqdisable(&ndev->queues[0], -1);=0A=
> +	}=0A=
> +=0A=
> +	nvme_suspend_io_queues(ndev);=0A=
> +	nvme_suspend_queue(&ndev->queues[0]);=0A=
> +	pci_free_irq_vectors(pdev);=0A=
> +=0A=
> +	blk_mq_tagset_busy_iter(&ndev->tagset, nvme_cancel_request, &ndev->ctrl=
);=0A=
> +	blk_mq_tagset_busy_iter(&ndev->admin_tagset, nvme_cancel_request, &ndev=
->ctrl);=0A=
> +=0A=
> +	/* Make sure all HMB DMA operations are done */=0A=
> +	mb();=0A=
> +}=0A=
> +=0A=
> +static int nvme_do_resume_from_idle(struct pci_dev *pdev)=0A=
> +{=0A=
> +	struct nvme_dev *ndev =3D pci_get_drvdata(pdev);=0A=
> +	int result;=0A=
> +=0A=
> +	pdev->dev_flags &=3D ~PCI_DEV_FLAGS_NO_D3;=0A=
> +	ndev->ctrl.suspend_to_idle =3D false;=0A=
> +=0A=
> +	result =3D pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);=0A=
> +	if (result < 0)=0A=
> +		goto out;=0A=
> +=0A=
> +	result =3D nvme_pci_configure_admin_queue(ndev);=0A=
> +	if (result)=0A=
> +		goto out;=0A=
> +=0A=
> +	result =3D nvme_alloc_admin_tags(ndev);=0A=
> +	if (result)=0A=
> +		goto out;=0A=
> +=0A=
> +	ndev->ctrl.max_hw_sectors =3D NVME_MAX_KB_SZ << 1;=0A=
> +	ndev->ctrl.max_segments =3D NVME_MAX_SEGS;=0A=
> +	mutex_unlock(&ndev->shutdown_lock);=0A=
> +=0A=
> +	result =3D nvme_init_identify(&ndev->ctrl);=0A=
> +	if (result)=0A=
> +		goto out;=0A=
> +=0A=
> +	result =3D nvme_setup_io_queues(ndev);=0A=
> +	if (result)=0A=
> +		goto out;=0A=
> +=0A=
> +	if (ndev->online_queues < 2) {=0A=
> +		dev_warn(ndev->ctrl.device, "IO queues not created\n");=0A=
> +		nvme_kill_queues(&ndev->ctrl);=0A=
> +		nvme_remove_namespaces(&ndev->ctrl);=0A=
> +	} else {=0A=
> +		nvme_start_queues(&ndev->ctrl);=0A=
> +		nvme_wait_freeze(&ndev->ctrl);=0A=
> +		nvme_dev_add(ndev);=0A=
> +		nvme_unfreeze(&ndev->ctrl);=0A=
> +	}=0A=
> +=0A=
> +	nvme_start_ctrl(&ndev->ctrl);=0A=
> +=0A=
> +	return 0;=0A=
> +=0A=
> + out:=0A=
> +	nvme_remove_dead_ctrl(ndev, result);=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
>   static int nvme_suspend(struct device *dev)=0A=
>   {=0A=
>   	struct pci_dev *pdev =3D to_pci_dev(dev);=0A=
>   	struct nvme_dev *ndev =3D pci_get_drvdata(pdev);=0A=
>=0A=
> -	nvme_dev_disable(ndev, true);=0A=
> +	if (IS_ENABLED(CONFIG_ACPI) && pm_suspend_via_s2idle() &&=0A=
> +	    ndev->ctrl.npss && !(ndev->ctrl.quirks & NVME_QUIRK_USE_D3_ON_S2I))=
=0A=
> +		nvme_do_suspend_to_idle(pdev);=0A=
> +	else=0A=
> +		nvme_dev_disable(ndev, true);=0A=
> +=0A=
>   	return 0;=0A=
>   }=0A=
>=0A=
> @@ -2841,9 +2928,16 @@ static int nvme_resume(struct device *dev)=0A=
>   {=0A=
>   	struct pci_dev *pdev =3D to_pci_dev(dev);=0A=
>   	struct nvme_dev *ndev =3D pci_get_drvdata(pdev);=0A=
> +	int result =3D 0;=0A=
>=0A=
> -	nvme_reset_ctrl(&ndev->ctrl);=0A=
> -	return 0;=0A=
> +	if (ndev->ctrl.suspend_to_idle) {=0A=
> +		result =3D nvme_do_resume_from_idle(pdev);=0A=
> +		if (result)=0A=
> +			dev_warn(dev, "failed to resume from idle state (%d)\n", result);=0A=
> +	} else=0A=
> +		nvme_reset_ctrl(&ndev->ctrl);=0A=
> +=0A=
> +	return result;=0A=
>   }=0A=
>   #endif=0A=
>=0A=
> @@ -2921,6 +3015,8 @@ static const struct pci_device_id nvme_id_table[] =
=3D {=0A=
>   	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */=0A=
>   		.driver_data =3D NVME_QUIRK_IDENTIFY_CNS |=0A=
>   				NVME_QUIRK_DISABLE_WRITE_ZEROES, },=0A=
> +	{ PCI_DEVICE(0x1179, 0x0116),	/* Toshiba XG5 */=0A=
> +		.driver_data =3D NVME_QUIRK_USE_D3_ON_S2I, },=0A=
>   	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */=0A=
>   		.driver_data =3D NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },=0A=
>   	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */=0A=
>=0A=
=0A=
