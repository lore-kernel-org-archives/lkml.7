Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CA5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5346E20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YcPejJ6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfCGV0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:26:07 -0500
Received: from mail-eopbgr750072.outbound.protection.outlook.com ([40.107.75.72]:64736
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726166AbfCGV0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaWWXgvHaRMlaqWUH5YDjMmP/Ghh7FC9iDvlnIdugoM=;
 b=YcPejJ6t9To9koiEcBmkP992RgOOFPIxcpWPFysJl34pJlmLsNNf08ngYkjQsyxLOX0oK81g/MiRw47NDu1AVHQsxjTNU7cT39ciomv9573MzIDzSD/+LBt6U+qXXKndASESJprJjGT+0+VVnwOYvU8EEJveQ0rCiLEDyQFD4hM=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2719.namprd12.prod.outlook.com (52.135.103.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 7 Mar 2019 21:26:04 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 21:26:04 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: [PATCH 1/2] x86/MCE/AMD: Export smca_get_bank_type()
Thread-Topic: [PATCH 1/2] x86/MCE/AMD: Export smca_get_bank_type()
Thread-Index: AQHU1Sxe9xndgBTMJEipKsFojQN5+g==
Date:   Thu, 7 Mar 2019 21:26:04 +0000
Message-ID: <20190307212552.8865-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0801CA0011.namprd08.prod.outlook.com
 (2603:10b6:803:29::21) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db2a9605-8a10-432d-bb04-08d6a34380cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2719;
x-ms-traffictypediagnostic: SN6PR12MB2719:
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2719;20:H79CGr7i6kuWiIhjrS87BGEp776tHgYDPIa6bw8m9pnJCS4ilxkUja9J4kMisL7DI4SqyZV7QU/zY6o4zqMWYd5Nh4v4fXpD/3lfyORLTkQOB/nbJ/10r1Vho9+hKngQjG3XAw2pSP48tZMX7Eg89yRg6c3Zn6TpsgD6IXgQDrFaVf2Ww7KMVQXjmrtZOHvZsh5E6UDsf4EQYlG9SNEmqwOyU/tG3mjMcbLuv9olsGh+c2A2JBNdS+95uCiay9Sm
x-microsoft-antispam-prvs: <SN6PR12MB2719B54E351411F4ECBE64E2F84C0@SN6PR12MB2719.namprd12.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(71200400001)(305945005)(36756003)(6916009)(1076003)(68736007)(71190400001)(8936002)(5640700003)(6486002)(50226002)(2501003)(53936002)(99286004)(6506007)(54906003)(386003)(316002)(7736002)(26005)(52116002)(102836004)(2906002)(5660300002)(66066001)(81156014)(8676002)(81166006)(25786009)(6436002)(4326008)(97736004)(105586002)(3846002)(6116002)(186003)(476003)(106356001)(6512007)(86362001)(486006)(2616005)(72206003)(2351001)(14444005)(256004)(14454004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2719;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VObiLqBx1DEGcYhDlJWqTKo8Lku4XsZwiYwNg1ii54dg5LWy/ZPY2JPZis6wd7EDLOc42ToDLzc07KZx4ahE97vtGBltjET64A+WFJh+40ANb1LfoPbicr3x/s/8BCssEALkUy09+ysRLzaidzZkmApCHycQLO7zgfEc3kbhqaqoJ8J8bij3a/rUGUYGCwVVhqcROVNpbhDrmzsHQz2XJ1lkNDGKATZJa61MCsulDS5OBL0B9HzNtiYvPNuF7GrL42pkPgaKfpHUuex04G3G7uGZZoEO1JRYOvVAm0OiJef0+D9/X0BstrmmVmLSp1miIsLNddjl60gfH9XbLx4Zmf+jggN1teJ37BHkDow+qnASYff/1pjxp60GKzVWjYD6mHQOS/M/EmGlIzy4GvfnEbb2SOhPE7qC+Cx7LBA3Ooo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2a9605-8a10-432d-bb04-08d6a34380cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 21:26:04.2149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2719
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Export the smca_get_bank_type() function so it can be used in the AMD
MCE decoder module.

Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    | 1 +
 arch/x86/kernel/cpu/mce/amd.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 22d05e3835f0..605b46fde1ee 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -340,6 +340,7 @@ struct smca_bank {
 extern struct smca_bank smca_banks[MAX_NR_BANKS];
=20
 extern const char *smca_get_long_name(enum smca_bank_types t);
+extern enum smca_bank_types smca_get_bank_type(unsigned int bank);
 extern bool amd_mce_is_memory_error(struct mce *m);
=20
 extern int mce_threshold_create_device(unsigned int cpu);
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index e64de5149e50..041bb800cda8 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -123,7 +123,7 @@ const char *smca_get_long_name(enum smca_bank_types t)
 }
 EXPORT_SYMBOL_GPL(smca_get_long_name);
=20
-static enum smca_bank_types smca_get_bank_type(unsigned int bank)
+enum smca_bank_types smca_get_bank_type(unsigned int bank)
 {
 	struct smca_bank *b;
=20
@@ -136,6 +136,7 @@ static enum smca_bank_types smca_get_bank_type(unsigned=
 int bank)
=20
 	return b->hwid->bank_type;
 }
+EXPORT_SYMBOL_GPL(smca_get_bank_type);
=20
 static struct smca_hwid smca_hwid_mcatypes[] =3D {
 	/* { bank_type, hwid_mcatype, xec_bitmap } */
--=20
2.17.1

