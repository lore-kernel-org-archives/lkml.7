Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9019C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0782054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FoFGdqOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfEGFyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:54:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45758 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfEGFyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:54:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x475mn5F173525;
        Tue, 7 May 2019 05:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=kJQobYwWo6iFFg61xydLrFO2gb+vbqflfGMqytbSt44=;
 b=FoFGdqOSsVcD9mQe/DscR5O60zlk+Ejev9fOw62vKLZlEilOZD1+sMk5dUblc/KEJOfL
 +gAf1RItHcleauKg8kOyPEhPKJerXL4YpKj/z56S1pfkASQdhdwV3m6o6vI1yVB6Twm9
 X+L6RH7zj2d+oSQ80CjvBjDwLBi/ZO176zo6vHpIgbo/Ik93nbkN0kYmkWT1pBrgtBxJ
 8OkVEYbfw6E9bmI2erg5nm8bcTIFk0LXJFNLpunYT6zh2j9w3TCQRNzqyfaTTp8yrWDK
 PG9QTzBNjJv2e9BjeQW7TYxEbBn4zUeTeyH8wQ+sxlnny+1WjTPeOWagb64rYsO5Y5SN jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2s94b5tpe7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 May 2019 05:54:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x475qxmF127046;
        Tue, 7 May 2019 05:54:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2s94b99m85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 May 2019 05:54:20 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x475sDut019063;
        Tue, 7 May 2019 05:54:13 GMT
Received: from kadam (/196.109.148.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 May 2019 22:54:12 -0700
Date:   Tue, 7 May 2019 08:54:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org, stefan.wahren@i2se.com,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        phil@raspberrypi.org, Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] staging: vchiq: revert "switch to
 wait_for_completion_killable"
Message-ID: <20190507055405.GI2269@kadam>
References: <20190506144030.29056-1-nsaenzjulienne@suse.de>
 <20190506144030.29056-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506144030.29056-3-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905070039
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905070039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 04:40:29PM +0200, Nicolas Saenz Julienne wrote:
> The killable version of wait_for_completion() is meant to be used on
> situations where it should not fail at all costs, but still have the
> convenience of being able to kill it if really necessary. VCHIQ doesn't
> fit this criteria, as it's mainly used as an interface to V4L2 and ALSA
> devices.
> 
> Fixes: a772f116702e ("staging: vchiq: switch to wait_for_completion_killable")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> This reverts commit a772f116702e3f0afdd7e6acadc1b8fb3b20b9ff.
> ---

Git just sets you up for failure with its revert.  That code was from
when git was really new and now everyone gets annoyed when they see a
raw git hash without a human readable subject.  Just say at the start of
the commit message:

This reverts commit a772f116702e ("staging: vchiq: switch to
wait_for_completion_killable").

The killable version of wait_for_completion() is meant to be used on
situations where it should not fail at all costs, but still have the
convenience of being able to kill it if really necessary. VCHIQ doesn't
fit this criteria, as it's mainly used as an interface to V4L2 and ALSA
devices.

Fixes: a772f116702e ("staging: vchiq: switch to wait_for_completion_killable")

regards,
dan carpenter

