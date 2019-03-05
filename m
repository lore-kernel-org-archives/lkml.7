Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5903CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8C620652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3/WuDCR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfCEWaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:30:07 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:14911 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfCEWaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:30:06 -0500
X-IronPort-AV: E=Sophos;i="5.58,445,1544511600"; 
   d="scan'208";a="24872553"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 05 Mar 2019 15:30:06 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Mar 2019 15:30:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDDjaeIe2s/2/pooGss9dBVBVdMQTItpG+Ndt/10XZY=;
 b=3/WuDCR2ELT5Cf7fEXcKhKljaCbvp+G2VS1cfTiA+pKJPDKTC76eA4Zb/ZbqnSZAG27ECEcRS/nHDe6bjF2ibRP4z9SoHb6/0Td/lnJztqcz6Xl4F6daPzzfHIZ3BNRzt8KplnBqsu30tLL4VaMh6iZi0O1aFAYeWryTNW5Nd00=
Received: from SN6PR11MB2767.namprd11.prod.outlook.com (52.135.92.154) by
 SN6PR11MB3311.namprd11.prod.outlook.com (52.135.110.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Tue, 5 Mar 2019 22:30:04 +0000
Received: from SN6PR11MB2767.namprd11.prod.outlook.com
 ([fe80::c132:ead7:a2df:5a51]) by SN6PR11MB2767.namprd11.prod.outlook.com
 ([fe80::c132:ead7:a2df:5a51%3]) with mapi id 15.20.1665.019; Tue, 5 Mar 2019
 22:30:04 +0000
From:   <Don.Brace@microchip.com>
To:     <erwanaliasr1@gmail.com>
CC:     <e.velu@criteo.com>, <don.brace@microsemi.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <esc.storagedev@microsemi.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] scsi: smartpqi_init: Reporting 'logical unit failure'
Thread-Topic: [PATCH v3] scsi: smartpqi_init: Reporting 'logical unit failure'
Thread-Index: AQHU0EltMaljq66IB0CtKeYDDV02X6X9pUAw
Date:   Tue, 5 Mar 2019 22:30:04 +0000
Message-ID: <SN6PR11MB27675810361CE0D169CAF97CE1720@SN6PR11MB2767.namprd11.prod.outlook.com>
References: <1551455797.3334.6.camel@linux.ibm.com>
 <20190301160806.16099-1-e.velu@criteo.com>
