Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544D5C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB1F21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="SD2E0nKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfD2KD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 06:03:58 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:60472 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727560AbfD2KD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:03:57 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3TA1tJt011176;
        Mon, 29 Apr 2019 12:03:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=LkTdd7E2MxZuZ4AhmICRbNTuZ1ixfkA53WYKdrN9npk=;
 b=SD2E0nKfOMxwPrVw2n4TTD3MlLzQohPG5VZpT/RgP3SE7fkv7PMMGIarObjZb7I6+EuU
 FMy8sId/yreAFqnFbi7KFu2nkxOUCzB8DoV94Gj87D0FVStTyGrhVL0ldpjNp0dBVfZO
 4hw3j4aECgngrCZ9V7vmV0M1rsOMinVTonGMHWkig1oj3mIBKTIrMgJa05oTgKaqDULC
 Ca/iZw9/69yBM1NA0sU6vvZCJkurZdTkSLloB6Xu4ksUtKfCFvKxsh6WNxTZw7TW03JB
 X2sUa92F61L4PZbBFgBPllFWmv/60fQ0XIxRYyvq4wHOheof6JJzQ4Z7XztETvd3EA7B OQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2s4cj0bfqn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 29 Apr 2019 12:03:38 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 88AE53D;
        Mon, 29 Apr 2019 10:03:37 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 63D281516;
        Mon, 29 Apr 2019 10:03:37 +0000 (GMT)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 29 Apr
 2019 12:03:37 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1347.000; Mon, 29 Apr 2019 12:03:36 +0200
From:   Gerald BAEZA <gerald.baeza@st.com>
To:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Gerald BAEZA <gerald.baeza@st.com>
Subject: [PATCH 1/5] Documentation: perf: stm32: ddrperfm support
Thread-Topic: [PATCH 1/5] Documentation: perf: stm32: ddrperfm support
Thread-Index: AQHU/nLPEHho1416oEiblCko4nynGA==
Date:   Mon, 29 Apr 2019 10:03:36 +0000
Message-ID: <1556532194-27904-2-git-send-email-gerald.baeza@st.com>
References: <1556532194-27904-1-git-send-email-gerald.baeza@st.com>
In-Reply-To: <1556532194-27904-1-git-send-email-gerald.baeza@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-29_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DDRPERFM is the DDR Performance Monitor embedded in STM32MP1 SOC.

This documentation introduces the DDRPERFM, the stm32-ddr-pmu driver
supporting it and how to use it with the perf tool.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 Documentation/perf/stm32-ddr-pmu.txt | 41 ++++++++++++++++++++++++++++++++=
++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/perf/stm32-ddr-pmu.txt

diff --git a/Documentation/perf/stm32-ddr-pmu.txt b/Documentation/perf/stm3=
2-ddr-pmu.txt
new file mode 100644
index 0000000..d5b35b3
--- /dev/null
+++ b/Documentation/perf/stm32-ddr-pmu.txt
@@ -0,0 +1,41 @@
+STM32 DDR Performance Monitor (DDRPERFM)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The DDRPERFM is the DDR Performance Monitor embedded in STM32MP1 SOC.
+See STM32MP157 reference manual RM0436 to get a description of this periph=
eral.
+
+
+The five following counters are supported by stm32-ddr-pmu driver:
+	cnt0: read operations counters		(read_cnt)
+	cnt1: write operations counters		(write_cnt)
+	cnt2: active state counters		(activate_cnt)
+	cnt3: idle state counters		(idle_cnt)
+	tcnt: time count, present for all sets	(time_cnt)
+
+The stm32-ddr-pmu driver relies on the perf PMU framework to expose the
+counters via sysfs:
+	$ ls /sys/bus/event_source/devices/ddrperfm/events
+	activate_cnt  idle_cnt  read_cnt  time_cnt  write_cnt
+
+
+The perf PMU framework is usually invoked via the 'perf stat' tool.
+
+The DDRPERFM is a system monitor that cannot isolate the traffic coming fr=
om a
+given thread or CPU, that is why stm32-ddr-pmu driver rejects any 'perf st=
at'
+call that does not request a system-wide collection: the '-a, --all-cpus'
+option is mandatory!
+
+Example:
+	$ perf stat -e ddrperfm/read_cnt/,ddrperfm/time_cnt/ -a sleep 20
+	Performance counter stats for 'system wide':
+
+	         342541560      ddrperfm/read_cnt/
+	       10660011400      ddrperfm/time_cnt/
+
+	      20.021068551 seconds time elapsed
+
+
+The driver also exposes a 'bandwidth' attribute that can be used to displa=
y
+the read/write/total bandwidth achieved during the last 'perf stat' execut=
ion.
+	$ cat /sys/bus/event_source/devices/ddrperfm/bandwidth
+	Read =3D 403, Write =3D 239, Read & Write =3D 642 (MB/s)
--=20
2.7.4
