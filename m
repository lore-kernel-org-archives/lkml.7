Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F055DC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 08:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CC221744
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 08:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nShqYQli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfHQIZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 04:25:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35088 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfHQIZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 04:25:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7H8PdnV112915;
        Sat, 17 Aug 2019 08:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=KHaNnxAc8GUonZC9GsG6aTzW5/6gi5hQb/YaflyPp6Q=;
 b=nShqYQlitLJ03GbtECzaEfxUyK5+Rgsd4YC3y+A+9t29x8NHgfJ5lBVgYhXaVyjGz550
 BUjRNhr61J4I6SuW/I3M01dGND97/r7lGZbnn/5aJyLzJSzuoCjbw/hxBAuoEk8/kcq/
 zRGw8gQLIBFmentiK5cB9ZyBj/ndrsKdneDjuraKOtS3ZZbzKbju+RMuetplqd86rYMT
 2ocyrrs052p1Wu5eCG6xtA7uXZTZhzDiIOKOIxTgGTUWNLx/whoL374mL3aNo3gr8rxl
 zZYocEtbD3cii503e0O0E38bQgix16sqktva1WoywP35GzrpKOHdPkkmYGn/hV8Ij3w7 eA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ue9hp0q7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Aug 2019 08:25:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7H8N8LB100789;
        Sat, 17 Aug 2019 08:25:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ue6qctayg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Aug 2019 08:25:48 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7H8Ph3U032591;
        Sat, 17 Aug 2019 08:25:44 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 17 Aug 2019 01:25:43 -0700
Date:   Sat, 17 Aug 2019 11:25:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marek Behun <marek.behun@nic.cz>, Arnd Bergmann <arnd@arndb.de>
Cc:     Colin King <colin.king@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] bus: moxtet: fix unsigned comparison to less than
 zero
Message-ID: <20190817082534.GB4451@kadam>
References: <20190816224106.11583-1-colin.king@canonical.com>
 <20190817020434.4ef2dc5f@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817020434.4ef2dc5f@nic.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9351 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908170092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9351 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908170093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 02:04:34AM +0200, Marek Behun wrote:
> On Fri, 16 Aug 2019 23:41:06 +0100
> Colin King <colin.king@canonical.com> wrote:
> 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently the size_t variable res is being checked for
> > an error failure however the unsigned variable is never
> > less than zero so this test is always false. Fix this by
> > making variable res ssize_t
> > 
> > Addresses-Coverity: ("Unsigned compared against 0")
> > Fixes: 5bc7f990cd98 ("bus: Add support for Moxtet bus")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/bus/moxtet.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
> > index 1ee4570e7e17..288a9e4c6c7b 100644
> > --- a/drivers/bus/moxtet.c
> > +++ b/drivers/bus/moxtet.c
> > @@ -514,7 +514,7 @@ static ssize_t output_write(struct file *file, const char __user *buf,
> >  	struct moxtet *moxtet = file->private_data;
> >  	u8 bin[TURRIS_MOX_MAX_MODULES];
> >  	u8 hex[sizeof(bin) * 2 + 1];
> > -	size_t res;
> > +	ssize_t res;
> >  	loff_t dummy = 0;
> >  	int err, i;
> >  
> 
> Hi Colin,
> thanks. Should I just Ack this, or do I need to send patch to the
> developer who commited my patches?

According to MAINTAINERS, you're the maintainer and not Arnd.  You
should forward this to him.  But in the future it might be easier if
Arnd added himself to the MAINTAINERS file for this.

You're probably better off if you have a subsystem mailing list for this
driver instead of using LKML.  That way more people can get involved
with the development if they want to.

Anyway, as the maintainer, you need to collect patches and forward them
on to Arnd or someone else.  Since you are handling the patches, that
means you need to Sign them to certify that you haven't added any of
SCOs private super secret UNIXWARE intellectual property.  You can't
just use the Acked-by, you have to use the Signed-off-by tag.

If Arnd or someone else is collecting the patches then you could use
Reviewed-by or Acked-by.  Acked-by basically means you approve the
patch and often it's going through a different maintainer's tree.  Or it
can be you like the approach the patch is taking.  It's sort of vague.
I seldom Ack patches because I'm not a maintainer in an official sense,
but I do give people a Reviewed-by tag if I review their patch and I
want to make their day a little happier.  Also if it's a huge patch
series and I want to help out Greg to know that he can skip reviewing
the patch if he wants to.

regards,
dan carpenter
