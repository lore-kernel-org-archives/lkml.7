Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC299C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B06D2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BEzm0ydn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfEJSk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 14:40:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48508 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfEJSk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:40:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4AIdC4g166006;
        Fri, 10 May 2019 18:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=PF9nSljjwxZvY8N68CIMJjaG6SHD4lndQ6iOfJzlPHM=;
 b=BEzm0ydnQn0WecTzTm6LdcCauN0AxlsGaGTKnokY2RHG7+7bUv6ECL8i6g84lazgOITM
 NKdBk9pHLE2C5E2DsEKk9NYlxXl+4HgAfWxmimYb7GznETkWeX91t7RQ/X3ibAE4UHdf
 qtC0h5s9pvFWEI8Ghbn7EdUK6i/ETsC9rypo9HPo/A6pXbCo+7mJgxSXM/SlV/wSaVny
 Et6e4YuAPxkLA0vXtKDw8NiDfNIzKL6BwH+41tr1ID8oUyB00b/BB/Te7Pliot8dacQf
 se1/qEjhXQYjxnpV90KyYBA8K5qQswDYqL5hIZjgPLdYnIfR7ZwSXSyJobEhI+ycRN5n nQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2s94b6jyq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 18:40:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4AIdAVk149201;
        Fri, 10 May 2019 18:40:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2schw0jtcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 18:40:20 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4AIeJDE022435;
        Fri, 10 May 2019 18:40:19 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 May 2019 18:40:18 +0000
Date:   Fri, 10 May 2019 21:40:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tim Collier <osdevtc@gmail.com>,
        Chris Opperman <eklikeroomys@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: collect return status without variable
Message-ID: <20190510184011.GE18105@kadam>
References: <20190510023900.GA4390@hari-Inspiron-1545>
 <20190510105754.GA18105@kadam>
 <20190510172308.GA3075@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510172308.GA3075@hari-Inspiron-1545>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905100121
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905100121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 10:53:08PM +0530, Hariprasad Kelam wrote:
> On Fri, May 10, 2019 at 01:57:54PM +0300, Dan Carpenter wrote:
> > On Fri, May 10, 2019 at 08:09:00AM +0530, Hariprasad Kelam wrote:
> > > diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> > > index 8a862f7..5dad5ac 100644
> > > --- a/drivers/staging/wlan-ng/cfg80211.c
> > > +++ b/drivers/staging/wlan-ng/cfg80211.c
> > > @@ -231,17 +231,12 @@ static int prism2_set_default_key(struct wiphy *wiphy, struct net_device *dev,
> > >  {
> > >  	struct wlandevice *wlandev = dev->ml_priv;
> > >  
> > > -	int err = 0;
> > > -	int result = 0;
> > > -
> > > -	result = prism2_domibset_uint32(wlandev,
> > > -		DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
> > > -		key_index);
> > > -
> > > -	if (result)
> > > -		err = -EFAULT;
> > > -
> > > -	return err;
> > > +	if (prism2_domibset_uint32(wlandev,
> > > +				   DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
> > > +				   key_index))
> > > +		return -EFAULT;
> > > +	else
> > > +		return 0;
> > 
> > We should just preserve the error codes from prism2_domibset_uint32().
> > 
> > 	return prism2_domibset_uint32(dev->ml_priv,
> > 				DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
> > 				key_index);
> >
>    prism2_domibset_uint32 function can return  -ENODEV,-EPERM,-EBUSY if
>    fail  case.
> 
>    If we observe the pattern of calling this function,we can find
>    
>    "return -EFAULT on failure and 0 on success".
> 
>    Due to this we  can not collect return status directly.

Yes, I know this code is full of nonsense.

It shouldn't just always return -EFAULT, it should preserve the correct
error code.  This is only called from rdev_set_default_key() if you want
to check the caller.

regards,
dan carpenter

