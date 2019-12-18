Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90030C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585CB218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jJvnvaFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfLRO15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:27:57 -0500
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:6119
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727114AbfLRO14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:27:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQ/RSdHTK0HCXamHRtWzikk1gs8It2P2TtAtJWrkvd26P/Oghui/3i8z5xV4lQtLWjrGVFekJ0eFcd777C/cyacncBO2RnJ+/kuRc+4Z0XVdYNMwazteGfBU+TF2dn8jvR0ybGxmtuyqC5TDInfvxe25jrOxl+r9Z56YycVk0cyqj2FhhtTPNe8ffWGXU3HeMeP8zo8MdacnTgYDevuHFwEEgD8dq/nSZf3T1BKz8qBOtI8UChbsCxRCGzgQUvvCV6rx7nNNeJ0D9NJDkrGSLEKYJY/o/lj+jq+hGUia+4m+QrMeZpU/n4Lnwm18X60FwcIaYTwuuYJTse/SRRmQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob7CT/n46s+Uwz52JLJ3NLyUAslH/6Li4/HPVF6Rpcw=;
 b=Vb7VZ0Nh8npZ2ZDL5SXB0bLV9+8I/CbNdkXlMt0taCIWtEsM3Jj31pKOQdwsvVrkWzx66zLXQJ+vB+aeTcZ49bMEPSr353sa251uYle1QiSxp/yauhu0PMUBcQzVe/R+4hhnHgXJVsY80JaE5tiEjR0tjDnifbVHQlU+wqpsY7rOE1dhLW4siK/6ADuzhS9mJMfx4tBJhrKlCafLj0CSAqhDvVFYwFQqh8DOFWL5k8Xl9krD8IO3rfckYX6vlN6KPirobfw5qVA/A3IiGtqUUU1wEjfHNHRdrGUluCFIvCZ7MoJG49ybbq/yxkHkNV+cWjKQEn88JYuRjVoxVKdHNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob7CT/n46s+Uwz52JLJ3NLyUAslH/6Li4/HPVF6Rpcw=;
 b=jJvnvaFMZEj5f/tim3yWOdHF45II+4PfiNz+01yrm+XJMd2+PvgY69ctanDro7p9Ft3iaudt6EdnuNEsv/m0kLjquC4VOiUzFv0G9nMVhhAadqxdNMjklde87oWhjMeBIelGCbjSuh1b4W48LM+sq4o96yIl0jVNjIdYe0IQgqc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=John.Allen@amd.com; 
