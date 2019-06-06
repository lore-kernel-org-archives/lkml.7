Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9525C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A202520883
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qlYdtrGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfFFR3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:29:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52902 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfFFR33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:29:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56HOuSi079163;
        Thu, 6 Jun 2019 17:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=TDbZF773jSoChjtiU4YTRwsZq9wLcLVh4IoX023ZDqI=;
 b=qlYdtrGtNkq/DGUy1Fy3cE4F0JRT0pOjWdfM8BHHilOnc5DY5/X9rfnKM49nW5kQFteu
 GFiEcgizfyig8KGU+oQpIam15N7jiieMQWzwZ6a6UfacUBZDVSrVAc7QppkbZeXwAvMb
 xNZpbZZ1HZRtZDfKfRRIdtyzCUzgDF9zPea5IGl4UdvQJ5Hbn9fa9uIFo5Iq3CtZupKr
 Jpmw83HtEHf/OcRaVL6deHde9JZhTt1TU+rkW5A+jYhyyNXQYCNf7nZmF/nKdw93sF3q
 PHsmqEEksyw814FM9w7R3BqBMCsY/eNlJtmApp4T37nMOFwu8WP4ZHeyLi9pvJsqOBop dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2suevdt5eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 17:29:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56HS4eo085739;
        Thu, 6 Jun 2019 17:29:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2swngjju6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 17:29:24 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x56HTMoW005092;
        Thu, 6 Jun 2019 17:29:22 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Jun 2019 10:29:22 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 6EC486A0125; Thu,  6 Jun 2019 13:30:46 -0400 (EDT)
Date:   Thu, 6 Jun 2019 13:30:46 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        hpa@zytor.com, kanth.ghatraju@oracle.com, ross.philipson@oracle.com
Subject: Re: [PATCH RFC 0/2] x86/boot: Introduce the setup_header2
Message-ID: <20190606173046.GI3252@char.us.oracle.com>
References: <20190524095504.12894-1-daniel.kiper@oracle.com>
 <20190605135031.62grhhxn2pfbkcdg@tomti.i.net-space.pl>
 <20190605140117.GA32106@char.us.oracle.com>
 <20190606115108.sfp2bnu3qzdby4h7@tomti.i.net-space.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606115108.sfp2bnu3qzdby4h7@tomti.i.net-space.pl>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=723
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=817 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 01:51:08PM +0200, Daniel Kiper wrote:
> On Wed, Jun 05, 2019 at 10:01:17AM -0400, Konrad Rzeszutek Wilk wrote:
> > On Wed, Jun 05, 2019 at 03:50:31PM +0200, Daniel Kiper wrote:
> > > On Fri, May 24, 2019 at 11:55:02AM +0200, Daniel Kiper wrote:
> > > > Hi,
> > > >
> > > > This change is needed to properly start the Linux kernel in Intel TXT mode and
> > > > is a part of the TrenchBoot project (https://github.com/TrenchBoot).
> >
> > Can you please expand more on this?
> >
> > Nice explanation of why, other alternative solutions that didn't work, and so on.
> 
> OK.
> 
> > > > Daniel
> > > >
> > > >  Documentation/x86/boot.txt               | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  arch/x86/Kconfig                         |  7 +++++++
> > > >  arch/x86/boot/Makefile                   |  2 +-
> > > >  arch/x86/boot/compressed/Makefile        |  5 +++--
> > > >  arch/x86/boot/compressed/setup_header2.S | 18 ++++++++++++++++++
> > > >  arch/x86/boot/compressed/sl_stub.S       | 28 ++++++++++++++++++++++++++++
> > > >  arch/x86/boot/header.S                   |  3 ++-
> > > >  arch/x86/boot/tools/build.c              |  8 ++++++++
> > > >  arch/x86/include/uapi/asm/bootparam.h    |  1 +
> > > >  9 files changed, 123 insertions(+), 4 deletions(-)
> > > >
> > > > Daniel Kiper (2):
> > > >       x86/boot: Introduce the setup_header2
> > > >       x86/boot: Introduce dummy MLE header
> > >
> > > Ping?
> >
> > Can you add Ingo and Thomas to the To: next time please?
> 
> OK.
> 
> > Also please drop the second patch.
> 
> Why? This is an example how to use the setup_header2.

If you are going to post it as non-RFC (which I suspect you will
for the next), then why post a patch that is not to be checked in?

It just takes people time up.


> 
> Daniel
