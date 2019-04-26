Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C31C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7C52077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfDZNIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:08:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726013AbfDZNIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:08:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QD50sD158820
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 09:08:29 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s410y5gpa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 09:08:19 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 26 Apr 2019 14:07:43 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Apr 2019 14:07:39 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3QD7cmY30212172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 13:07:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F43442045;
        Fri, 26 Apr 2019 13:07:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 465114203F;
        Fri, 26 Apr 2019 13:07:38 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 26 Apr 2019 13:07:38 +0000 (GMT)
Date:   Fri, 26 Apr 2019 15:07:36 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Prarit Bhargava <prarit@redhat.com>, Jessica Yu <jeyu@kernel.org>
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Cathy Avery <cavery@redhat.com>
Subject: [-next] system hangs likely due to "modules: Only return -EEXIST for
 modules that have finished loading"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
x-cbid: 19042613-0008-0000-0000-000002E0837B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042613-0009-0000-0000-0000224CE125
Message-Id: <20190426130736.GB8646@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Prarit,

it looks like your commit f9a75c1d717f ("modules: Only return -EEXIST
for modules that have finished loading") _sometimes_ causes hangs on
s390. This is unfortunately not 100% reproducible, however the
mentioned commit seems to be the only relevant one in modules.c.

What I see is a hanging system with messages like this on the console:

[   65.876040] rcu: INFO: rcu_sched self-detected stall on CPU
[   65.876049] rcu:     7-....: (5999 ticks this GP) idle=eae/1/0x4000000000000002 softirq=1181/1181 fqs=2729
[   65.876078]  (t=6000 jiffies g=-471 q=17196)
[   65.876084] Task dump for CPU 7:
[   65.876088] systemd-udevd   R  running task        0   731    721 0x06000004
[   65.876097] Call Trace:
[   65.876113] ([<0000000000abb264>] __schedule+0x2e4/0x6e0)
[   65.876122]  [<00000000001ee486>] finished_loading+0x4e/0xb0
[   65.876128]  [<00000000001f1ed6>] load_module+0xcce/0x27a0
[   65.876134]  [<00000000001f3af0>] __s390x_sys_init_module+0x148/0x178
[   65.876142]  [<0000000000ac0766>] system_call+0x2aa/0x2c8

crash's backtrace of this task looks like this:

PID: 731    TASK: 1e79ba000         CPU: 7   COMMAND: "systemd-udevd"
 LOWCORE INFO:
  -psw      : 0x0704c00180000000 0x0000000000ab666a
  -function : memcmp at ab666a
  -prefix   : 0x7fe32000
  -cpu timer: 0x7fffff5784d0f048
  -clock cmp: 0xd60757081cd70d00
  -general registers:
     0x0000000000000009 0x0000000000000009
     0x000003ff80347321 000000000000000000
     0x000003ff8034f321 000000000000000000
     0x000000000000001e 0x000003ff8c592708
     0x000003e0047da900 0x000003ff8034f318
     0x0000000000000001 0x0000000000000009
     0x000003ff80347300 0x0000000000ad81b8
     0x00000000001ee062 0x000003e004357cb0
[...]
 #0 [3e004357cf0] load_module at 1f1eb0
 #1 [3e004357dd0] __se_sys_init_module at 1f3af0
 #2 [3e004357ea8] system_call at ac0766
 PSW:  0705000180000000 000003ff8c27ad3e (user space)
 GPRS: 000002aa280d2fb0 000003ff8c27ad3c 0000000000000080 00000000000035fd
       000003ff8c592708 000002aa280c8770 0000000000000000 000002aa280d7130
       0000000000020000 000002aa28915760 000003ff8c592708 000002aa280c00b0
       000003ff8c8fff80 000002aa280c00b0 000003ff8c58a456 000003ffe9cfde90

I did not look any further into the dump, however since the commit
touches exactly the code path which seems to be looping... ;)

