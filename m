Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9746C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA43123774
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sWk+0tjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfIBH1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:27:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38178 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729678AbfIBH1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:27:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x827NZLF194938;
        Mon, 2 Sep 2019 07:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=aWAetxU11Vc8g+G0ROwwZ/P1cCEG4UUXADfS79jjg9M=;
 b=sWk+0tjQEoVe5hdQXfeXgGoDosyxHGVMw1C06+OwNUs//MhZvrtXtjM1WRTybQfCQsl5
 oaycdAWB4klqmqB9I5WWhQw/e9+K3KdAi+O+oF7wuwb2IB3zPOwsSxHR9lQVg33xwUgk
 7YeM57iMpobL0r6CJ3tnqztbi+Js7nNOAtspSPL97Re3oVbxqQ+b4kmfi5FazMCRHs3h
 IQU4Oa1Y53vHzQDjP78wrP+todk4ce0rXckJos6S0tZEoaKJLhYO+IUoz8+cIw4btXys
 OLZhj1Q4nbEJJuOPdEHg8cDtYEjNoSw/an3fQXKWYDMB+k7j0jMOEW5018qfFTvxHlRJ ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2urxkug154-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Sep 2019 07:27:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x827NLcP109808;
        Mon, 2 Sep 2019 07:27:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2uqe1c0qhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Sep 2019 07:27:18 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x827RDgY022373;
        Mon, 2 Sep 2019 07:27:15 GMT
Received: from [10.141.158.24] (/109.166.128.0)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Sep 2019 00:27:11 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Parallel microcode update in Linux
From:   Mihai Carabas <mihai.carabas@oracle.com>
X-Mailer: iPhone Mail (16G77)
In-Reply-To: <20190901172547.GD1047@bug>
Date:   Mon, 2 Sep 2019 10:27:06 +0300
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, ashok.raj@intel.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        patrick.colp@oracle.com, kanth.ghatraju@oracle.com,
        Jon.Grimm@amd.com, Thomas.Lendacky@amd.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5BACA033-7613-49A9-801C-9F75F4306909@oracle.com>
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com> <20190901172547.GD1047@bug>
To:     Pavel Machek <pavel@ucw.cz>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909020083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909020083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 1 Sep 2019, at 20:25, Pavel Machek <pavel@ucw.cz> wrote:
>=20
> Hi!
>=20
>> +       u64 p0, p1;
>>        int ret;
>>=20
>>        atomic_set(&late_cpus_in,  0);
>>        atomic_set(&late_cpus_out, 0);
>>=20
>> +       p0 =3D rdtsc_ordered();
>> +
>>        ret =3D stop_machine_cpuslocked(__reload_late, NULL, cpu_online_ma=
sk);
>> +
>> +       p1 =3D rdtsc_ordered();
>> +
>>        if (ret > 0)
>>                microcode_check();
>>=20
>>        pr_info("Reload completed, microcode revision: 0x%x\n", boot_cpu_d=
ata.microcode);
>>=20
>> +       pr_info("p0: %lld, p1: %lld, diff: %lld\n", p0, p1, p1 - p0);
>> +
>>        return ret;
>> }
>>=20
>> We have used a machine with a broken microcode in BIOS and no microcode i=
n
>> initramfs (to bypass early loading).
>>=20
>> Here are the results for parallel loading (we made two measurements):
>=20
>> [   18.197760] microcode: updated to revision 0x200005e, date =3D 2019-04=
-02
>> [   18.201225] x86/CPU: CPU features have changed after loading microcode=
, but might not take effect.
>> [   18.201230] microcode: Reload completed, microcode revision: 0x200005e=

>> [   18.201232] microcode: p0: 118138123843052, p1: 118138153732656, diff:=
 29889604
>=20
>> Here are the results of serial loading:
>>=20
>> [   17.542518] microcode: updated to revision 0x200005e, date =3D 2019-04=
-02
>> [   17.898365] x86/CPU: CPU features have changed after loading microcode=
, but might not take effect.
>> [   17.898370] microcode: Reload completed, microcode revision: 0x200005e=

>> [   17.898372] microcode: p0: 149220216047388, p1: 149221058945422, diff:=
 842898034
>>=20
>> One can see that the difference is an order magnitude.
>=20
> Well, that's impressive, but it seems to finish 300 msec later? Where does=
 that difference
> come from / how much real time do you gain by this?

The difference comes from the large amount of cores/threads the machine has:=
 72 in this case, but there are machines with more. As the commit message sa=
ys initially the microcode was applied serially one by one and now the micro=
code is updated in parallel on all cores.

300ms seems nothing but it is enough to cause disruption in some critical se=
rvices (e.g. storage) - 300ms in which we do not execute anything on CPUs. A=
lso this 300ms is increasing when the machine is fully loaded with guests.

Thanks,
Mihai

>=20
> Best regards,
>                                    Pavel
>=20
> --=20
> (english) https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__www.livejo=
urnal.com_-7Epavelmachek&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65e=
apI_JnE&r=3DIOMTUEJr06tE0LeEzvwr_907ba6u9S5iDf7M8ZYjbGY&m=3Dcz26YweqnHS4QvZB=
i-1jNR8t7o3n04-8UsSBZqEQHgA&s=3D-nEQbDyJrDjKxyrt496frey_aMJHXmgMcm-hH0ewO7M&=
e=3D=20
> (cesky, pictures) https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__at=
rey.karlin.mff.cuni.cz_-7Epavel_picture_horses_blog.html&d=3DDwIBAg&c=3DRoP1=
YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DIOMTUEJr06tE0LeEzvwr_907ba6u9S5i=
Df7M8ZYjbGY&m=3Dcz26YweqnHS4QvZBi-1jNR8t7o3n04-8UsSBZqEQHgA&s=3D0L72IdzqTDn_=
8PmDVcNxLAFbcYG1jRDN9ob8SZ18XTE&e=3D=20

