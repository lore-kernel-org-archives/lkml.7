Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30305C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0182F223D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B0xCqQUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfKSVMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 16:12:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55660 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfKSVMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:12:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJL9Ipf167749;
        Tue, 19 Nov 2019 21:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=6dcH/qkebOqljBdIh3WCweO98b6LCRO0hdF6cgh5iJw=;
 b=B0xCqQUlSQWlMG1QP3OyX4j97e3xEtUwS7HG+b26JVTYFO9zjZrdInz7b+dlLbyKtKSt
 xccLYsVLoq+71MBRq+Gl/ctaaqiyZTeeZuUIsLLHUKPSbNDr+z/PFZga14czTGCEVB3Y
 vHdcvKTMposXGAAMAM+LNwVO/lT4uUaLaA7puUUU6g0uGfHlNKLihV+tD3ozxd7+j4+V
 kR1gl81NmBiTtvxUYjCID3ee3XwjkrsAUL+2lbVjKdb33HAcPv/hWXuARS+FDwt7NZkg
 GvZFV8MACA6jEhP9EsoQtsgG3NBAGqnQUE3Bzf9CZHLwPNsnhvtUDNRZadyKXbmynShW HA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wa8htsr9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 21:12:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJL9Hqc159729;
        Tue, 19 Nov 2019 21:12:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2wc0ah209w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 21:12:13 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAJLCAax030927;
        Tue, 19 Nov 2019 21:12:12 GMT
Received: from Junxiaos-MacBook-Pro.local (/10.11.16.208)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Nov 2019 13:12:10 -0800
Subject: Re: [PATCH] block-mq: ratelimit the warning log
To:     Junxiao Bi <junxiao.bi@oracle.com>, linux-kernel@vger.kernel.org
References: <20191114230233.3582-1-junxiao.bi@oracle.com>
Cc:     axboe@kernel.dk
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <00519647-0993-4e7c-0990-283358c1865b@oracle.com>
Date:   Tue, 19 Nov 2019 13:12:07 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191114230233.3582-1-junxiao.bi@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anybody help reviewing this?

On 11/14/19 3:02 PM, Junxiao Bi wrote:
> When doing cpu online/offlile, sometimes this warning will be triggered,
> it's harmless, io will be dispatched. But sometimes it warns too much and
> even stall the whole system, so ratelimit it.
>
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> ---
>   block/blk-mq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ec791156e9cc..846f5d26c523 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1384,7 +1384,7 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>   	 *   handle dispatched requests to this hctx
>   	 */
>   	if (!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
> -		cpu_online(hctx->next_cpu)) {
> +		cpu_online(hctx->next_cpu) && printk_ratelimit()) {
>   		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
>   			raw_smp_processor_id(),
>   			cpumask_empty(hctx->cpumask) ? "inactive": "active");
