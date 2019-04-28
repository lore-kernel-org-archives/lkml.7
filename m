Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38ABC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 05:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98AC20881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 05:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfD1FpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 01:45:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725999AbfD1FpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 01:45:18 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3S5ckGP108960
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 01:45:16 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s54cfamhm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 01:45:16 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 28 Apr 2019 06:45:14 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 28 Apr 2019 06:45:09 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3S5j8gi45023464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Apr 2019 05:45:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9A88AE055;
        Sun, 28 Apr 2019 05:45:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F4C9AE056;
        Sun, 28 Apr 2019 05:45:07 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 28 Apr 2019 05:45:07 +0000 (GMT)
Date:   Sun, 28 Apr 2019 08:45:05 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 2/7] x86/sci: add core implementation for system call
 isolation
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-3-git-send-email-rppt@linux.ibm.com>
 <20190426074956.GZ4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426074956.GZ4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19042805-0016-0000-0000-00000276086A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042805-0017-0000-0000-000032D28A42
Message-Id: <20190428054505.GC14896@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=518 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904280040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 09:49:56AM +0200, Peter Zijlstra wrote:
> On Fri, Apr 26, 2019 at 12:45:49AM +0300, Mike Rapoport wrote:
> > The initial SCI implementation allows access to any kernel data, but it
> > limits access to the code in the following way:
> > * calls and jumps to known code symbols without offset are allowed
> > * calls and jumps into a known symbol with offset are allowed only if that
> > symbol was already accessed and the offset is in the next page
> > * all other code access are blocked
> 
> So if you have a large function and an in-function jump skips a page
> you're toast.

Right :(
 
> Why not employ the instruction decoder we have and unconditionally allow
> all direct JMP/CALL but verify indirect JMP/CALL and RET ?

Apparently I didn't dig deep enough to find the instruction decoder :)
Surely I can use it.

> Anyway, I'm fearing the overhead of this one, this cannot be fast.

Well, I think that the verification itself is not what will slow things
down the most. IMHO, the major overhead is coming from cr3 switch.

-- 
Sincerely yours,
Mike.

