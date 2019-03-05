Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EBFC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E1820842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LsMn7FTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfCELju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:39:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60928 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfCELju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:39:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x25BcXn4085327;
        Tue, 5 Mar 2019 11:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Wif6yycougY83WhBkZh1+1999fWZYtnKErplzcP1YUE=;
 b=LsMn7FTQnkDTnmJ7vCPzkkZpLDQN6ZcCGIdNn96xZsIYJBbL9QPriJ2eCAYW+vdCzRgI
 MBDRYjpbvVJSEWdscGq1+wZvF8Y4wLE7vq62o0pyYmyn193wCIxuhHYB7gYH20UvzdJC
 JQyE5HSP0cxtbCgceC//2KEVKLvXjfWxwHTBHe3OMDFrQG/MUQS52THZKsvcuYGd6vh8
 iWqg6NM4hHvlpTQTrvAlbJVytXf8z8Hyz7WY/ZMQoDRX83HqYJW8nk7ihBgI9BSfpM7V
 k2LnLE0FSYK4nPStmkk70dUNn6asgpBQQrhzdU5wCuoQM2eHe488YvpXWA3LczPDLP6D 0Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qyjfrcp5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Mar 2019 11:39:42 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x25Bdf0u022921
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Mar 2019 11:39:41 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x25Bde5k010797;
        Tue, 5 Mar 2019 11:39:40 GMT
Received: from kadam (/197.157.34.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Mar 2019 03:39:39 -0800
Date:   Tue, 5 Mar 2019 14:39:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Spencer E . Olson" <olsonse@umich.edu>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: ni_mio_common: Fix divide-by-zero for
 DIO cmdtest
Message-ID: <20190305113915.GB13474@kadam>
References: <20190304143354.4964-1-abbotti@mev.co.uk>
 <20190305081629.GA13474@kadam>
 <261cec72-ed19-7092-5307-76481e9f20ba@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <261cec72-ed19-7092-5307-76481e9f20ba@mev.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9185 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=898 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903050081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 11:32:18AM +0000, Ian Abbott wrote:
> On 05/03/2019 11:10, Dan Carpenter wrote:
> > On Mon, Mar 04, 2019 at 02:33:54PM +0000, Ian Abbott wrote:
> > > The problem was reported on the COMEDI mailing list here:
> > > https://groups.google.com/forum/#!topic/comedi_list/4t9WlHzMhKM
> > > 
> > 
> > Can you give Ivan a Reported-by tag?  It's a public mailing list so
> > that shouldn't be a problem.
> 
> I can do, but I don't know his full name.  Will that be a problem?
> 

Nah, it's not a problem.  People should fix their email headers to
reflect what they want to be called.

Or you could ask but I don't think I have ever asked for someone's name
I've always just gone with their email header name.

regards,
dan carpenter

