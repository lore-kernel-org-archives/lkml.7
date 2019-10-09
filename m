Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A151DC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A315218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l380up3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfJISse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:48:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41952 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfJISse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:48:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99ITRUL113163;
        Wed, 9 Oct 2019 18:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=X/XlqmLhKdpXdwTSj9Wwj61QnnWxUgg9cTTadrNS07o=;
 b=l380up3gGDjs1AXEw8eYYAUF4Xh0pDZmvYTJ5NKbVXjItsH9NjOUaQk44Tv1q5grs82i
 alLJ22aTzE86n4SM2kQ8EOy7u+uCRTU3OREZcEzxWrWEZYnbNrG7qqSY07RRT1yPh1LS
 60msf4zJWMMc1SKQMv1JyI0U33kihJBFoaaVpsBxeBKy1YI0EOZq1bEoksFkyH9rA872
 IX/fHOWPkPLSxlCWO/NQ2xWa6/96DE1CMW51SYMKHQlxvP0JFsFqWREtNFb7WRNIIWVn
 igzuYmuFyF5bwtuMhbMxO5B5oPn3dRC44v8NNL69UacGvSmUqS18dhSjAJhRYtW6yET9 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vektrpcsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 18:47:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99IS4wb047107;
        Wed, 9 Oct 2019 18:45:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vhhsn42cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 18:45:33 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x99IjV5v010609;
        Wed, 9 Oct 2019 18:45:31 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 11:45:29 -0700
Date:   Wed, 9 Oct 2019 21:45:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] string.h: Mark 34 functions with __must_check
Message-ID: <20191009184518.GF13286@kadam>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
 <954c5d70-742f-7b0e-57ad-ea967e93be89@rasmusvillemoes.dk>
 <20191009135522.GA20194@kadam>
 <b1f055ec-b4ec-d0ed-a03d-7d9828fa9440@rasmusvillemoes.dk>
 <20191009143000.GD13286@kadam>
 <CAKwvOd=Jkd_qJULB+i1u31VJAex6KB=wFAyXO04V0UcAAEZeXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=Jkd_qJULB+i1u31VJAex6KB=wFAyXO04V0UcAAEZeXw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 09:31:41AM -0700, Nick Desaulniers wrote:
> On Wed, Oct 9, 2019 at 7:30 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Wed, Oct 09, 2019 at 04:21:20PM +0200, Rasmus Villemoes wrote:
> > > On 09/10/2019 15.56, Dan Carpenter wrote:
> > > > That's because glibc strlen is annotated with __attribute_pure__ which
> > > > means it has no side effects.
> > >
> > > I know, except it has nothing to do with glibc headers. Just try the
> > > same thing in the kernel. gcc itself knows this about __builtin_strlen()
> > > etc. If anything, we could annotate some of our non-standard functions
> > > (say, memchr_inv) with __pure - then we'd both get the Wunused-value in
> > > the nonsense cases, and allow gcc to optimize or reorder the calls.
> >
> > Huh.  You're right.  GCC already knows.  So this patch is pointless like
> > you say.
> 
> Is it? None of the functions in include/linux/string.h are currently
> marked __pure today.

I've already embarrassed myself with my ignorance once so I may as well
keep talking now...  GCC did complain about the unused result even
though we don't declare them as __pure.  So GCC rule must have this rule
built in.

We were discussing in a different thread that standard says that
memcpy() pointers can't be NULL (even when we're copying zero bytes) so
GCC will assume that's true.  If you have:

	memcpy(foo, bar, 0);

	if (foo)
		*foo = 0;


GCC will sometimes remove the condition.  This doesn't affect the kernel
because we use -fno-delete-null-pointer-checks.
https://groups.google.com/forum/#!msg/syzkaller-netbsd-bugs/8B4CIKN0Xz8/wRvIUWxiAgAJ

Weird, huh?

regards,
dan carpenter

