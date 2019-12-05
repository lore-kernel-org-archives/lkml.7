Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53751C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33952245C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="wLeDMfty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfLEN3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:29:30 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:7462 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729048AbfLEN3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:29:30 -0500
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB5DOmf4026714
        for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2019 08:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=smtpout1;
 bh=zjPDK3FcYNU3UV4k7FLqe3Ln85julNeCSKI97eiIrd8=;
 b=wLeDMftyecCuNG4SzW7gqAwXVtq15jy3+7NbT9CgO9bYUvLc7MOdE+N7e9QArF+ET0NP
 2YoQgpeORyoYjS4BqEcqGHPIILRQmH8AnLEIuwgPBEvCnBckW8oZuI1QMFxaMVFk7GSK
 wxFeYh2b0NqNO2H/nQFhYw+TPBn30tYZ7ceKkCGjzsKmCY4/qjUW+lSgfQL5MWVJEm8i
 xwZdLkH7r3ZZ3UsmpybTFgX3LvxQQSnYm7F77fCxMiCbYXk/d/cW0c0FNio2Bo9lJUyY
 KagMBEoAUj0ytL8bf6fZLZYDmQUhdJp0X1geleW0LZhexssSt0hWUwBoCsrNjLPrYgVi xw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2wp8ewefef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 08:29:29 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB5DRxWw067235
        for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2019 08:29:28 -0500
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 2wpf8j7vr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 08:29:28 -0500
X-LoopCount0: from 10.166.132.54
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="457389922"
From:   <Narendra.K@dell.com>
To:     <rong.a.chen@intel.com>
CC:     <ard.biesheuvel@linaro.org>, <Mario.Limonciello@dell.com>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <lkp@lists.01.org>, <Narendra.K@dell.com>
Subject: Re: [efi] 1c5fecb612: WARNING:at_kernel/iomem.c:#memremap
Thread-Topic: [efi] 1c5fecb612: WARNING:at_kernel/iomem.c:#memremap
Thread-Index: AQHVqPSzwARs+w96okKqUpUqied7KqentwiAgAN61IA=
Date:   Thu, 5 Dec 2019 13:29:25 +0000
Message-ID: <20191205132915.GA2698@localhost.localdomain>
References: <20191201155238.GR18573@shao2-debian>
 <CAKv+Gu8MO_85Fa0y7YZ0iEgxrXbfR5-1e37FbiByzP8LrohcYA@mail.gmail.com>
 <51a225fa-6775-ed3f-22ff-4c88de6f6db4@intel.com>
In-Reply-To: <51a225fa-6775-ed3f-22ff-4c88de6f6db4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <723610D4B160D343901F769D1F9DF693@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_03:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050114
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912050113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 04:20:51PM +0800, Rong Chen wrote:
> On 12/2/19 5:41 PM, Ard Biesheuvel wrote:
> > On Sun, 1 Dec 2019 at 16:53, kernel test robot <rong.a.chen@intel.com> =
wrote:
> > > FYI, we noticed the following commit (built with gcc-7):
> > >=20
> > > commit: 1c5fecb61255aa12a16c4c06335ab68979865914 ("efi: Export Runtim=
e Configuration Interface table to sysfs")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git maste=
r
> > >=20
> > > in testcase: rcutorture
> > > with following parameters:
> > >=20
> > >          runtime: 300s
> > >          test: default
> > >          torture_type: tasks
> > >=20
> > > test-description: rcutorture is rcutorture kernel module load/unload =
test.
> > > test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> > >=20
> > >=20
> > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp=
 2 -m 8G
> > >=20
> > > caused below changes (please refer to attached dmesg/kmsg for entire =
log/backtrace):
> > >=20
> > >=20
> > > +------------------------------------------------+------------+------=
------+
> > > |                                                | 5828efb95b | 1c5fe=
cb612 |
> > > +------------------------------------------------+------------+------=
------+
> > > | boot_successes                                 | 0          | 0    =
      |
> > > | boot_failures                                  | 4          | 4    =
      |
> > > | Kernel_panic-not_syncing:No_working_init_found | 4          | 4    =
      |
> > > | WARNING:at_kernel/iomem.c:#memremap            | 0          | 4    =
      |
> > > | EIP:memremap                                   | 0          | 4    =
      |
> > > +------------------------------------------------+------------+------=
------+
> > >=20
> > I don't understand this result. Doesn't it say the number of failures
> > is the same, but it just fails in a different place? Is there a
> > working config that breaks due to that commit?
>=20
> Hi Ard,
>=20
> The results means all boot are failed, parent commit fails at
> "Kernel_panic-not_syncing:No_working_init_found"
> which may causes by the wrong test environment, but the commit "1c5fecb61=
2"
> introduced a new error:
> "WARNING:at_kernel/iomem.c:#memremap".
>=20
> We prepared the reproduce steps and config file in report mail:
> https://lore.kernel.org/lkml/20191201155238.GR18573@shao2-debian/
>=20

Hi Rong,

Thank you. I am trying to replicate the issue. I will share findings.

--=20
With regards,
Narendra K=
