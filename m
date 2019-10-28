Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEA6CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1114F208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UwlgYWoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390186AbfJ1Ofl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:35:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49818 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfJ1Ofk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:35:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9SETAd1128019;
        Mon, 28 Oct 2019 14:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=FAQdU1JCR9DULjDB0FZACrkp/IGyVtvK8bkE0lTp0p0=;
 b=UwlgYWoRvKbwsApjVD2nnCWAEa2CI26mXkDrCrGKKTrf7P74iv6W1i5pU6dfZ/1rc65D
 tek1qlKFkEMJ3pX7EYequeQgGCiVZPnj4TV7mK+r8+NWnk/rUP/cXHu/ThHhP07HEDWs
 Lc2wiqVYJ9hUNOT5l/mjpVh8sl3Z7I/hjpS8WvVGDpXIYxOrJibv5Tf+VSgy7LRcYXJB
 f20fRkEUb8tvZKS6EzlF4FfDGsIhzsCY2Xp6kOZc91DIgkQUQHKySe+04M1eedY5DIcd
 sgf1GOPHfJ8xQd54ee+aYgt4cwblJ56V8jyNWPUAa13FvT7iFPGDIxKhbJ2Mhf8x/9Qb Cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vve3q2cj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 14:34:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9SEWgNF138564;
        Mon, 28 Oct 2019 14:34:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vvymyrpbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 14:34:25 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9SEYGrk030677;
        Mon, 28 Oct 2019 14:34:21 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Oct 2019 07:34:16 -0700
Date:   Mon, 28 Oct 2019 17:34:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     syzbot <syzbot+0620f79a1978b1133fd7@syzkaller.appspotmail.com>,
        alsa-devel@alsa-project.org, andreyknvl@google.com,
        benquike@gmail.com, g@b4.vu, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, perex@perex.cz, rfontana@redhat.com,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        yuehaibing@huawei.com
Subject: Re: KASAN: slab-out-of-bounds Read in build_audio_procunit
Message-ID: <20191028143406.GE1922@kadam>
References: <000000000000df5189059580f8e9@google.com>
 <s5hsgnkdbsl.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hsgnkdbsl.wl-tiwai@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9423 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910280151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9423 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910280150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wish that this could have been detected with static analysis...

On Tue, Oct 22, 2019 at 05:45:14PM +0200, Takashi Iwai wrote:
> diff --git a/sound/usb/validate.c b/sound/usb/validate.c
> index 3c8f73a0eb12..a5e584b60dcd 100644
> --- a/sound/usb/validate.c
> +++ b/sound/usb/validate.c
> @@ -75,7 +75,7 @@ static bool validate_processing_unit(const void *p,
>  
>  	if (d->bLength < sizeof(*d))
            ^^^^^^^^^^^^^^^^^^^^^^^
So we know that d->bLength is >= 10.

>  		return false;
> -	len = d->bLength < sizeof(*d) + d->bNrInPins;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Len is 1 or 0.

> +	len = sizeof(*d) + d->bNrInPins;
>  	if (d->bLength < len)
            ^^^^^^^^^^^^^^^^

So this condition can't be false.

>  		return false;

But it just makes this return into dead code and we have a lot of dead
code paths in the kernel so it doesn't make sense to generate a warning.
...  I don't know if I have a solution.

Maybe some day we will have a vim pluggin which will highlight all the
dead paths and someone would notice that it that way.

regards,
dan carpenter
