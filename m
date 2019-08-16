Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4450AC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFE720665
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="aLkc48Iv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfHPR7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:59:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42367 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfHPR7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:59:35 -0400
Received: by mail-qt1-f193.google.com with SMTP id t12so6982652qtp.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 10:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i+VaYShVe3W4saXvma26zdIVf9Xybael3NPyVed5syY=;
        b=aLkc48Iv3BEtjm/2qN4QzICZl1ZQPTWx25NbCRn1HW9XdtsoUjbweXsnjDlLsKZi1J
         eMRgFoOabckCJVDwQCf3cP6fU/r6sSJhpasdl4EGuMySugGjw+upOZIga+pIINMeJ3xw
         CeV6SJUPwmY1VmVgNPYbKkNIdeX0H0WotcV7LrpBjKsGTs7i3JNCh2fBEtZLGSRQPxYe
         qRezc4x14INseWzsydsRg7TcISrkkjXU6AJNpOsyhiYTyETv9sUGFU3GoYgk2yO2naK3
         1In4gVwiXjPtlYv8hKosQQGKD5VaY7pJvzn3XMICp3l+A9BSj4OwvScPAzrl2Hp/W7Fl
         xbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i+VaYShVe3W4saXvma26zdIVf9Xybael3NPyVed5syY=;
        b=ugQoNpE62AOroQSinRmN0hJiW4qqdLAQq0FA2hOODVkUYR7tGcVTFHRx05znCom4/G
         OCm9Y9Bss4owZiXo01xp42N5TCd43duqKhjgusJS0sTG29kh9bVDL60B45j1CuWkX4u8
         oIg+h4hG49z9/RUdwKKOkR+TQFIbfavCCHfOSbLwVJwvtkVRUIK/nbmUBFjs7LYpS72g
         uHZvuX6WVn1jIlfbYYrUBxMvgS1Wc0MNtef083TsgEGLTvfax6PMQdNWcqHYVomDgnOp
         90dEKH6tZWnJ84Cw/XNgqwqRLWh6UpymL4m31b2p0gR5jpuFWIP+3/q4IXNzjMnu1K8J
         0fOg==
X-Gm-Message-State: APjAAAXdD3/OcBz67LF2EZCAh1oytPZC/sYD/SaqiBe5WdR3JbrYAUM0
        iuiXC77MDJexd3jsbYWVihxHCP7CBHvA8A==
X-Google-Smtp-Source: APXvYqybiP6RTpZYVBbePO+r54SBvnBfIpDtKNk0dPP6vG1GPAdNAV91uUp8uQT54GtZNuoeHO/dRg==
X-Received: by 2002:ac8:50b:: with SMTP id u11mr9739786qtg.308.1565978374560;
        Fri, 16 Aug 2019 10:59:34 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s184sm3390387qkf.73.2019.08.16.10.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 10:59:33 -0700 (PDT)
Date:   Fri, 16 Aug 2019 13:59:32 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, Tejun Heo <tj@kernel.org>
Subject: Re: io.latency controller apparently not working
Message-ID: <20190816175931.cxpdko44cuyq7trj@MacBook-Pro-91.local>
References: <22878C62-54B8-41BA-B90C-1C5414F3060F@linaro.org>
 <20190816132124.ggedqxrhi5povqlo@macbook-pro-91.dhcp.thefacebook.com>
 <1842D618-3E31-47FE-8B9C-F26BF1F5349C@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1842D618-3E31-47FE-8B9C-F26BF1F5349C@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 07:52:40PM +0200, Paolo Valente wrote:
> 
> 
> > Il giorno 16 ago 2019, alle ore 15:21, Josef Bacik <josef@toxicpanda.com> ha scritto:
> > 
> > On Fri, Aug 16, 2019 at 12:57:41PM +0200, Paolo Valente wrote:
> >> Hi,
> >> I happened to test the io.latency controller, to make a comparison
> >> between this controller and BFQ.  But io.latency seems not to work,
> >> i.e., not to reduce latency compared with what happens with no I/O
> >> control at all.  Here is a summary of the results for one of the
> >> workloads I tested, on three different devices (latencies in ms):
> >> 
> >>             no I/O control        io.latency         BFQ
> >> NVMe SSD     1.9                   1.9                0.07
> >> SATA SSD     39                    56                 0.7
> >> HDD          4500                  4500               11
> >> 
> >> I have put all details on hardware, OS, scenarios and results in the
> >> attached pdf.  For your convenience, I'm pasting the source file too.
> >> 
> > 
> > Do you have the fio jobs you use for this?
> 
> The script mentioned in the draft (executed with the command line
> reported in the draft), executes one fio instance for the target
> process, and one fio instance for each interferer.  I couldn't do with
> just one fio instance executing all jobs, because the weight parameter
> doesn't work in fio jobfiles for some reason, and because the ioprio
> class cannot be set for individual jobs.
> 
> In particular, the script generates a job with the following
> parameters for the target process:
> 
>  ioengine=sync
>  loops=10000
>  direct=0
>  readwrite=randread
>  fdatasync=0
>  bs=4k
>  thread=0
>  filename=/mnt/scsi_debug/largefile_interfered0
>  iodepth=1
>  numjobs=1
>  invalidate=1
> 
> and a job with the following parameters for each of the interferers,
> in case, e.g., of a workload made of reads:
> 
>  ioengine=sync
>  direct=0
>  readwrite=read
>  fdatasync=0
>  bs=4k
>  filename=/mnt/scsi_debug/largefileX
>  invalidate=1
> 
> Should you fail to reproduce this issue by creating groups, setting
> latencies and starting fio jobs manually, what if you try by just
> executing my script?  Maybe this could help us spot the culprit more
> quickly.

Ah ok, you are doing it on a mountpoint.  Are you using btrfs?  Cause otherwise
you are going to have a sad time.  The other thing is you are using buffered,
which may or may not hit the disk.  This is what I use to test io.latency

https://patchwork.kernel.org/patch/10714425/

I had to massage it since it didn't apply directly, but running this against the
actual block device, with O_DIRECT so I'm sure to be measure the actual impact
of the controller, it all works out fine.  Thanks,

Josef
