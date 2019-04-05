Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD42C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F3721850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yN9VpaNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfDEHfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:35:19 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59734 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfDEHfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:35:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x357SpqF185576;
        Fri, 5 Apr 2019 07:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=SxyQaYhd7ZzRHinZlCiJ6QEL7GocBEvXMrkkUVVgznw=;
 b=yN9VpaNh29f9HBMMAsNOeo9JxiJQ10v90Mx56FBGy62lly5nSTzJRBQHVvgy1t/aHQHy
 IYmvQ52OwWSnIpzBQ/wdHNZnkHxCUWCPyHPAp4lZqgU8QCmFjMNK+NBFcWxt8rHKIrQU
 NwyLZNiSmvElRvkuF/845MApU3ytcuKTrHS6y3FpcPJvZKluIRLGEfB9quCi/s//zTxb
 5aSYMzbsQWi/UPyLRmsVnlKhZTpzWpt16glvPUlaP77jVl4sLh+Rb0Xgik9WubcMRF7g
 dCpCVyZ0XU431innBPQEAbSPm5A5ZaJbqlrc2KzyeKa65CbAS+wMqWfFHu9ABJLRcFeL Eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2rhwydkc7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 07:35:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x357WIu1091066;
        Fri, 5 Apr 2019 07:33:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2rm8f63wf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 07:33:13 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x357XCOQ025727;
        Fri, 5 Apr 2019 07:33:12 GMT
Received: from kadam (/41.202.241.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Apr 2019 00:33:12 -0700
Date:   Fri, 5 Apr 2019 10:33:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] remoteproc: silence an uninitialized variable warning
Message-ID: <20190405073301.GS32613@kadam>
References: <20190404084204.GA20193@kadam>
 <a08db945-44d3-ff99-7a89-75367f314855@codeaurora.org>
 <20190404093622.GM32613@kadam>
 <f570c0c0-1493-88d7-474c-ad7437e6a1d0@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f570c0c0-1493-88d7-474c-ad7437e6a1d0@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904050056
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904050056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 12:38:19PM +0530, Mukesh Ojha wrote:
> 
> On 4/4/2019 3:06 PM, Dan Carpenter wrote:
> > On Thu, Apr 04, 2019 at 02:47:39PM +0530, Mukesh Ojha wrote:
> > > On 4/4/2019 2:12 PM, Dan Carpenter wrote:
> > > > Smatch complains that "ret" might be uninitialized.  I can see why it
> > > > generates the warning, but I don't know if it's actually possible.
> > > > Anyway initializing "ret" here is harmless.
> > > > 
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > ---
> > > >    drivers/soc/qcom/mdt_loader.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> > > > index 1c488024c698..fc58d660692f 100644
> > > > --- a/drivers/soc/qcom/mdt_loader.c
> > > > +++ b/drivers/soc/qcom/mdt_loader.c
> > > > @@ -188,7 +188,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
> > > >    	if (reloc_base)
> > > >    		*reloc_base = mem_reloc;
> > > > -
> > > > +	ret = 0;
> > > 
> > > You are overriding the value here, better keep it at the start.
> > I like how I wrote it.  It makes it clear that this is the success path.
> 
> 
> But think about a case when this request_firmware_into_buf fails or the
> snippet above that can set the ret with error value
> 
> right.. is not that possible?..and ret = 0 stops propagating the error
> properly.
> 

Gar.  I read "goto out;" instead of "break;".  It probably should be
goto out though...  Anyway, I will resend.

Thanks!

regards,
dan carpenter

