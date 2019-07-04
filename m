Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0C7C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D662083B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfGDOTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 10:19:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726875AbfGDOTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:19:25 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x64EGjuv121340
        for <linux-kernel@vger.kernel.org>; Thu, 4 Jul 2019 10:19:24 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2thhudu0ad-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 10:19:23 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 4 Jul 2019 15:19:23 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Jul 2019 15:19:20 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x64EJJ9E33882572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jul 2019 14:19:19 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7448B2065;
        Thu,  4 Jul 2019 14:19:19 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86017B205F;
        Thu,  4 Jul 2019 14:19:19 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.225.224])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  4 Jul 2019 14:19:19 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 08D3B16C3D0B; Thu,  4 Jul 2019 07:19:20 -0700 (PDT)
Date:   Thu, 4 Jul 2019 07:19:20 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] torture: remove exporting of internal functions
Reply-To: paulmck@linux.ibm.com
References: <20190704125719.31290-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704125719.31290-1-efremov@linux.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19070414-0060-0000-0000-00000358FE3E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011377; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01227338; UDB=6.00646218; IPR=6.01008575;
 MB=3.00027584; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-04 14:19:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070414-0061-0000-0000-00004A03586D
Message-Id: <20190704141919.GD26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 03:57:19PM +0300, Denis Efremov wrote:
> The functions torture_onoff_cleanup, torture_shuffle_cleanup are declared
> as static and marked as EXPORT_SYMBOL. It's a bit confusing for an
> internal function to be exported. The area of visibility for such function
> is its .c file and all other modules. Other *.c files of the same module
> can't use it, despite all other modules can. Relying on the fact that these
> are the internal functions and they are not a crucial part of the API, the
> patch removes the EXPORT_SYMBOL marking of the torture_onoff_cleanup and
> torture_shuffle_cleanup. The patch complements commit cc47ae083026
> ("rcutorture: Abstract torture-test cleanup").
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Good catch, applied, thank you!

I reworked the commit message as follows, so could you please check
to make sure that I didn't fold, spindle, or otherwise mutilate
something?

						Thanx, Paul

------------------------------------------------------------------------

commit 0848a1dfea913f0c384b49a1f61f84b95a4d555a
Author: Denis Efremov <efremov@linux.com>
Date:   Thu Jul 4 15:57:19 2019 +0300

    torture: Remove exporting of internal functions
    
    The functions torture_onoff_cleanup() and torture_shuffle_cleanup()
    are declared static and marked EXPORT_SYMBOL_GPL(), which is at best an
    odd combination.  Because these functions are not used outside of the
    kernel/torture.c file they are defined in, this commit removes their
    EXPORT_SYMBOL_GPL() marking.
    
    Fixes: cc47ae083026 ("rcutorture: Abstract torture-test cleanup")
    Signed-off-by: Denis Efremov <efremov@linux.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/torture.c b/kernel/torture.c
index a8d9bdfba7c3..7c13f5558b71 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -263,7 +263,6 @@ static void torture_onoff_cleanup(void)
 	onoff_task = NULL;
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
 }
-EXPORT_SYMBOL_GPL(torture_onoff_cleanup);
 
 /*
  * Print online/offline testing statistics.
@@ -449,7 +448,6 @@ static void torture_shuffle_cleanup(void)
 	}
 	shuffler_task = NULL;
 }
-EXPORT_SYMBOL_GPL(torture_shuffle_cleanup);
 
 /*
  * Variables for auto-shutdown.  This allows "lights out" torture runs

