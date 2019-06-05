Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F43C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC9020684
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iK5NC642"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfFENup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:50:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39288 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfFENup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:50:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55DmsGb143872;
        Wed, 5 Jun 2019 13:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=l4vcql0vdBgv0fylul1rOHFitrdqfzP4NKQKG4JIh34=;
 b=iK5NC6428xrP1Ri7RuLHiwgYZXygi7BRUlSaWM5et6euuMT4dnOYZAqhYH1j23q+Glzb
 B/lyDEysgJ0+PGbUhMGbFp4ili2fFbyDWxs0DtgW1p4VlNQv/WEReJbxaKiEkzppv9KT
 6TgjTdVVjnezKKuaHLxVcP3/7y5nhtu1GNHLZNqvwBLb6auPA9cdrxJKA0OcmX13nYpT
 SkJv5PMD328yYFmV459wqU7a4Mdf2IQJrg/vK91I/ZfpOHAa4VxhijIKVF9wrsixv4Zt
 FchEsp43i3mflV1/Xcj30B0+BqQ1AvADuJMwJpgViTLIXLFcjPYYZD6Xmyz3LXYTmCcH BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2suj0qjm4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 13:50:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55DoceR064243;
        Wed, 5 Jun 2019 13:50:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2swnhc54q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 13:50:37 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x55DoaSU031971;
        Wed, 5 Jun 2019 13:50:37 GMT
Received: from tomti.i.net-space.pl (/10.175.215.173)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Jun 2019 06:50:35 -0700
Date:   Wed, 5 Jun 2019 15:50:31 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        hpa@zytor.com, kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        ross.philipson@oracle.com
Subject: Re: [PATCH RFC 0/2] x86/boot: Introduce the setup_header2
Message-ID: <20190605135031.62grhhxn2pfbkcdg@tomti.i.net-space.pl>
References: <20190524095504.12894-1-daniel.kiper@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524095504.12894-1-daniel.kiper@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=643
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=674 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:55:02AM +0200, Daniel Kiper wrote:
> Hi,
>
> This change is needed to properly start the Linux kernel in Intel TXT mode and
> is a part of the TrenchBoot project (https://github.com/TrenchBoot).
>
> Daniel
>
>  Documentation/x86/boot.txt               | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  arch/x86/Kconfig                         |  7 +++++++
>  arch/x86/boot/Makefile                   |  2 +-
>  arch/x86/boot/compressed/Makefile        |  5 +++--
>  arch/x86/boot/compressed/setup_header2.S | 18 ++++++++++++++++++
>  arch/x86/boot/compressed/sl_stub.S       | 28 ++++++++++++++++++++++++++++
>  arch/x86/boot/header.S                   |  3 ++-
>  arch/x86/boot/tools/build.c              |  8 ++++++++
>  arch/x86/include/uapi/asm/bootparam.h    |  1 +
>  9 files changed, 123 insertions(+), 4 deletions(-)
>
> Daniel Kiper (2):
>       x86/boot: Introduce the setup_header2
>       x86/boot: Introduce dummy MLE header

Ping?

Daniel
