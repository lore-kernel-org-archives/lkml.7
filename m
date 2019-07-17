Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE21C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E932173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PihsPpKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfGQIta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:49:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52130 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfGQIt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:49:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H8mQt5173236;
        Wed, 17 Jul 2019 08:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=s1Vwk3m/q8S/Z/PqBg0E7GuIYvQbJTubJmgN6bruI/U=;
 b=PihsPpKoVqNfoVW6SzKGs1Qk3w559VH/TaQk7JLjZOarkir/ju957ARY/OKESzM9SGlO
 RPuHGCPo+oaRlpc9IPMznBu9U27r7CV4X/tQmHhSZfok6iT2zXLtTno3kIBWik1zhavS
 x02OWLLh0xq01mLCyQbaEk746bbRU8gUvyWfC1clq3zRsLV9kzO2Q5X08qbXsEcivIZE
 ZgMc/Sc3OE+w/Rrq8mrASTEeOlXeJu5V9PdGxXrkxAteo+msVZ3719Q3OVf18jU3xqAg
 5oDEnA2a5GyQ8zW/pJHBXlqlD7Z2VcfkBT8+RiueQeq4KmDW2GEtDYCy4ph72f/kxSCi RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tq6qtscf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 08:49:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H8m73Y026995;
        Wed, 17 Jul 2019 08:49:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tsmcc9c7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 08:49:07 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6H8n0x1019837;
        Wed, 17 Jul 2019 08:49:00 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 08:49:00 +0000
Date:   Wed, 17 Jul 2019 11:48:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tobias =?iso-8859-1?Q?Nie=DFen?= 
        <tobias.niessen@stud.uni-hannover.de>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        Sabrina Gaube <sabrina-gaube@web.de>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de
Subject: Re: [PATCH 1/2] staging: rts5208: Rewrite redundant if statement to
 improve code style
Message-ID: <20190717084852.GA3089@kadam>
References: <20190626142857.30155-1-tobias.niessen@stud.uni-hannover.de>
 <20190626142857.30155-2-tobias.niessen@stud.uni-hannover.de>
 <20190626145636.GG28859@kadam>
 <a0f3ac8b-541a-d3d0-e25e-26da11e29748@stud.uni-hannover.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0f3ac8b-541a-d3d0-e25e-26da11e29748@stud.uni-hannover.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=927
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=983 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 30, 2019 at 04:12:44PM +0200, Tobias Nieﬂen wrote:
> Am 26.06.2019 um 16:56 schrieb Dan Carpenter:
> > Both these patches seem fine.
> > 
> > On Wed, Jun 26, 2019 at 04:28:56PM +0200, Tobias Nieﬂen wrote:
> >> This commit uses the fact that
> >>
> >>     if (a) {
> >>             if (b) {
> >>                     ...
> >>             }
> >>     }
> >>
> >> can instead be written as
> >>
> >>     if (a && b) {
> >>             ...
> >>     }
> >>
> >> without any change in behavior, allowing to decrease the indentation
> >> of the contained code block and thus reducing the average line length.
> >>
> >> Signed-off-by: Tobias Nieﬂen <tobias.niessen@stud.uni-hannover.de>
> >> Signed-off-by: Sabrina Gaube <sabrina-gaube@web.de>
> > 
> > Signed-off-by is like signing a legal document that you didn't put any
> > of SCO's secret UNIXWARE source code into your patch or do other illegal
> > activities.  Everyone who handles a patch is supposed to Sign it.
> > 
> > It's weird to see Sabrina randomly signing your patches.  Probably there
> > is a more appropriate kind of tag to use as well or instead such as
> > Co-Developed-by, Reviewed-by or Suggested-by.
> > 
> > regards,
> > dan carpenter
> > 
> 
> Thank you, Dan. This patch series is a mandatory part of a course
> Sabrina and I are taking at university. We were told to add
> Signed-off-by for both of us. I can add Co-Developed-by if that helps?

Yes.  It does help.

regards,
dan carpenter

