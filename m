Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D3EECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B26218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TgUlqaBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfJOMqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 08:46:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53658 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfJOMqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:46:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FCivSY187110;
        Tue, 15 Oct 2019 12:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=TxP0ZWs0Ifhgzr9mzKZ5K8VfBbMXyx7BesdvQuxDWL4=;
 b=TgUlqaBGOJKG4fHX334bsbAgcF/WLNv6HPiMv80K3LFGMwN9sX0yjWJfG65KoL14Iv6l
 jNtjc3ZBMD8bVoanWIXlAfJokXaDcxObjB5eVRqaJtJmYP8akalnuomIGNrXf8D8vav2
 k1IB9mSrNgNG8kAn9jLOvmNkYdnJ67BE0EI5b+EHTqdVf95iV5RhTT3DjEgm8ZpJhujP
 FTR4fQwrZplv+b7l5VntezIyN0cnLXMhRRnziZpBxzwaKZ9UG6nD0Y7Qy6V4GiIXk9RB
 NznvbDBteI+8TMkZlUsAY/KI9ArBlIhACNl0sI1BSMVjv1415HLFZzjwbI8/HiCBkmC8 TQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vk7fr7hhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 12:46:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FCh3Le134869;
        Tue, 15 Oct 2019 12:46:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vn7184x0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 12:46:35 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9FCkXqt017011;
        Tue, 15 Oct 2019 12:46:33 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 12:46:32 +0000
Date:   Tue, 15 Oct 2019 15:46:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Takashi Iwai <tiwai@suse.de>, Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/x86: huawei-wmi: make validation stricter in
 huawei_wmi_battery_set()
Message-ID: <20191015124623.GF21344@kadam>
References: <20191015083837.GA29104@mwanda>
 <CAB3uXr63uUwxBjkeeoftZ6HYm_hmN+E5EUhu15_Mta2qruOugA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB3uXr63uUwxBjkeeoftZ6HYm_hmN+E5EUhu15_Mta2qruOugA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 08:21:59AM -0400, Ayman Bagabas wrote:
> Hi Dan
> 
> On Tue, Oct 15, 2019, 4:39 AM Dan Carpenter <dan.carpenter@oracle.com>
> wrote:
> 
> > I don't think it makes sense for "end" to be negative or for even for it
> > to be less than "start".  That also means that "start" can't be more
> > than 100 which is good.
> >
> 
> While this makes sense, you run into issues where you cannot set "start"
> before "end" and vice versa.
> 
> Take this scenario, you have start=70 and end=90, now you want to set these
> to start=40 and end=60, you would have to set "start" first before you can
> change the value of "end" otherwise you will run into EINVAL. Now imagine
> you wanna go the opposite direction, you would have to set "end" before you
> can change "start".
> I think having a little wiggle room is fine for such scenarios.
> 

I haven't tested this code...  What you're describing sounds really
very weird to me, but I will accept that you know more about your
use cases than I do.

My other concern is that right now you can set start > 100 or end < 0.

regards,
dan carpenter

