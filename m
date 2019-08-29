Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B65C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F49523426
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfH2OdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:33:20 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:18328 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726739AbfH2OdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:33:19 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7TEQnDw028837;
        Thu, 29 Aug 2019 14:33:07 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 2upduehe61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 14:33:07 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 994DA8C;
        Thu, 29 Aug 2019 14:33:06 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 1A59646;
        Thu, 29 Aug 2019 14:33:06 +0000 (UTC)
Date:   Thu, 29 Aug 2019 09:33:05 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Subject: Re: Purgatory compile flag changes apparently causing Kexec
 relocation overflows
Message-ID: <20190829143305.GD29967@swahl-linux>
References: <20190828194226.GA29967@swahl-linux>
 <CAKwvOdn0=7YabPD-5EUwkSoJgWjdYHY2mirM2LUz0TxZTBOf_Q@mail.gmail.com>
 <20190828221048.GB29967@swahl-linux>
 <CAKwvOdnaxZuJHpbmMzdtKSZD10m3Rd52FdHeq2gvkas3XVmk7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnaxZuJHpbmMzdtKSZD10m3Rd52FdHeq2gvkas3XVmk7w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-29_06:2019-08-29,2019-08-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=674
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908290158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 03:22:13PM -0700, Nick Desaulniers wrote:
> 
> One point that might be more useful first would be, is a revert of:
> 
> commit b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than
> reset KBUILD_CFLAGS")
> 
> good enough, or must:
> 
> commit 4ce97317f41d ("x86/purgatory: Do not use __builtin_memcpy and
> __builtin_memset")
> 
> be reverted additionally?  They were part of a 2 patch patchset.  I
> would prefer tglx to revert as few patches as necessary if possible
> (to avoid "revert of revert" soup), and I doubt the latter patch needs
> to be reverted.  (Even more preferential would be a fix, with no
> reverts, but whichever).

A revert of the single commit is sufficient.  Previously I have
checked out and compiled the tree at commit b059f801a937 and
b059f801a937^ (with caret, the previous commit).  It worked with the
previous commit, but not with b059f801a937.

4ce97317f41d *is* the previous commit to b059f801a937, so it was in
both kernels that I tested:

$ git log -1 --oneline b059f801a937^ | cat
4ce97317f41d x86/purgatory: Do not use __builtin_memcpy and __builtin_memset
$ 

And, I also did an exploratory 'git revert b059f801a937' at the tip of
the tree.  That corrects the problem as well.

So both say that it's only the single commit that would need to be
reverted *if* that's the route taken.

Now, on to seeing if we can narrow this down to a fix with no reverts
instead.

--> Steve
-- 
Steve Wahl, Hewlett Packard Enterprise
