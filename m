Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2119C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950102077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ryi//oUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfLMKH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:07:57 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33690 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMKH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:07:57 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDA6Vu9160793;
        Fri, 13 Dec 2019 10:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=AKoeB1RqPNNBZudW1VjtdbzEXr+fRKjptWA5OqnDUZY=;
 b=Ryi//oUxON/6AbsjrfhDL8Kq653YUs7wNwH+EKN7V3VXf7R0rCuZX1QlB4Fh7jxzTuaM
 rjSXikzPcV/vgfc33cJeqnFbRGJA1U9MA4BN5dwtv4g4lLkqTC5/uvT0ixpFirf2iUPi
 SmIP8EkN8Xj3WwC8jeB+Tqw+PXax6QiZO7neSaHGR0hBJgdtxqU96qLbO9JNNSWqZ+0z
 3014jDqpv+oCn01Lt4S9iV2qMZR5KGvR60s0D1b7r8V/ua3l06VOyz7pL5Xrcjtz50kZ
 g61VB0ZS3VCrMMOtU+fD6r/9aLtn76gYKjnfqX0J4/rtr2a8JdhBhzIw+lMtRBMevHov 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wr41qr8kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 10:07:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDA6RXx041407;
        Fri, 13 Dec 2019 10:07:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wumu641rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 10:07:48 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBDA7iD8008063;
        Fri, 13 Dec 2019 10:07:44 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 02:07:43 -0800
Date:   Fri, 13 Dec 2019 13:07:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Stephen Boyd <sboyd@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: drivers/clk/ingenic/jz4770-cgu.c:442 jz4770_cgu_init() error: we
 previously assumed 'cgu' could be null (see line 435)
Message-ID: <20191213100737.GC2407@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9455d25f4e3b3d009fa1b810862e5b06229530e4
commit: cd94eade0b2ab7673a97223d09406abf668b7f73 clk: ingenic: Allow drivers to be built with COMPILE_TEST
date:   2 weeks ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/clk/ingenic/jz4770-cgu.c:442 jz4770_cgu_init() error: we previously assumed 'cgu' could be null (see line 435)

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cd94eade0b2ab7673a97223d09406abf668b7f73
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout cd94eade0b2ab7673a97223d09406abf668b7f73
vim +/cgu +442 drivers/clk/ingenic/jz4770-cgu.c

7a01c19007ad3c Paul Cercueil 2018-01-16  429  static void __init jz4770_cgu_init(struct device_node *np)
7a01c19007ad3c Paul Cercueil 2018-01-16  430  {
7a01c19007ad3c Paul Cercueil 2018-01-16  431  	int retval;
7a01c19007ad3c Paul Cercueil 2018-01-16  432  
7a01c19007ad3c Paul Cercueil 2018-01-16  433  	cgu = ingenic_cgu_new(jz4770_cgu_clocks,
7a01c19007ad3c Paul Cercueil 2018-01-16  434  			      ARRAY_SIZE(jz4770_cgu_clocks), np);
7a01c19007ad3c Paul Cercueil 2018-01-16 @435  	if (!cgu)
7a01c19007ad3c Paul Cercueil 2018-01-16  436  		pr_err("%s: failed to initialise CGU\n", __func__);
7a01c19007ad3c Paul Cercueil 2018-01-16  437  
7a01c19007ad3c Paul Cercueil 2018-01-16  438  	retval = ingenic_cgu_register_clocks(cgu);
7a01c19007ad3c Paul Cercueil 2018-01-16  439  	if (retval)
7a01c19007ad3c Paul Cercueil 2018-01-16  440  		pr_err("%s: failed to register CGU Clocks\n", __func__);
7a01c19007ad3c Paul Cercueil 2018-01-16  441  
2ee93e3c953b72 Paul Cercueil 2019-06-11 @442  	ingenic_cgu_register_syscore_ops(cgu);
7a01c19007ad3c Paul Cercueil 2018-01-16  443  }

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
