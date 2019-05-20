Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEDFC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2543204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbfETI5r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:57:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725372AbfETI5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:57:46 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4K8rT3A025506
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 04:57:45 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2skrbejbu8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 04:57:45 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Mon, 20 May 2019 09:57:43 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 May 2019 09:57:42 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4K8vfca57606158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 08:57:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1910011C058;
        Mon, 20 May 2019 08:57:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EAD311C04C;
        Mon, 20 May 2019 08:57:40 +0000 (GMT)
Received: from localhost (unknown [9.199.34.110])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 May 2019 08:57:40 +0000 (GMT)
Date:   Mon, 20 May 2019 14:27:38 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 4/4] powerpc/ftrace: Additionally nop out the
 preceding mflr with -mprofile-kernel
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1558115654.git.naveen.n.rao@linux.vnet.ibm.com>
        <ee2a5457d98850f51bf96eb17389b375e6955bbf.1558115654.git.naveen.n.rao@linux.vnet.ibm.com>
        <1558144594.f92d1rcmes.astroid@bobo.none>
In-Reply-To: <1558144594.f92d1rcmes.astroid@bobo.none>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19052008-0012-0000-0000-0000031D825E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052008-0013-0000-0000-000021562DB8
Message-Id: <1558342515.q6rtkeahk8.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905200065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Piggin wrote:
> Naveen N. Rao's on May 18, 2019 5:02 am:
>> With -mprofile-kernel, gcc emits 'mflr r0', followed by 'bl _mcount' to
>> enable function tracing and profiling. So far, with dynamic ftrace, we
>> used to only patch out the branch to _mcount(). However, Nick Piggin
>> points out that "mflr is executed by the branch unit that can only
>> execute one per cycle on POWER9 and shared with branches, so it would be
>> nice to avoid it where possible."
>> 
>> We cannot simply nop out the mflr either. Michael Ellerman pointed out
>> that when enabling function tracing, there can be a race if tracing is
>> enabled when some thread was interrupted after executing a nop'ed out
>> mflr. In this case, the thread would execute the now-patched-in branch
>> to _mcount() without having executed the preceding mflr.
>> 
>> To solve this, we now enable function tracing in 2 steps: patch in the
>> mflr instruction, use synchronize_rcu_tasks() to ensure all existing
>> threads make progress, and then patch in the branch to _mcount(). We
>> override ftrace_replace_code() with a powerpc64 variant for this
>> purpose.
>> 
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
> Nice! Thanks for doing a real patch. You needn't add my SOB there: my
> hack was obviously garbage :) Suggested-by if anything, then for
> clarity of changelog you can write the motivation directly rather than
> quote me.

Thanks, I meant to call out the fact that I had added your SOB before
sending the patch, but missed doing so. Your patch was perfectly fine ;)

> 
> I don't know the ftrace subsystem well, but the powerpc instructions
> and patching sequence appears to match what we agreed is the right way
> to go.
> 
> As a suggestion, I would perhaps add most of information from the
> second and third paragraphs of the changelog into comments
> (and also explain that the lone mflr r0 is harmless).
> 
> But otherwise it looks good
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks, I will incorporate those changes.


- Naveen


