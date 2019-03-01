Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BD7C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC3220643
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cPFVnY5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbfCACgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:36:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51292 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfCACgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:36:01 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x212Sb9m116835;
        Fri, 1 Mar 2019 02:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=J03mO0gd4F9iqsTXPE2fpy0NZUD7AH2QeqqurNmaDiU=;
 b=cPFVnY5p0wfPgDQAIh8qGY35NwLxhVMwVN8MTrOSXozcJWcKFTRm9CvuU1XA3T/9z1Tc
 urok+uEGRKt2fzf2AUV6+tbTcAK0flFhgox2zBmrouyeMrpuYjyqHkBezH40SM2iQ6RE
 bi6WmqdoIXp7D7EnOHdKfNfAqlNNwvu3zBtjlBtLPy9kSalAmonkTixjc5CAWGEzcA/A
 ylY/BtjwEtRPO53feZBsFqI6QDPk1qdsBLjuHZZff3qQlflqSyXyV+O++2vgg7gQDSXF
 Pzv0fjgi2cGNNNqD+QR6DUf/hosbUB4r+bwK48JK9BucrbK03NTUVEheL4oyNtiS0HZB YQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qtxts4qfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Mar 2019 02:35:41 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x212Zeu2002548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Mar 2019 02:35:40 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x212ZdXR031027;
        Fri, 1 Mar 2019 02:35:39 GMT
MIME-Version: 1.0
Message-ID: <841bb9a9-1cba-483f-a353-1209684f7c74@default>
Date:   Thu, 28 Feb 2019 18:35:38 -0800 (PST)
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     <xen-devel@lists.xenproject.org>, <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <boris.ostrovsky@oracle.com>, <sstabellini@kernel.org>,
        <jgross@suse.com>, <tglx@linutronix.de>, <joe.jin@oracle.com>,
        Herbert Van Den Bergh <herbert.van.den.bergh@oracle.com>,
        <sboyd@kernel.org>, <john.stultz@linaro.org>
Subject: [BUG linux-4.9.x] xen hotplug cpu leads to 100% steal usage
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9181 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903010013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This issue is only for stable 4.9.x (e.g., 4.9.160), while the root cause i=
s
still in the lasted mainline kernel.

This is obviated by new feature patch set ended with b672592f0221
("sched/cputime: Remove generic asm headers").

After xen guest is up for long time, once we hotplug new vcpu, the correspo=
nding
steal usage might become 100% and the steal time from /proc/stat would incr=
ease
abnormally.

As we cannot wait for long time to reproduce the issue, here is how I repro=
duce
it on purpose by accounting a large initial steal clock for new vcpu 2 and =
3.

1. Apply the below patch to guest 4.9.160 to account large initial steal cl=
ock
for new vcpu 2 and 3:

diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index ac5f23f..3cf629e 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -85,7 +85,14 @@ u64 xen_steal_clock(int cpu)
        struct vcpu_runstate_info state;
=20
        xen_get_runstate_snapshot_cpu(&state, cpu);
-       return state.time[RUNSTATE_runnable] + state.time[RUNSTATE_offline]=
;
+
+       if (cpu =3D=3D 2 || cpu =3D=3D 3)
+               return state.time[RUNSTATE_runnable]
+                      + state.time[RUNSTATE_offline]
+                      + 0x00071e87e677aa12;
+       else
+               return state.time[RUNSTATE_runnable]
+                      + state.time[RUNSTATE_offline];
 }
=20
 void xen_setup_runstate_info(int cpu)


2. Boot hvm guest with "vcpus=3D2" and "maxvcpus=3D4". By default, VM boot =
with
vcpu 0 and 1.

3. Hotplug vcpu 2 and 3 via "xl vcpu-set <domid> 4" on dom0.

In my env, the steal becomes 100% within 10s after the "xl vcpu-set" comman=
d on
dom0.

I can reproduce on kvm with similar method. However, as the initial steal c=
lock
on kvm guest is always 0, I do not think it is easy to hit this issue on kv=
m.

--------------------------------------------------------

