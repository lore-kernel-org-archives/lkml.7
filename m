Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994BFCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65405214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rwZRJ9M7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404874AbfJWLbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:31:41 -0400
Received: from mail-eopbgr790080.outbound.protection.outlook.com ([40.107.79.80]:7197
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404629AbfJWLbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:31:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzceXT5IDntUwCiexMVTeTYsfd4jw1cKosPpyQSnushwkweuN9lJFKyCilYk9rPADlVtSIuKF8Hm2GKj/ljGKt4BdixvQx2ZDqfxUzBVFPuKmZr5Izdikt+8v0e2a5vpyBSISSeUtJ1p19N4XkmyOE4QCyaQFAM/dbDKIocojf1w9DqJJVYF/G6YCgfvifNOtnSfZNlpGp8cotnV6+YqX069hpDowQMM2N1Pvxtov/Hx29hNSCMYuucgIuqafGjD9NfN0IjcCW/RlfImi3s0Hnn8z/g5FuV57SPMIfnzRRm7EJudPzScuLl4ayaQVv+8LjaZ+iQFewaA1c1Ai16o5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iII33pjC9/NvItuQ+k2S+WSqWZdl5ivFLLg0CNCL3kI=;
 b=EIhUMq5p368hJq7ibE32dnIrLwwCp5acsnMNJdERwBB0Np9c+9u0QN3IegP8kOzbws+XdwRAXsaYDEQj2O9/v9yNakGOhptH/jvSbjxJlcDtbwXBOf/5MryvwE4Xi0+jKlX26ZWmUdo249yPhu16dGdcgHFkSv/Zz+ZySsHWBUUrJvNMX3edNj2MUcw+akdgVbyMn5B2z2mfK8jfiEys6Hsh1a9DScPm0oIJ1mNsk4QXPHgAv5ssDXlhFjxziD5yrK1EaOI7npb3pU6h7jAX3x20dbNRn3tJc5qjMPLg1JDzUWSRphrO0qX005FLcLet9GVuGAMcioW49Pj6s4CYrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iII33pjC9/NvItuQ+k2S+WSqWZdl5ivFLLg0CNCL3kI=;
 b=rwZRJ9M7CDPJSciudjeq1z15BresWJZKuNG3tQUgUj8x8vRLU+xnLwP7M6WTbrex5yM6b3uRJct5W8SA5t/vPru63kgL5deUXVqG2kRT0r3++6xqHk1hAtgABcUKvQnkatV60BqCPLPs6TJSP+TOzY38GowcWv9UtXZeoRAA6Nc=
Received: from CY4PR12MB1925.namprd12.prod.outlook.com (10.175.62.7) by
 CY4PR12MB1527.namprd12.prod.outlook.com (10.172.66.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Wed, 23 Oct 2019 11:30:56 +0000
Received: from CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::a1f5:6f09:5c0d:78f1]) by CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::a1f5:6f09:5c0d:78f1%11]) with mapi id 15.20.2387.019; Wed, 23 Oct
 2019 11:30:56 +0000
From:   "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        "tee-dev@lists.linaro.org" <tee-dev@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>,
        "Easow, Nimesh" <Nimesh.Easow@amd.com>,
        "Rangasamy, Devaraj" <Devaraj.Rangasamy@amd.com>
