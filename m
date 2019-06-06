Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A90C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E78C206E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wanoNWQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfFFLvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:51:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38248 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfFFLvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:51:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56BmbV5161383;
        Thu, 6 Jun 2019 11:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=AeEmQlVa60NFeNwlopFn58+AzrkSf/eEmYtRH4FR7F8=;
 b=wanoNWQPZslnUGgXFwf6LLeoE0W1BFVtILJRJkTtvnUjbB+PNN71azhb4E9/zD1Zny+Q
 bxnuG7q/kiKswaMHznGApIHJIO16YdG80p1jFLCJ+0ZmFfrJY56OxqKIfYpKwnXpAbkp
 KdApJTkAcv6s0P5NuAuSN/rmGAK0rPn9bIwAnXUzPhg1L65TS2nUFZ2p9Q7tuSMazHr7
 e831V5NMNGxEF/S+edSeQN35j/vYxt+mVoSuof8oHQkNFjqvwUhy+7Uy5ixWPxC+DDul
 EmxnQj8xv1FZuaRvc4aR1HaOwy99iULejVJXJ4PFcHeO55Y/3hyYs17bMDAljrhf3RQp PQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2suj0qqtk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 11:51:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56Bp0WU139886;
        Thu, 6 Jun 2019 11:51:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2swnhcn59j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 11:51:16 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x56BpDCL014710;
        Thu, 6 Jun 2019 11:51:14 GMT
Received: from tomti.i.net-space.pl (/10.175.219.193)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Jun 2019 04:51:13 -0700
Date:   Thu, 6 Jun 2019 13:51:08 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        hpa@zytor.com, kanth.ghatraju@oracle.com, ross.philipson@oracle.com
Subject: Re: [PATCH RFC 0/2] x86/boot: Introduce the setup_header2
Message-ID: <20190606115108.sfp2bnu3qzdby4h7@tomti.i.net-space.pl>
References: <20190524095504.12894-1-daniel.kiper@oracle.com>
 <20190605135031.62grhhxn2pfbkcdg@tomti.i.net-space.pl>
 <20190605140117.GA32106@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605140117.GA32106@char.us.oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=661
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=752 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 10:01:17AM -0400, Konrad Rzeszutek Wilk wrote:
> On Wed, Jun 05, 2019 at 03:50:31PM +0200, Daniel Kiper wrote:
> > On Fri, May 24, 2019 at 11:55:02AM +0200, Daniel Kiper wrote:
> > > Hi,
> > >
> > > This change is needed to properly start the Linux kernel in Intel TXT mode and
> > > is a part of the TrenchBoot project (https://github.com/TrenchBoot).
>
> Can you please expand more on this?
>
> Nice explanation of why, other alternative solutions that didn't work, and so on.

OK.

> > > Daniel
> > >
> > >  Documentation/x86/boot.txt               | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  arch/x86/Kconfig                         |  7 +++++++
> > >  arch/x86/boot/Makefile                   |  2 +-
> > >  arch/x86/boot/compressed/Makefile        |  5 +++--
> > >  arch/x86/boot/compressed/setup_header2.S | 18 ++++++++++++++++++
> > >  arch/x86/boot/compressed/sl_stub.S       | 28 ++++++++++++++++++++++++++++
> > >  arch/x86/boot/header.S                   |  3 ++-
> > >  arch/x86/boot/tools/build.c              |  8 ++++++++
> > >  arch/x86/include/uapi/asm/bootparam.h    |  1 +
> > >  9 files changed, 123 insertions(+), 4 deletions(-)
> > >
> > > Daniel Kiper (2):
> > >       x86/boot: Introduce the setup_header2
> > >       x86/boot: Introduce dummy MLE header
> >
> > Ping?
>
> Can you add Ingo and Thomas to the To: next time please?

OK.

> Also please drop the second patch.

Why? This is an example how to use the setup_header2.

Daniel
