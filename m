Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05C9C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C308120675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfDZPHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:07:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbfDZPHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:07:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QExrS2107054
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 11:07:49 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s41yrgxr0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 11:07:48 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 26 Apr 2019 16:07:46 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Apr 2019 16:07:43 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3QF7gkU37355540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 15:07:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C656C11C058;
        Fri, 26 Apr 2019 15:07:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87C3E11C04C;
        Fri, 26 Apr 2019 15:07:42 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 26 Apr 2019 15:07:42 +0000 (GMT)
Date:   Fri, 26 Apr 2019 17:07:41 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Cathy Avery <cavery@redhat.com>
Subject: Re: [-next] system hangs likely due to "modules: Only return -EEXIST
 for modules that have finished loading"
References: <20190426130736.GB8646@osiris>
 <d4d75ad1-e193-c230-1edc-a93db2b068d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4d75ad1-e193-c230-1edc-a93db2b068d7@redhat.com>
X-TM-AS-GCONF: 00
x-cbid: 19042615-0020-0000-0000-000003368E10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042615-0021-0000-0000-00002188FFEB
Message-Id: <20190426150741.GD8646@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 09:22:34AM -0400, Prarit Bhargava wrote:
> On 4/26/19 9:07 AM, Heiko Carstens wrote:
> > Hello Prarit,
> > 
> > it looks like your commit f9a75c1d717f ("modules: Only return -EEXIST
> > for modules that have finished loading") _sometimes_ causes hangs on
> > s390. This is unfortunately not 100% reproducible, however the
> > mentioned commit seems to be the only relevant one in modules.c.
> > 
> > What I see is a hanging system with messages like this on the console:
> > 
> > [   65.876040] rcu: INFO: rcu_sched self-detected stall on CPU
> > [   65.876049] rcu:     7-....: (5999 ticks this GP) idle=eae/1/0x4000000000000002 softirq=1181/1181 fqs=2729
> > [   65.876078]  (t=6000 jiffies g=-471 q=17196)
> > [   65.876084] Task dump for CPU 7:
> > [   65.876088] systemd-udevd   R  running task        0   731    721 0x06000004
> > [   65.876097] Call Trace:
> > [   65.876113] ([<0000000000abb264>] __schedule+0x2e4/0x6e0)
> > [   65.876122]  [<00000000001ee486>] finished_loading+0x4e/0xb0
> > [   65.876128]  [<00000000001f1ed6>] load_module+0xcce/0x27a0
> > [   65.876134]  [<00000000001f3af0>] __s390x_sys_init_module+0x148/0x178
> > [   65.876142]  [<0000000000ac0766>] system_call+0x2aa/0x2c8
> > I did not look any further into the dump, however since the commit
> > touches exactly the code path which seems to be looping... ;)
> > 
> 
> Ouch :(  I wonder if I exposed a further race or another bug.  Heiko, can you
> determine which module is stuck?  Warning: I have not compiled this code.

Here we go:

[   11.716866] PRARIT: waiting for module s390_trng to load.
[   11.716867] PRARIT: waiting for module s390_trng to load.
[   11.716868] PRARIT: waiting for module s390_trng to load.
[   11.716870] PRARIT: waiting for module s390_trng to load.
[   11.716871] PRARIT: waiting for module s390_trng to load.
[   11.716872] PRARIT: waiting for module s390_trng to load.
[   11.716874] PRARIT: waiting for module s390_trng to load.
[   11.716875] PRARIT: waiting for module s390_trng to load.
[   11.716876] PRARIT: waiting for module s390_trng to load.
[   16.726850] add_unformed_module: 31403529 callbacks suppressed
[   16.726853] PRARIT: waiting for module s390_trng to load.
[   16.726862] PRARIT: waiting for module s390_trng to load.
[   16.726865] PRARIT: waiting for module s390_trng to load.
[   16.726867] PRARIT: waiting for module s390_trng to load.
[   16.726869] PRARIT: waiting for module s390_trng to load.

If I'm not mistaken then there was _no_ corresponding message on the
console stating that the module already exists.

