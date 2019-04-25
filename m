Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1907FC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 03:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E078B2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 03:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbfDYDWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 23:22:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388852AbfDYDWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 23:22:37 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3P394kO146903
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 23:22:36 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s31bd75ys-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 23:22:36 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Thu, 25 Apr 2019 04:22:34 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Apr 2019 04:22:31 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3P3MUPQ57147490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 03:22:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F8EC4C058;
        Thu, 25 Apr 2019 03:22:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44FE84C044;
        Thu, 25 Apr 2019 03:22:29 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.124.31.152])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 25 Apr 2019 03:22:29 +0000 (GMT)
Date:   Thu, 25 Apr 2019 08:52:24 +0530
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] stacktrace: Remove superfluous WARN_ONCE() from
 save_stack_trace_tsk_reliable()
References: <20190424085550.29612-1-pmladek@suse.com>
 <20190424085550.29612-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424085550.29612-3-pmladek@suse.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-TM-AS-GCONF: 00
x-cbid: 19042503-0008-0000-0000-000002DEE9AF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042503-0009-0000-0000-0000224B40F9
Message-Id: <20190425032224.GB24416@JAVRIS.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=784 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904250020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:55:49AM +0200, Petr Mladek wrote:
> WARN_ONCE() in the generic save_stack_trace_tsk_reliable() is superfluous.
> The only current user klp_check_stack() writes its own warning when
> -ENOSYS is returned.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

-- 
Kamalesh

