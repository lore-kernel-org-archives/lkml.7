Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFB9C31E51
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 01:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE6C2183E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 01:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="bRQZJk+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfFOBRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 21:17:30 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:54194 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbfFOBR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 21:17:29 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5F1GMX1005284;
        Sat, 15 Jun 2019 02:16:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=JJVpXFLEbynrn+rgZyXnc2n2fwvAuRV+5DVvAuFJ4D8=;
 b=bRQZJk+sLcxjdwdjHNc2Xrq+7fO69sjHHey+fQbyUVbm1BW81fKHfurTsK222xPOQ6LM
 HcDnpfAIm1RPSVvKrPDFZIoFVnNMvPok5IqYRkkVAx9+2DXEpq175d/XDv7URF/UhPTb
 rMFirwniCnvEWqhLoNACR3IY4QKMX2OXiDdh2oltwh/1PbrljxCyaWjdqrSWGlV0lrVY
 tYBNOl9eYjLcO5TFr3sxTK/W/0Vb8LKP5W9tRYFHvOW36wn4k/iQGJxjphXCRQ42NTFE
 LpbZ4m4T/3k+G7HuwCXW1VW4GHyvYLQ9uT7mWr+sT34F4gFVnLVJ1o0RNSY7KLrxb78O JA== 
Received: from prod-mail-ppoint3 (prod-mail-ppoint3.akamai.com [96.6.114.86] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2t4n6kr940-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jun 2019 02:16:34 +0100
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x5F12M1H008120;
        Fri, 14 Jun 2019 21:16:33 -0400
Received: from email.msg.corp.akamai.com ([172.27.25.34])
        by prod-mail-ppoint3.akamai.com with ESMTP id 2t08c2j8ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Jun 2019 21:16:33 -0400
Received: from USTX2EX-DAG1MB5.msg.corp.akamai.com (172.27.27.105) by
 ustx2ex-dag1mb2.msg.corp.akamai.com (172.27.27.102) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Fri, 14 Jun 2019 20:16:32 -0500
Received: from USTX2EX-DAG1MB5.msg.corp.akamai.com ([172.27.27.105]) by
 ustx2ex-dag1mb5.msg.corp.akamai.com ([172.27.27.105]) with mapi id
 15.00.1473.004; Fri, 14 Jun 2019 20:16:32 -0500
From:   "Lubashev, Igor" <ilubashe@akamai.com>
To:     James Morris <jmorris@namei.org>
CC:     Serge Hallyn <serge@hallyn.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 0/1] security: add SECURE_KEEP_FSUID to preserve
 fsuid/fsgid across execve
Thread-Topic: [RFC PATCH 0/1] security: add SECURE_KEEP_FSUID to preserve
 fsuid/fsgid across execve
Thread-Index: AQHVIkp2KrFaTjvuWkqWuYjnYmNLQ6aa7f2AgAD6xpA=
Date:   Sat, 15 Jun 2019 01:16:32 +0000
Message-ID: <720751180a9543cfa205cd527248df7c@ustx2ex-dag1mb5.msg.corp.akamai.com>
References: <1560473087-27754-1-git-send-email-ilubashe@akamai.com>
 <alpine.LRH.2.21.1906141445010.7150@namei.org>