Received: from DM5PR12MB2423.namprd12.prod.outlook.com (52.132.140.158) by
 DM5PR12MB1338.namprd12.prod.outlook.com (10.168.235.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Wed, 18 Dec 2019 14:27:52 +0000
Received: from DM5PR12MB2423.namprd12.prod.outlook.com
 ([fe80::84ad:4e59:7686:d79c]) by DM5PR12MB2423.namprd12.prod.outlook.com
 ([fe80::84ad:4e59:7686:d79c%3]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 14:27:52 +0000
From:   John Allen <john.allen@amd.com>
To:     linux-firmware@kernel.org
Cc:     linux-kernel@vger.kernel.org, jwboyer@kernel.org,
        suravee.suthikulpanit@amd.com, John Allen <john.allen@amd.com>
Subject: [PATCH] linux-firmware: Update AMD cpu microcode
Date:   Wed, 18 Dec 2019 08:27:40 -0600
Message-Id: <20191218142740.20173-1-john.allen@amd.com>
X-Mailer: git-send-email 2.24.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:5:54::36) To DM5PR12MB2423.namprd12.prod.outlook.com
 (2603:10b6:4:b3::30)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b314dae-88da-4c34-8abe-08d783c6772f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1338:|DM5PR12MB1338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1338EC96073CEB9448CF215D9A530@DM5PR12MB1338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:13;
X-Forefront-PRVS: 0255DF69B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(36756003)(316002)(478600001)(8676002)(2616005)(6916009)(6666004)(81166006)(4326008)(2906002)(186003)(8936002)(81156014)(15650500001)(44832011)(52116002)(4001150100001)(66946007)(86362001)(66556008)(19627235002)(6486002)(6506007)(1076003)(26005)(66476007)(5660300002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1338;H:DM5PR12MB2423.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvXaHmJCkJo2AGQ/vTrmgmYqklF/FDxVSw2wEK4b2pPw0tCACJmOG8ojAUYwMLzNpHqs3VMxYp5roqBWkqfCDUqHi9ZZUvDJXLzXrmHV7ox05NWYMzmsjbcV/lbjKvQeN5xYxz/Chsa7+KFPQlz0Hkf+8rdDFU5kPlJud15Ir/wfHzaWpOgVQUHTzsXr5GfXqFqBScdlJu93g+ffF3IYlZeRPe0sf2zYy9VvRhmuyUGltSEhnEdGX+SnRYKvZjkr/bMtX/Ok6I2r8IHR1rum81B//zgcntvrGymYsc4vEfECsoaTz6BAkvCK2RAR6yz124QCs1rJ2gkuYvJ8rQQhO5qLBXnuQVo9pUQ/NBoe54/UwazHyOpg25GgWkDtJgJuwUaLBvUFcKiwBCgWKwH3NzwAvqyQozt1Vu2yDG4tSScweIZqdUX4lx6snLmrF+Xf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b314dae-88da-4c34-8abe-08d783c6772f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 14:27:52.4830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0C6HoT2+4fifPsjy+RUS9jr51kSGHM4KPkjbYICfhB6rYGYKP2tY5gTUCc2/zE3txKAb7FItxW9JczcmXuPWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Update AMD cpu microcode for processor family 17h

Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
Key ID          = F328AE73
Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

Signed-off-by: John Allen <john.allen@amd.com>
---
 WHENCE                                 |   2 +-
 amd-ucode/microcode_amd_fam17h.bin     | Bin 9700 -> 6476 bytes
 amd-ucode/microcode_amd_fam17h.bin.asc |  16 ++++++++--------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/WHENCE b/WHENCE
index b84e706..9389aaa 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3490,7 +3490,7 @@ Version: 2018-05-24
 File: amd-ucode/microcode_amd_fam16h.bin
 Version: 2014-10-28
 File: amd-ucode/microcode_amd_fam17h.bin
-Version: 2019-10-21
+Version: 2019-12-18
 
 License: Redistributable. See LICENSE.amd-ucode for details
 
diff --git a/amd-ucode/microcode_amd_fam17h.bin b/amd-ucode/microcode_amd_fam17h.bin
index 8e768d583bd67552aa52f2bf6881e9f59401291c..259560b22abaa670cd08db36f23b8cbd20f3efaf 100644
GIT binary patch
delta 19
YcmaFjea48(#n+Jm1PmB9N;yda05<~!U;qFB

delta 2056
zcmZuy3v5$m6h6JZE4SM%cHQlz8+X~?ty`~4*^6SU^0?rTF*fK3$QWP;qJ}6IB{4S!
zX_3k+705bdCf7I!!v!2pUM@;_4$(-6AqtX^DG!6u6_i(SGVuJjEg_3HX;1He&i|k9
z|IT+#Pgh-?mRDUr5$L1f$NI!-`cr?btG~#clp8kSON0l=CE3G@trZ*_(Y=qptf?Jq
ze#pt(x;$7`*0KAUj00Wgmu;AS?DnFrj;5MXFZI5@)P1MRH)_kh_wob(%zNiMp>9*w
z$*VKYe{iwQ;JCj1sp^5YE5BE*UEq6r5r1=+mc2f_vL)9!f<KuVKHIeFT+yXx69;Ct
z9BMdNzG;6!>q2v7_{9AeFSPt^zB{<H=D42>&p$AmyW{(}Z`76BU)u*01Bp*cj4S*1
zzkKAC(8$R@<=u)69`7qYJmXH@Win=O+&13w{2OPqEZ>qhx7GU&iKE57?{_I@s}sE=
z$1iy8pm^&ek8g6%_Qee)iP8sUt7;VA+@1B8PCt3BxO3*Iv3*SyEmcPnMPKf5FJIR1
z*X5@#IKQ17nlrGk-@-B;%F&rur)3V_Ji_05>o78hk5bFm?;V$^ENL*`+db8Ma5TWX
z%f8~{PHR~hVDO=ng;=@6@PGk93aD1#h#(Oa9Hd?Jgyd`1?Z5%&1xtxqXyicA4DDtE
z=N0(Hs)5GFn$#jAgL#@OMc(BHASSytfEFJO6Qu0*0)|B_mGH6be^@+xzMXGWAq>g_
zk(VC@uNc8V#K?VSmt++WA`z*~k4fY)v04?@y4j4nK-)k813z=bBa97o0_P+^Le{%m
z2rJ?{0<93GAOce`EpZ|^JX_H%0dBt_x#+ph2+f(pz!Zu|j8#?OVucth_0uGFPpC7U
zlnQX2k@JWM2$OcxB$(7olcGz%A+gVle{L(Tp&;x@5V9RX(D#h_fi?ss+qFjZJ_6TS
zdOY7Fkj*+s12jWC;HZiBXBEd2S+3NlC~N{QBJcr<-Ua+Z0xXFNu8>^2#vNs=18vs|
z3gOR!R1ErX&5>bD?@0ostO%`yWf4>raI7E|sd;GaXmysPpnncSK|+V1H6n9_c%@pj
z;O!95`RRvvuzn+4Qn;vBs-u9G<f9L5B5Bcwb)R6Ki>x@q<IFbJ`o5bLkX4ihiD2EI
zGjl*RrX3^o*okHaFeVCJr02(|JDQ4h(b(x2+pHPeX(a$Tk7;xA)(tCR>rR_CKn}oB
z%{hs>XwHixD0*UyX|=hy5{YS3!nr24BwE*N+OUysLi>xIVKztIx?V82TjU%4nXM#B
zOJ_h!b#)ANh`wsd^zp64OMNVGI-q<Cber6hm7&LAB^DBcYj{-DN>y4Fs0%nK9tvoM
zfnf~sZX2mv>70x5k4%ij8vTo{sp~tGVh*Dxa9nl7BBN>nELkZZwwj&R8)J|TIenrf
z%cct?d;_~u55OLzy?F&yHk+TSLM!Qn`2oibR2%J2>iczwk4dfToTdcDu1)fedv*wX
zP`!ZHWR*bMA2u7{nJ%P77HPldm#Ao+M9>OpG8YQMaV=;@fMkadll?WQNTs>3Cw|l>
z6nRi?dZRKXoGL+;DgdRW(sin&(riXoNzl%)RLY_&)JYEzNT{<>kX;drts7D@*3mwO
zWR_H-(pb3U>Y>PHNrh@Z?XeUn9S~pUHyJrBoUAqqNUg-QCvOc^BB!gCh4tlOe*w}d
zBHt5mg1mq<(x9tDXfvj0`z^Je0;JRZ&5&}O_@9_`IgSoF*8sHu>6-Koai){fWG9FC
z@P=%}f;Y_OJRq6dP1#9tJT^TF*e-@)sRYA&@CThqrsPbj5U~yljum?Cr6_#5zE42@
z*16kp&dKRmoLL4@3XDYnx~S=l!eN^HmjI~5f$PUTUfl0U&%9GOTsLEFXyX8j16?c6
R!BLSsAZ_Puj8Ave{s+WP{n-Ej

diff --git a/amd-ucode/microcode_amd_fam17h.bin.asc b/amd-ucode/microcode_amd_fam17h.bin.asc
index 45c986d..dfa782d 100644
--- a/amd-ucode/microcode_amd_fam17h.bin.asc
+++ b/amd-ucode/microcode_amd_fam17h.bin.asc
@@ -1,11 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
 
-iQEzBAABCAAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAl2to1IACgkQ5L5TOfMo
-rnNaqQf/XL0XBls9ByaVm9uS/SCRTeazSBTByz+C1+rkqoq5iU/GjtREF/FjvpI+
-SsIHXe0u0FSZ9/uFK+TXuOMTuhqX8+QyidmB22yeFT07+5/6jljtX3/InAOYA286
-Op2tvBBfZAMBXoVbdg0mPQnY2ERhiRI7TIDtSWb/YzMYHW3zPdmNUPvGNV7apzWn
-P53Nyg+wriHYNwgXaOGtG2zsdaLWGyROgJP0U26wgwpnY7Yr5ZQBe7kqRkZQ5Cm9
-HajOGfaimt3azJnvxifCZZZGH5LHxUsyqnmmaBDlqDrrPo8rA37PLAyQPnOa209d
-lGjkfff2Ukhhv1I2WGrKarUGaBUXoQ==
-=zbWl
+iQEzBAABCAAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAl35JHMACgkQ5L5TOfMo
+rnMUEAgAkjo5AlcQNp42b/JCJFYxVn9iaPsLrJ83yfDceMn4su30oErnlyXf8sYR
+vphA+qkowfcpT2ZUngMxxywW6mRnvErx2RfT7UM1kRjDnLcJPHWu3e4gBg/fcsxF
+D0H7FkZkSo/bRo0O04TeujNawvL7rTvwIgPHXVQ3n0IkLLRvyz8R5B4oxiybOm7D
+hW08eshMgsBPNypbgO3rtsDwrM3Md/qoIC55wnrqI7N0Qul3oe+ORNx4PdcWYcey
+yfpjAaiYEot24WIWLBzd95lzCircEuPfL12gxKE7MwwHD/8mjj8R7aB/J/oKSSyU
+o3ffWPN+V+9nqKGlJlVrbAYz/6kucA==
+=Z0EC
 -----END PGP SIGNATURE-----
-- 
2.24.0

