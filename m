Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BB1C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC342072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578557016;
	bh=7XvTC5kB36KuLK7zd1wFe8Scqv4MqoW/teqSDD+VGqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UowoTCPbs4kbD0x5qBP7hXr7vG7hRAVUKX/lW+0c0WiQrjySUI4/jQuMFia30AKZm
	 61dNb99Xu8vugCQZ5CPVjr1y+cIOnghFPdBhS4yHHyFk7JP9D/fcNVcL5JSIAC9IIG
	 1JrBClRMsnWr3C4aO7Nsvny75IMbEf6DCpI9UlFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgAIIDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:03:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbgAIIDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:03:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A40B206ED;
        Thu,  9 Jan 2020 08:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578557014;
        bh=7XvTC5kB36KuLK7zd1wFe8Scqv4MqoW/teqSDD+VGqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QG5X6xnQaJ7jCwtwIMFpR8dQA+hRdkOodGTB/0ZXTscE2zalO7KLx7eghDIrzl+Ku
         KYscjlBRzUw5d+7OHmubqvfV0GtcfSwKWJyFN1nnfUSFDUuqUgcb25SzWlxv5LxkFl
         7B3Km2ffEZ3/Z1PPvJtcbrzEJjmu5QYtFsxHkKDk=
Date:   Thu, 9 Jan 2020 09:03:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     liuyang34 <yangliuxm34@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        liuyang34 <liuyang34@xiaomi.com>
Subject: Re: [PATCH] x86: event, use scnprintf instead of snprintf
Message-ID: <20200109080330.GA2579993@kroah.com>
References: <cover.1578550730.git.liuyang34@xiaomi.com>
 <5fc0611a37b6c73fb524b8469cced8fd4cefc6a1.1578550730.git.liuyang34@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fc0611a37b6c73fb524b8469cced8fd4cefc6a1.1578550730.git.liuyang34@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 02:36:26PM +0800, liuyang34 wrote:
> the return size will low than PAGE_SIZE but maybe over 40 in show_sysctl_tfa,
> so use scnprintf instead of snprintf to get real size
> 
> Signed-off-by: liuyang34 <liuyang34@xiaomi.com>
> ---
>  arch/x86/events/intel/core.c    | 6 +++---
>  arch/x86/events/intel/pt.c      | 2 +-
>  arch/x86/platform/uv/uv_sysfs.c | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 3be51aa..bf287b4 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4372,7 +4372,7 @@ static ssize_t show_sysctl_tfa(struct device *cdev,
>  			      struct device_attribute *attr,
>  			      char *buf)
>  {
> -	return snprintf(buf, 40, "%d\n", allow_tsx_force_abort);
> +	return scnprintf(buf, 40, "%d\n", allow_tsx_force_abort);

No, just use sprintf() for all of these.  We "know" the buffer size is
big enough for a single number.  There's no need for fancy checks for
any sysfs file.

thanks,

greg k-h
