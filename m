Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5306CC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 00:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2376B2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 00:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P3mMFML7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfHPABy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 20:01:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42194 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfHPABx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 20:01:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FNwv05174055;
        Fri, 16 Aug 2019 00:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=YH3Xo/swmlttbevlnMC/uKir6epT0KVbjLdgUOEwni0=;
 b=P3mMFML7WJfraHz1KSml8qZnLvSI54/a1JE9ilwIncSwiyKlhMycwqc+fr53YFG9n+7h
 S0Qs7mbqUvHz9iFYPW75dNVmwMHdToa/sX53adXmywjvPIz7SdqIUpXaqFl2UUX+HeIZ
 L43U2AnU204Pqk/TL1M9S+vHidimNvrVa2fuaiV2nM98i3UDogHzWT5q/t5gWyny4BvN
 V1WRtVzjk5QTzVYV9+qDaQMHy46606k+MpVyk1DLoUU5xmaRAOwtS0Ta15I6E1U/ex9c
 hLvc4f/LQntZ3zDgR1K0RVz8QP9mq74jAkfLlpMLw7hvF+wAZG7roVzNv/G/91dmy7eS Pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u9pjqwgdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 00:01:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FNwj5W059373;
        Fri, 16 Aug 2019 00:01:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2udgqfh5us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 00:01:50 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7G01nsn030693;
        Fri, 16 Aug 2019 00:01:50 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 17:01:49 -0700
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Subject: Panic on v5.3-rc4
Message-ID: <2561aeca-2263-00a7-d088-67a81a6c8b59@oracle.com>
Date:   Thu, 15 Aug 2019 16:57:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150231
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting the following panic during boot of tag v5.3-rc4 of
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git. I don't
see the panic on tag v5.2 on same rig. Is it a bug or something
legitimately changed?

Thanks,
Subhra

[  147.184948] dracut Warning: No root device 
"block:/dev/mapper/vg_paex623-lv_root" found


[  147.282665] dracut Warning: LVM vg_paex623/lv_swap not found


[  147.354854] dracut Warning: LVM vg_paex623/lv_root not found

[  147.432099] dracut Warning: Boot has failed. To debug this issue add 
"rdshell" to the kernel command line.
[  147.549737] dracut Warning: Signal caught!


[  147.600145] dracut Warning: LVM vg_paex623/lv_swap not found
[  147.670692] dracut Warning: LVM vg_paex623/lv_root not found

[  147.738593] dracut Warning: Boot has failed. To debug this issue add 
"rdshell" to the kernel command line.
[  147.856206] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x00000100
[  147.947859] CPU: 3 PID: 1 Comm: init Not tainted 
5.3.0-rc4latency_nice_BL #3
[  148.032225] Hardware name: Oracle Corporation ORACLE SERVER 
X6-2L/ASM,MOBO TRAY,2U, BIOS 39050100 08/30/2016
[  148.149879] Call Trace:
[  148.179117] dump_stack+0x5c/0x7b
[  148.218760] panic+0xfe/0x2e2
[  148.254242] do_exit+0xbd8/0xbe0
[  148.292842] do_group_exit+0x3a/0xa0
[  148.335597] __x64_sys_exit_group+0x14/0x20
[  148.385644] do_syscall_64+0x5b/0x1d0
[  148.429448] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  148.489900] RIP: 0033:0x3a5ccad018
[  148.530582] Code: Bad RIP value.
[  148.569178] RSP: 002b:00007ffc147a5b48 EFLAGS: 00000246 ORIG_RAX: 
00000000000000e7
[  148.659791] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 
0000003a5ccad018
[  148.745197] RDX: 0000000000000001 RSI: 000000000000003c RDI: 
0000000000000001
[  148.830605] RBP: 0000000000000000 R08: 00000000000000e7 R09: 
ffffffffffffffa8
[  148.916011] R10: 0000000000000001 R11: 0000000000000246 R12: 
0000000000401fb0
[  149.001414] R13: 00007ffc147a5e20 R14: 0000000000000000 R15: 
0000000000000000
[  149.086929] Kernel Offset: disabled
[  149.132815] ---[ end Kernel panic - not syncing: Attempted to kill 
init! exitcode=0x00000100 ]---

