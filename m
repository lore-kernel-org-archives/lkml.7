Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEE1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126092084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfCAKk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:40:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727492AbfCAKk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:40:27 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x21AeD8G071352
        for <linux-kernel@vger.kernel.org>; Fri, 1 Mar 2019 05:40:25 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qy2cj2da4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 05:40:25 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 1 Mar 2019 10:40:23 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Mar 2019 10:40:16 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x21AeFVQ50724934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Mar 2019 10:40:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEE45A4053;
        Fri,  1 Mar 2019 10:40:15 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDCF6A404D;
        Fri,  1 Mar 2019 10:40:13 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.73])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  1 Mar 2019 10:40:13 +0000 (GMT)
Date:   Fri, 1 Mar 2019 12:40:11 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Matt Hart <matthew.hart@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, khilman@baylibre.com,
        enric.balletbo@collabora.com, Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, info@kernelci.org
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
References: <5c6702da.1c69fb81.12a14.4ece@mx.google.com>
 <20190215104325.039dbbd9c3bfb35b95f9247b@linux-foundation.org>
 <20190215185151.GG7897@sirena.org.uk>
 <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
 <CAPcyv4ivjC8fNkfjdFyaYCAjGh7wtvFQnoPpOcR=VNZ=c6d6Rg@mail.gmail.com>
 <20190228151438.fc44921e66f2f5d393c8d7b4@linux-foundation.org>
 <CAPcyv4hDmmK-L=0txw7L9O8YgvAQxZfVFiSoB4LARRnGQ3UC7Q@mail.gmail.com>
 <026b5082-32f2-e813-5396-e4a148c813ea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <026b5082-32f2-e813-5396-e4a148c813ea@collabora.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19030110-0012-0000-0000-000002FBB841
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030110-0013-0000-0000-0000213367FA
Message-Id: <20190301104011.GB5156@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903010075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 09:25:24AM +0100, Guillaume Tucker wrote:
> On 01/03/2019 00:55, Dan Williams wrote:
> > On Thu, Feb 28, 2019 at 3:14 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >>
> >> On Tue, 26 Feb 2019 16:04:04 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
> >>
> >>> On Tue, Feb 26, 2019 at 4:00 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >>>>
> >>>> On Fri, 15 Feb 2019 18:51:51 +0000 Mark Brown <broonie@kernel.org> wrote:
> >>>>
> >>>>> On Fri, Feb 15, 2019 at 10:43:25AM -0800, Andrew Morton wrote:
> >>>>>> On Fri, 15 Feb 2019 10:20:10 -0800 (PST) "kernelci.org bot" <bot@kernelci.org> wrote:
> >>>>>
> >>>>>>>   Details:    https://kernelci.org/boot/id/5c666ea959b514b017fe6017
> >>>>>>>   Plain log:  https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.txt
> >>>>>>>   HTML log:   https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.html
> >>>>>
> >>>>>> Thanks.
> >>>>>
> >>>>>> But what actually went wrong?  Kernel doesn't boot?
> >>>>>
> >>>>> The linked logs show the kernel dying early in boot before the console
> >>>>> comes up so yeah.  There should be kernel output at the bottom of the
> >>>>> logs.
> >>>>
> >>>> I assume Dan is distracted - I'll keep this patchset on hold until we
> >>>> can get to the bottom of this.
> >>>
> >>> Michal had asked if the free space accounting fix up addressed this
> >>> boot regression? I was awaiting word on that.
> >>
> >> hm, does bot@kernelci.org actually read emails?  Let's try info@ as well..
> 
> bot@kernelci.org is not person, it's a send-only account for
> automated reports.  So no, it doesn't read emails.
> 
> I guess the tricky point here is that the authors of the commits
> found by bisections may not always have the hardware needed to
> reproduce the problem.  So it needs to be dealt with on a
> case-by-case basis: sometimes they do have the hardware,
> sometimes someone else on the list or on CC does, and sometimes
> it's better for the people who have access to the test lab which
> ran the KernelCI test to deal with it.
> 
> This case seems to fall into the last category.  As I have access
> to the Collabora lab, I can do some quick checks to confirm
> whether the proposed patch does fix the issue.  I hadn't realised
> that someone was waiting for this to happen, especially as the
> BeagleBone Black is a very common platform.  Sorry about that,
> I'll take a look today.
> 
> It may be a nice feature to be able to give access to the
> KernelCI test infrastructure to anyone who wants to debug an
> issue reported by KernelCI or verify a fix, so they won't need to
> have the hardware locally.  Something to think about for the
> future.

Another thing to consider is adding "earlyprintk debug" to the kernel
command line for the boot tests.
 
> >> Is it possible to determine whether this regression is still present in
> >> current linux-next?
> 
> I'll try to re-apply the patch that caused the issue, then see if
> the suggested change fixes it.  As far as the current linux-next
> master branch is concerned, KernelCI boot tests are passing fine
> on that platform.
> 
> Guillaume
> 

-- 
Sincerely yours,
Mike.

