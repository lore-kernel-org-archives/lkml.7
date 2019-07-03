Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF36C06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ABA20659
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="rHN993VC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfGCSGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:06:54 -0400
Received: from mail-eopbgr710069.outbound.protection.outlook.com ([40.107.71.69]:64840
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbfGCSGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWyDwB9SlM9tVhFqxN1CC8B6osh46cbd+LK5Yf59lcU=;
 b=rHN993VCYu78aXlXy6n3hGb0YyEavuTAdSqErA4V8lRnGsCXA1kYNsf6x2Z/xbxoYCyPhLr/vXQPC9R4j3T6cp8FsbnenjWl4LxqsTVM1tLs1Z2yvBG7fH9jB7qg/Y1KTHk1cRnSo2+7aEqP1M+h1uMeYzym8pjpB6ZjZTonoo8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5703.namprd05.prod.outlook.com (20.178.48.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.15; Wed, 3 Jul 2019 18:06:51 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2052.010; Wed, 3 Jul 2019
 18:06:51 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: Re: [patch 16/18] x86/apic: Convert 32bit to IPI shorthand static key
Thread-Topic: [patch 16/18] x86/apic: Convert 32bit to IPI shorthand static
 key
Thread-Index: AQHVMY8QgIx5pjJdE0yOed/UKt0/5qa5MQyA
Date:   Wed, 3 Jul 2019 18:06:51 +0000
Message-ID: <1DC35A28-DEBC-4A46-AC35-3AADD23AA40D@vmware.com>
References: <20190703105431.096822793@linutronix.de>
 <20190703105917.044463061@linutronix.de>
In-Reply-To: <20190703105917.044463061@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3fc9ba8-c292-458a-6530-08d6ffe1396d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB5703;
x-ms-traffictypediagnostic: BYAPR05MB5703:
x-microsoft-antispam-prvs: <BYAPR05MB57031094FD3C779AC334862DD0FB0@BYAPR05MB5703.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(229853002)(256004)(66066001)(2906002)(6436002)(99286004)(36756003)(68736007)(102836004)(305945005)(316002)(7736002)(2616005)(6486002)(54906003)(11346002)(476003)(6506007)(186003)(486006)(86362001)(71190400001)(6512007)(25786009)(26005)(71200400001)(81156014)(81166006)(478600001)(76176011)(8676002)(8936002)(446003)(53546011)(4326008)(6246003)(66446008)(66946007)(66476007)(64756008)(5660300002)(66556008)(6116002)(3846002)(14454004)(53936002)(76116006)(6916009)(33656002)(73956011)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5703;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kI0HTawlcB931rpvboL83uX0tzTGLEH/SJ9Bdazu0ZGmXg4Z/rfQ+zUQLhvy6EbIZbWuFLqWdsc/kKqDD+t0gAZq841E50Qbr6qeyYhFlg2fMhMXK7VBvvl+UQHca5UnNXSeM0CcGENAXddVTjSf0n6UKi951kqlCnIuqszc48sXuOeQkhUQUNvFpPJg6vV9IiOl0EMJG9jQwf/ROdgVdidD1AMm4eNptTSYTxSNLvJYe8NnUhCb1s5x3Tjm3LX5DwLuO5YZy7/8/geU03aq/slzIzeQvBHcGoO9NZxtWzVHJE2flkhJiQzE+qo2jBFoE2lfHjwxxsfTw55uQTtD0ZxMozbZIm9c7peKuFmolxyqb4hMNxmTr4f6rJ8ybNe6j4WLE/VX5LrPKRM6xNwW4j4PGwXv+/eF4/GPCCPTiII=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A186A04C82B1214D92A2A3DCC4B35B0F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fc9ba8-c292-458a-6530-08d6ffe1396d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 18:06:51.4399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5703
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 3, 2019, at 3:54 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> Broadcast now depends on the fact that all present CPUs have been booted
> once so handling broadcast IPIs is not doing any harm. In case that a CPU
> is offline, it does not react to regular IPIs and the NMI handler returns
> early.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> arch/x86/kernel/apic/ipi.c |   12 +++---------
> 1 file changed, 3 insertions(+), 9 deletions(-)
>=20
> --- a/arch/x86/kernel/apic/ipi.c
> +++ b/arch/x86/kernel/apic/ipi.c
> @@ -8,13 +8,7 @@
> DEFINE_STATIC_KEY_FALSE(apic_use_ipi_shorthand);
>=20
> #ifdef CONFIG_SMP
> -#ifdef CONFIG_HOTPLUG_CPU
> -#define DEFAULT_SEND_IPI	(1)
> -#else
> -#define DEFAULT_SEND_IPI	(0)
> -#endif
> -
> -static int apic_ipi_shorthand_off __ro_after_init =3D DEFAULT_SEND_IPI;
> +static int apic_ipi_shorthand_off __ro_after_init;
>=20
> static __init int apic_ipi_shorthand(char *str)
> {
> @@ -250,7 +244,7 @@ void default_send_IPI_allbutself(int vec
> 	if (num_online_cpus() < 2)
> 		return;
>=20
> -	if (apic_ipi_shorthand_off || vector =3D=3D NMI_VECTOR) {
> +	if (static_branch_likely(&apic_use_ipi_shorthand)) {
> 		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
> 	} else {
> 		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
> @@ -259,7 +253,7 @@ void default_send_IPI_allbutself(int vec
>=20
> void default_send_IPI_all(int vector)
> {
> -	if (apic_ipi_shorthand_off || vector =3D=3D NMI_VECTOR) {
> +	if (static_branch_likely(&apic_use_ipi_shorthand)) {
> 		apic->send_IPI_mask(cpu_online_mask, vector);
> 	} else {
> 		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);

It may be better to check the static-key in native_send_call_func_ipi() (an=
d
other callers if there are any), and remove all the other checks in
default_send_IPI_all(), x2apic_send_IPI_mask_allbutself(), etc.

This would allow to remove potentially unnecessary checks in
native_send_call_func_ipi()I also have this patch I still did not send to
slightly improve the test in native_send_call_func_ipi().

-- >8 --

From: Nadav Amit <namit@vmware.com>
Date: Fri, 7 Jun 2019 15:11:44 -0700
Subject: [PATCH] x86/smp: Better check of allbutself

Introduce for_each_cpu_and_not() for this matter.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/smp.c             | 22 +++++++++++-----------
 include/asm-generic/bitops/find.h | 17 +++++++++++++++++
 include/linux/cpumask.h           | 17 +++++++++++++++++
 lib/cpumask.c                     | 20 ++++++++++++++++++++
 lib/find_bit.c                    | 21 ++++++++++++++++++---
 5 files changed, 83 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 96421f97e75c..7972ab593397 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -136,23 +136,23 @@ void native_send_call_func_single_ipi(int cpu)
=20
 void native_send_call_func_ipi(const struct cpumask *mask)
 {
-	cpumask_var_t allbutself;
-
-	if (!alloc_cpumask_var(&allbutself, GFP_ATOMIC)) {
-		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
-		return;
+	int cpu, this_cpu =3D smp_processor_id();
+	bool allbutself =3D true;
+	bool self =3D false;
+
+	for_each_cpu_and_not(cpu, cpu_online_mask, mask) {
+		if (cpu !=3D this_cpu) {
+			allbutself =3D false;
+			break;
+		}
+		self =3D true;
 	}
=20
-	cpumask_copy(allbutself, cpu_online_mask);
-	__cpumask_clear_cpu(smp_processor_id(), allbutself);
-
-	if (cpumask_equal(mask, allbutself) &&
+	if (allbutself && !self &&
 	    cpumask_equal(cpu_online_mask, cpu_callout_mask))
 		apic->send_IPI_allbutself(CALL_FUNCTION_VECTOR);
 	else
 		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
-
-	free_cpumask_var(allbutself);
 }
=20
 static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops=
/find.h
index 8a1ee10014de..e5f19eec2737 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -32,6 +32,23 @@ extern unsigned long find_next_and_bit(const unsigned lo=
ng *addr1,
 		unsigned long offset);
 #endif
=20
+#ifndef find_next_and_bit
+/**
+ * find_next_and_not_bit - find the next set bit in the the first region
+ *			   which is clear on the second
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next set bit
+ * If no bits are set, returns @size.
+ */
+extern unsigned long find_next_and_not_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long size,
+		unsigned long offset);
+#endif
+
 #ifndef find_next_zero_bit
 /**
  * find_next_zero_bit - find the next cleared bit in a memory region
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 693124900f0a..4648add54fad 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -229,6 +229,7 @@ static inline unsigned int cpumask_next_zero(int n, con=
st struct cpumask *srcp)
 }
=20
 int cpumask_next_and(int n, const struct cpumask *, const struct cpumask *=
);
+int __pure cpumask_next_and_not(int n, const struct cpumask *, const struc=
t cpumask *);
 int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
=20
@@ -291,6 +292,22 @@ extern int cpumask_next_wrap(int n, const struct cpuma=
sk *mask, int start, bool
 	for ((cpu) =3D -1;						\
 		(cpu) =3D cpumask_next_and((cpu), (mask), (and)),		\
 		(cpu) < nr_cpu_ids;)
+
+
+/**
+ * for_each_cpu_and_not - iterate over every cpu in @mask & ~@and_not
+ * @cpu: the (optionally unsigned) integer iterator
+ * @mask: the first cpumask pointer
+ * @and_not: the second cpumask pointer
+ *
+ * After the loop, cpu is >=3D nr_cpu_ids.
+ */
+#define for_each_cpu_and_not(cpu, mask, and_not)			\
+	for ((cpu) =3D -1;						\
+		(cpu) =3D cpumask_next_and_not((cpu), (mask), (and_not)),	\
+		(cpu) < nr_cpu_ids;)
+
+
 #endif /* SMP */
=20
 #define CPU_BITS_NONE						\
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 0cb672eb107c..59c98f55c308 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -42,6 +42,26 @@ int cpumask_next_and(int n, const struct cpumask *src1p,
 }
 EXPORT_SYMBOL(cpumask_next_and);
=20
+/**
+ * cpumask_next_and_not - get the next cpu in *src1p & ~*src2p
+ * @n: the cpu prior to the place to search (ie. return will be > @n)
+ * @src1p: the first cpumask pointer
+ * @src2p: the second cpumask pointer
+ *
+ * Returns >=3D nr_cpu_ids if no further cpus set in both.
+ */
+int cpumask_next_and_not(int n, const struct cpumask *src1p,
+		     const struct cpumask *src2p)
+{
+	/* -1 is a legal arg here. */
+	if (n !=3D -1)
+		cpumask_check(n);
+	return find_next_and_not_bit(cpumask_bits(src1p), cpumask_bits(src2p),
+		nr_cpumask_bits, n + 1);
+}
+EXPORT_SYMBOL(cpumask_next_and_not);
+
+
 /**
  * cpumask_any_but - return a "random" in a cpumask, but not this one.
  * @mask: the cpumask to search
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 5c51eb45178a..7bd2c567287e 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -23,7 +23,7 @@
 /*
  * This is a common helper function for find_next_bit, find_next_zero_bit,=
 and
  * find_next_and_bit. The differences are:
- *  - The "invert" argument, which is XORed with each fetched word before
+ *  - The "invert" argument, which is XORed with each fetched first word b=
efore
  *    searching it for one bits.
  *  - The optional "addr2", which is anded with "addr1" if present.
  */
@@ -37,9 +37,9 @@ static inline unsigned long _find_next_bit(const unsigned=
 long *addr1,
 		return nbits;
=20
 	tmp =3D addr1[start / BITS_PER_LONG];
+	tmp ^=3D invert;
 	if (addr2)
 		tmp &=3D addr2[start / BITS_PER_LONG];
-	tmp ^=3D invert;
=20
 	/* Handle 1st word. */
 	tmp &=3D BITMAP_FIRST_WORD_MASK(start);
@@ -51,9 +51,9 @@ static inline unsigned long _find_next_bit(const unsigned=
 long *addr1,
 			return nbits;
=20
 		tmp =3D addr1[start / BITS_PER_LONG];
+		tmp ^=3D invert;
 		if (addr2)
 			tmp &=3D addr2[start / BITS_PER_LONG];
-		tmp ^=3D invert;
 	}
=20
 	return min(start + __ffs(tmp), nbits);
@@ -91,6 +91,21 @@ unsigned long find_next_and_bit(const unsigned long *add=
r1,
 EXPORT_SYMBOL(find_next_and_bit);
 #endif
=20
+#if !defined(find_next_and_not_bit)
+unsigned long find_next_and_not_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long size,
+		unsigned long offset)
+{
+	/*
+	 * Switching addr1 and addr2, since the first argument is the one that
+	 * will be inverted.
+	 */
+	return _find_next_bit(addr2, addr1, size, offset, ~0UL);
+}
+EXPORT_SYMBOL(find_next_and_not_bit);
+#endif
+
+
 #ifndef find_first_bit
 /*
  * Find the first set bit in a memory region.
--=20
2.20.1=
