Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246BCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E795720856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TBE+c2Rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbfCZIpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:45:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35488 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZIpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:45:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2Q8hp7P166651;
        Tue, 26 Mar 2019 08:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=3U0zNVC0lsiCPw7uX8AGQ0P64csD1XLhYs6Pbs0Lzu4=;
 b=TBE+c2RlEdMzZ5yq+N8rdn1JykFiy1t3XjVBBtI6Xbgg1MxzFR5k4omO74oZmilJO/Rh
 tnCO1nLRqbFxuX4f8GRLy1bMarte09V2o3+uLDW83ri6W8aiHPLvq69Nw/Sp2qN9k9E8
 AbOQkD5qxOErmTLuKAavpTWgzYpVUgxRRRKdCh0PDoAbBkbXLvQPzbjVAWf9/qTNQbFE
 X/v0J30VK/RQEWp6ARgCs0E2RsCBbaJK1Qb/V/sqIiHNdNnO99pgpQ3XoOpwpkvgBwxC
 Niq2cqEgws8dQGHOHmdYs007LLh2FShOyZFnR6gKrLFF3f6dkhWqZ3aji/3v+Xw/dQsJ vw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2re6dj908m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 08:45:32 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q8jUqa025403
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 08:45:30 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2Q8jPNv023446;
        Tue, 26 Mar 2019 08:45:25 GMT
Received: from kadam (/197.157.0.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Mar 2019 01:45:24 -0700
Date:   Tue, 26 Mar 2019 11:45:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [PATCH] coccinelle: put_device: reduce false positives
Message-ID: <20190326084512.GC32590@kadam>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <179bbdd1-3fcb-bba5-52b3-7f96973c7650@web.de>
 <alpine.DEB.2.21.1903232104030.5660@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1903232104030.5660@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=861 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 09:06:54PM +0100, Julia Lawall wrote:
> 
> 
> On Sat, 23 Mar 2019, Markus Elfring wrote:
> 
> > > Don't complain about a return when this function returns "&pdev->dev".
> >
> > Would this information qualify to add the tag “Fixes” to the commit message?
> 
> Fixes tags relate to stable kernels, so that one can see which stable
> kernels a particular patch should be propagated to.  There is no need to
> propagate patches on semantic patches to stable kernels.  People who run
> stable kernels are interested in their behavior, not the bug finding
> rules that they contain.

The Fixes tag is not just about stable...  For example, we use them for
statistics to see how quickly bugs get fixed etc.

regards,
dan carpenter

