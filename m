Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CE2C0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF193218A0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfGECGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 22:06:18 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:38789 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727116AbfGECGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 22:06:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TW3OPEY_1562292372;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TW3OPEY_1562292372)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 05 Jul 2019 10:06:13 +0800
Subject: Re: [PATCH] fs: ocfs2: dlmglue: Unneeded variable: "status"
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <20190702183237.GA13975@hari-Inspiron-1545>
Cc:     Andrew Morton <akpm@linux-foundation.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <6a6ae279-9d35-0c00-d3db-72e11cda3838@linux.alibaba.com>
Date:   Fri, 5 Jul 2019 10:06:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702183237.GA13975@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/7/3 02:32, Hariprasad Kelam wrote:
> fix below issue reported by coccicheck
> fs/ocfs2/dlmglue.c:4410:5-11: Unneeded variable: "status". Return "0" on
> line 4428
> 
> We can not change return type of ocfs2_downconvert_thread as its
> registered as callback of kthread_create.
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/dlmglue.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index dc987f5..1420723 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -4407,7 +4407,6 @@ static int ocfs2_downconvert_thread_should_wake(struct ocfs2_super *osb)
>  
>  static int ocfs2_downconvert_thread(void *arg)
>  {
> -	int status = 0;
>  	struct ocfs2_super *osb = arg;
>  
>  	/* only quit once we've been asked to stop and there is no more
> @@ -4425,7 +4424,7 @@ static int ocfs2_downconvert_thread(void *arg)
>  	}
>  
>  	osb->dc_task = NULL;
> -	return status;
> +	return 0;
>  }
>  
>  void ocfs2_wake_downconvert_thread(struct ocfs2_super *osb)
> 
