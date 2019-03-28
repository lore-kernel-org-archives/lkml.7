Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429F3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA1F21773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LjmDLUau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfC1MVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:21:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54886 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfC1MVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:21:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2SC990c126397;
        Thu, 28 Mar 2019 12:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=W9Enll0htYA1EXDV14AIj5B2PgkiEFBryMG52keRzrI=;
 b=LjmDLUauWNnWGr0Xm7jD3x6zGT6J0RxkRfv0Df4EqrkNPloXAvQBicK8Mc9g2Bj8s/5V
 RGtHOvIzP2bOumCNvxuy81+PwiUk3pQwc/qnmO1J44zrUjSUAwcHTzKnhu+LckAue8th
 yAJg3d6Yy15YNQDKmzxLEVBfIrOrEk9q9QJgRSjNH/dS6ZbYprLQ3Mrnfdfr3NDtqwgL
 Eq1aUEnwIVqBm+hCeNPdqiQ0BiNSFQnOYMoXAWHBdgR7BLpTvbN1JTGDhN6umIPUFNuB
 4rGYv/F8P1MsB25cGmNayINpgIIzfz35KIEw9a1osj1rnou/ppWwvgZvQR+VuyhrIeHG 5Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2re6djp775-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 12:20:45 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2SCKhKJ006257
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 12:20:43 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2SCKYmX030050;
        Thu, 28 Mar 2019 12:20:35 GMT
Received: from kadam (/41.202.241.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Mar 2019 05:20:34 -0700
Date:   Thu, 28 Mar 2019 15:20:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     wen.yang99@zte.com.cn, yamada.masahiro@socionext.com,
        Markus.Elfring@web.de, Gilles.Muller@lip6.fr,
        nicolas.palix@imag.fr, michal.lkml@markovi.net,
        yellowriver2010@hotmail.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: =?utf-8?B?562U5aSNOiBSZTogW3Y1?= =?utf-8?Q?=5D?= coccinelle:
 semantic code search for missing put_device()
Message-ID: <20190328122022.GG32590@kadam>
References: <201903281010336645826@zte.com.cn>
 <alpine.DEB.2.21.1903280708590.2756@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903280708590.2756@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9208 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=926 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 07:09:22AM +0100, Julia Lawall wrote:
> 
> 
> On Thu, 28 Mar 2019, wen.yang99@zte.com.cn wrote:
> 
> > > > > When I searched "Wen Yang", v6 did not show up for some reasons.
> > > > > https://lore.kernel.org/patchwork/project/lkml/list/?series=&submitter=22638&state=*&q=&archive=&delegate=
> > > >
> > > > I find such a situation also interesting somehow.
> > > > I assume that there was another temporary technical difficulty involved
> > > > with the Linux mailing list (and related information systems).
> > >
> > >
> > > I think v6 fell into a crack somehow.
> > >
> > >
> > > Check the LKML archive:
> > > https://lkml.org/lkml/2019/2/16
> > >
> > >
> > > I see your reply:
> > >
> > > Re: [v6] coccinelle: semantic code search for missing put_device()Markus Elfring
> > >
> > >
> > > But, I cannot find the v6 patch itself.
> > >
> >
> > I am sorry to bother you.
> > I checked it again and  found that I can not send mail to <linux-kernel@vger.kernel.org>
> > via my private mailbox <yellowriver2010@hotmail.com>.
> > The reject reply like this:
> >
> > for your MAIL FROM address <yellowriver2010@hotmail.com> policy analysis reported: Your address is not liked source for email
> >
> > Is it looked my mail as spam mail?
> > Who should I send to for help me resolving this problem?
> 
> Maybe Konstantin Ryabitsev?
> 

I think postmaster@vger.kernel.org is still Dave Miller, but I'm not
positive.

Hotmail is not listed as a taboo thing:
http://vger.kernel.org/majordomo-taboos.txt

regards,
dan carpenter
