Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEF5C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92312215F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfK1BFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:05:39 -0500
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:54653 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726984AbfK1BFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:05:39 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 87FC31801AA99;
        Thu, 28 Nov 2019 01:05:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fang91_13c5142831d3f
X-Filterd-Recvd-Size: 2213
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Nov 2019 01:05:35 +0000 (UTC)
Message-ID: <34b6c8637bfe636b2b4880e536a190627bb1ee91.camel@perches.com>
Subject: Re: [PATCH 4/4] checkpatch: Drop pr_warning check
From:   Joe Perches <joe@perches.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, pmladek@suse.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, arnd@arndb.de,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        Andy Whitcroft <apw@canonical.com>
Date:   Wed, 27 Nov 2019 17:05:08 -0800
In-Reply-To: <20191128004752.35268-5-wangkefeng.wang@huawei.com>
References: <20191128004752.35268-1-wangkefeng.wang@huawei.com>
         <20191128004752.35268-5-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-28 at 08:47 +0800, Kefeng Wang wrote:
> All pr_warning are removed from kernel, let's cleanup pr_warning
> check in checkpatch.
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Assuming the other bits go in:

Acked-by: Joe Perches <joe@perches.com>

> ---
>  scripts/checkpatch.pl | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 64890be3c8fd..447c0050eec0 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4113,15 +4113,6 @@ sub process {
>  			     "Prefer [subsystem eg: netdev]_$level2([subsystem]dev, ... then dev_$level2(dev, ... then pr_$level(...  to printk(KERN_$orig ...\n" . $herecurr);
>  		}
>  
> -		if ($line =~ /\bpr_warning\s*\(/) {
> -			if (WARN("PREFER_PR_LEVEL",
> -				 "Prefer pr_warn(... to pr_warning(...\n" . $herecurr) &&
> -			    $fix) {
> -				$fixed[$fixlinenr] =~
> -				    s/\bpr_warning\b/pr_warn/;
> -			}
> -		}
> -
>  		if ($line =~ /\bdev_printk\s*\(\s*KERN_([A-Z]+)/) {
>  			my $orig = $1;
>  			my $level = lc($orig);

