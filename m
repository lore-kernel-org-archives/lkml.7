Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05243C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 05:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BB220989
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 05:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=HCL.COM header.i=@HCL.COM header.b="Mt+JVMdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfHLFdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 01:33:45 -0400
Received: from mail-eopbgr1310129.outbound.protection.outlook.com ([40.107.131.129]:45632
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbfHLFdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 01:33:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTI1X99RPcWxCsVnE+N3TQ6mbwx254bhVeegik2bfhKW3IM86Kmo87AxvYJnG/IKK8HEO9eUb9mPOliZtH/ucBm1H4GV0K4+Q0i6mm4TTNACZ6O/aO5c+dZ1bXoKA5YzPAqb4h5o+uUyeLBQMcfeeGb3AdK6JtrfZ/hE+uHB+3VXMXE/F1iYsMZkdR9M5j/FYy3pEP0mRbazy8IDheu8M15Zoe4Mfa17OqnqjNcWBpdeL2ixEe38594xk8j02KnD+GIJwBT76ldPwgBPoE0xB2I16yRViI7xleiGl6Fj0JKpF1WcJ94Zs7spb4rnAv+BBwqBadg8FLGTd8xNpUHgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glVgD9MDCVOe8KBg2J7DlDzOSVrKaJp9XDF51aZ4jwE=;
 b=a8suO6KSAgRo+zJ9ZrCgSS8Lv8DRKhda5ossrbVhUoLvoZ5MH7A+mjC+AtjT+MiY7wGhu01u1ffdlwAR/W9MW82Anjuz4Wjszv31XYwZkAiJCCjhGNFOkGKm17Pc25kIrTxwhus+33vr/OrXWwXWTQo13KnSmO9VMzyAV3+h0WxHF9MkjKJlGIWQ2Z85KrAo1adNSux6Q3sz/M0QRpUNVhiepmV6LOcThgQwUjw4VYByjyHPpY+g1iFh7RYOReNoEdbB7SYvwmT3XuBbNz4Cl6rirmWZqlmP0zJk3ws9UyW2+ZOngW9jl6MYKdyXWNhmigBmZ0ED05YywtE4H5qHig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hcl.com; dmarc=pass action=none header.from=hcl.com; dkim=pass
 header.d=hcl.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HCL.COM; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glVgD9MDCVOe8KBg2J7DlDzOSVrKaJp9XDF51aZ4jwE=;
 b=Mt+JVMdgPvnQn/jyu9u/4sJO/DZmA3Pqg7jAlb/UjCML+iA6NIxU7vz6YEuoDFPuH4WCoOhyXOz1EFY6+1dmeav2taMWx8rpj6Y7rtQ9t2QWNHN4COncoFhH4JX0MSdLdSg9ytpVJZQGY9FiCMSWIhiL+cgB2jnob4xlNuqIXV0=
Received: from HK0PR04MB2401.apcprd04.prod.outlook.com (52.133.146.15) by
 HK0PR04MB2579.apcprd04.prod.outlook.com (20.177.27.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Mon, 12 Aug 2019 05:31:44 +0000
Received: from HK0PR04MB2401.apcprd04.prod.outlook.com
 ([fe80::3c6c:9aba:c7b7:acd1]) by HK0PR04MB2401.apcprd04.prod.outlook.com
 ([fe80::3c6c:9aba:c7b7:acd1%5]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 05:31:43 +0000
From:   Satendra Singh Thakur <satendrasingh.thakur@hcl.com>
CC:     Satendra Singh Thakur <satendrasingh.thakur@hcl.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] [semaphore] Removed redundant code from semaphore's down
 family of function
Thread-Topic: [PATCH] [semaphore] Removed redundant code from semaphore's down
 family of function
Thread-Index: AQHVUM85D3zWCbPyIUK0rIeZXRj4NA==
Date:   Mon, 12 Aug 2019 05:31:43 +0000
Message-ID: <20190812053014.27743-1-satendrasingh.thakur@hcl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::14) To HK0PR04MB2401.apcprd04.prod.outlook.com
 (2603:1096:203:4c::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=satendrasingh.thakur@hcl.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [103.82.150.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 072bdd81-59a3-4243-d0a1-08d71ee65c4c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:HK0PR04MB2579;
x-ms-traffictypediagnostic: HK0PR04MB2579:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR04MB257916A69F9EC3CE3DD5B5628CD30@HK0PR04MB2579.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(38564003)(199004)(189003)(66476007)(66556008)(64756008)(36756003)(2616005)(2906002)(5660300002)(486006)(66446008)(476003)(50226002)(66946007)(8936002)(81156014)(81166006)(1076003)(7736002)(305945005)(66066001)(3846002)(6116002)(25786009)(8676002)(1671002)(54906003)(5024004)(14444005)(4326008)(59246006)(316002)(71200400001)(71190400001)(256004)(109986005)(186003)(6486002)(53936002)(478600001)(99286004)(26005)(6506007)(52116002)(86362001)(386003)(102836004)(6512007)(6436002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0PR04MB2579;H:HK0PR04MB2401.apcprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hcl.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZsNyPLi9n51MTAOGxmGFEN5p+QBjYniI/6ubVVgP8bHQETKttuc4Ubq5YM7POWB1n0IMlbABbCOWsT7XPDZquHH8/sbcdveFdvKuRStubdGI2vqE9IcyivM//JQesY4+mZm3Eg42kbXqJtrejCUwScFxqjxZLeaT4B9QZj9nEK2TeTm2u2oAWHAEsh4KbKQYWvVqAIa9s9zPLKulBIVbsLqWySdg+sxcWUYboQG4kfgy0Lq0Nbd1dE9l6JPjjEJaZKJIDUwQkvmdMu0qZMM5FBiqmwC8Xwq3QQkN3MTUwEiQlHZCcWSRcPrQF2pqtJHQiOQC6SSfV+KlFYzBYAGE3LnPJpW8ashFDGP3MAcQ6Gvgud3Y+UpymNMJksHevihm/dM+aSmWvimDKXsKxwX+1hUbhEZ6FnJOv1d1G6HZRmo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: HCL.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 072bdd81-59a3-4243-d0a1-08d71ee65c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 05:31:43.8102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 189de737-c93a-4f5a-8b68-6f4ca9941912
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFywcBbxQSrOpONv8qq+vEs1vPW8L4/+7WKvUohscIuxOapcdnpXrRyKrASfSrLFtS6woU+RunR+fxPawFLEZYDTDkpZjobe2oDQBw6sv8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2579
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-The semaphore code has four funcs
down,
down_interruptible,
down_killable,
down_timeout
-These four funcs have almost similar code except that
they all call lower level function __down_xyz.
-This lower level func in-turn call inline func
__down_common with appropriate arguments.
-This patch creates a common macro for above family of funcs
so that duplicate code is eliminated.
-Also, __down_common has been made noinline so that code is
functionally similar to previous one
-For example, earlier down_killable would call __down_killable
, which in-turn would call inline func __down_common
Now, down_killable calls noinline __down_common directly
through a macro
-The funcs __down_interruptible, __down_killable etc have been
removed as they were just wrapper to __down_common

Signed-off-by: Satendra Singh Thakur <satendrasingh.thakur@hcl.com>
---
 kernel/locking/semaphore.c | 107 +++++++++++++------------------------
 1 file changed, 38 insertions(+), 69 deletions(-)

diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index d9dd94defc0a..0468bc335908 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -33,11 +33,33 @@
 #include <linux/spinlock.h>
 #include <linux/ftrace.h>

-static noinline void __down(struct semaphore *sem);
-static noinline int __down_interruptible(struct semaphore *sem);
-static noinline int __down_killable(struct semaphore *sem);
-static noinline int __down_timeout(struct semaphore *sem, long timeout);
+static noinline int __sched __down_common(struct semaphore *sem, long stat=
e,
+long timeout);
 static noinline void __up(struct semaphore *sem);
+/**
+ * down_common - acquire the semaphore
+ * @sem: the semaphore to be acquired
+ * @state: new state of the task
+ * @timeout: either MAX_SCHEDULE_TIMEOUT or actual specified
+ * timeout
+ * Acquires the semaphore. If no more tasks are allowed to
+ * acquire the semaphore, calling this macro will put the task
+ * to sleep until the semaphore is released.
+ *
+ * This internally calls another func __down_common.
+ */
+#define down_common(sem, state, timeout)\
+({\
+int ret =3D 0;\
+unsigned long flags;\
+raw_spin_lock_irqsave(&(sem)->lock, flags);\
+if (likely((sem)->count > 0))\
+(sem)->count--;\
+else\
+ret =3D __down_common(sem, state, timeout);\
+raw_spin_unlock_irqrestore(&(sem)->lock, flags);\
+ret;\
+})

 /**
  * down - acquire the semaphore
@@ -52,14 +74,7 @@ static noinline void __up(struct semaphore *sem);
  */
 void down(struct semaphore *sem)
 {
-unsigned long flags;
-
-raw_spin_lock_irqsave(&sem->lock, flags);
-if (likely(sem->count > 0))
-sem->count--;
-else
-__down(sem);
-raw_spin_unlock_irqrestore(&sem->lock, flags);
+down_common(sem, TASK_UNINTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
 }
 EXPORT_SYMBOL(down);

@@ -74,17 +89,7 @@ EXPORT_SYMBOL(down);
  */
 int down_interruptible(struct semaphore *sem)
 {
-unsigned long flags;
-int result =3D 0;
-
-raw_spin_lock_irqsave(&sem->lock, flags);
-if (likely(sem->count > 0))
-sem->count--;
-else
-result =3D __down_interruptible(sem);
-raw_spin_unlock_irqrestore(&sem->lock, flags);
-
-return result;
+return down_common(sem, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
 }
 EXPORT_SYMBOL(down_interruptible);

@@ -100,17 +105,7 @@ EXPORT_SYMBOL(down_interruptible);
  */
 int down_killable(struct semaphore *sem)
 {
-unsigned long flags;
-int result =3D 0;
-
-raw_spin_lock_irqsave(&sem->lock, flags);
-if (likely(sem->count > 0))
-sem->count--;
-else
-result =3D __down_killable(sem);
-raw_spin_unlock_irqrestore(&sem->lock, flags);
-
-return result;
+return down_common(sem, TASK_KILLABLE, MAX_SCHEDULE_TIMEOUT);
 }
 EXPORT_SYMBOL(down_killable);

@@ -154,17 +149,7 @@ EXPORT_SYMBOL(down_trylock);
  */
 int down_timeout(struct semaphore *sem, long timeout)
 {
-unsigned long flags;
-int result =3D 0;
-
-raw_spin_lock_irqsave(&sem->lock, flags);
-if (likely(sem->count > 0))
-sem->count--;
-else
-result =3D __down_timeout(sem, timeout);
-raw_spin_unlock_irqrestore(&sem->lock, flags);
-
-return result;
+return down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
 }
 EXPORT_SYMBOL(down_timeout);

@@ -196,12 +181,15 @@ struct semaphore_waiter {
 bool up;
 };

-/*
- * Because this function is inlined, the 'state' parameter will be
- * constant, and thus optimised away by the compiler.  Likewise the
- * 'timeout' parameter for the cases without timeouts.
+/**
+ * __down_common - Adds the current task to wait list
+ * puts the task to sleep until signal, timeout or up flag
+ * @sem: the semaphore to be acquired
+ * @state: the state of the calling task
+ * @timeout: either MAX_SCHEDULE_TIMEOUT or actual specified
+ * timeout
  */
-static inline int __sched __down_common(struct semaphore *sem, long state,
+static noinline int __sched __down_common(struct semaphore *sem, long stat=
e,
 long timeout)
 {
 struct semaphore_waiter waiter;
@@ -232,25 +220,6 @@ static inline int __sched __down_common(struct semapho=
re *sem, long state,
 return -EINTR;
 }

-static noinline void __sched __down(struct semaphore *sem)
-{
-__down_common(sem, TASK_UNINTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
-}
-
-static noinline int __sched __down_interruptible(struct semaphore *sem)
-{
-return __down_common(sem, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
-}
-
-static noinline int __sched __down_killable(struct semaphore *sem)
-{
-return __down_common(sem, TASK_KILLABLE, MAX_SCHEDULE_TIMEOUT);
-}
-
-static noinline int __sched __down_timeout(struct semaphore *sem, long tim=
eout)
-{
-return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
-}

 static noinline void __sched __up(struct semaphore *sem)
 {
--
2.17.1

::DISCLAIMER::
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------------------------------------------
The contents of this e-mail and any attachment(s) are confidential and inte=
nded for the named recipient(s) only. E-mail transmission is not guaranteed=
 to be secure or error-free as information could be intercepted, corrupted,=
 lost, destroyed, arrive late or incomplete, or may contain viruses in tran=
smission. The e mail and its contents (with or without referred errors) sha=
ll therefore not attach any liability on the originator or HCL or its affil=
iates. Views or opinions, if any, presented in this email are solely those =
of the author and may not necessarily reflect the views or opinions of HCL =
or its affiliates. Any form of reproduction, dissemination, copying, disclo=
sure, modification, distribution and / or publication of this message witho=
ut the prior written consent of authorized representative of HCL is strictl=
y prohibited. If you have received this email in error please delete it and=
 notify the sender immediately. Before opening any email and/or attachments=
, please check them for viruses and other defects.
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------------------------------------------
