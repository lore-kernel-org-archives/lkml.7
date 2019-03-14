Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EC8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5352184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Z9rTmnhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfCNN4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:56:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43827 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfCNN4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:56:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id l11so4019915pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pxUN0assfQwAH4npwQcC9Bp1PkvWAATo6HLmNj9kEUE=;
        b=Z9rTmnhkHvjRSfEp239a3ZBcZatG9f2b/yWsT4okdj6Ok7g+LbdE3pgkpSsF/hJCHU
         SYqOi0PpQD4mxmjKA9B57ACpW3o9PvpkXDzelNMgixBKCZZVFGr3S6kIE7iqz2vyCcf9
         Zf+5/nNhyghYl0b4ufjlwTubmNIXjetRC/0o4MeVDD4MYAAQKyy6V04byAqVmx5Wo+J0
         4h+hMbdVTkmftDGm2AQamS3zFRL/7Nkn2WV+ONbl2VNjOlfvztdxVKPNycRZwabN31NT
         RLEnA7FKIdvk/owtXPOS11LX/uNSfHP7oFEic+tAtDFu6y3+eT7S0e1iF4uyjwsUPYo0
         TtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pxUN0assfQwAH4npwQcC9Bp1PkvWAATo6HLmNj9kEUE=;
        b=VfTC+1SaX/MvOZqkiU0sKCMEvzVg6dCdOe7hTAzNELZaBHcVcpqoyvHauQIymt5/0H
         CVaaVHtnxKXxRvQ1OUA7XXQuKnicyrtg5a7HnzVWBLksnt3nQoumi5H7JXOQQz3S7O57
         6+HznhhvAMoCIL85QlW3YP+GccePNHJqwv4kNA52IPJAk9zRwqdTfl8sz5IyQl37LHAa
         J9r0lV6/1a0Kaptl8tfrFUlr6h9XmRQBTDnvwvhcuKy+j6V98w2eUmq/vhXNbC/9wFLP
         D+KKWs1tZ624V8R04M1LE4zXuZhP607YqpXTRAebPnWFI7w6LH0UI6qR/mkBF8V+1Ax2
         usiQ==
X-Gm-Message-State: APjAAAW5zbXzDbf6iIR9HGSj8CQ/a+uA8qL7y9M7D0wmqReCIaanw4EK
        jsKx9y95/uxlGO3Jx+Y6W8BSZNGz3ZfmHw==
X-Google-Smtp-Source: APXvYqyCNWlS7KFyMMIgjmhWQn7oVOmW4gkYujMbVx/ZxluriOEnjilEbm/r2cthBzyxEnHZmEXN1Q==
X-Received: by 2002:aa7:8186:: with SMTP id g6mr49716507pfi.138.1552571771277;
        Thu, 14 Mar 2019 06:56:11 -0700 (PDT)
Received: from [192.168.15.174] (71-6-111-190.static-ip.telepacific.net. [71.6.111.190])
        by smtp.gmail.com with ESMTPSA id m24sm18129041pgv.1.2019.03.14.06.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 06:56:10 -0700 (PDT)
Subject: Re: [PATCH] nvme: lightnvm: expose OC devices as zero size to OS
To:     Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Cc:     igor.j.konopko@intel.com, Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1552570910-11706-1-git-send-email-marcin.dziegielewski@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <4e43d40a-b253-1493-da38-70a8c062749e@lightnvm.io>
Date:   Thu, 14 Mar 2019 06:56:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1552570910-11706-1-git-send-email-marcin.dziegielewski@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/19 6:41 AM, Marcin Dziegielewski wrote:
> Open channel devices are not able to handle traditional
> IO requests addressed by LBA, so following current
> approach to exposing special nvme devices as zero size
> (e.g. with namespace formatted to use metadata) also
> open channel devices should be exposed as zero size
> to OS.
> 
> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
> ---
>   drivers/nvme/host/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 07bf2bf..52cd5c8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1606,7 +1606,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   	if (ns->ms && !ns->ext &&
>   	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
>   		nvme_init_integrity(disk, ns->ms, ns->pi_type);
> -	if (ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
> +	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
> +	    ns->ndev)
>   		capacity = 0;
>   
>   	set_capacity(disk, capacity);
> 

Marcin,

The read/write as traditional I/Os feature is supported in OCSSD 2.0. 
For example, one can hook support up through the zone device support in 
the kernel. There is a patch here that enables it here:

https://github.com/OpenChannelSSD/linux/commit/e79e747601a315784e505d51a9265e82a3e7613c

With that, an OCSSD device can be used as a traditional zoned block 
device, and use the existing infrastructure. Which is really neat.

It is not upstream, since it depends on some features that we introduce 
with zoned namespaces, but in general, tools can read/write from a block 
device as any other, just honoring the special write rules that are for 
OCSSD/zoned block devices.

-Matias