In-Reply-To: <20190301160806.16099-1-e.velu@criteo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Don.Brace@microchip.com; 
x-originating-ip: [216.54.225.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c310059-1534-41ea-cb15-08d6a1ba1d14
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SN6PR11MB3311;
x-ms-traffictypediagnostic: SN6PR11MB3311:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SN6PR11MB3311;23:602aq0kjbJExylwRj7cl27NO4nc25B5FWrINd1fNK?=
 =?us-ascii?Q?v/Ra6iwSmibQn9fn5YbGP9JOWriZikeMK2COIRw2srbk6mGtuCeAAw3xXXc8?=
 =?us-ascii?Q?ERSoREaSesmPMSnGBLQP9ZzY05PPut7SlmAZnKc9+W04XguIuBvBO0bCt/gu?=
 =?us-ascii?Q?/nvyMn18AnVGqOxj8zRAjvRjT0aorx/mf1O1lMhpxDAeZbv8oiVT27+tz/ZS?=
 =?us-ascii?Q?r3RmwYC13PSBm5QSBBsWNldhjBHqiZhYcb4ZAarEaE2W+aACJKtb7ifemMVM?=
 =?us-ascii?Q?+ZFgzKwLn2q1ZifsXADmEWk+ks20i4fZCVjvjoRcuP8IChQADN1p/UNQ2Wz3?=
 =?us-ascii?Q?vAmaTyP43UU9ciz0Fz+DY4yO6rk/EliLKeSR2Gy6DB8QeiM3gqbdtG9bT62p?=
 =?us-ascii?Q?zH6qWErgQydKRw73FdD7DsCx0j55Me9FU5e6Rin++oO9LOKQL1U5zfFVxWV2?=
 =?us-ascii?Q?Q2Js51txSXPMMorBMFLQXX6bEnKFSfnckDMicoF6AWx+rl+pbid/d7TyfTOq?=
 =?us-ascii?Q?1Q31TJOjZHwk07guk2l1P4yHpdlU0GGCErLAzGeRbB3+APuf2Z9K48ZR74qk?=
 =?us-ascii?Q?e5sqEHj9sCy5b13SH8+12Db57wb9RVFZhCcuOfR8Te+Hw85Q8fnK2BaSI6Kt?=
 =?us-ascii?Q?p1CkHzbywje2ahGWYprg3CiBLrJcmkPTgg9VEVjW+9NMpxhHa4sPHGxk3h+4?=
 =?us-ascii?Q?6XDZ+JJW0NzHR0SMthpxHuxaDwKwMJGxhKvEWwdn/Qea5E5NFk8t+VlsCbhH?=
 =?us-ascii?Q?jp86K1PeobqHDD6qAm201tgPRj05XNgfctOCpTHISZl4NJJwwDtJpWFkj2Kk?=
 =?us-ascii?Q?yqCUeXMExrmTqmnN5ysdVPNepuE2go6ns8DHpdCJt4MnFDiOBvdxBB/k/+8E?=
 =?us-ascii?Q?CKZFJQFV/KJkp2fHSoWU++N2tGQSVgSeR9+yWOXZZbLn8kp5R/w3oQ4V8iSe?=
 =?us-ascii?Q?w+7YrtzAdZMAfIRBFawwMFfx2f3EOqT6sOaFwhtgJYluBbvhsRti/bGN+oHE?=
 =?us-ascii?Q?vR9wwcFdsO71UcXuCfpMGQaPfCh4LSrRvF30BIDxvr8ILrohHqeCdQ3BB83K?=
 =?us-ascii?Q?dUwtcfCvRUxBh5LMYBdzUM3rJWHmvGsiTcP02bv+XYZRegQcbiD7tXLriWbh?=
 =?us-ascii?Q?5wf/t1Ztqx5MmWaFLIAn0+WzccdGZVXYFpKoGvo3AfsKIwTDfXBbuecjBDHD?=
 =?us-ascii?Q?h3bEiclFJ7/K36Repp19+6Qxne43L4481SD7c93gp5jynEreGKiH4cwr3OJD?=
 =?us-ascii?Q?YwVRKphZ1ui9x0QE+/iDOTKgDqXiF8iuedzGMTzc0N44Yam1F2cEPfNDRTTL?=
 =?us-ascii?B?Zz09?=
x-microsoft-antispam-prvs: <SN6PR11MB33116875E174D3635DEA1AD8E1720@SN6PR11MB3311.namprd11.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(39860400002)(396003)(13464003)(199004)(189003)(14454004)(72206003)(9686003)(476003)(26005)(1411001)(97736004)(68736007)(52536013)(86362001)(53936002)(486006)(71190400001)(71200400001)(66066001)(14444005)(5660300002)(256004)(446003)(11346002)(186003)(3846002)(54906003)(316002)(102836004)(6506007)(99286004)(305945005)(74316002)(6916009)(7696005)(7736002)(6436002)(55016002)(76176011)(33656002)(81156014)(6116002)(81166006)(8676002)(2906002)(478600001)(6246003)(25786009)(229853002)(8936002)(106356001)(105586002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB3311;H:SN6PR11MB2767.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z1zvm7AOrkdG7UqMUtpKijZnBGpcuIoHebgJS/D+wqmu/CnfNxh8Ovlk0FtKE+JxAXtPJJXrQ6OPgkCV7xVLh52R+p3uEnrTYp/dNnNjycS9lIdBy6wabiJROf8+BFELzykji68ab2KMPzeEXQ8gY+I7v7STbxemn1uo0zbwI4lwqucLBdCUVVWZkx+vBQ1+Ok1RsCL87ar07VAjuWc0sytu/SpZiuaWdVaSDE76feD7ViDJQWKx20qlN+OAh368zofxJWTlA3n9nwf1JmYxFIa0EGENupxY2a2ru9v5PRmVGe3tBjZD/S/bjBec7HP/dz993W6ybVFPF3LU0UvTicpvG5o6ucprH4tdgCxNQ33utQ+YWFwO7KsObNupAQ6MwlvOzOevtfVhd1GenTlTa+KacKzkPfqMiN9h180WMNs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c310059-1534-41ea-cb15-08d6a1ba1d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 22:30:04.1753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3311
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-owner@vger.kernel=
.org] On Behalf Of Erwan Velu
Sent: Friday, March 1, 2019 10:08 AM
Cc: Erwan Velu <e.velu@criteo.com>; Don Brace <don.brace@microsemi.com>; Ja=
mes E.J. Bottomley <jejb@linux.ibm.com>; Martin K. Petersen <martin.peterse=
n@oracle.com>; open list:MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi) <=
esc.storagedev@microsemi.com>; open list:MICROSEMI SMART ARRAY SMARTPQI DRI=
VER (smartpqi) <linux-scsi@vger.kernel.org>; open list <linux-kernel@vger.k=
ernel.org>
Subject: [PATCH v3] scsi: smartpqi_init: Reporting 'logical unit failure'

When the HARDWARE_ERROR/0x3e/0x1 case is triggered, the logical volume is o=
fflined.
When reading the kernel log, the reason why the device got offlined isn't r=
eported to the user.
This situation makes difficult for admins to estimate the root cause of the=
 issue they analize.

Reading this part of the code makes clear this is because driver received a=
 HARDWARE_ERROR/0x3e/0x1 which is a 'logical unit failure'.
This patch is just about reporting the reason behind the offlining to ease =
the analyse.

Signed-off-by: Erwan Velu <e.velu@criteo.com>

Acked-by: Don Brace <don.brace@microsemi.com>

---
 drivers/scsi/smartpqi/smartpqi_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/=
smartpqi_init.c
index f564af8949e8..adebafe56b5b 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -2764,6 +2764,12 @@ static void pqi_process_raid_io_error(struct pqi_io_=
request *io_request)
 				sshdr.sense_key =3D=3D HARDWARE_ERROR &&
 				sshdr.asc =3D=3D 0x3e &&
 				sshdr.ascq =3D=3D 0x1) {
+			struct pqi_ctrl_info *ctrl_info =3D shost_to_hba(scmd->device->host);
+			struct pqi_scsi_dev *device =3D scmd->device->hostdata;
+
+			if (printk_ratelimit())
+				scmd_printk(KERN_ERR, scmd, "received 'logical unit failure' from cont=
roller for scsi %d:%d:%d:%d\n",
+					ctrl_info->scsi_host->host_no, device->bus, device->target, device->l=
un);
 			pqi_take_device_offline(scmd->device, "RAID");
 			host_byte =3D DID_NO_CONNECT;
 		}
--=20
2.20.1

