Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2ACC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB8B2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kuVsG8x7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfFXJEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:04:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59518 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfFXJED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:04:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5O8xEXL054804;
        Mon, 24 Jun 2019 09:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=iuTIqR77mbkKkua9Khoq/rOSBVnpK6lTjqe4ytlfdQ4=;
 b=kuVsG8x7IGwY4wUYyOPzJtOzGjq5c/LqHnlZGpSMt266hRfT4/+4gsewBWAWhx+mcDB7
 f+PQ7QzF7wttbkrOALL6WNiuNqBMqhqj11EOTIof2o1T4RATUIyWS+5tOjwRZgIoEZpu
 5GlBqqsByKYvhEt2erupYOxVuhMYgrmLwjerNJGLKNkRmPuhKiHZUEDqBtNm68sm4kYq
 AhPNI2bAVPM/ECus8iU8jl7ouU42fSVSN/X5L2oWPHEJCG/ruKooiQaaCh5FaeYCNBxK
 mD9mCbc958KUDuabRWL/t6ZlFdlrp9YcxZb3HhaT6CyOpgVQwOeVDXAVcXCg/C/7P+9D hA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t9c9pd4nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 09:03:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5O93Orw048583;
        Mon, 24 Jun 2019 09:03:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tat7bhdau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 09:03:49 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5O93k96008205;
        Mon, 24 Jun 2019 09:03:46 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 02:03:45 -0700
Date:   Mon, 24 Jun 2019 12:03:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Colin King <colin.king@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] clocksource: davinci-timer: fix memory leak of
 clockevent on error return
Message-ID: <20190624090339.GW28859@kadam>
References: <20190617113109.24689-1-colin.king@canonical.com>
 <CAMpxmJVxg2+2mdAQDSo5LTq=w7+ccXnwRmK+iz=4zkNhepE6pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJVxg2+2mdAQDSo5LTq=w7+ccXnwRmK+iz=4zkNhepE6pQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:28:10AM +0200, Bartosz Golaszewski wrote:
> pon., 17 cze 2019 o 13:31 Colin King <colin.king@canonical.com> napisał(a):
> >
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently when the call to request_irq falls there is a memory leak of
> > clockevent on the error return path. Fix this by kfree'ing clockevent.
> >
> > Addresses-Coverity: ("Resource leak")
> > Fixes: fe3b8194f274 ("clocksource: davinci-timer: add support for clockevents")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/clocksource/timer-davinci.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
> > index a9ca02390b66..8512f12e250a 100644
> > --- a/drivers/clocksource/timer-davinci.c
> > +++ b/drivers/clocksource/timer-davinci.c
> > @@ -300,6 +300,7 @@ int __init davinci_timer_register(struct clk *clk,
> >                          "clockevent/tim12", clockevent);
> >         if (rv) {
> >                 pr_err("Unable to request the clockevent interrupt");
> > +               kfree(clockevent);
> >                 return rv;
> >         }
> >
> > --
> > 2.20.1
> >
> 
> Hi Colin,
> 
> I omitted the error checking in this driver on purpose - it doesn't
> make sense as the system won't boot without a timer.

One way to silence these static checker warnings is to use
"GFP_KERNEL | __GFP_NOFAIL".

regards,
dan carpenter

