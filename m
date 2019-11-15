Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16918C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F8F2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OTlC08TD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfKOTWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:22:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58940 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfKOTWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 14:22:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFJJQNK107213;
        Fri, 15 Nov 2019 19:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=kF0XFFkgWea6P/hAYC2G/X4OdRLkXHYHd88Ih8s5+no=;
 b=OTlC08TDnunFEiwJhgq2fWQM5A5DW3LxrWyBFoMIJKGkdJL+B2TeB0WPA2T9xRqj+k8F
 4oO8augF7Gk52s3wmilIIaiq0r0NZelZkqJlTqr+mnsoLwWJavhtoPwq4X3MQ8RrMn6C
 KEpI7uRJpsa1ZUs9MeguZ67sapP47A6ALvdLhor8gNvfHbHY7h3DamurF1bg/59gbd/T
 VuL61sPm4zpnSx878WWvIOykxY3UefNXiBmzts4EISnWSUiNSQ/jFCgJxFfqFPFLQLtO
 rF/kxqUyZRp3dSgYp/vFlO7Ni31xIg0IxgCKjfy6JDzQGHzmZVzKh91gqF6bZgEx7ZFB 2w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2w9gxpn5q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 19:21:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFJ53I7183374;
        Fri, 15 Nov 2019 19:21:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2w9h157gce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 19:21:13 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAFJL9XQ006223;
        Fri, 15 Nov 2019 19:21:09 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Nov 2019 11:21:09 -0800
Subject: Re: tty crash in Linux 4.6
To:     Daniel Axtens <dja@axtens.net>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Neuling <mikey@neuling.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <alpine.LRH.2.02.1605161555430.8188@file01.intranet.prod.int.rdu2.redhat.com>
 <573A5996.3080305@hurleysoftware.com> <573B3F84.5050201@hurleysoftware.com>
 <573B5E4C.8030808@hurleysoftware.com>
 <alpine.LRH.2.02.1607071855150.19053@file01.intranet.prod.int.rdu2.redhat.com>
 <CAEjGV6zRghiCCMC1+-n+YPeA0Lrq=-vcvdoYpbwE4G=TXWzY3Q@mail.gmail.com>
 <87po3wusq1.fsf@linkitivity.dja.id.au> <20180322140554.GA3273@kroah.com>
 <alpine.LRH.2.02.1803270818150.30055@file01.intranet.prod.int.rdu2.redhat.com>
 <87k1td913u.fsf@linkitivity.dja.id.au>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d8ba132f-e174-2acc-e74c-4e9aed945c30@oracle.com>
Date:   Fri, 15 Nov 2019 11:21:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87k1td913u.fsf@linkitivity.dja.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9442 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9442 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/18 9:09 AM, Daniel Axtens wrote:
> Mikulas Patocka <mpatocka@redhat.com> writes:
> 
>> On Thu, 22 Mar 2018, Greg Kroah-Hartman wrote:
>>
>>> On Fri, Mar 23, 2018 at 12:48:06AM +1100, Daniel Axtens wrote:
>>>> Hi,
>>>>
>>>>>> This patch works, I've had no tty crashes since applying it.
>>>>>>
>>>>>> I've seen that you haven't sent this patch yet to Linux-4.7-rc and
>>>>>> Linux-4.6-stable. Will you? Or did you create a different patch?
>>>>>
>>>>> We are hitting this now on powerpc.  This patch never seemed to make
>>>>> it upstream (drivers/tty/tty_ldisc.c hasn't been touched in 1 year).
>>>>
>>>> I seem to be hitting this too on a kernel that has the 4.6 changes
>>>> backported to 4.4.
>>>>
>>>> Has there been any further progress on getting this accepted?
>>>
>>> Can you try applying 28b0f8a6962a ("tty: make n_tty_read() always abort
>>> if hangup is in progress") to see if that helps out or not?
> 
> Sorry for the delay in getting the test results; as with Mikulas,
> 28b0f8a6962a does not help.
> 
> Regards,
> Daniel
> 
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> It doesn't help. I get the same crash as before.
>>
>> Mikulas

Reviving a really old thread.

It looks like this patch never got merged.  Did it get resolved in
some other way?  I ask because we have a customer who seems to have
hit this issue.

-- 
Mike Kravetz
