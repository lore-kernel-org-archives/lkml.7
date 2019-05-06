Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E51C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A7B2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQsVyBPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfEFP25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:28:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42378 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfEFP2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:28:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id x15so6543488pln.9;
        Mon, 06 May 2019 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ni0nYa2huLfZBcftsr0RdPMCdFa/P01V014djrD6sKg=;
        b=IQsVyBPLp/A4XetoGLHzbycCzucWhdjtZStFTTwYuI0tCp4LaX/jzYySSVeUib6bac
         fZcncFhkGLSTq12wUK9wb4pnd1woUJs6hQeccWXU3B2Lgo2zAZssF0nuZk3laAEc8XDp
         jY8baztQtqyJ6S0d5pbTM3SqqfTjmU382MU5jBQzSRFXgT5xLwP4kN6cPGad+hq4osrJ
         7NlVjlVCCt7ke+vhCW+AT/Uiklo3cxsDKXzN4zEOv/GkjmawR70P+V3TM1TflMxMldhl
         DAwcjB5f40atanTkvY3X6rdh6IurIWo5o8PG0yA6iKyt+wTArcqCQnVtCTL43/zXDwuY
         jMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ni0nYa2huLfZBcftsr0RdPMCdFa/P01V014djrD6sKg=;
        b=Mxlj20gjCTBGcs3W4MzkQqRhh30M43DErQgiilN9h35HVC2W/zO8yVwz9a811IvFJ0
         MFmYwyWcW1berBKKu7NJqcp4H3Skb1i0zjBIHedFlxIQ8VSCvGJbYVZBzblaH4FfyLtE
         HLvkHoB0pwd72y72UblZdKnt5tYzyc+Lfe6HrBTcemu3zYlGqW6r6VW1hN1KzzSQ6Hs7
         Swqp7oX/Z2yeZPCErCa/WlsA9nda1IwEHl7GGAyRXqCNObIrE54Cpmq/S3a8kHKARxtt
         WXU77yEDVlicXOEeh7KbbGjnelArbXtNJhCp7RR3rvnjcYRM5pOs4tkmyROpgTf2EFDB
         1zUw==
X-Gm-Message-State: APjAAAUyKkTzhAMaQzH28rrN8o5rrbXwcE+GDy81uqXee71diM3JMnBq
        fn2Eili+nUr9nuRbI36hnh0=
X-Google-Smtp-Source: APXvYqydNNlU2ZquZynRHfOvL7hRk6S4ZuUoLz6/jAUr2FlK5c3lzxg9e+ysVl5xkMyx6LepNMTzxA==
X-Received: by 2002:a17:902:8f93:: with SMTP id z19mr25488306plo.108.1557156534653;
        Mon, 06 May 2019 08:28:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2sm28060719pfi.73.2019.05.06.08.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:28:54 -0700 (PDT)
Date:   Mon, 6 May 2019 08:28:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: typec: tcpm: Export the logging function so it
 can be used by tcpci
Message-ID: <20190506152853.GB29049@roeck-us.net>
References: <20190506140830.25376-1-angus@akkea.ca>
 <20190506140830.25376-2-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506140830.25376-2-angus@akkea.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 08:08:28AM -0600, Angus Ainslie (Purism) wrote:
> Give the rest of the tcpm stack access to the logging function.
> 

Those functions are not intended to be exported. I would be open to extracting
the loging code into its own file and make it generic/usable for all tcpm
drivers, but the tcpm log itself should be limited to tcpm, and remain so.

Guenter

> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 ++-
>  include/linux/usb/tcpm.h      | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index fba32d84e578..7c35cc1accae 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -465,7 +465,7 @@ static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
>  }
>  
>  __printf(2, 3)
> -static void tcpm_log(struct tcpm_port *port, const char *fmt, ...)
> +void tcpm_log(struct tcpm_port *port, const char *fmt, ...)
>  {
>  	va_list args;
>  
> @@ -479,6 +479,7 @@ static void tcpm_log(struct tcpm_port *port, const char *fmt, ...)
>  	_tcpm_log(port, fmt, args);
>  	va_end(args);
>  }
> +EXPORT_SYMBOL_GPL(tcpm_log);
>  
>  __printf(2, 3)
>  static void tcpm_log_force(struct tcpm_port *port, const char *fmt, ...)
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index 36a15dcadc53..70bfffdf5760 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -169,4 +169,6 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
>  void tcpm_pd_hard_reset(struct tcpm_port *port);
>  void tcpm_tcpc_reset(struct tcpm_port *port);
>  
> +void tcpm_log(struct tcpm_port *port, const char *fmt, ...);
> +
>  #endif /* __LINUX_USB_TCPM_H */
> -- 
> 2.17.1
> 
