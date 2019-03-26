Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1317C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD73C2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lij5X2WX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbfCZKLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:11:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50374 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCZKLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:11:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2QA90Uw038277;
        Tue, 26 Mar 2019 10:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=AB0YaICaasoYS0X63qlpptAXq48WFU6qakXfDgTD7bM=;
 b=Lij5X2WXmkW5XGP+e5GIbKmuFSEOszD8p+YLc+15+A2XpGVK6nLOickJ4fACex1ANrtf
 GlAdIqkLwqSIp4+t+9gyuNEXtnLILKMXwkMSKL628DAHYF6CuYyy5evnJdxPs4OasLkr
 8v/0AUIFV77EFMJf4JcpIlMExLvHuH6+TgS4lX+yBBcfvPq0V2kJ87TtKluN5WjQlAIg
 htGO1oa5AO7IOu+jEl+v00YnXoiqlFsA70J9XSoMketbl5Cr2jd64D88CkRQUhvt5m0z
 IcSPzNZVfb6HK+Be94s/aVJYqxj7eNqxhXhTUoJKup6rwGwi3Jv4nb5WGMq2MniKpSgH 1Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2re6g11cee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 10:11:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2QABMqF010715
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 10:11:23 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2QABF8T029198;
        Tue, 26 Mar 2019 10:11:17 GMT
Received: from kadam (/197.157.0.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Mar 2019 03:11:15 -0700
Date:   Tue, 26 Mar 2019 13:11:04 +0300
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
Message-ID: <20190326101103.GH32613@kadam>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <179bbdd1-3fcb-bba5-52b3-7f96973c7650@web.de>
 <alpine.DEB.2.21.1903232104030.5660@hadrien>
 <20190326084512.GC32590@kadam>
 <alpine.DEB.2.20.1903261037320.5021@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.20.1903261037320.5021@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:38:43AM +0100, Julia Lawall wrote:
> 
> 
> On Tue, 26 Mar 2019, Dan Carpenter wrote:
> 
> > On Sat, Mar 23, 2019 at 09:06:54PM +0100, Julia Lawall wrote:
> > >
> > >
> > > On Sat, 23 Mar 2019, Markus Elfring wrote:
> > >
> > > > > Don't complain about a return when this function returns "&pdev->dev".
> > > >
> > > > Would this information qualify to add the tag “Fixes” to the commit message?
> > >
> > > Fixes tags relate to stable kernels, so that one can see which stable
> > > kernels a particular patch should be propagated to.  There is no need to
> > > propagate patches on semantic patches to stable kernels.  People who run
> > > stable kernels are interested in their behavior, not the bug finding
> > > rules that they contain.
> >
> > The Fixes tag is not just about stable...  For example, we use them for
> > statistics to see how quickly bugs get fixed etc.
> 
> OK.  But still do we need fixes tags for bug finding rules?  Perhaps if
> the previous version was really broken, and it would be really undesirable
> to use it.

It's not worth resending a patch for that, but I probably would use the
fixes tag.  It depends on your definition of "bug" really...  I tell
people not to use Fixes for spelling mistakes and unused variables.  But
I do use the Fixes tag for things like "an off by one in a sanity check
which doesn't affect run time because the index is always correct".

regards,
dan carpenter
