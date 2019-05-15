Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90266C04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C48F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEOGuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:50:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfEOGuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:50:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4F6g2Ll116201
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 02:50:09 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sgdaysg69-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 02:50:08 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 15 May 2019 07:50:06 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 May 2019 07:50:03 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4F6o2hg53477432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 06:50:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32F434203F;
        Wed, 15 May 2019 06:50:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAD4D42042;
        Wed, 15 May 2019 06:49:59 +0000 (GMT)
Received: from [9.85.89.71] (unknown [9.85.89.71])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 May 2019 06:49:59 +0000 (GMT)
Subject: Re: [PATCH V2 1/3] perf parse-regs: Split parse_regs
To:     kan.liang@linux.intel.com, acme@kernel.org
Cc:     jolsa@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <1557865174-56264-1-git-send-email-kan.liang@linux.intel.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 15 May 2019 12:19:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557865174-56264-1-git-send-email-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051506-0020-0000-0000-0000033CD12B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051506-0021-0000-0000-0000218F90CD
Message-Id: <02cd8171-3dbf-b835-3fe0-245f6fbea1cb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=841 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/15/19 1:49 AM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The available registers for --int-regs and --user-regs may be different,
> e.g. XMM registers.
> 
> Split parse_regs into two dedicated functions for --int-regs and
> --user-regs respectively.
> 
> Modify the warning message. "--user-regs=?" should be applied to show
> the available registers for --user-regs.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---

For patch 1 and 2,
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Minor neat. Should we update document as well? May be something like:

  tools/perf/Documentation/perf-record.txt

  --user-regs::
  Similar to -I, but capture user registers at sample time. To list the available
  user registers use --user-regs=\?.

Ravi

