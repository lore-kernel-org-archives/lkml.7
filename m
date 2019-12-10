Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B96BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6AD20663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfLJHHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 02:07:43 -0500
Received: from mail.sysgo.com ([176.9.12.79]:54902 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfLJHHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 02:07:43 -0500
Subject: Re: [PATCH] initramfs: forcing panic when kstrdup failed
To:     zhanglin <zhang.lin16@zte.com.cn>, akpm@linux-foundation.org
Cc:     rppt@linux.ibm.com, steven.price@arm.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn
References: <1575946121-30548-1-git-send-email-zhang.lin16@zte.com.cn>
From:   David Engraf <david.engraf@sysgo.com>
Message-ID: <96005ea6-2192-220b-40c1-be369946fdfe@sysgo.com>
Date:   Tue, 10 Dec 2019 08:07:41 +0100
MIME-Version: 1.0
In-Reply-To: <1575946121-30548-1-git-send-email-zhang.lin16@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.12.19 at 03:48, zhanglin wrote:
> preventing further undefined behaviour when kstrdup failed.
> 
> Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>
> ---
>   init/initramfs.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index fca899622937..39a4fba48cc7 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -125,6 +125,8 @@ static void __init dir_add(const char *name, time64_t mtime)
>   		panic("can't allocate dir_entry buffer");
>   	INIT_LIST_HEAD(&de->list);
>   	de->name = kstrdup(name, GFP_KERNEL);
> +	if (!de->name)
> +		panic("can't allocate dir_entry.name buffer");
>   	de->mtime = mtime;
>   	list_add(&de->list, &dir_list);
>   }
> @@ -340,6 +342,8 @@ static int __init do_name(void)
>   				if (body_len)
>   					ksys_ftruncate(wfd, body_len);
>   				vcollected = kstrdup(collected, GFP_KERNEL);
> +				if (!vcollected)
> +					panic("can not allocate vcollected buffer.");

I would change the message to have the same naming as the other out of 
memory messages:

panic("can't allocate vcollected buffer");

Best regards
- David

>   				state = CopyFile;
>   			}
>   		}
> 

