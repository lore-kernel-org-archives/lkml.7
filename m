Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880E7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578432084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDCNzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:55:41 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:52274 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725959AbfDCNzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:55:41 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33DtW6n021944;
        Wed, 3 Apr 2019 08:55:32 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2rm59s20yv-1;
        Wed, 03 Apr 2019 08:55:32 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 215E9611C8BE;
        Wed,  3 Apr 2019 08:56:49 -0500 (CDT)
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 14:55:31 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com
 [198.61.86.93])        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 61B862DD;
        Wed,  3 Apr 2019 14:55:31 +0100 (BST)
Date:   Wed, 3 Apr 2019 14:55:31 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>, <digetx@gmail.com>, <l.stach@pengutronix.de>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Regulator Potential Deadlock
Message-ID: <20190403135531.GB81578@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

Was testing some of my hardware and hit this potential lockup:

Possible unsafe locking scenario:

CPU0                    CPU1
----                    ----
lock((work_completion)(&(&rdev->disable_work)->work));
                        lock(regulator_list_mutex);
                        lock((work_completion)(&(&rdev->disable_work)->work));
lock(regulator_list_mutex);

***
DEADLOCK
***

Looks like it comes from this patch:

commit f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")

The basic problem appears to be that regulator_unregister takes
the regulator_list_mutex and then calls flush_work on
disable_work. But regulator_disable_work calls
regulator_lock_dependent which will also take the
regulator_list_mutex. Resulting in a deadlock if the flush_work
call actually needs to flush the work.

The locking appears to have got quite complex since last time I
looked at it and I am having a little difficulty working out
exactly is protecting what.

I am wondering if the flush_work can just be moved outside the
regulator_list_mutex in regulator_unregister since that mutex
doesn't seem to protect the against the work being queued anyway?
I will keep looking into this over the next couple of days,
any pointers or ideas anyone has would be greatly appreciated.
Finally, as it looks like it might take a couple of days to
figure out the locking, I am leaving on holiday on Saturday
so if you don't see a fix from my by then it might be a couple
of weeks before I can look at it again.

Thanks,
Charles
