Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4524BC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130C820693
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rVdnevkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfFEODP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:03:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53078 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfFEODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:03:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55DsOBa148440;
        Wed, 5 Jun 2019 14:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=4tsHcPK7Le89nZF0U7itmKB/uoQ6GDTehpTv2rwXMVg=;
 b=rVdnevkxhSQo8U7mkfA7nNdt3T7WdXo7a4o9hpKbveCzjaWWzHHExSGo8Fw/JYkbxji2
 bh8O4jGgQGHMnZX3bDvagFX453ylSPHi6yeM+aMRBwIm1rnIuJqGJov1kBXUbvZ4nHu+
 ByJlzuBRKl9Utb3X2mQEfrXMgo/JuPRju6X6m5KB/8qw0TF4t3sfoxXejd9hvjgx8uyO
 DmQh67Nf2TEZKBVkhSy713qCOFx9itnTNi4/Bck+d98jbssOP/2uYrQOStLdxkcmVHLR
 uEisdfqS/1FtxQ+D/ZUtW7+DUzNGO4ncWp9wmJWUfL0KUCSPqofV3a1wOsJGPv399ww2 Bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2suj0qjq26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 14:03:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55E0b2d129062;
        Wed, 5 Jun 2019 14:01:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2swnha5e80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 14:01:11 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x55E1AAo025490;
        Wed, 5 Jun 2019 14:01:10 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Jun 2019 07:01:10 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id E7B766A0116; Wed,  5 Jun 2019 10:01:17 -0400 (EDT)
Date:   Wed, 5 Jun 2019 10:01:17 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        hpa@zytor.com, kanth.ghatraju@oracle.com, ross.philipson@oracle.com
Subject: Re: [PATCH RFC 0/2] x86/boot: Introduce the setup_header2
Message-ID: <20190605140117.GA32106@char.us.oracle.com>
References: <20190524095504.12894-1-daniel.kiper@oracle.com>
 <20190605135031.62grhhxn2pfbkcdg@tomti.i.net-space.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605135031.62grhhxn2pfbkcdg@tomti.i.net-space.pl>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=799
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=890 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 03:50:31PM +0200, Daniel Kiper wrote:
> On Fri, May 24, 2019 at 11:55:02AM +0200, Daniel Kiper wrote:
> > Hi,
> >
> > This change is needed to properly start the Linux kernel in Intel TXT mode and
> > is a part of the TrenchBoot project (https://github.com/TrenchBoot).

Can you please expand more on this?

Nice explanation of why, other alternative solutions that didn't work, and so on.
 
> >
> > Daniel
> >
> >  Documentation/x86/boot.txt               | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  arch/x86/Kconfig                         |  7 +++++++
> >  arch/x86/boot/Makefile                   |  2 +-
> >  arch/x86/boot/compressed/Makefile        |  5 +++--
> >  arch/x86/boot/compressed/setup_header2.S | 18 ++++++++++++++++++
> >  arch/x86/boot/compressed/sl_stub.S       | 28 ++++++++++++++++++++++++++++
> >  arch/x86/boot/header.S                   |  3 ++-
> >  arch/x86/boot/tools/build.c              |  8 ++++++++
> >  arch/x86/include/uapi/asm/bootparam.h    |  1 +
> >  9 files changed, 123 insertions(+), 4 deletions(-)
> >
> > Daniel Kiper (2):
> >       x86/boot: Introduce the setup_header2
> >       x86/boot: Introduce dummy MLE header
> 
> Ping?

Can you add Ingo and Thomas to the To: next time please?

Also please drop the second patch.
> 
> Daniel
