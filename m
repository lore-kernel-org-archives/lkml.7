Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5A9C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B5926F0C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mu8+YrUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfFCTBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:01:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34901 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFCTBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:01:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id p1so7329456plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 12:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uOj8qS4yMWJcPzBr8jU/oW2KYVngTdjQDL1LJv/Tl0k=;
        b=mu8+YrUWQdYC2yPvI31aJeWbUy+/m/JdlBnvxPwbPgA4aR3Dko6HDsZHyi2HsBRRA8
         5ZlaLTjxNM68Al1YETdnGXAFwRlrElG6NZZ1j8Hx4UVHJ3hcuZD5Y/7VqGQRirguL3N7
         ccmPcVkphF2ROPyPYGWb6oqTC7KpewSiRiDXKJGxCopyHEAW0lSbHXCTbSbo40S30gSm
         UrgWiQJ9MzEPZG4NWjrakLfjBSt+eTyVA+31+Grrka+qDfU5BzOXXSXNlVKnOEoumMGs
         c9QGJJG4EXRd5w2FiwIHepI++jpU4ZPuUEBJf4WhgSmpKyN4NxdhbypbTGeXH38oeMkA
         5P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uOj8qS4yMWJcPzBr8jU/oW2KYVngTdjQDL1LJv/Tl0k=;
        b=WArcoyXT/2R1p1NAJT99b7d+fO6/qNGB+YsxTfieMYOUDoXJxhPzMYwy++ZVJhA+Vw
         c6YYihozzzkEzPhp40742bp9GdCyeOAUvcL3X1yqY8YbPCVT2hzFGy7iUPCtsyUIzzh2
         j3k8c+Y9J8u9VhLtBF0o4Rq35DsWN/kFdMy0J7BGqWS9sY+HqcXvP+Ed2WXxLMI45i1c
         vWXmGmoiBlJnBzOcnqD24ItR8askVTtDW5Q3Vo1tQiTaiyoRmEhWMGoTPCoNxgn3rcDB
         8jUMZW5FbkXrj5nOALQJ/zKgvtdeJaH+ur87rHzG1eR4a4Iu1rHf5uDfjtIpcVZ6cCGq
         058A==
X-Gm-Message-State: APjAAAUL8b1frWOrysvCErLTP7/b+D1m/L9BEqrlhaFVKll+YLJto4pi
        gqsIuOBvmEbh19PBrD5w3Zliqg==
X-Google-Smtp-Source: APXvYqykPgkSoXQZvF7692GpCMJ2OMiNKz9Vibqh/vST8wLXn0EjIfLgD7N96K2Ny86xOMvDMWXBGw==
X-Received: by 2002:a17:902:bc83:: with SMTP id bb3mr9026727plb.56.1559588495811;
        Mon, 03 Jun 2019 12:01:35 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 24sm17259787pgn.32.2019.06.03.12.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 12:01:35 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:01:33 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        leo.yan@linaro.org, coresight@lists.linaro.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: coresight: Update the generic device names
