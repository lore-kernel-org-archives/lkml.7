Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D469DCA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D9A208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HAQhKnpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbfJ1H57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:57:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36440 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731140AbfJ1H57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:57:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9S7s6n4177032;
        Mon, 28 Oct 2019 07:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=jQ6PJCli6p5m7RwQspPzyqTvse7VkcpWcjvd3zOJ4+A=;
 b=HAQhKnprpT+rni6UrLSaaxlllVPKP9qFG9g/DnYovW+Mey13732trRR/riMkNnRM66Fn
 gl7+/0Gc0h4RVBzI/RlvZ5ewCa+Jh8JsFdLxEhMof//9KM4oWmqxuAg6Iu22b74X/Hg5
 b325kHQWHNF2LPUsPxCy7bAdIUu6yqsZlHjduOVuIjVUEkR9w2u6qSeZGqM9IRXopZJT
 tl25BUtCGQvLWQPAl8gIpD1LotwFU0P6kx+GMTjOEkDLAeWyzHqNozAKQHHEKnZHfarK
 PJJOeZcQU6AkeYMFNqBs9JumOrSSdf5aqsQH78Kfl9E5zmX+aFSOgTBx1R/sE+tLebyS jA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vvumf50na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 07:57:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9S7s07f105156;
        Mon, 28 Oct 2019 07:57:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vw09f7h59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 07:57:50 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9S7vmEl029995;
        Mon, 28 Oct 2019 07:57:49 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Oct 2019 00:57:47 -0700
Date:   Mon, 28 Oct 2019 10:57:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Cristiane Naves <cristianenavescardoso09@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [RESEND PATCH] staging: gasket: Fix lines ending with a '('
Message-ID: <20191028075738.GC1944@kadam>
References: <20191025232935.GA813@cristiane-Inspiron-5420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025232935.GA813@cristiane-Inspiron-5420>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9423 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910280079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9423 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910280079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I see a RESEND in the subject, that means you are tell us we messed
up and accidentally ignored your patch.  So then we have to figure out
what went wrong with the process and so we don't mess up again.

It would help us if you put a note under the --- cut off like "I sent
this a month ago and never received a response.  Here is a link to the
email archive so I know that it made it to the list."

I recently had an issue like this where I complained that my patch
wasn't applied and the maintainer said "Oh.  That's odd.  I have it
written down in patchword that I emailed you to ask you do fix the bug
in a different way."  So these sorts of mistakes happen.

regards,
dan carpenter


