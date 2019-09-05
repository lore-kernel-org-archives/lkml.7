Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F2FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A1B2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390354AbfIEPHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:07:53 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:49626 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731338AbfIEPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:07:53 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85F78fS007860;
        Thu, 5 Sep 2019 15:07:40 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com with ESMTP id 2uttq6mv5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 15:07:40 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 2D01E62;
        Thu,  5 Sep 2019 15:07:39 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 8454356;
        Thu,  5 Sep 2019 15:07:38 +0000 (UTC)
Date:   Thu, 5 Sep 2019 10:07:38 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, vaibhavrustagi@google.com,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        mike.travis@hpe.com
Subject: Re: [PATCH 1/1] x86/purgatory: Change compiler flags to avoid
 relocation errors.
Message-ID: <20190905150738.GD14263@swahl-linux>
References: <20190904214505.GA15093@swahl-linux>
 <20190905091514.GA21479@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905091514.GA21479@zn.tnic>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_05:2019-09-04,2019-09-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=708 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909050144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 11:15:14AM +0200, Borislav Petkov wrote:
> On Wed, Sep 04, 2019 at 04:45:05PM -0500, Steve Wahl wrote:
> > The last change to this Makefile caused relocation errors when loading
> > a kdump kernel.
> 
> How do those relocation errors look like?

kexec: Overflow in relocation type 11 value 0x11fffd000

... when loading the crash kernel.

> What exactly caused those errors, the flags removal from
> kexec-purgatory.o?

No, it's the flags for compiling the other objects (purgatory.o,
sha256.o, and string.o) that cause the problem.  You may have missed
the added initial values for PURGATORY_CFLAGS_REMOVE and
PURGATORY_CFLAGS.  This changes -mcmodel=kernel back to
-mcmodel=large, and adds back -ffreestanding and
-fno-zero-initialized-in-bss, to match the previous flags.

-mcmodel=kernel is the major cause of the relocation errors, as the
code generated contained only 32 bit references to things that can be
anywhere in 64 bit address space.

The remaining flag changes are appropriate for compiling a standalone
module, which applies to 3 of the objects compiled from C files in
this directory -- they contribute to a standalone piece of code that
is not (technically) linked with the rest of the kernel.

(Fine line here: the standalone binary does not get any symbols
resolved against the rest of the kernel; which is why I say it's not
*linked* with it.  The binary image of this standalone binary does get
put into a character array that is pulled into the kernel object code,
so it does become part of the kernel, but just as an array of bytes
that kexec copies somewhere and eventually jumps to as a standalone
program.)

kexec-purgatory.o, on the other hand, does get linked with the rest of
the kernel and should be compiled with the usual flags, not standalone
flags. That is why changes for it are a bit different, which you
noticed.

> Can we have the failure properly explained in the commit message pls?

Is " 'kexec: Overflow in relocation type 11 value 0x11fffd000' when
loading the crash kernel" sufficient, or would you like more?

> > This change restores the appropriate flags, without
> 
> You don't have to say "This change" in the commit message - it is
> obvious which change you're talking about. Instead say: "Restore the
> appropriate... "

OK.

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise
