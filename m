Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C62C48BDE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 15:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B0D20830
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 15:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e9O8T04O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfGGPrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 11:47:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37154 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfGGPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 11:47:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x67Fhv0P071029;
        Sun, 7 Jul 2019 15:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=uYaJcnvEx4X1SmHQfvatBVE33WA/WoF3de594XALlMo=;
 b=e9O8T04O1yzKAv3SKvh1lVAPaLjvb6sWOoGD7iyuPikLilR/pRY3PGYX8fb6e/KEdjkh
 hdOsvhjoc2m5jAwCbbN+sYx3mD0Rr/FZsA4OZio4Mzn7PcmAVLrTal/rde8/mIpL6Zk9
 SdTntEEaxkoDhxuVMarOTC8YIpXqo9YYrQmU5uoWU01LPs2U7F0foSZ8IBoP4TVEndM3
 eCBxARBwyXDSAAoiofi67pJDLApTCItVWe5isBFHkRsOjY3ZZdxs5RgoLmanuqvJquLO
 Icg/5XpxSzz3RkUsDzJ+O8WvgFyKnOKsH/oYz8wx1EuT7l7SnH9mnU3bHhtlx7KNOoY/ +Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tjm9qayac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Jul 2019 15:46:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x67Fhk7C023162;
        Sun, 7 Jul 2019 15:46:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tjgrt6amn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Jul 2019 15:46:17 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x67FkFGg028454;
        Sun, 7 Jul 2019 15:46:15 GMT
Received: from [10.0.0.83] (/73.223.239.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Jul 2019 08:46:14 -0700
Subject: Re: [PATCH] tracing: make exported ftrace_set_clr_event non-static
To:     Denis Efremov <efremov@linux.com>,
        Divya Indi <divya.indi@oracle.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20190704172110.27041-1-efremov@linux.com>
From:   Joe Jin <joe.jin@oracle.com>
Message-ID: <a86cfb65-6430-c79d-29b1-447601527418@oracle.com>
Date:   Sun, 7 Jul 2019 08:46:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190704172110.27041-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907070217
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907070218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch looks good to me.

Reviewed-by: Joe Jin <joe.jin@oracle.com>

Thanks,
Joe
On 7/4/19 10:21 AM, Denis Efremov wrote:
> The function ftrace_set_clr_event is declared static and marked
> EXPORT_SYMBOL_GPL(), which is at best an odd combination. Because the
> function was decided to be a part of API, this commit removes the static
> attribute and adds the declaration to the header.
> 
> Fixes: f45d1225adb04 ("tracing: Kernel access to Ftrace instances")
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  include/linux/trace_events.h | 1 +
>  kernel/trace/trace_events.c  | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 8a62731673f7..84bc84f00e8f 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -539,6 +539,7 @@ extern int trace_event_get_offsets(struct trace_event_call *call);
>  
>  #define is_signed_type(type)	(((type)(-1)) < (type)1)
>  
> +int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
>  int trace_set_clr_event(const char *system, const char *event, int set);
>  
>  /*
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 0ce3db67f556..b6b46184f6bf 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -795,7 +795,7 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
>  	return ret;
>  }
>  
> -static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
> +int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
>  {
>  	char *event = NULL, *sub = NULL, *match;
>  	int ret;
> 

