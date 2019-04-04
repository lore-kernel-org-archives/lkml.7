Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0660FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A47205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oXI61zRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfDDJhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:37:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52894 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbfDDJhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:37:01 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x349TI8W129850;
        Thu, 4 Apr 2019 09:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=IXlz+Q3u/scfUGUwG3oVp51Em8wLiz4akJ/lg2lxtis=;
 b=oXI61zReLX4AmFB5nUW+MmsHw6NlmYdE/dRjv0vMNjyNOj9tk7HWtvKNkyyVG6wrFq/z
 rHnnq+uWiG4j13HO71aUZD/VCWUTNwVu2hGOxDx78Nxk/D6wbl1ceRExJlO92l6PmuGN
 EDG/X1twWyhfYEvI64761Zo3kaiistzP2mWxuT8BjoJtkqalq60U42Q/Z9F2cZFl1F5o
 YfSwX/PImYmpv6lEwmCecsoSlpugz7zweUU6JyyDG30bWOW+vp2Zl3uaNf37s00M3bph
 1Zu8r+ny99xji8YdJytqcB9xLu0bTzhwTpTMvy8NVwUc6JkJYXdyQLN5IWsplEkGmJtD jQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2rhwyde60w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 09:36:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x349ZLEa012745;
        Thu, 4 Apr 2019 09:36:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2rm8f5ta0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 09:36:56 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x349atLS022772;
        Thu, 4 Apr 2019 09:36:55 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Apr 2019 02:36:34 -0700
Date:   Thu, 4 Apr 2019 12:36:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] remoteproc: silence an uninitialized variable warning
Message-ID: <20190404093622.GM32613@kadam>
References: <20190404084204.GA20193@kadam>
 <a08db945-44d3-ff99-7a89-75367f314855@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a08db945-44d3-ff99-7a89-75367f314855@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040067
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 02:47:39PM +0530, Mukesh Ojha wrote:
> 
> On 4/4/2019 2:12 PM, Dan Carpenter wrote:
> > Smatch complains that "ret" might be uninitialized.  I can see why it
> > generates the warning, but I don't know if it's actually possible.
> > Anyway initializing "ret" here is harmless.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >   drivers/soc/qcom/mdt_loader.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> > index 1c488024c698..fc58d660692f 100644
> > --- a/drivers/soc/qcom/mdt_loader.c
> > +++ b/drivers/soc/qcom/mdt_loader.c
> > @@ -188,7 +188,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
> >   	if (reloc_base)
> >   		*reloc_base = mem_reloc;
> > -
> > +	ret = 0;
> 
> 
> You are overriding the value here, better keep it at the start.

I like how I wrote it.  It makes it clear that this is the success path.

regards,
dan carpenter