Subject: [RFC PATCH 0/2] TEE driver for AMD APUs
Thread-Topic: [RFC PATCH 0/2] TEE driver for AMD APUs
Thread-Index: AQHViZVVYVl2QH7mgE6B2GtVoWnwDg==
Date:   Wed, 23 Oct 2019 11:30:56 +0000
Message-ID: <cover.1571818136.git.Rijo-john.Thomas@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::35) To CY4PR12MB1925.namprd12.prod.outlook.com
 (2603:10b6:903:120::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 423461b2-13c6-433d-fe00-08d757ac783a
x-ms-traffictypediagnostic: CY4PR12MB1527:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1527EE8B4E152D79F0FE9E95CF6B0@CY4PR12MB1527.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(189003)(199004)(99286004)(6306002)(71200400001)(6512007)(25786009)(71190400001)(66946007)(50226002)(3846002)(6116002)(6436002)(316002)(478600001)(66066001)(52116002)(2201001)(66476007)(66556008)(64756008)(2501003)(36756003)(4326008)(66446008)(966005)(54906003)(110136005)(8676002)(486006)(8936002)(256004)(14444005)(2906002)(6506007)(6486002)(386003)(81156014)(14454004)(476003)(2616005)(5660300002)(305945005)(86362001)(102836004)(7736002)(186003)(81166006)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1527;H:CY4PR12MB1925.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e7Q6yeiPVbWBSkNwZTSQv9raI3ZUQhAtuNsvjP+cGas/nQKVJpDQV3l77nhS/ZHc9DlrVKoN66uxhoirWW+aqSkOAjb+pUlV0npv96tlGNLCaARu+Bc1Nwr7Xelcx7OWgJDsEZ80r8w9GtYjfZ3RyekUC5w1Z14QRLUeUfLa1Ao53sOIx3wZdS00CPG+DO3f7zKgb1OWw9dE16a09h4qAh5CC4n0TCrZUWJ5eSemsrd+ZE31q5p1Uz8JncpE65kDAeCQy6rPacFUbC5c7TgCfvT8BiMzmK9fZyYtWc5WQ93Tx+kZRkNUPpmUD/kjf0Pv9hZaIHn5Tdj6naIsH9pW+IaAhpSsO/mPoLfVJVlaowVVD2obR1QObo+iM3+NsG4WVYcAc8q4yFckmQ8l5SFZFugAKD0FcL9ldn82ztCYF/QJIo9pyzipliwuz2XY5kbYyiJhSPa5yBFLozH/uJTM2WUWK6TL4cR/sNgAsjS/6Hs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423461b2-13c6-433d-fe00-08d757ac783a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 11:30:56.3276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KnJmKNWUSaCIXQV3L81A2tp/XBhl8+LEec+mic33no/Tf5J+damGuc55Z9/R8do+KJPXS1qJgf5BR+aQBLkhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1527
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces Trusted Execution Environment (TEE) driver
for AMD APU enabled systems. The TEE is a secure area of a processor which
ensures that sensitive data is stored, processed and protected in an
isolated and trusted environment. The AMD Secure Processor is a dedicated
processor which provides TEE to enable HW platform security. It offers
protection against software attacks generated in Rich Operating
System (Rich OS) such as Linux running on x86. The AMD-TEE Trusted OS
running on AMD Secure Processor allows loading and execution of security
sensitive applications called Trusted Applications (TAs). An example of
a TA would be a DRM (Digital Rights Management) TA written to enforce
content protection.

Linux already provides a tee subsystem, which is described in [1]. The tee
subsystem provides a generic TEE ioctl interface which can be used by user
space to talk to a TEE driver. AMD-TEE driver registers with tee subsystem
and implements tee function callbacks in an AMD platform specific manner.

The following TEE commands are recognized by AMD-TEE Trusted OS:
1. TEE_CMD_ID_LOAD_TA : Load Trusted Application (TA) binary into TEE
   environment
2. TEE_CMD_ID_UNLOAD_TA : Unload TA binary from TEE environment
3. TEE_CMD_ID_OPEN_SESSION : Open session with loaded TA
4. TEE_CMD_ID_CLOSE_SESSION : Close session with loaded TA
5. TEE_CMD_ID_INVOKE_CMD : Invoke a command with loaded TA
6. TEE_CMD_ID_MAP_SHARED_MEM : Map shared memory
7. TEE_CMD_ID_UNMAP_SHARED_MEM : Unmap shared memory

Each command has its own payload format. The AMD-TEE driver creates a
command buffer payload for submission to AMD-TEE Trusted OS.

This patch series has a dependency on another patch set titled - Add TEE
interface support to AMD Secure Processor driver.

[1] https://www.kernel.org/doc/Documentation/tee.txt

Rijo Thomas (2):
  tee: allow compilation of tee subsystem for AMD CPUs
  tee: add AMD-TEE driver

 drivers/tee/Kconfig                 |   4 +-
 drivers/tee/Makefile                |   1 +
 drivers/tee/amdtee/Kconfig          |   8 +
 drivers/tee/amdtee/Makefile         |   5 +
 drivers/tee/amdtee/amdtee_if.h      | 183 +++++++++++++
 drivers/tee/amdtee/amdtee_private.h | 159 +++++++++++
 drivers/tee/amdtee/call.c           | 370 ++++++++++++++++++++++++++
 drivers/tee/amdtee/core.c           | 510 ++++++++++++++++++++++++++++++++=
++++
 drivers/tee/amdtee/shm_pool.c       | 130 +++++++++
 include/uapi/linux/tee.h            |   1 +
 10 files changed, 1369 insertions(+), 2 deletions(-)
 create mode 100644 drivers/tee/amdtee/Kconfig
 create mode 100644 drivers/tee/amdtee/Makefile
 create mode 100644 drivers/tee/amdtee/amdtee_if.h
 create mode 100644 drivers/tee/amdtee/amdtee_private.h
 create mode 100644 drivers/tee/amdtee/call.c
 create mode 100644 drivers/tee/amdtee/core.c
 create mode 100644 drivers/tee/amdtee/shm_pool.c

--=20
1.9.1