In-Reply-To: <alpine.LRH.2.21.1906141445010.7150@namei.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.34.125]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-15_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906150004
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-15_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906150007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Friday, June 14, 2019, James Morris wrote:
> On Thu, 13 Jun 2019, Igor Lubashev wrote:
>=20
> > I've posted this in March but received no response. Reposting.
> >
> > This patch introduces SECURE_KEEP_FSUID to allow fsuid/fsgid to be
> > preserved across execve. It is currently impossible to execve a
> > program such that effective and filesystem uid differ.
> >
> > The need for this functionality arose from a desire to allow certain
> > non-privileged users to run perf. To do this, we install perf without
> > set-uid-root and have a set-uid-root wrapper decide who is allowed to
> > run perf (and with what arguments).
> >
> > The wrapper must execve perf with real and effective root uid, because
> > perf and KASLR require this. However, that presently resets fsuid to
> > root, giving the user ability to read and overwrite any file owned by
> > root (perf report -i, perf record -o). Also, perf record will create
> > perf.data that cannot be deleted by the user.
> >
> > We cannot reset /proc/sys/kernel/perf_event_paranoid to a permissive
> > level, since we must be selective which users have the permissions.
> >
> > Of course, we could fix our problem by a patch to perf to allow
> > passing a username on the command line and having perf execute
> > setfsuid before opening files. However, perf is not the only program
> > that uses kernel features that require root uid/euid, so a general
> > solution that does not involve updating all such programs seems
> > warranted.

> This seems like a very specific corner case, depending on fsuid!=3D0 for =
an
> euid=3D0 process, along with a whitelist policy for perf arguments. It wo=
uld be a
> great way to escalate to root via a bug in an executed app or via a wrapp=
er
> misconfiguration.

Any set-uid-root app is a hazard.  This wrapper's purpose is to reduce the =
risk inherent in running apps with elevated privs.
It removes all capabilities (CAT_SETUID, CAT_SETPCAP, CAP_DAC_OVERRIDE, etc=
.) except for the required ones before execve().  It has a list of users al=
lowed run apps (and a per-user whitelist of arguments, and it manages resou=
rces and time used by apps).

The wrapper works great for things like tcpdump -- it is executed with the =
user's uid and just CAP_NET_CAP and CAP_NET_ADMIN set.

Unfortunately, perf is using uid=3D=3D0 and euid=3D=3D0 as a "capability bi=
ts".

In tools/perf/util/evsel.c:
	static bool perf_event_can_profile_kernel(void)
	{
		return geteuid() =3D=3D 0 || perf_event_paranoid() =3D=3D -1;
	}

In tools/perf/util/symbol.c:
	static bool symbol__read_kptr_restrict(void)
	{
	...
		value =3D ((geteuid() !=3D 0) || (getuid() !=3D 0)) ?
				(atoi(line) !=3D 0) :
				(atoi(line) =3D=3D 2);
	...
	}

> Have you considered the example security configuration in
> Documentation/admin-guide/perf-security.rst ?

Unfortunately, this configuration does not work, unless you reset /proc/sys=
/kernel/perf_event_paranoid to a permissive level (see code above). We have=
 perf_event_paranoid set to 2. If it worked, we could had implemented the s=
ame capability-based policy in the wrapper.


> It also adds complexity to kernel credential handling -- it's yet another=
 thing
> to consider when trying to reason about this.

I really wish that there were only two concepts that mattered: capability s=
ets and fsuid/fsgid. The proposed patch allows one to switch to such mode -=
- a much simpler mode. Yes, the patch does add a "new feature", but what ma=
tters most for the complexity question is whether this feature is a move in=
 the right direction.  I am leaning that way, but I am not 100% positive --=
 hence this RFC patch.


> What are some other examples of programs that could utilize this scheme?

That's everything, like our wrapper, that needs to allow non-root users to =
run apps (like perf) that use uid/euid as capabilities.  It is a required, =
if the apps could interact with a filesystem (and accessing root-owned file=
s is not a desired effect).  It is a good idea from the security perspectiv=
e even if those apps do not normally interact with a filesystem.

I do not have a clear view about a variety of Linux apps ever written, but =
I suspect that there are many apps that fall into "use uid/euid as capabili=
ties" category.  There are at least two in the kernel's tools directory. Th=
ere is also use of uid/eiud in the kernel itself, and anything that uses th=
is functionality cannot be fixed w/o fixing the kernel. It may be a bit har=
d to find all such uses, but a good start is:

	grep -rE '(uid_eq|uid\(\)).*\b(GLOBAL_ROOT_ID|0)\b'

- Igor
