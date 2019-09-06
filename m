Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FF7C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4956C20578
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cd/tD6ed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392314AbfIFQmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:42:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58296 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732712AbfIFQmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:42:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x86Gf4KP192982;
        Fri, 6 Sep 2019 16:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=3awWuyJlmxsGduGGHPgHXEbECBSnzzMDoXldXMVeRa0=;
 b=cd/tD6edhiR8Pe7Cgnpsve2ISRfa7T11eNGV4UaUruEY5pAYXaYtYet6Gt4R9iszmTHA
 tqg5KJD5xTz75EUKz9b3WVdd38+e5Y9TzDO94Db+fQIQ2TWAfVUtuCcqXS7edDbYLx48
 3W587A6abviJ1QzPNf797QCnAH8YE8xMSV2wUEb83gmDivteI/+Az4iSCsbLV5xtipRi
 Z9v7/C3rQ1gPtYSTLxo/22zoO4qsnY4brf0XeR6HTFkuP6CBwnDQnr+ksJPlB0EMMeJX
 7EFKzI7MlKB+xYBC3wtaeCtKAuqwEdXvCXtxiKpSgNPkgAwr+zsXiVDybaf3A1utXgeS 3Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2uuu6dr05s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 16:42:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x86GY97P159792;
        Fri, 6 Sep 2019 16:42:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2uu1b9wpp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 16:42:13 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x86GgCqF016491;
        Fri, 6 Sep 2019 16:42:12 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Sep 2019 09:42:12 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id F40D16A00C1; Fri,  6 Sep 2019 12:43:53 -0400 (EDT)
Date:   Fri, 6 Sep 2019 12:43:53 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Johannes Erdfelt <johannes@erdfelt.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        patrick.colp@oracle.com, Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
Message-ID: <20190906164353.GB2840@char.us.oracle.com>
References: <20190905002132.GA26568@otc-nc-03>
 <20190905072029.GB19246@zn.tnic>
 <20190905194044.GA3663@otc-nc-03>
 <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
 <20190905222706.GA4422@otc-nc-03>
 <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
 <20190906144039.GA29569@sventech.com>
 <20190906151617.GE19008@zn.tnic>
 <20190906154618.GB29569@sventech.com>
 <20190906161735.GH19008@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906161735.GH19008@zn.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9372 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909060176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9372 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909060177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Or someone could rewrite arch/x86/ to rediscover new features upon a
> microcode reload or a feature disabling. And do that in a clean way. Who
> knows...

The clean way to do microcode reloading and the vast amount of re-initialization
that has to happen is the definitly what we all want.

It may not surprise you that we have tinkered with this, but what we have
is very far from 'clean'.

Do you have insights on the best way to restructure the code for this?

..snip..

> Practically speaking, late loading probably won't disappear as it is
> being used apparently. Just don't expect that it will get "extended" if
> that extension brings with itself fallout and duct tape fixes left and
> right.

We don't want duct-tape.

I am hoping you can help in figuring out a way that will be acceptable.

We did an analysis of some of the the things that we would need to address
to make this work, but sadly it only covered the "oh crud, this has to
be thought off", but not the overall architecture.