Message-ID: <20190603190133.GA20462@xps15>
References: <1559229077-26436-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559229077-26436-1-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Thu, May 30, 2019 at 04:11:17PM +0100, Suzuki K Poulose wrote:
> Update the documentation to reflect the new naming scheme with
> latest changes.
> 
> Reported-by: Leo Yan <leo.yan@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  Documentation/trace/coresight.txt | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
> index efbc832..7b427cf 100644
> --- a/Documentation/trace/coresight.txt
> +++ b/Documentation/trace/coresight.txt
> @@ -326,16 +326,20 @@ amount of processor cores), the "cs_etm" PMU will be listed only once.
>  A Coresight PMU works the same way as any other PMU, i.e the name of the PMU is
>  listed along with configuration options within forward slashes '/'.  Since a
>  Coresight system will typically have more than one sink, the name of the sink to
> -work with needs to be specified as an event option.  Names for sink to choose
> -from are listed in sysFS under ($SYSFS)/bus/coresight/devices:
> +work with needs to be specified as an event option.
> +On newer kernels the available sinks are listed in sysFS under:
> +($SYSFS)/bus/event_source/devices/cs_etm/sinks/
>  
> -	root@linaro-nano:~# ls /sys/bus/coresight/devices/
> -		20010000.etf   20040000.funnel  20100000.stm  22040000.etm
> -		22140000.etm  230c0000.funnel  23240000.etm 20030000.tpiu
> -		20070000.etr     20120000.replicator  220c0000.funnel
> -		23040000.etm  23140000.etm     23340000.etm
> +	root@localhost:/sys/bus/event_source/devices/cs_etm/sinks# ls
> +	tmc_etf0  tmc_etr0  tpiu0
>  
> -	root@linaro-nano:~# perf record -e cs_etm/@20070000.etr/u --per-thread program
> +On older kernels, this may need to be found from the list of coresight devices,
> +available under ($SYSFS)/bus/coresight/devices/:
> +
> +	root@localhost:/sys/bus/coresight/devices# ls
> +	etm0  etm1  etm2  etm3  etm4  etm5  funnel0  funnel1  funnel2  replicator0  stm0 tmc_etf0  tmc_etr0  tpiu0
> +
> +	root@linaro-nano:~# perf record -e cs_etm/@tmc_etr0/u --per-thread program

On the "older" kernels you are referring to one would find the original naming
convention.  Everything else looks good to me.

Mathieu

>  
>  The syntax within the forward slashes '/' is important.  The '@' character
>  tells the parser that a sink is about to be specified and that this is the sink
> @@ -352,7 +356,7 @@ perf can be used to record and analyze trace of programs.
>  Execution can be recorded using 'perf record' with the cs_etm event,
>  specifying the name of the sink to record to, e.g:
>  
> -    perf record -e cs_etm/@20070000.etr/u --per-thread
> +    perf record -e cs_etm/@tmc_etr0/u --per-thread
>  
>  The 'perf report' and 'perf script' commands can be used to analyze execution,
>  synthesizing instruction and branch events from the instruction trace.
> @@ -381,7 +385,7 @@ sort example is from the AutoFDO tutorial (https://gcc.gnu.org/wiki/AutoFDO/Tuto
>  	Bubble sorting array of 30000 elements
>  	5910 ms
>  
> -	$ perf record -e cs_etm/@20070000.etr/u --per-thread taskset -c 2 ./sort
> +	$ perf record -e cs_etm/@tmc_etr0/u --per-thread taskset -c 2 ./sort
>  	Bubble sorting array of 30000 elements
>  	12543 ms
>  	[ perf record: Woken up 35 times to write data ]
> @@ -405,7 +409,7 @@ than the program flow through the code.
>  As with any other CoreSight component, specifics about the STM tracer can be
>  found in sysfs with more information on each entry being found in [1]:
>  
> -root@genericarmv8:~# ls /sys/bus/coresight/devices/20100000.stm
> +root@genericarmv8:~# ls /sys/bus/coresight/devices/stm0
>  enable_source   hwevent_select  port_enable     subsystem       uevent
>  hwevent_enable  mgmt            port_select     traceid
>  root@genericarmv8:~#
> @@ -413,14 +417,14 @@ root@genericarmv8:~#
>  Like any other source a sink needs to be identified and the STM enabled before
>  being used:
>  
> -root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20010000.etf/enable_sink
> -root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20100000.stm/enable_source
> +root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> +root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/stm0/enable_source
>  
>  From there user space applications can request and use channels using the devfs
>  interface provided for that purpose by the generic STM API:
>  
> -root@genericarmv8:~# ls -l /dev/20100000.stm
> -crw-------    1 root     root       10,  61 Jan  3 18:11 /dev/20100000.stm
> +root@genericarmv8:~# ls -l /dev/stm0
> +crw-------    1 root     root       10,  61 Jan  3 18:11 /dev/stm0
>  root@genericarmv8:~#
>  
>  Details on how to use the generic STM API can be found here [2].
> -- 
> 2.7.4
> 
