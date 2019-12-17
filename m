Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8F6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D282067C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axjmwqup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfLQHcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:32:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34066 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLQHcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:32:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id x17so5711235pln.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 23:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=o9tdHWD77Msphb5SbcvlIXbnBZel1oX6S1JFAOa66jk=;
        b=axjmwqup/aTMRSMjYm9Y4TMXli/UJbEdrCgDaWuDLXZyudjg4JqCq2YLSixQQXLpZI
         u3n5Zj+orwoh/T3W6A+mv5iLa6ZODqfgr4EpW0ikcqxLvcbQ+VAyrhctvx80Hz+mRw1j
         SIAFrHqPR1zQaLO+QUuMPFeVBUAvZ/TXhmYVYF6vx7AUqSm79rddQWndwiqa7GZDpqVX
         PKnoTdLZU6Hx0xF9t6pzeqe+I4rPlXSM7/fRizcsGG2xADBhlZxNPsCqU1cm6rPpQESQ
         5Eg5zzRJaiLfyt67p5kLe5XU+gMbh9hrrZV4pA+e39a5+z10GXps3YXxgALbVZLUdwrT
         eBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=o9tdHWD77Msphb5SbcvlIXbnBZel1oX6S1JFAOa66jk=;
        b=blYsX/VbPHmDLzYqy92NjH3rPZVX8geUg0zMAUp7I2eQxN3/e6edpPM0/Y92X78vbk
         0BoIC9Ua8B+DE8Szj2OaXEF/yRDxZ1TKIPP47TNJGlOFAt69p87pUeCG0HxHYczdUw8a
         TSEeg11iL7IAN7Z21NsuEufGJVCldq2fujaoe9ijxFLIyldKWOnIvc5wFJSmYsoBZMYc
         26yZV8qBHBqm6xJKavyHLTkpKLl2E0gbR07CEskzm16cycsJUMyvJD8vormd+F62x/VB
         OaAz73lL0PmnwNLHY2IJW9UuAoTPZfZ1+axvbtBnD6OOFyp63GOe7mEvNvfOirdiF2tA
         y5nw==
X-Gm-Message-State: APjAAAXuVri/7uegJN5S7WhjBdVXHWhTbmvHHD11NlC7DyQxfT+lBKrf
        pwVSeHw2oQwjHaj9fmdZPSx/bA==
X-Google-Smtp-Source: APXvYqwbWVbjdimlaICgxarJlVLr9XYaYHenzi5D4IY0YOKA2AKxdGHJCXGkGpje4RlsT1I2khpObw==
X-Received: by 2002:a17:90b:4396:: with SMTP id in22mr4114328pjb.111.1576567937402;
        Mon, 16 Dec 2019 23:32:17 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d23sm24799629pfo.176.2019.12.16.23.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 23:32:16 -0800 (PST)
Date:   Mon, 16 Dec 2019 23:32:16 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Pan Zhang <zhangpan26@huawei.com>
cc:     hushiyuan@huawei.com, ulf.hansson@linaro.org, allison@lohutok.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: host: use kzalloc instead of kmalloc and
 memset
In-Reply-To: <1576567086-11469-1-git-send-email-zhangpan26@huawei.com>
Message-ID: <alpine.DEB.2.21.1912162331110.168267@chino.kir.corp.google.com>
References: <1576567086-11469-1-git-send-email-zhangpan26@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019, Pan Zhang wrote:

> Signed-off-by: Pan Zhang <zhangpan26@huawei.com>
> ---
>  drivers/mmc/host/vub300.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index 6ced1b7..e18931d 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -1227,12 +1227,10 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
>  	size -= 1;
>  	if (interrupt_size < size) {
>  		u16 xfer_length = roundup_to_multiple_of_64(interrupt_size);
> -		u8 *xfer_buffer = kmalloc(xfer_length, GFP_KERNEL);
> +		u8 *xfer_buffer = kzalloc(xfer_length, GFP_KERNEL);
>  		if (xfer_buffer) {
>  			int retval;
>  			memcpy(xfer_buffer, data, interrupt_size);
> -			memset(xfer_buffer + interrupt_size, 0,
> -			       xfer_length - interrupt_size);
>  			size -= interrupt_size;
>  			data += interrupt_size;
>  			retval =
> @@ -1270,12 +1268,10 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
>  	size -= 1;
>  	if (ts < size) {
>  		u16 xfer_length = roundup_to_multiple_of_64(ts);
> -		u8 *xfer_buffer = kmalloc(xfer_length, GFP_KERNEL);
> +		u8 *xfer_buffer = kzalloc(xfer_length, GFP_KERNEL);
>  		if (xfer_buffer) {
>  			int retval;
>  			memcpy(xfer_buffer, data, ts);
> -			memset(xfer_buffer + ts, 0,
> -			       xfer_length - ts);
>  			size -= ts;
>  			data += ts;
>  			retval =

I think the previous code is an optimization since the first 
interrupt_size bytes or ts bytes of xfer_buffer would otherwise 
unnecessarily be zeroed and then copied to.
