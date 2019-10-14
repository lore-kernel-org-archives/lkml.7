Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23288ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EFC206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaZ52buO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfJNT5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 15:57:32 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35599 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfJNT5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 15:57:32 -0400
Received: by mail-oi1-f194.google.com with SMTP id x3so14795825oig.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 12:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S01INIyV+fklkeKDjyJw8HpiViode75kudgiuVlNQho=;
        b=GaZ52buO0OTwi5HR740F/BoLVwdE74ahz0/3cNcywM9XNFnxec7OMXPmDsTphcpoPv
         iyI3apF1YoggNbv+eYVxtVVjgD4cKmyjmNT3ESAIKD5SrT6NeVeXcGUJZy6DbWaFCb77
         1EP2Ylo4qA+ZraO7/Qch347HPhNcYbaad69ue6EMeRgux1XGUWI6eIReccXR3pMO9j84
         J8EM1orKRUvXOIKA/yFhrsyu1gWcJdWldjoyLH3vr3oi0h1eHm3SHmOvspRgcMOs1ksK
         rreTm6oXw6b7d/o7tNA/cVC3hxBiVet37Jero9E7SHp09fHPsu+2ShvLbZwtvn0tPybL
         Zi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=S01INIyV+fklkeKDjyJw8HpiViode75kudgiuVlNQho=;
        b=abJaZmi6YxM0k/WBHBvVSxxoszXKwyp6RqNI2z1/hL4YQ2p3MZMIP6f6uXK9MWOYZu
         9Ym0++a0H7sd4/DrDcfF1nXJb/rbUWaGweCCaP/NN8m4eB/dgdNhd86qdW1ONqpKSZkD
         nVnv845OtUoiuz0mvJhjcvdWzKUqy4zdMFHVXdCA+PblQXWakEEtpM8qdiI/DAOOU5dK
         rZlwUW28bwcX8/pHQ0XxWquhFYRahAY740Si2NXbc2J+reoRIahH7tmreIGW23SchHTW
         1JpjlMC5uGZ4/6BXndU62kj3YXDGSFI3auCYcNBDOBZ9eGRC7orBzSwiP3AfDXY1SwPK
         khpg==
X-Gm-Message-State: APjAAAWCBb0+27RXVHrifxUaQWfpBMImVgjdm3FQJ0p/MT/axCSN3TDm
        SnUbfSiTPpw+eUFnWr6ruQ==
X-Google-Smtp-Source: APXvYqxfBJqbteaediDQIkvlxWR9Mog/vfLwxiN/QCbBcmSNo6l3Uzn2wZ4jri5q1YSpG0Fg8pcSsw==
X-Received: by 2002:aca:3001:: with SMTP id w1mr8792629oiw.162.1571083051520;
        Mon, 14 Oct 2019 12:57:31 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id x140sm5965108oix.42.2019.10.14.12.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 12:57:30 -0700 (PDT)
Received: from t560 (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id 3A0C7180046;
        Mon, 14 Oct 2019 19:57:30 +0000 (UTC)
Date:   Mon, 14 Oct 2019 14:57:28 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] ipmi: use %*ph to print small buffer
Message-ID: <20191014195728.GG25427@t560>
Reply-To: minyard@acm.org
References: <20191011155036.36748-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011155036.36748-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 06:50:36PM +0300, Andy Shevchenko wrote:
> From: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Use %*ph format to print small buffer as hex string.
> 
> The change is safe since the specifier can handle up to 64 bytes and taking
> into account the buffer size of 100 bytes on stack the function has never been
> used to dump more than 32 bytes. Note, this also avoids potential buffer
> overflow if the length of the input buffer is bigger.

This is an improvment, thanks, it is in queue in the next tree and
queued for the next merge window.

Thanks, Andy and Jes, for sorting this out while I was on vacation,

-corey

> 
> This completely eliminates ipmi_debug_msg() in favour of Dynamic Debug.
> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> - eliminate ipmi_debug_msg() in favour of Dynamic Debug (Joe)
>  drivers/char/ipmi/ipmi_msghandler.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 2aab80e19ae0..1768b81aaf78 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -44,25 +44,6 @@ static void need_waiter(struct ipmi_smi *intf);
>  static int handle_one_recv_msg(struct ipmi_smi *intf,
>  			       struct ipmi_smi_msg *msg);
>  
> -#ifdef DEBUG
> -static void ipmi_debug_msg(const char *title, unsigned char *data,
> -			   unsigned int len)
> -{
> -	int i, pos;
> -	char buf[100];
> -
> -	pos = snprintf(buf, sizeof(buf), "%s: ", title);
> -	for (i = 0; i < len; i++)
> -		pos += snprintf(buf + pos, sizeof(buf) - pos,
> -				" %2.2x", data[i]);
> -	pr_debug("%s\n", buf);
> -}
> -#else
> -static void ipmi_debug_msg(const char *title, unsigned char *data,
> -			   unsigned int len)
> -{ }
> -#endif
> -
>  static bool initialized;
>  static bool drvregistered;
>  
> @@ -2267,7 +2248,7 @@ static int i_ipmi_request(struct ipmi_user     *user,
>  		ipmi_free_smi_msg(smi_msg);
>  		ipmi_free_recv_msg(recv_msg);
>  	} else {
> -		ipmi_debug_msg("Send", smi_msg->data, smi_msg->data_size);
> +		pr_debug("Send: %*ph\n", smi_msg->data_size, smi_msg->data);
>  
>  		smi_send(intf, intf->handlers, smi_msg, priority);
>  	}
> @@ -3730,7 +3711,7 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_smi *intf,
>  		msg->data[10] = ipmb_checksum(&msg->data[6], 4);
>  		msg->data_size = 11;
>  
> -		ipmi_debug_msg("Invalid command:", msg->data, msg->data_size);
> +		pr_debug("Invalid command: %*ph\n", msg->data_size, msg->data);
>  
>  		rcu_read_lock();
>  		if (!intf->in_shutdown) {
> @@ -4217,7 +4198,7 @@ static int handle_one_recv_msg(struct ipmi_smi *intf,
>  	int requeue;
>  	int chan;
>  
> -	ipmi_debug_msg("Recv:", msg->rsp, msg->rsp_size);
> +	pr_debug("Recv: %*ph\n", msg->rsp_size, msg->rsp);
>  
>  	if ((msg->data_size >= 2)
>  	    && (msg->data[0] == (IPMI_NETFN_APP_REQUEST << 2))
> @@ -4576,7 +4557,7 @@ smi_from_recv_msg(struct ipmi_smi *intf, struct ipmi_recv_msg *recv_msg,
>  	smi_msg->data_size = recv_msg->msg.data_len;
>  	smi_msg->msgid = STORE_SEQ_IN_MSGID(seq, seqid);
>  
> -	ipmi_debug_msg("Resend: ", smi_msg->data, smi_msg->data_size);
> +	pr_debug("Resend: %*ph\n", smi_msg->data_size, smi_msg->data);
>  
>  	return smi_msg;
>  }
> -- 
> 2.23.0
> 
