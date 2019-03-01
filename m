Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34EBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD9A20851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="He60ngLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbfCAHnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:43:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54644 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732630AbfCAHnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:43:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x217dNld138152;
        Fri, 1 Mar 2019 07:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=6lfOGVAAUB6OA/1HcHLRzwr8artXT5fP2lKwYELpOYc=;
 b=He60ngLB7NccrPGHNHTA25ymjq9FsnMSwBzlQoRajbi42JYEwA0lFdSOEkxc7jh40Ngs
 HtXVO78AxY1Bqh9vqDNd5vUOojQEiByaoWFWAaUrr+C/Lfdj7o0lDSPy4tYakBM7e5qf
 vEsBy1A+Rg1PLsyGwq6vwNauP/b45qZLk1QW3R7nEGn5Bp6LoyD0gQTNOUZii5ykWvoS
 U3m0vEaqU48Xnanx4CLr+2kPX6zk+3/dX6mH4MoeSQRxE3HnqgAJT4ff0BV08NsA25pM
 4cUIO+XHf1EzUprkks5K8lGZp4/CyWSvq370yFavs3Cbl+heoI+uqVDHaN195J9ZiJG3 Hw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qtwkunte7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Mar 2019 07:42:19 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x217gITS020966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Mar 2019 07:42:18 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x217gGtH013925;
        Fri, 1 Mar 2019 07:42:16 GMT
Received: from kadam (/41.202.241.19)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Feb 2019 23:42:16 -0800
Date:   Fri, 1 Mar 2019 10:42:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Ardelean, Alexandru" <Alex.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v4 1/9] staging: iio: ad7780: add gain & filter gpio
 support
Message-ID: <20190301074024.GA9828@kadam>
References: <cover.1551358569.git.renatogeh@gmail.com>
 <b83c0558a600cb44677b0d06f31e014be550b8bf.1551358569.git.renatogeh@gmail.com>
 <4f945f058c8536a2731c4de3e0b9227a41cd2891.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f945f058c8536a2731c4de3e0b9227a41cd2891.camel@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9181 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903010054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 06:56:14AM +0000, Ardelean, Alexandru wrote:
> On Thu, 2019-02-28 at 11:23 -0300, Renato Lui Geh wrote:
> > 
> > 
> > Previously, the AD7780 driver only supported gpio for the 'powerdown'
> > pin. This commit adds suppport for the 'gain' and 'filter' pin.
> > 
> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> > Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
> > Co-developed-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
> > ---
> > Changes in v3:
> >  - Renamed ad7780_chip_info's filter to odr
> >  - Renamed ad778x_filter to ad778x_odr_avail
> >  - Changed vref variable from unsigned int to unsigned long long to avoid
> >    overflow
> >  - Removed unnecessary AD_SD_CHANNEL macro
> > Changes in v4:
> >  - Removed useless macro
> >  - Added default case for switch to suppress warning
> >  - Removed chunks belonging to filter reading, adding these as a
> >    patch for itself
> > 
> >  drivers/staging/iio/adc/ad7780.c | 90 +++++++++++++++++++++++++++++---
> >  1 file changed, 84 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7780.c
> > b/drivers/staging/iio/adc/ad7780.c
> > index c4a85789c2db..87fbcf510d45 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -39,6 +39,12 @@
> >  #define AD7170_PATTERN         (AD7780_PAT0 | AD7170_PAT2)
> >  #define AD7170_PATTERN_MASK    (AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
> > 
> > +#define AD7780_GAIN_MIDPOINT   64
> > +#define AD7780_FILTER_MIDPOINT 13350
> > +
> > +static const unsigned int ad778x_gain[2]      = { 1, 128 };
> > +static const unsigned int ad778x_odr_avail[2] = { 10000, 16700 };
> 
> ad778x_odr_avail[2] is not used in this patch, so it should probably go
> into the next one 
> (i.e. staging: iio: ad7780: add filter reading to ad778x )
> 
> one good way of catching stuff like this is to do interactive rebase and
> compile your driver on each patch to see if the compiler catches this;
> i suspect the compiler would have thrown an error for this change
> 

GCC (v7.3) doesn't complain about unused variables if they're const.

regards,
dan carpenter

