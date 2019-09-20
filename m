Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEA1C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2166C2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B92q+1tu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438108AbfITK2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:28:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33650 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393456AbfITK2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:28:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8KAONSk009268;
        Fri, 20 Sep 2019 10:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=o/+8VWjq66u4kHcS5rClvAfiki4/PccampY7VYyU+Kk=;
 b=B92q+1tuKam1I3qE2aYQemBNVvDpF6IWI8kLeAFDrrKJHJmj4vZxlWjDbcCBZytg3B9o
 PxvcEyccrLWGAs49aXR1doUSc3WHe32KQCQXJ3GwjfrJwenf6et1W9LEyCnLwiIwKHLa
 gmyvG6SbAsyMxKQCNddVuMEmMz43PX4gjP6wUZxs/QVISVPbl/DSBwa7LRK3n4KiEnEW
 B++4ER4KoZlhsFZGP/BpCoPMeahqqmSIGmMTWSLYLVZ1sdVYP8u1oO8C+Oz8+dw49VFj
 y8dbbP34RHrcdoeeC02sW05xbG0eEdXX/zzyPeO2CGdx9bteTDTxIxfTmDz/N2DH8u2i aA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2v3vb4sk28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Sep 2019 10:28:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8KANZ3k086815;
        Fri, 20 Sep 2019 10:26:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2v4g2v8nun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Sep 2019 10:26:11 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8KAQA4C011944;
        Fri, 20 Sep 2019 10:26:10 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Sep 2019 03:26:09 -0700
Date:   Fri, 20 Sep 2019 13:25:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Steve French <smfrench@gmail.com>,
        Nicolai Stange <nicstange@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Chris Li <christ.li@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org
Subject: Re: checkpatch warnings in sched.h
Message-ID: <20190920102535.GA25547@kadam>
References: <CAH2r5mu1+muust_HA8oOWjYSmH6cLZA-d7pRzGJJsHauoDdJdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mu1+muust_HA8oOWjYSmH6cLZA-d7pRzGJJsHauoDdJdQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909200098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909200098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 02:34:46AM -0500, Steve French wrote:
> Any hints to get rid of the noisy warnings in sched.h that make it
> hard to spot real warnings:
> 
> /include/linux/sched.h:609:43: error: bad integer constant expression
> /include/linux/sched.h:609:73: error: invalid named zero-width bitfield `value'
> 

This is a bug in Sparse and it's way worse than you think.  It actually
disables the real Sparse warnings because now Sparse thinks it has
encountered a parse error.  I think we should just ifdef out that Sparse
code.

The problem is that if you have code like:

	1 ? 1 :__bits_per()

GCC treats that as a compile constant but Sparse says that it's not
because all three elements of the conditional statement have to be
constant.  See the code in evaluate_conditional_expression().  The
complication is that Sparse sets the constant flags before calls
expand_expression() to see what the condition part of the statement is
so the code needs to shuffled around to set the constant bits to match
GCC.

I'm going to #ifdef this out for Smatch later today but someone needs
to do the same thing in Sparse because right now no one can check for
endian bugs until this gets fixed.  It's been broken for a month so
we'll probably get a flood of patches marking functions as static once
we patch this and people start seeing that warning again.

regards,
dan carpenter

