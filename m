Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE889C04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4D920843
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2wWriTKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfEPBv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:51:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39724 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfEPBv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 21:51:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4G1ivkU105807;
        Thu, 16 May 2019 01:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=HYO9ezbu2Dl+8sVygsMDRAKrRIRpqkGBLrL69Eo8bes=;
 b=2wWriTKaTn3ytF35CvZTgtwBxK9VcMSbmLgHTFya+BZl9Pi1peferkYHzD+qEklrZOr7
 SFHpzlivDV0eDdJU6xRoe9jx8D0oQpHLrjrWgNF1LfVWLwVKfAyeSlpk4lCxy9BybfGx
 zsDBra4IEEQpat6QxGNS5B0erj4LwFAoilOeOWEkYHkQGjrnDk2MQYpB/pHuYVPLUixz
 9Ln8XJB9ryBfoxq9hj0Wl0cNrbRroAoaqk6GFtljuLvVxD3NCP9Ny7gZ29gEyWUmoUYG
 gUIEUsl/bkKLitLGoSr2AmZMvQqe0Ra4rzp38o6EuOs7Q1VNuUQEgpWJVcN0NsTvNgNK bQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2sdntu0b96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 01:51:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4G1pNd9062910;
        Thu, 16 May 2019 01:51:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2sgp32q8x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 01:51:26 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4G1pPYb015103;
        Thu, 16 May 2019 01:51:25 GMT
Received: from dhcp-10-159-244-171.vpn.oracle.com (/10.159.244.171)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 May 2019 01:51:24 +0000
Subject: Re: [PATCH] tracing: Kernel access to Ftrace instances
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Joe Jin <joe.jin@oracle.com>
References: <1553106531-3281-1-git-send-email-divya.indi@oracle.com>
 <1553106531-3281-2-git-send-email-divya.indi@oracle.com>
 <20190516090942.75f3a957ceed20201edc91a6@kernel.org>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <a96e884d-534f-65ef-8f82-85cd52953695@oracle.com>
Date:   Wed, 15 May 2019 18:51:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516090942.75f3a957ceed20201edc91a6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9258 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905160011
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9258 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905160011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

Thanks for pointing it out.

Yes, it should not be static.

On 5/15/19 5:09 PM, Masami Hiramatsu wrote:
> HI Divya,
>
> On Wed, 20 Mar 2019 11:28:51 -0700
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
>> Signed-off-by: Divya Indi <divya.indi@oracle.com>
>> Reviewed-by: Joe Jin <joe.jin@oracle.com>
> Would you tested these APIs with your module? Since,
> [...]
>> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
>> index 5b3b0c3..81c038e 100644
>> --- a/kernel/trace/trace_events.c
>> +++ b/kernel/trace/trace_events.c
>> @@ -832,6 +832,7 @@ static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
>>   
>>   	return ret;
>>   }
>> +EXPORT_SYMBOL_GPL(ftrace_set_clr_event);
> I found this exports a static function to module. Did it work?

I had tested the changes with my module. This change to static was added 
in the test patch, but somehow missed it in the final patch that was 
sent out.

Will send a new patch along with a few additional ones to add some NULL 
checks to ensure safe usage by modules and add the APIs to a header file 
that can be used by the modules.

Thanks,

Divya

>
> Thank you,
>
