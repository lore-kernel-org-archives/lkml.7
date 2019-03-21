Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AACBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B1F20850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBEvRgE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfCUJra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:47:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36959 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfCUJra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:47:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so1966036wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 02:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Od3i4kr9yLr0+eztuTG35y6WrNaSDWhqSnaiU53xeo=;
        b=eBEvRgE6RfDfdNqQEg0seNqaC8iQlVDgdiiBeDykV+1nClL9+AVIi6sS5UxlRgttp8
         MuznJAqLS7AmqEtdhm+GOFQXMFTE8PAy4fmzOg/Moz5oR81dFPUBaHch2RDoS5rX/JSt
         qnRrN1bRxtu6u5hTlCk4cfp8qp8cSAeNiNvenTje5uR6dJEoH/uCLrVnmSXTprpJS1xR
         ktMXWiVqp9d3T7FLVpFUnlvTQBlqWl5v3FykzkBjS74T8oyNHIB8mxIU2bEClvZtODh1
         AQhR/FXNwpXiwR9UFT6Hm5SdeRdeKPP3klHvsBSc9/pzoBlUzXtt1EGK8DqBV+t6TTnm
         JIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Od3i4kr9yLr0+eztuTG35y6WrNaSDWhqSnaiU53xeo=;
        b=Q8nPbsaf6ZM1E+r9GK6jMyGFWNaIdm2SCRy7rD9PNf10USs7PwonOOomDFEgSKlkpp
         F5bz0/FKX3H+6Utci0qJY2FJIsQFlrR3b03Tqu7d46MIG9Fx2bI7ebkrxGfqDtw6IVyD
         uQLMr8Ck6zXEvTMOx/cn2MnmFQevx4SipXEHcwXA2TVx+KJRqNANgD1h6GJ1sEE04t2n
         M3P7da5brHunSyDajrikhQFwWfvn2XQXg2NckQjclKC1/hzMlVGwemQzwWCErUKPTWLt
         NIdl6pIxWX9n2rv/QzTjl6fYrG7JaRtuBgoVod1MusGlTiT8pPsTg29bnn8JGgUxamIq
         u5pg==
X-Gm-Message-State: APjAAAVmP4JxLAUQpFRyaYr2Lq2TZSd7gFn1KnubUOY5gHfNP3hZtp/z
        qgK1hIEJzAusJvheAETR0zM=
X-Google-Smtp-Source: APXvYqycQRaBo9B4DLw3Iot0P8g1KSU0WwIt47ZgrNWJwfItaGH0dq/UdRTQpc1eCCLHdcGrcOKUpw==
X-Received: by 2002:a1c:2c4:: with SMTP id 187mr1760468wmc.77.1553161648604;
        Thu, 21 Mar 2019 02:47:28 -0700 (PDT)
Received: from giga-mm ([62.68.28.142])
        by smtp.gmail.com with ESMTPSA id n13sm6205009wrw.67.2019.03.21.02.47.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Mar 2019 02:47:27 -0700 (PDT)
Date:   Thu, 21 Mar 2019 10:47:26 +0100
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Mike Crowe <mac@mcrowe.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kay Sievers <kay@vrfy.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: kmsg: lseek errors confuse glibc's dprintf
Message-Id: <20190321104726.3c570c41e5757611a13c23ca@gmail.com>
In-Reply-To: <20150115173132.GA7486@mcrowe.com>
References: <20150115173132.GA7486@mcrowe.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike and all,

On Thu, 15 Jan 2015 17:31:32 +0000
Mike Crowe <mac@mcrowe.com> wrote:

> glibc's dprintf implementation does not work correctly with /dev/kmsg file
> descriptors because glibc treats receiving EBADF and EINVAL from lseek when
> trying to determine the current file position as errors. See
> https://sourceware.org/bugzilla/show_bug.cgi?id=17830

we need to conclude on this issue. This is a real bug which is ignored
for 4 years now. Mike, would you like to re-send a formal patch?
I can do it as well, preserving a link to your original patch/report.
In case you'd like to post it yourself, I can be a tester and/or
provide a reproducer.

> >>From what I can tell prior to Kay Sievers printk record commit
> e11fea92e13fb91c50bacca799a6131c81929986, calling lseek(fd, 0, SEEK_CUR)
> with such a file descriptor would not return an error.
> 
> Prior to Kay's change, Arnd Bergmann's commit
> 6038f373a3dc1f1c26496e60b6c40b164716f07e seemed to go to some lengths to
> preserve the successful return code rather than returning (the perhaps more
> logical) -ESPIPE.
> 
> glibc is happy with either a successful return or -ESPIPE.
> 
> For maximum compatibility it seems that success should be returned but
> given Kay's new seek interface perhaps this isn't helpful.
> 
> This patch ensures that such a seek succeeds:
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 02d6b6d..b3ff6f0 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -693,7 +693,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
>  	loff_t ret = 0;
>  
>  	if (!user)
> -		return -EBADF;
> +		return (whence == SEEK_CUR) ? 0 : -EBADF;
>  	if (offset)
>  		return -ESPIPE;
>  
> @@ -718,6 +718,11 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
>  		user->idx = log_next_idx;
>  		user->seq = log_next_seq;
>  		break;
> +	case SEEK_CUR:
> +		/* For compatibility with userspace requesting the
> +		 * current file position. */
> +		ret = 0;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> 
> (although it could be argued that the !user case should return -ESPIPE
> rather than EBADF since the file descriptor _is_ valid.)
> 
> and this patch causes a failure that glibc is prepared to accept:
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 02d6b6d..f6b0c93 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -693,7 +693,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
>  	loff_t ret = 0;
>  
>  	if (!user)
> -		return -EBADF;
> +		return -ESPIPE;
>  	if (offset)
>  		return -ESPIPE;
>  
> @@ -718,6 +718,11 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
>  		user->idx = log_next_idx;
>  		user->seq = log_next_seq;
>  		break;
> +	case SEEK_CUR:
> +		/* For compatibility with userspace expecting SEEK_CUR
> +		 * to not yield EINVAL. */
> +		ret = -ESPIPE;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> 
> Either makes dprintf work, but is either the right solution?
> 
> Thanks.
> 
> Mike.


-- 
Alexander Sverdlin.
