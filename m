Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0777C0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AF72087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437321AbfHBXFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 19:05:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730376AbfHBXFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 19:05:07 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72Mv1EP022517;
        Fri, 2 Aug 2019 19:05:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4vbvm5qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 19:05:02 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x72Mv3Z6022785;
        Fri, 2 Aug 2019 19:05:02 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4vbvm5pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 19:05:01 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x72MtJ5R004813;
        Fri, 2 Aug 2019 23:05:00 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04dal.us.ibm.com with ESMTP id 2u0e87hgdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 23:05:00 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x72N4xTO53150118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 23:04:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B780FB206B;
        Fri,  2 Aug 2019 23:04:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AD1CB2068;
        Fri,  2 Aug 2019 23:04:59 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Aug 2019 23:04:59 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 96AA116C9A3A; Fri,  2 Aug 2019 16:05:01 -0700 (PDT)
Date:   Fri, 2 Aug 2019 16:05:01 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] locking/locktorture: Replace strncmp with
 str_has_prefix
Message-ID: <20190802230501.GS28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190802014656.8789-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802014656.8789-1-hslester96@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 09:46:56AM +0800, Chuhong Yuan wrote:
> strncmp(str, const, len) is error-prone because len
> is easy to have typo.
> The example is the hard-coded len has counting error
> or sizeof(const) forgets - 1.
> So we prefer using newly introduced str_has_prefix
> to substitute such strncmp.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Queued, thank you!  I updated the commit log as follows.  Please let
me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit e2be525371b2f6790f6c1ab712c3d273fb1f2bea
Author: Chuhong Yuan <hslester96@gmail.com>
Date:   Fri Aug 2 09:46:56 2019 +0800

    locktorture: Replace strncmp() with str_has_prefix()
    
    The strncmp() function is error-prone because it is easy to get the
    length wrong, especially if the string is subject to change, especially
    given the need to account for the terminating nul byte.  This commit
    therefore substitutes the newly introduced str_has_prefix(), which
    does not require a separately specified length.
    
    Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index c513031cd7e3..8dd900247205 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -889,16 +889,16 @@ static int __init lock_torture_init(void)
 		cxt.nrealwriters_stress = 2 * num_online_cpus();
 
 #ifdef CONFIG_DEBUG_MUTEXES
-	if (strncmp(torture_type, "mutex", 5) == 0)
+	if (str_has_prefix(torture_type, "mutex"))
 		cxt.debug_lock = true;
 #endif
 #ifdef CONFIG_DEBUG_RT_MUTEXES
-	if (strncmp(torture_type, "rtmutex", 7) == 0)
+	if (str_has_prefix(torture_type, "rtmutex"))
 		cxt.debug_lock = true;
 #endif
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if ((strncmp(torture_type, "spin", 4) == 0) ||
-	    (strncmp(torture_type, "rw_lock", 7) == 0))
+	if ((str_has_prefix(torture_type, "spin")) ||
+	    (str_has_prefix(torture_type, "rw_lock")))
 		cxt.debug_lock = true;
 #endif
 
