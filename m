Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D885CC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37C32089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfGAIva convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:51:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726442AbfGAIva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:51:30 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x618m94I050596
        for <linux-kernel@vger.kernel.org>; Mon, 1 Jul 2019 04:51:29 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tfem5s561-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 04:51:28 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Mon, 1 Jul 2019 09:51:25 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 09:51:20 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x618pJ1I50266294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 08:51:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD34042042;
        Mon,  1 Jul 2019 08:51:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E56F42041;
        Mon,  1 Jul 2019 08:51:19 +0000 (GMT)
Received: from localhost (unknown [9.124.35.147])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Jul 2019 08:51:19 +0000 (GMT)
Date:   Mon, 01 Jul 2019 14:21:17 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/7] powerpc/ftrace: Additionally nop out the preceding
 mflr with -mprofile-kernel
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
References: <cover.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
        <841386feda429a1f0d4b7442c3ede1ed91466f92.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
        <20190627110819.4892780f@gandalf.local.home>
        <1561648598.uvetvkj39x.naveen@linux.ibm.com>
        <20190627121344.25b5449a@gandalf.local.home>
In-Reply-To: <20190627121344.25b5449a@gandalf.local.home>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19070108-0020-0000-0000-0000034F14D6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070108-0021-0000-0000-000021A29D96
Message-Id: <1561970917.6b4f6qppo3.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=930 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Thu, 27 Jun 2019 20:58:20 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
>> 
>> > But interesting, I don't see a synchronize_rcu_tasks() call
>> > there.  
>> 
>> We felt we don't need it in this case. We patch the branch to ftrace 
>> with a nop first. Other cpus should see that first. But, now that I 
>> think about it, should we add a memory barrier to ensure the writes get 
>> ordered properly?
> 
> Do you send an ipi to the other CPUs. I would just to be safe.
> 

<snip>

>> 
>> We are handling this through ftrace_replace_code() and 
>> __ftrace_make_call_prep() below. For FTRACE_UPDATE_MAKE_CALL, we patch 
>> in the mflr, followed by smp_call_function(isync) and 
>> synchronize_rcu_tasks() before we proceed to patch the branch to ftrace.
>> 
>> I don't see any other scenario where we end up in 
>> __ftrace_make_nop_kernel() without going through ftrace_replace_code().  
>> For kernel modules, this can happen during module load/init and so, I 
>> patch out both instructions in __ftrace_make_call() above without any 
>> synchronization.
>> 
>> Am I missing anything?
>> 
> 
> No, I think I got confused ;-), it's the patch out that I was worried
> about, but when I was going through the scenario, I somehow turned it
> into the patching in (which I already audited :-p). I was going to
> reply with just the top part of this email, but then the confusion
> started :-/
> 
> OK, yes, patching out should be fine, and you already covered the
> patching in. Sorry for the noise.
> 
> Just to confirm and totally remove the confusion, the patch does:
> 
> 	<func>:
> 	mflr	r0 <-- preempt here
> 	bl	_mcount
> 
> 	<func>:
> 	mflr	r0
> 	nop
> 
> And this is fine regardless.
> 
> OK, Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks for confirming! We do need an IPI to be sure, as you pointed out 
above. I will have the patching out take the same path to simplify 
things.


- Naveen


