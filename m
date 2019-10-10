Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05387C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C622220B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VyPshbJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732903AbfJJKk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:40:56 -0400
Received: from mail-eopbgr710048.outbound.protection.outlook.com ([40.107.71.48]:63857
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbfJJKkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:40:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC66nuo5V/2A14QaStu6Dpf4bm6/X7d2v51iDat9DcyLK3hohGhqRH4OdX2SDoBlSRk0E1dNg7Hdfy3YeVmSGp3QwgUVuf2rCskc5/iA3ZrlImqO0S3XHvMitUueUzLgd9sEM/erjFsr811eUGaBBmgGS8ivCZ/nC5GG5wSfIDKTrUNYSgrZZ91K4sTKvCVsXSOHl2rNiVug7aFLhMoDDal4p80F4El78L3mI33MLCXmSEyJ8YsX/yQsMW3g+NzHjfi8ervblsxd9vNAzJLkcdtZRKWGSMJMSy0UBT3GMngEirTE/9WgcXUTIBQK7nLG8ivKBg1L1GbwflKSYaxvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taJfzhBhgLYSNVx6tza02zms4nw5WV/Fo2B+hydIYmY=;
 b=JipE7C1tWQKs2DzjmBkqtHXzL0MX13awIBfjGOBkVT26+PCA+OJCW2Zu6/5qwaR9XIB7qgIIfsRFEtkl4XumcsjopuF/b6Un8qLM5KGP+7nO7KKS3f8XOTSTnONn8fskLLeHtG4Zw84gdnNjlo7qvcpyby1W1T2vgWyM0WA6nLvfu3QpSKIysgNLTkUYIj/EwymCJYOCyfldX5UVTxEwlmW/x6rPX/gP99en+txImbAJ03PB0T5ridkqSiAOlfFl8PbmVrZhidIMNjJDxiWOeeaSlos7gwm4Yb3NiWM1x29QOgLMW+lIlfW8ZlTzbG6nfBNNPFCbIjp0AI6k09jWZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taJfzhBhgLYSNVx6tza02zms4nw5WV/Fo2B+hydIYmY=;
 b=VyPshbJUq3q6CGKWm9/Q5+mzSLeEZW612nfXxqIYH8RB8k/DaoLkbo1uiDzblRQT7gksVZTVNahgLRbTLJ3/Jjys5dAodKHgSIvfomo30yQp9574+b5dVk2xSmjtb44SJY263JuDopeEExCIkp3Gb+5Jq34B1ZatAwM1gZd/RbQ=
Received: from DM6PR12MB3868.namprd12.prod.outlook.com (10.255.173.213) by
 DM6PR12MB2793.namprd12.prod.outlook.com (20.176.114.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 10 Oct 2019 10:40:51 +0000
Received: from DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1]) by DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1%4]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 10:40:51 +0000
From:   vishnu <vravulap@amd.com>
To:     Mark Brown <broonie@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] ASoC: amd: No need PCI-MSI interrupts
Thread-Topic: [PATCH 1/7] ASoC: amd: No need PCI-MSI interrupts
Thread-Index: AQHVd/NK02/86+8bwUqA0+UYmDRNb6dGCguAgAABq4CADmkpAA==
Date:   Thu, 10 Oct 2019 10:40:51 +0000
Message-ID: <f9b1c3d5-6e02-354f-91b6-3b57e2f88bde@amd.com>
References: <1569891524-18875-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <BN6PR12MB18093C8EDE60811B3D917DEAF79D0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20191001172941.GC4786@sirena.co.uk>
In-Reply-To: <20191001172941.GC4786@sirena.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR0101CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::16) To DM6PR12MB3868.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vishnuvardhanrao.Ravulapati@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 120a3bf8-715f-4c93-e6cc-08d74d6e519d
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM6PR12MB2793:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2793C4AD344931B17225D558E7940@DM6PR12MB2793.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(189003)(199004)(4326008)(6116002)(71190400001)(71200400001)(66476007)(66556008)(64756008)(66446008)(6636002)(66946007)(3846002)(256004)(66066001)(6246003)(99286004)(52116002)(25786009)(14454004)(478600001)(31686004)(7736002)(305945005)(486006)(476003)(54906003)(110136005)(11346002)(2616005)(446003)(76176011)(31696002)(316002)(102836004)(81166006)(81156014)(53546011)(6506007)(8676002)(386003)(8936002)(26005)(186003)(36756003)(6436002)(2906002)(229853002)(5660300002)(6486002)(4744005)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2793;H:DM6PR12MB3868.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FRpD9649/lvZG3nM/cu4MNhLK77As/TS80Y1pNKHZERrciprotlk9up5jeQlk0Lf+DF5FRChehVHTFde045zwSegB3DNXpkzUvaI08/8xepVU2dN/dxfWTVTfgAUSVuzW8kXSRkAj5BG4VTpuuFvWDKx4MX8e90Db+4790imVQ2RoCcGcfcZqwmLHTbkSfsNPjH0rjZU4tHSwOtyVrb6SkSQXLUemd2xNlNZk0GoKKzosHTkF9a3R/RyuNA/I0Nd7eivn0m8HbZDTi0bXz2e0biURPiGi1e7Nn/VgMcbaSTg9UgcsJT7C5cQUio/LZuEMTl4T06RmeqkI4wcA4UYGb/E6EbKsQC2hty/g0I67V2UP3HFdKVBR77W8c0OEMu7EmTwLz/q526Nf3OZbuyVmgi5XDbnmgPRtG1QRs7+B0E=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <7882EA1F37EFB7409C1D10251D7901F9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120a3bf8-715f-4c93-e6cc-08d74d6e519d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 10:40:51.0906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fNxYOwFaUb2Ita2e52ZT4O4OCdRb5ulajHo9XI2v7fc5uECfIeWsd5OV+by0Urzm9qtsVMvRmEZhoKE8KZFaAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2793
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Please find my inline comments.

Thanks,
Vishnu

On 01/10/19 10:59 PM, Mark Brown wrote:
> On Tue, Oct 01, 2019 at 05:23:43PM +0000, Deucher, Alexander wrote:
>=20
>>> ACP-PCI controller driver does not depends msi interrupts.
>>> So removed msi related pci functions which have no use and does not imp=
act
>>> on existing functionality.
>=20
>> In general, however, aren't MSIs preferred to legacy interrupts?
>=20
> As I understand it.  Or at the very least I'm not aware of any situation
> where they're harmful.  It'd be good to have a clear explanation of why
> we're removing the support.

Actually our device is audio device and it does not depends on MSI`s.
So we thought to remove it as it has no purpose or meaning to have
this code in our audio based ACP-PCI driver.

>> Doesn't the driver have to opt into MSI support?  As such, won't
>> removing this code effectively disable MSI support?
>=20
> Yes.


