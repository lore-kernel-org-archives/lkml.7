Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF12C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A80A2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbfCAAF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:05:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727806AbfCAAF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 19:05:28 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2104xqZ030980
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 19:05:27 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qxsf20wdt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 19:05:27 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 1 Mar 2019 00:05:25 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Mar 2019 00:05:22 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2105L3i32505966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Mar 2019 00:05:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF757AE057;
        Fri,  1 Mar 2019 00:05:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45636AE04D;
        Fri,  1 Mar 2019 00:05:21 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Mar 2019 00:05:21 +0000 (GMT)
Subject: Re: [PULL REQUEST] Lock down patches
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     jmorris@namei.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Date:   Thu, 28 Feb 2019 19:05:20 -0500
In-Reply-To: <CACdnJuvwnh0PKr5jUTm2h=P5-u-oLgBjvThX+DxcegShXReCdA@mail.gmail.com>
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
         <1551392438.10911.227.camel@linux.ibm.com>
         <CACdnJuvwnh0PKr5jUTm2h=P5-u-oLgBjvThX+DxcegShXReCdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19030100-0020-0000-0000-0000031C9675
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030100-0021-0000-0000-0000216E0ACD
Message-Id: <1551398720.10911.270.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-28 at 15:13 -0800, Matthew Garrett wrote:
> On Thu, Feb 28, 2019 at 2:20 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Thu, 2019-02-28 at 13:28 -0800, Matthew Garrett wrote:
> > > This PR is mostly the same as the previous attempt, but with the
> > > following changes:
> >
> > Where/when was this latest version of the patches posted?
> 
> They should have followed this, but git-send-email choked on some
> reviewed-by: lines so I'm just trying to sort that out.

I'm a little perplexed as to why you would send a pull request, before
re-posting the patches with the changes for review.

> 
> > >
> > > 1) The integration between EFI secure boot and the lockdown state has
> > > been removed
> > > 2) A new CONFIG_KERNEL_LOCK_DOWN_FORCE kconfig option has been added,
> > > which will always enable lockdown regardless of the kernel command
> > > line
> > > 3) The integration with IMA has been dropped for now. Requiring the
> > > use of the IMA secure boot policy when lockdown is enabled isn't
> > > practical for most distributions at the moment, as there's still not a
> > > great deal of infrastructure for shipping packages with appropriate
> > > IMA signatures, and it makes it complicated for end users to manage
> > > custom IMA policies.
> >
> > I'm all in favor of dropping the original attempt to coordinate
> > between the kexec PE and IMA kernel image signatures and the kernel
> > appended and IMA modules signatures, but there has been quite a bit of
> > work recently coordinating the different types of signatures.
> >
> > Preventing systems which do use IMA for signature verification, should
> > not limit their ability to enable "lock down".  Does this version of
> > the "lock down" patches coordinate the different kexec kernel image
> > and kernel module signature verification methods?
> 
> It's a little more complicated than this. We can't just rely on IMA
> appraisal - it has to be based on digital signatures, and the existing
> patch only made that implicit by enabling the secure_boot policy.  

Right, which is the reason the IMA architecture specific policy
requires file signatures. [1][2]

> I
> think we do want to integrate these, but there's a few things we need
> to take into account:
> 
> 1) An integrated solution can't depend on xattrs, both because of the
> lagging support for distributing those signatures but also because we
> need to support filesystems that don't support xattrs

That's not a valid reason for preventing systems that do use IMA for
verifying the kexec kernel image signature or kernel module signatures
from enabling "lock down".  This just means that there needs to be
some coordination between the different signature verification
methods. [1][2]

> 2) An integrated solution can't depend on the current secure_boot
> policy because that requires signed IMA policy updates, but
> distributions have no way of knowing what IMA policy end users require

Both the "CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS" and the IMA
architecture policy rules persist after loading a custom policy.
 Neither of them require loading or signing a custom policy.

> In any case, I do agree that we should aim to make this more
> reasonable - having orthogonal signing code doesn't benefit anyone.
> Once there's solid agreement on that we can extend this support.
> 

Having multiple signature verification methods is going to be around
for a while.  The solution is to coordinate the signature verification
methods, without requiring both types of signatures. [1][2]

[For distros that do enable IMA, enabling the IMA architecture
specific policy enforces the kexec kernel image and kernel modules
signature verification.]

Mimi

[1] Subject: [PATCH v2 0/5] selftests/ima: add kexec and kernel module tests
[2] Patches available from the "next-queued-testing" branch
https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/

