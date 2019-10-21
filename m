Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609B5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D5720679
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UEBqzmmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfJUMys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:54:48 -0400
Received: from mail-eopbgr720078.outbound.protection.outlook.com ([40.107.72.78]:6851
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727985AbfJUMyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:54:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcVfU6gUnW+C7d/BKePVXyvMtevRFNI0IUIk14VWmlmMLCYB8pVkQHnA7Egd1ZYngoBjEmZzj9nevkNhN8xWWa+hw8hOPNAjr5ucZ2L3qxf15tWSrHMCisLPbOmFLiqexY8KaioBxOEzj5aEQZq+B6yME9E9SQuHmDktvOCU/GAWBQu1bikaaea5VZ5cyUgXfdX8F/N3zsCjkiYEzQwUCR5iVeBGstzDyKbiZ+gQY+ivguiih9T5kVoMJzwLjCUisRvOeX5KgUzh0xG6XRoop79igYQTiSac27okARmLlSf6RciCeXzrQyU6fqC84DemE9sHytt3c0ITiFawxGUehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Hc1+8wqO8SPrwJhD2uLGNAk0vogNUzux6SVSC0yItE=;
 b=Z0Ih2PWr7H4p6GXWEuBu7m5GOTw8EjO5lfOasn/fgZKybpWLARQSYYixHvKwd0Mm98ie63rHZkernJ2LYPa8wKhTB5PJNvhQOIlA87c9mj+M+82zVPTRFy/Xz+99TDlVW4v2xqyIMEVbfHV25lS5dZMc1OoYNBbLgw5BjA0HQP6afx7C3Wz8nuU5FSJ5+iuGr8SpOx2j6kb0WaTohQlHA81B8tjeFtor0IwXlYYorU2/28YpflDS9H/S2t/fbur+uGDZlNPVOAdmL/t+OpLW1JQHxCC1WXMQBX9jHvk99R7T2Vuoe7EZjU0iOS5Eh15EynAW/9zCnQ6fWTgbVer3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Hc1+8wqO8SPrwJhD2uLGNAk0vogNUzux6SVSC0yItE=;
 b=UEBqzmmE1g7LztEmcgTol/k062hsepxcg6m20FEzTblqW9ofCLdYOP/TgqVYFH+baAyI/ZIAAGSSlZgx7p8O3B0/iIfw9BItIrtPQrSlyQSHZets156e5IjfT9B66njSkr/A2XRmoNaKOc0lt1XyeLVPxIaraj4jen6jh6sSpMA=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (20.176.118.91) by
 DM6PR12MB3434.namprd12.prod.outlook.com (20.178.198.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Mon, 21 Oct 2019 12:54:40 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::3cea:420e:a297:7537]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::3cea:420e:a297:7537%6]) with mapi id 15.20.2367.022; Mon, 21 Oct 2019
 12:54:40 +0000
From:   "Allen, John" <John.Allen@amd.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Allen, John" <John.Allen@amd.com>
Subject: [PATCH] linux-firmware: Update AMD cpu microcode
Thread-Topic: [PATCH] linux-firmware: Update AMD cpu microcode
Thread-Index: AQHViA6zUUK18LbihUSvVgJcEJCxqw==
Date:   Mon, 21 Oct 2019 12:54:40 +0000
Message-ID: <20191021125402.5043-1-john.allen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0112.namprd05.prod.outlook.com
 (2603:10b6:803:42::29) To DM6PR12MB2761.namprd12.prod.outlook.com
 (2603:10b6:5:41::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Allen@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.16.4
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59a936c1-a0f4-4c23-d926-08d75625d639
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM6PR12MB3434:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3434084C3FBA10207C7E4BAA9A690@DM6PR12MB3434.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:13;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(199004)(189003)(305945005)(7736002)(6116002)(3846002)(4326008)(6486002)(52116002)(99286004)(71200400001)(71190400001)(4001150100001)(54906003)(316002)(6436002)(6512007)(5640700003)(36756003)(2906002)(25786009)(50226002)(478600001)(81156014)(15650500001)(6916009)(81166006)(8676002)(8936002)(86362001)(14454004)(1076003)(5660300002)(386003)(6506007)(102836004)(26005)(14444005)(256004)(2616005)(2501003)(66066001)(486006)(64756008)(66556008)(66476007)(66946007)(66446008)(2351001)(476003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3434;H:DM6PR12MB2761.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gOlAga89zPCKp13DEPF1Cn1wERHcqB7k3spS5z4EIggSitaZsgcOE3iGcXCcCCd/0sym3x3Rlp9E9OUWG14u8yLfx9+G69Y7FeUPOEaW2TUKMxB9Uk2DzoqymA7JQq0oCwvTQZ2f/mNGvl7VSPFFAu/qL0CnlW578E8XHYRZeiKidVCwmrQ7asX5C1yS0UjK/JyG7SQeJCfTnkwXTtU0/pSiP6sShSROEUt9FcLE3nhmemx0gv/rXVxuod98oLUZHm2meE26WKhrsSK3o2WHCEA1IRZLgL4ihRM6te4ttrnSVb5bk8bPX/ybMoNSXurbbU6x3YoEX99anm7KPLBRqqg66v4HTxppjaDG+wJOjdm5Jo+0GYo9T9+523T3S8uYmxKVmJ845cchIF2bzXBP3QXqTg7f/i6KyRUo03DlYpRapq1oRi5HPtoSjj+OrINj
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a936c1-a0f4-4c23-d926-08d75625d639
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 12:54:40.5677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EbGF3qXJ/gux493UfEeZ9QGqG9aFrVI3JUUzBnx7mu2K2ohenT+IlABboD91p1E1H5FRzxy6aO6wRqsyvHuwqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3434
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Update AMD cpu microcode for processor family 17h

Key Name        =3D AMD Microcode Signing Key (for signing microcode contai=
ner files only)
Key ID          =3D F328AE73
Key Fingerprint =3D FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

Signed-off-by: John Allen <john.allen@amd.com>
---
 WHENCE                                 |   2 +-
 amd-ucode/microcode_amd_fam17h.bin     | Bin 6476 -> 9700 bytes
 amd-ucode/microcode_amd_fam17h.bin.asc |  21 ++++++++-------------
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/WHENCE b/WHENCE
index 8a43386..1d1bb66 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3454,7 +3454,7 @@ Version: 2018-05-24
 File: amd-ucode/microcode_amd_fam16h.bin
 Version: 2014-10-28
 File: amd-ucode/microcode_amd_fam17h.bin
-Version: 2018-11-28
+Version: 2019-10-21
=20
 License: Redistributable. See LICENSE.amd-ucode for details
=20
diff --git a/amd-ucode/microcode_amd_fam17h.bin b/amd-ucode/microcode_amd_f=
am17h.bin
index 8ba3c612e10188a4572ce6b59fa754ceb58c5d0c..8e768d583bd67552aa52f2bf688=
1e9f59401291c 100644
GIT binary patch
delta 3116
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
W3WVG{R1GrGyFs6QeS`Gfmi`}4*p_kt

delta 842
zcmaFjea48(#n+Jm1PmA^N?EZ=3DC~z{VPmGkV@2mWMD|Pa;aITwOj=3D^WSZlAbOJ%Q<l
z^}67C|JkZ@TeFucUHGy2QTyi4zcmkEEMdB3T3Hp_bH%h*RA2gNcBkB5`GZ^HKC&ew
z%2sc^x^!3R2e&6?Ie)9BmS1^Txi9c~!-TYFe`jf^npcIpiHI`1ieI>{^qQBu{nIig
zzeT?%|9Mw`>_>yGOR&aYGqc9|9Y%51y9}q<CtQwp)>-{l{>R&w4<|M65J|aNa(RYj
z`NM9XjZ3z)xO%xAnADJSoa@ZbYniW?h6FD^BRIiAQ0imVWOHj-j%_akRl65)M(N&i
zJ7X9#_3-iyx2;)aSJsGj{X5sZ@yMg64<;^k>iQ$dqb&I1R3wxBrOkhMS(tRxg%~)x
zQjYL2rd{CquQ!=3D<NBJU7=3D`=3DpBpXxkZAJWr#?itwf=3D&HqX?p?WtXR@Jy-ed;>*2(b#
zy_-{56d5P;3iVGGVcWp?YjQ1{GLS43o;<mRJ!kR(A(hEI9J!MZ3Mo&X!%;GMhNuHj
zOm*{LQDvsdGq~-Tm{`DSdU!lk8QRrb8W!m9*w4<vpfHDNLE|(977?5L6#{G=3D3q*KQ
zDzrJ77`P{Ylu(|$g<D~AgM<bzBQQD}co-NY6cpIFCqLwot`BQAxnkRKT&S|sLg49M
z`;(R&0b!1pmgzm|<<2{>^vmXFfA82&VO6V*5u5(<YMvdFnDAGJ1e=3DnV$<NL6>;3O<
z7Z!Kz(9*lvx$Stl--&;RTi+;rkv4qwB9l#|X49So$;Dz}G9M*xWO}}GdahK{?<4rx
z)-mAG4fbntWh&~TaTWFLv!&b@wwJC~dAwt>UiB8O0I}z-#$Rs*Ys4|sb;X~vcABcY
zGBf<is^i<IOHbU#npnrx^ZLNq)RmV`rCx9rE?!djX<>QP=3D4lsfV!aFPujdzW1zlU2
zT5!^CP2tvdnP0NLF*lue?k^So&s5)GcF#e`_s-k1{_TsTp0Du#(=3DMEIj;ZV$I5ru%
zCo>ADvN13q$JXX}fwxSs7}{JYyp?hCJvq0@IijFw0!2w86H;_cJ|iK)iyrjZ0NA@@
Ag8%>k

diff --git a/amd-ucode/microcode_amd_fam17h.bin.asc b/amd-ucode/microcode_a=
md_fam17h.bin.asc
index 9822944..45c986d 100644
--- a/amd-ucode/microcode_amd_fam17h.bin.asc
+++ b/amd-ucode/microcode_amd_fam17h.bin.asc
@@ -1,16 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
=20
-iQIzBAABCgAdFiEE15J9K0GJJtx9xI6sDKS4vABH4PkFAlv/CfcACgkQDKS4vABH
-4PksAhAAmfYROlv/xzR1iPxbxPLo9Cz9rv3iYwqAw8WD4Uum5KJHvkdyvofFWnPF
-FdH/wB3F6BniA/HxKHw4NoyhiKSqTcSl/RgKPwoSOFxBBUQQZdlkl1w5ta1mwiCu
-iSDP2+pdbjZmAKhH+GDkixZiECz8J9+oR8SM+VsWI6DopTIymc9mQaOSLV0iPJgX
-tc8wAw+X9LkpnfSuLGyzg/jHzHa9KWl4ki13ii6h46bdavxVHY39JTCa/Bg2wSXE
-zM3JFuJdRJJZrJaxcou/USa8l6lZS38x6OgThh3Rqf6O3vlJEpS4HSLB2yqJoDEj
-GUvoiJTiZLPXM7NT3/t+/lSk2bOHG6h0KqIUda41ZdtksWThgCs+WZmepyXn4StY
-sOyYMzBP2EqvHaA/FnYeezq5fCHVVLel7SggT8HZg9eYqQO+6rnOcXzuM39v1wm/
-GM+M4KYzLiHi9+1nVO2MByik21+QMc3EjTxEzyWd95+VzAT2kxxlkZ5cD8cTAfnB
-ysFNrd1jSBK5MeYBmjUkjTL9xy71rZjGWI61XU5G66h6Vu2XryCkBq/vA35rLnZB
-GBxq6ZpxdSAD96fdHEJuAaNX0ZvcWyNhvzJHe1dOPmeMHB/+gw1j1j4cUGNhkZ6C
-okTEcOKwmfOs8soZmkdJvoi/cwzVjy1nvZSkasQ8NfIhOgHZdMw=3D
-=3DFqUC
+iQEzBAABCAAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAl2to1IACgkQ5L5TOfMo
+rnNaqQf/XL0XBls9ByaVm9uS/SCRTeazSBTByz+C1+rkqoq5iU/GjtREF/FjvpI+
+SsIHXe0u0FSZ9/uFK+TXuOMTuhqX8+QyidmB22yeFT07+5/6jljtX3/InAOYA286
+Op2tvBBfZAMBXoVbdg0mPQnY2ERhiRI7TIDtSWb/YzMYHW3zPdmNUPvGNV7apzWn
+P53Nyg+wriHYNwgXaOGtG2zsdaLWGyROgJP0U26wgwpnY7Yr5ZQBe7kqRkZQ5Cm9
+HajOGfaimt3azJnvxifCZZZGH5LHxUsyqnmmaBDlqDrrPo8rA37PLAyQPnOa209d
+lGjkfff2Ukhhv1I2WGrKarUGaBUXoQ=3D=3D
+=3DzbWl
 -----END PGP SIGNATURE-----
--=20
2.16.4