The root cause is that the return type of jiffies_to_usecs() is 'unsigned i=
nt',
but not 'unsigned long'. As a result, the leading 32 bits are discarded.

jiffies_to_usecs() is indirectly triggered by cputime_to_nsecs() at line 26=
4.
If guest is already up for long time, the initial steal time for new vcpu m=
ight
be large and the leading 32 bits of jiffies_to_usecs() would be discarded.

As a result, the steal at line 259 is always large and the
this_rq()->prev_steal_time at line 264 is always small. The difference at l=
ine
260 is always large during each time steal_account_process_time() is involv=
ed.
Finally, the steal time in /proc/stat would increase abnormally.

252 static __always_inline cputime_t steal_account_process_time(cputime_t m=
axtime)
253 {
254 #ifdef CONFIG_PARAVIRT
255         if (static_key_false(&paravirt_steal_enabled)) {
256                 cputime_t steal_cputime;
257                 u64 steal;
258=20
259                 steal =3D paravirt_steal_clock(smp_processor_id());
260                 steal -=3D this_rq()->prev_steal_time;
261=20
262                 steal_cputime =3D min(nsecs_to_cputime(steal), maxtime)=
;
263                 account_steal_time(steal_cputime);
264                 this_rq()->prev_steal_time +=3D cputime_to_nsecs(steal_=
cputime);
265=20
266                 return steal_cputime;
267         }
268 #endif
269         return 0;
270 }

--------------------------------------------------------

I have emailed the kernel mailing list about the return type of
jiffies_to_usecs() and jiffies_to_msecs():

https://lkml.org/lkml/2019/2/26/899


So far, I have two solutions:

1. Change the return type from 'unsigned int' to 'unsigned long' as in abov=
e
link and I am afraid it would bring side effect. The return type in latest
mainline kernel is still 'unsigned int'.

2. Something like below based on stable 4.9.160:

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 734377a..9b1fc40 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -286,10 +286,11 @@ extern unsigned long preset_lpj;
  */
 extern unsigned int jiffies_to_msecs(const unsigned long j);
 extern unsigned int jiffies_to_usecs(const unsigned long j);
+extern unsigned long jiffies_to_usecs64(const unsigned long j);
=20
 static inline u64 jiffies_to_nsecs(const unsigned long j)
 {
-       return (u64)jiffies_to_usecs(j) * NSEC_PER_USEC;
+       return (u64)jiffies_to_usecs64(j) * NSEC_PER_USEC;
 }
=20
 extern u64 jiffies64_to_nsecs(u64 j);
diff --git a/kernel/time/time.c b/kernel/time/time.c
index a5b6d98..256c147 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -288,6 +288,27 @@ unsigned int jiffies_to_usecs(const unsigned long j)
 }
 EXPORT_SYMBOL(jiffies_to_usecs);
=20
+unsigned long jiffies_to_usecs64(const unsigned long j)
+{
+       /*
+        * Hz usually doesn't go much further MSEC_PER_SEC.
+        * jiffies_to_usecs() and usecs_to_jiffies() depend on that.
+        */
+       BUILD_BUG_ON(HZ > USEC_PER_SEC);
+
+#if !(USEC_PER_SEC % HZ)
+       return (USEC_PER_SEC / HZ) * j;
+#else
+# if BITS_PER_LONG =3D=3D 32
+       return (HZ_TO_USEC_MUL32 * j) >> HZ_TO_USEC_SHR32;
+# else
+       return (j * HZ_TO_USEC_NUM) / HZ_TO_USEC_DEN;
+# endif
+#endif
+}
+EXPORT_SYMBOL(jiffies_to_usecs64);
+
+
 /**
  * timespec_trunc - Truncate timespec to a granularity
  * @t: Timespec

People may dislike the 2nd solution.

3. Backport patch set ended with b672592f0221 ("sched/cputime:=20
Remove generic asm headers").

This is not reasonable for stable branch as the patch set involves
lots of changes.


Would you please let me know if there is any suggestion on this issue?

Thank you very much!

Dongli Zhang
