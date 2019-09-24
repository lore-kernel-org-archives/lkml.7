Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E901EC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F74207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HFVBFgQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504022AbfIXIF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 04:05:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36770 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503939AbfIXIF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:05:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8O7wpam117302;
        Tue, 24 Sep 2019 08:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=oPr+dhTOFwNYEC9AvZ3D35vpN0u2mt/C8zmbQDPs4ac=;
 b=HFVBFgQF0T+MqmMIQobTMPauKSJXXccywfobifO6SP2VcousntBXJfWO//Fq4hpKZinf
 0j8wWm1N8yajtorsqeJPuhqQBk4ZDTrKBe2Pbg4zLKX2dV9RRqwXZ+i50LhLqEPEIZ5+
 thuVIuHbHjnoNobBvffemUmzDLwMpkwZP4wuG7FMJf8mLfZe03jSceGg4LmvkVyrK1yU
 OKOmgtg+2YkOY/uWD43obaQriqlOZjxsLSBa2jmDF8vKgdPrB5EZpbve56gb8XQBU1Wh
 Nj5P9Jfuq4y9i0MA7BYN5ec+p1C2b0My3VvZXLpD2+M8XQlmjoWY/AD+acG0Luuu1Ex7 PQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2v5btpv9gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 08:05:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8O83T0K098806;
        Tue, 24 Sep 2019 08:05:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2v6yvjrx3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 08:05:19 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8O85HqS009562;
        Tue, 24 Sep 2019 08:05:17 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Sep 2019 01:05:16 -0700
Date:   Tue, 24 Sep 2019 11:05:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [rcu:dev.2019.09.23a 62/77] kernel/rcu/tree.c:2882 kfree_call_rcu()
 warn: inconsistent returns 'irqsave:flags'.
Message-ID: <20190924080510.GL20699@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909240081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909240081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.09.23a
head:   97de53b94582c208ee239178b208b8e8b9472585
commit: 39676bb72323718a9e7bab1ba9c4a68319a96f62 [62/77] rcu: Add support for debug_objects debugging for kfree_rcu()

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
kernel/rcu/tree.c:2882 kfree_call_rcu() warn: inconsistent returns 'irqsave:flags'.
  Locked on:   line 2867
  Unlocked on: line 2882

git remote add rcu https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
git remote update rcu
git checkout 39676bb72323718a9e7bab1ba9c4a68319a96f62
vim +2882 kernel/rcu/tree.c

5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2850) void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2851) {
5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2852) 	unsigned long flags;
5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2853) 	struct kfree_rcu_cpu *krcp;
5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2854) 
5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2855) 	head->func = func;
5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2856) 
87970ccf5a9125 Paul E. McKenney        2019-09-19  2857  	local_irq_save(flags);	// For safely calling this_cpu_ptr().
                                                                ^^^^^^^^^^^^^^^^^^^^^
IRQs disabled.

5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2858) 	krcp = this_cpu_ptr(&krc);
ff8db005e371cb Paul E. McKenney        2019-09-19  2859  	if (krcp->initialized)
5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2860) 		spin_lock(&krcp->lock);
5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2861) 
87970ccf5a9125 Paul E. McKenney        2019-09-19  2862  	// Queue the object but don't yet schedule the batch.
39676bb7232371 Joel Fernandes (Google  2019-09-22  2863) 	if (debug_rcu_head_queue(head)) {
39676bb7232371 Joel Fernandes (Google  2019-09-22  2864) 		// Probable double kfree_rcu(), just leak.
39676bb7232371 Joel Fernandes (Google  2019-09-22  2865) 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
39676bb7232371 Joel Fernandes (Google  2019-09-22  2866) 			  __func__, head);
39676bb7232371 Joel Fernandes (Google  2019-09-22  2867) 		return;

Need to re-enable before returning.

39676bb7232371 Joel Fernandes (Google  2019-09-22  2868) 	}
87970ccf5a9125 Paul E. McKenney        2019-09-19  2869  	head->func = func;
5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2870) 	head->next = krcp->head;
5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2871) 	krcp->head = head;
5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2872) 
87970ccf5a9125 Paul E. McKenney        2019-09-19  2873  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
ff8db005e371cb Paul E. McKenney        2019-09-19  2874  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
be39848334e088 Paul E. McKenney        2019-09-22  2875  	    !krcp->monitor_todo) {
be39848334e088 Paul E. McKenney        2019-09-22  2876  		krcp->monitor_todo = true;
5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2877) 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
be39848334e088 Paul E. McKenney        2019-09-22  2878  	}
5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2879) 
ff8db005e371cb Paul E. McKenney        2019-09-19  2880  	if (krcp->initialized)
5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2881) 		spin_unlock(&krcp->lock);
5f5046cc15d514 Joel Fernandes (Google  2019-08-05 @2882) 	local_irq_restore(flags);
5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2883) }
495aa969dbaef2 Andreea-Cristina Bernat 2014-03-18  2884  EXPORT_SYMBOL_GPL(kfree_call_rcu);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
