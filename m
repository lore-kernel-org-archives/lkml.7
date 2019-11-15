Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D71C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9441D20723
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="yev1EJra";
	dkim=pass (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="aShAzNvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKOAnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:43:46 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:31768 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbfKOAnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:43:46 -0500
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAF0PMlh003090
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 19:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=7K2Hwm+ukVd95TsONa0rVDgU+xWhef+xYqvwlN6u/BQ=;
 b=yev1EJraseURJXmLucK5oHbCpfUXrQZxCw1uegZwJRIw/0kuZvqtLXf+XwBl15p7Psm/
 +wGMrjwMaV4/MUShWs71y8OPsCYKNRUF3v7FE2rTo5bNOOChOXLFp7UEBcoonO1/aPSZ
 U9xK6TDJ+idS8HVe/SOqoOdm2n2S1nOSFdsvRrW7gtMMFWybCRRvaW8hNo0isUNCAhjN
 2WLU5nO8bkzl1DbDOaNdIWh2Lav31oXDITd2quRgcTfC+V6J7PM+wZav6EJw986OB4+I
 BW7j75KgrpYZOgDvcxobu1KIgrsXiUL7ohVkC0spfIs39Sns7jTy4j4lFADjtqiM2aZG jg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2w7pqhy4up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 19:43:45 -0500
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAF0SFCg039504
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 19:43:44 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2051.outbound.protection.outlook.com [104.47.36.51])
        by mx0a-00154901.pphosted.com with ESMTP id 2w7qa383a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 19:43:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIgNjHIF0JuBd2VDN9txrEimYLM0y5P99iSPIyrtYzW2V93ymShekY93PvsGJUeny5LpspVGEUhLIKufpM7hGuyfs+Cx7ApsIm/iW6CjK1bRIpnFKkZN5OkV7udbQ4QGf70MjFrB9wuvvfzA+WS7gSbO/bwm9mmkosZ++5FlEKurYBlG8TZMVx4s7/JrJ6voT7nYy9NXYX/QOBm2ovLJUXTb440G9PE1jkY8RYDpWoGYkMy0Ig5S0OsKdgv6A6QCg/SihgioiQ0kFF6YEuabDWEVpHDGNAzwYKBgr4BGbdaAyra+WoIt+E/FTg4y0xmPfoDZohY2Nbd1Gsmjuz3QmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7K2Hwm+ukVd95TsONa0rVDgU+xWhef+xYqvwlN6u/BQ=;
 b=aLJplWDwZ9DWv8W8dxsSKM+awS+eFsFTzHMhHuS2KI53W5F3dC3NNiINHwBydtHYZTn57CeAJs40fhI0p7YdnUP30SSLJWzca4IWxYvtiN6u6+O1pJPIyzIbxtq8gZ0V05YmfGu9aXuwWEleKVhZIf6Y53zlclJJXCFhXUX8wQj36wRpnU8+fPNlmIep95e396gbJT5vONBHlSEAC74af+Quajg15UcPlhZPK6ZY2aJv18dmkp+kTVfdcYJ0UOm9tZXx9fTTuIDEkQ8+S22c745LzBFgcmXJvDN3khGtlBR3FPBQN6XsR9Bjp1JhTvVenLpn2oX7oqWLrDofUF+q2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7K2Hwm+ukVd95TsONa0rVDgU+xWhef+xYqvwlN6u/BQ=;
 b=aShAzNvAUOm/Q90JdoK4bjjb4MfM4HvY36ddCZcjtvSa9ufuaFMjReIa8Y7c/Bl8VHLSRVx+uPfElgrtcEgxJvIcTkxqo9cLgemiXZIrTYZdjCUXtVBjfa9sS7IqWvK/wznUelrTRT0lXy+F8w6tqXDWkzeMgMRGaQKSR4L/fqA=
