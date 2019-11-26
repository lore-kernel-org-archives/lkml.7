Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CE7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157EE2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfKZL2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 06:28:24 -0500
Received: from foss.arm.com ([217.140.110.172]:33144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfKZL2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 06:28:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4959E1FB;
        Tue, 26 Nov 2019 03:28:23 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED7903F52E;
        Tue, 26 Nov 2019 03:28:21 -0800 (PST)
Date:   Tue, 26 Nov 2019 11:28:16 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     cj.chengjian@huawei.com, huawei.libin@huawei.com,
        guohanjun@huawei.com, xiexiuqi@huawei.com, wcohen@redhat.com,
        linux-kernel@vger.kernel.org, mtk.manpages@gmail.com,
        wezhang@redhat.com, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] sys_personality: Streamline code in sys_personality()
Message-ID: <20191126112815.GA32965@lakrids.cambridge.arm.com>
References: <20191126094045.134654-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126094045.134654-1-bobo.shaobowang@huawei.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 05:40:45PM +0800, Wang ShaoBo wrote:
> SYSCALL_DEFINE1 in kernel/exec_domain.c looks like verbose,
> ksys_personality() can make it more concise.
> 
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>

FWIW, this looks fine to me:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I'm not sure why I didn't do this initially; adding Christoph in case he
has any comments.

Mark.

> ---
>  kernel/exec_domain.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/kernel/exec_domain.c b/kernel/exec_domain.c
> index 33f07c5f2515..f7a0512ddc23 100644
> --- a/kernel/exec_domain.c
> +++ b/kernel/exec_domain.c
> @@ -37,10 +37,5 @@ module_init(proc_execdomains_init);
>  
>  SYSCALL_DEFINE1(personality, unsigned int, personality)
>  {
> -	unsigned int old = current->personality;
> -
> -	if (personality != 0xffffffff)
> -		set_personality(personality);
> -
> -	return old;
> +	return ksys_personality(personality);
>  }
> -- 
> 2.20.1
> 
