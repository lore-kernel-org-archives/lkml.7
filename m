Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09397C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEA82173B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mbz+1Y7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfEIOmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 10:42:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40226 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfEIOmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 10:42:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49Ecgl2195698;
        Thu, 9 May 2019 14:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=oHoNVXLo0KzT+7QLoewEj851rlFBBW83cdM6UjKZD+g=;
 b=mbz+1Y7XpMyQTGne7eS0tih1rqkEUTZzPfvvlBd6L++B1mQxKsKZH1P7QTYieGTumTXQ
 T/FKWwk2x2LURAt8NJHuB0ZDK2sJi3FGhLCTpyul5szJzqC4wELPfzm9hDFaWIFbtMRo
 9iWqVKDEiI4fgQTKSETOT6NxM0tKXr0ooDahNMqeaNvfVqMFI9ZScXO4OSt3mN/h60Iq
 YGaZ0/N36rBEI9u8mttIxGWRz9UCuhvcLJQT+1Yc9wj2zjIxQBqC7udYnRed2lPMRAoa
 gXT1QkBhw2yIfW+OXruYoB7tD20L1syoM7/oBNim31KOzg/Uqpjh+bPuy7UQ7ffxaB1I 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2s94bgbb4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 14:41:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49EdwvR035003;
        Thu, 9 May 2019 14:41:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2sagyv9fgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 14:41:50 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x49EffaY010615;
        Thu, 9 May 2019 14:41:41 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 07:41:40 -0700
Date:   Thu, 9 May 2019 17:41:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] staging: vchiq: stop explicitly comparing with
 zero to catch errors
Message-ID: <20190509144132.GF21059@kadam>
References: <20190509143137.31254-1-nsaenzjulienne@suse.de>
 <20190509143137.31254-5-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509143137.31254-5-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090086
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 04:31:36PM +0200, Nicolas Saenz Julienne wrote:
> The vchiq code tends to follow a coding pattern that's not accepted as
> per the Linux kernel coding style
> 
> We have this:
> 	if (expression != 0)
> 
> We want this:
> 	if (expression)
> 
> We make an exception if the expression refers to a size, in which case
> it's accepted for the sake of clarity.

It's not really Linux kernel style, it's just my style...  I wouldn't
have complained if the original code were consistent one way or the
other.  But since I was encouraging you to pick a style and use it
consistently, then I'm always going to advocate my style...  :P

Anyway, thanks!  Looks good to me.

regards,
dan carpenter