Received: from CH2PR19MB3896.namprd19.prod.outlook.com (20.180.12.148) by
 CH2PR19MB3718.namprd19.prod.outlook.com (10.186.149.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 00:43:42 +0000
Received: from CH2PR19MB3896.namprd19.prod.outlook.com
 ([fe80::c039:fad0:386:9711]) by CH2PR19MB3896.namprd19.prod.outlook.com
 ([fe80::c039:fad0:386:9711%6]) with mapi id 15.20.2451.023; Fri, 15 Nov 2019
 00:43:42 +0000
From:   "Rafikov, Rustem" <Rustem.Rafikov@dell.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RT scheduler is suboptimal when an RT thread preempts another RT in
 terms of choosing a core to migrate
Thread-Topic: RT scheduler is suboptimal when an RT thread preempts another RT
 in terms of choosing a core to migrate
Thread-Index: AdWbTZf+ewnEn7UbRpSKG3VAENnpaA==
Date:   Fri, 15 Nov 2019 00:43:42 +0000
Message-ID: <CH2PR19MB3896AFE1D13AD88A17160860FC700@CH2PR19MB3896.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Rustem.Rafikov@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-11-14T22:03:25.7098256Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-originating-ip: [168.159.213.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b726d30-89e0-47b8-b6f5-08d76964dd61
x-ms-traffictypediagnostic: CH2PR19MB3718:
x-microsoft-antispam-prvs: <CH2PR19MB3718A964ED8033B453D63552FC700@CH2PR19MB3718.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(376002)(396003)(39860400002)(7502003)(199004)(189003)(66066001)(6436002)(786003)(25786009)(99286004)(52536014)(316002)(33656002)(66556008)(66476007)(71190400001)(64756008)(2501003)(66446008)(71200400001)(6916009)(26005)(3846002)(6116002)(2351001)(256004)(186003)(14444005)(5640700003)(7696005)(55016002)(76116006)(81156014)(478600001)(7736002)(9686003)(102836004)(6506007)(81166006)(5660300002)(486006)(476003)(2906002)(86362001)(8936002)(14454004)(74316002)(8676002)(305945005)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR19MB3718;H:CH2PR19MB3896.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: dell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jzTG6pzE8KkiCgXPD/X925Cf+6STYbhVEMlg2lsjRbzvldFcyQibddrAcZUjWsW/W0Y61Lo2EVT/u6OH/PEIBMYdGqYwJu/rZWyymjcvWWjnKw8+FGGNSZ2BEtb7fbauxW/8phDeW0MS9d6FZXFKEyVRPcJk6+gZ89m0ZJ8mSKdQitoIOcS3A1WxZ7teHcYPSdxW79IVbUVKaB73o2zhtC/sNDuUTaCwcoaJerLL11KOQOjpEgD5uE4XdQiLJxvk+YM4emT6uIrxxVsd0Cv40sB2LTuTEDxVMahWmbTHtO7SCN1dF4qkS8iWGantm4X3uqTHH5uyo0iajAgAeGOm8zVgMM6XmL5bQiG9fGsX57wUws66DQP4L2wliOOsmKbjj1Lt2GM2aICGJLxcwPC5ZrP+0u4FQl/PtTdSngeHqzyIEfl8ZwjGgc0cDrE2A7Ty
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b726d30-89e0-47b8-b6f5-08d76964dd61
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 00:43:42.7312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8iqliJdBZAR2MG1T7txNm8cib3Ew+xegStO2c91qvVNzcTXLHFGCDM93OfnXkQejc+9N3/8/gKE/5cC4WZn4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3718
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-14_07:2019-11-14,2019-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911150001
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911150001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When an RT thread preempts another RT thread it migrates the latter one to =
a core.=20
The way RT scheduler chooses a core is quite suboptimal. Let me give an exa=
mple from a "production" server with 32 total physical cores.
There are SCHED_NORMAL threads (affined to particular core each) and 2+ gro=
ups of RT threads (allowed to run everywhere).=20
Scheduler trace showed that most cases RT scheduler preempts a normal prio =
thread from a core to put evicted RT one on rather than using an idle core =
the system had a plenty of which according the trace.

I reproduced the behavior on a vanilla 4.18.0 kernel with a micro test wher=
e I created 10 SCHED_NORMAL affined to 10 cores,
3 RT/69 with 0xFFFFFFFF affinity and a few RT/79 threads kicking off other =
RTs from CPUs every 5 msec.=20
Other cores were idle but RT/69 never migrated to them.

The problem seems to be in how mapping in cpupri structure is updated:
1) Fair scheduler does not update/read from there. So we don't know if a SC=
HED_NORMAL left a cpu. Well, that may be OK.
2) RT scheduler uses cpupri to find a core to migrate to, but it updates it=
 incorrectly:
- RT->RT works fine [2]
- But RT->IDLE or RT->SCHED_NORMAL [1] is not right - in both cases it sets=
 RT_MAX(100) which is min NORMAL!
It's totally okay to set it to RT_MAX for all of NORMALs but not for IDLE. =
BTW - IDLE means swapper which has pri=3D120 :)

See below traced with kprobes.

[1] IDLE->RT/79->IDLE
#1. <idle>-0     [001] d.h. 14717592.107294: myprobe3: (cpupri_set+0x0/0x10=
0) cpu=3D1 newp=3D14 oldpri=3D0001
#2. <...>-157332 [001] d... 14717592.107313: myprobe3: (cpupri_set+0x0/0x10=
0) cpu=3D1 newp=3D64 oldpri=3D0051

Decoding the output at #1 cpu=3D1 newp=3D14 oldpri=3D0001
- cpu =3D 1 - it happens on core 1
- newp=3D14 - the priority of a thread being scheduled in is 0x14 which is =
RT-79 (our test thread)
- oldpri=3D0001 - a priority of previous thread on that CPU. "1" means NORM=
AL in 0-101 scale. This is incorrect by itself because the core was IDLE!
Let's try to figure out why it is not '0' (IDLE) by looking at the last lin=
e - cpu=3D1 newp=3D64 oldpri=3D0051
- newp=3D64 says that the priority of a thread being scheduled in is 0x64 w=
hich min NORMAL. So, it is not 140 how we could expect when switching to ID=
LE thread.
- oldpri=3D0051 this is 81 - priority of our RT-79 thread in 0-101 scale


[2] RT/69->RT/79>RT/69
#1. <...>-158253 [001] d.h. 14723119.396120: myprobe3: (cpupri_set+0x0/0x10=
0) cpu=3D1 newp=3D14 oldpri=3D0047 #2. <...>-158254 [001] d... 14723119.396=
122: myprobe3: (cpupri_set+0x0/0x100) cpu=3D1 newp=3D1e oldpri=3D0051 Line =
#1 -  "cpu=3D1 newp=3D14 oldpri=3D0047"  switching to 0x14, RT-79 thread
- old pri currently on cpu is 0x47 in 0-101 scale OR RT-69
Line#2 - switching to 0x1e - RT-69. This is correct value of the thread bei=
ng scheduled in!
- oldppri=3D0051 - RT-69 in 0-101 scale

Thanks,
Rustem


