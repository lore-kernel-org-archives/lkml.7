Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB09C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F67F218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lEIw2rGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfCTSVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:21:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41118 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCTSVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:21:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2KIIbK7053772;
        Wed, 20 Mar 2019 18:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=44zS0rN0lFkOKd6owGCH9o48+inXYzKGH8Y3xOZr3d0=;
 b=lEIw2rGQOqbZoDy1Fx1cztis0YIYy+h23nBD3fz5f7s1GOVC/pwi41ONdn5wK+UzZQF/
 lPak5ajMWP26oCtjOoGwxLT2qVLJO/0MHPX5SY+TeWO7Z4hqmi5u42Z4Zb4FgPB7RpGv
 Bt7fVSX+oAHhzaOsXA9juLVBXBtbdbI/rfqG3sQsZJp3iSOnvoHr+KOo8dZ5KYv7+Bba
 PDSr/j9FcRfU7UKAV3D8qTubT/4fwwvChTQi9T4HnloI5QexUlhMTxVlLmFaCr7SS+i5
 Th6tSJYIvi+JrHT/QSuJEJbisAav/FnYNUeOiL7BEvkYlEVT+9PetrrjoP1WxZwsAR+d Gw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2r8rjuvj0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 18:20:47 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2KIKlvG029360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 18:20:47 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2KIKlxQ001966;
        Wed, 20 Mar 2019 18:20:47 GMT
Received: from [10.132.106.120] (/10.132.106.120)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 11:20:46 -0700
Subject: Re: [PATCH] tracing: Kernel access to ftrace instances
To:     Steven Rostedt <rostedt@goodmis.org>
References: <1552692925-17240-1-git-send-email-divya.indi@oracle.com>
 <1552692925-17240-2-git-send-email-divya.indi@oracle.com>
 <20190319161655.2824746c@gandalf.local.home>
Cc:     linux-kernel@vger.kernel.org
From:   divya.indi@oracle.com
Organization: Oracle Corporation
Message-ID: <8cb583dd-1712-f4c3-fa6f-191fa042137f@oracle.com>
Date:   Wed, 20 Mar 2019 11:20:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20190319161655.2824746c@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9201 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903200134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, thanks for taking the time to review.

There are a few issues with the patch styling and some minor modifications. I will shortly send the v2 for the same.


Regards,
Divya


On 03/19/2019 01:16 PM, Steven Rostedt wrote:
> On Fri, 15 Mar 2019 16:35:25 -0700
> Divya Indi <divya.indi@oracle.com> wrote:
>
>> Ftrace provides the feature “instances” that provides the capability to
>> create multiple Ftrace ring buffers. However, currently these buffers
>> are created/accessed via userspace only. The kernel APIs providing these
>> features are not exported, hence cannot be used by other kernel
>> components.
>>
>> This patch aims to extend this infrastructure to provide the
>> flexibility to create/log/remove/ enable-disable existing trace events
>> to these buffers from within the kernel.
>>
>>
> Thanks for sending this. I'm currently working on some other changes,
> but will look in this when I'm finished with the other work. Should be
> within this week.
>
> -- Steve

