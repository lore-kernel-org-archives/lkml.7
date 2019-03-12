Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56534C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A00213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfCLU4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:56:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbfCLU4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:56:35 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2CKhfeT085060
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 16:56:34 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r6h93t8py-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 16:56:33 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 12 Mar 2019 20:56:31 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Mar 2019 20:56:27 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2CKuRgD22282462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 20:56:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E12814C046;
        Tue, 12 Mar 2019 20:56:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2FB14C04A;
        Tue, 12 Mar 2019 20:56:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.217])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Mar 2019 20:56:25 +0000 (GMT)
Subject: Re: [PATCH] tpm: Make timeout logic simpler and more robust
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Calvin Owens <calvinowens@fb.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Date:   Tue, 12 Mar 2019 16:56:15 -0400
In-Reply-To: <20190312200820.GB5058@Haydn>
References: <358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com>
         <1552410298.24794.73.camel@linux.ibm.com> <20190312200820.GB5058@Haydn>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031220-0020-0000-0000-00000321CCEE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031220-0021-0000-0000-00002173FA8D
Message-Id: <1552424175.24794.105.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903120140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-12 at 20:08 +0000, Calvin Owens wrote:
> On Tuesday 03/12 at 13:04 -0400, Mimi Zohar wrote:
> > On Mon, 2019-03-11 at 16:54 -0700, Calvin Owens wrote:
> > > We're having lots of problems with TPM commands timing out, and we're
> > > seeing these problems across lots of different hardware (both v1/v2).
> > > 
> > > I instrumented the driver to collect latency data, but I wasn't able to
> > > find any specific timeout to fix: it seems like many of them are too
> > > aggressive. So I tried replacing all the timeout logic with a single
> > > universal long timeout, and found that makes our TPMs 100% reliable.
> > > 
> > > Given that this timeout logic is very complex, problematic, and appears
> > > to serve no real purpose, I propose simply deleting all of it.
> > 
> > Normally before sending such a massive change like this, included in
> > the bug report or patch description, there would be some indication as
> > to which kernel introduced a regression.  Has this always been a
> > problem? Is this something new? How new?
> 
> Honestly we've always had problems with flakiness from these devices,
> but it seems to have regressed sometime between 4.11 and 4.16.

Well, that's a start.  Around 4.10 is when we started noticing TPM
performance issues due to the change in the kernel timer scheduling.
 This resulted in commit a233a0289cf9 ("tpm: msleep() delays - replace
with usleep_range() in i2c nuvoton driver"), which was upstreamed in
4.12.

At the other end, James was referring to commit "424eaf910c32 tpm:
reduce polling time to usecs for even finer granularity", which was
introduced in 4.18.

> 
> I wish a had a better answer for you: we need on the order of a hundred
> machines to see the difference, and setting up these 100+ machine tests
> is unfortunately involved enough that e.g. bisecting it just isn't
> feasible :/

> What I can say for sure is that this patch makes everything much better
> for us. If there's anything in particular you'd like me to test, I have
> an army of machines I'm happy to put to use, let me know :)

I would assume not all of your machines are the same nor have the same
TPM.  Could you verify that this problem is across the board, not
limited to a particular TPM.

BTW, are you seeing this problem with both TPM 1.2 or 2.0?

thanks!

Mimi

