Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910F5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68526214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567013164;
	bh=/WgIREJkQrwwjg2dkCfQEKrOY+vrzE8/g2kN/Dagl60=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=pUoLAuUiwIGqRG4SN7nHKQfjS7o5wdO0yKVPpchnORAvq+lqzA2nOy2V+UEJAitzN
	 HM2wzIsQ9dQm2v2gwQgQDmjZnbdsz4UF+IF/dufZNRlY3xs+VvVOkn+miDr0d39Qa8
	 vYguB8aAcP+HWIit9O4qXk0ISfjamMQtHFld17GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfH1R0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:26:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbfH1R0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:26:02 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SHCBLH018155;
        Wed, 28 Aug 2019 13:25:58 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2unuxqd0mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 13:25:57 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7SHF3w6008785;
        Wed, 28 Aug 2019 17:25:56 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 2ujvv776s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 17:25:56 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SHPu4543450632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 17:25:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F370B206E;
        Wed, 28 Aug 2019 17:25:56 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02358B206C;
        Wed, 28 Aug 2019 17:25:55 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 17:25:55 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 89BA616C65DC; Wed, 28 Aug 2019 10:25:57 -0700 (PDT)
Date:   Wed, 28 Aug 2019 10:25:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
Subject: [GIT PULL rcu/next] Supplementary RCU commits for 5.4
Message-ID: <20190828172557.GA30541@linux.ibm.com>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=849 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo,

This pull request contains the following changes:

1.	A one-line change that affects only Tiny RCU that is needed
	by the RISC-V guys, courtesy of Christoph Hellwig.

2.	An update to my email address.	The old one still works, at
	least most of the time.

All of these changes have been subjected to 0day Test Robot and -next
testing, and are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to 049b405029c00f3fd9e4ffa269bdd29b429c4672:

  MAINTAINERS: Update from paulmck@linux.ibm.com to paulmck@kernel.org (2019-08-26 16:27:08 -0700)

----------------------------------------------------------------
Christoph Hellwig (1):
      rcu: Don't include <linux/ktime.h> in rcutiny.h

Paul E. McKenney (1):
      MAINTAINERS: Update from paulmck@linux.ibm.com to paulmck@kernel.org

 MAINTAINERS             | 14 +++++++-------
 include/linux/rcutiny.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)
