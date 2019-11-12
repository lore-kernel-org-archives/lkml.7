Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6A4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D48621925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5yUTYdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLU3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:29:37 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40882 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfKLU3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:29:37 -0500
Received: by mail-oi1-f195.google.com with SMTP id 22so16097341oip.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nuSxtpboCRFRoH7ONR/ButKqpEu2VWZcgPYrZ3xx478=;
        b=c5yUTYduIUiho00H0b3vhjtRjB+ajbeo7u2wmpJPSMI0+GG55FNytcQPRmRnWnyFj1
         m432tYV8/llpTRhPJfog/sSGDxnrAMUqkwR9Zqq+MNfLAtXO56t75b8042lQmynQEPUQ
         P66WVNVMDWdc5oalPToJYo0bl83h34bPblu7b9DkYCExgOHck3JuCFrqAIJm5P/otTux
         Uus+Bili5xOtFHdymFj7uqdzv/GtqofxZY5yfPdUTg/eg8NRGUZD9t5M+O/2ST7Pfqiy
         Wd6X4pUb8PBIxJoVziUV1cNNzAp49YvHBtA/neT73vXlgc9I9FOL2Znm/AbvtWgo0S+K
         jScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nuSxtpboCRFRoH7ONR/ButKqpEu2VWZcgPYrZ3xx478=;
        b=pt/PuIErGAADXhJBYim+MQ/tM3oFZm/Zsih296Eg/W9pLHRwEWcecrtsLwRb3I2N5j
         M5LOHz90DW1yOtD6sQ3WNgvSH3ElYXnxWoXqWPcPqMn/UVY7XZVPve6ywitSuTQeZm3J
         7OQ2ablXJv92Nso4ZLkZazIgscdDW/2L+Ggtj8B1sVC6xSYGTxUcWvw68ZbcgBT4csHp
         0x3YXrzEh2jYrg4BdO0v1JUKz34YzADjWUOBlFbErFXIy1fHDTVWI9NRxSRx/spBCMz+
         3Iz0JOwjJnQMuLuzjYeWHeIlAQ2MLCZ3T0fA9sncaCvsnfASIktrDW1jUod4L2uTtvkO
         izZA==
X-Gm-Message-State: APjAAAWEgBMlRNdIMKkeABZ/Cm2//IFVYPBOPJeQ9qcmiE48g+4c04lL
        2HJZvEuIipbBH+ZS4d0DlQ==
X-Google-Smtp-Source: APXvYqzkAt+1k/8BZCXeyArXDOhGImLjCdeMesIH8HcGa0Km475jeAHh7ADW67WFyJhYu8RqDGgvZQ==
X-Received: by 2002:a05:6808:181:: with SMTP id w1mr751465oic.109.1573590575994;
        Tue, 12 Nov 2019 12:29:35 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id k6sm2775908otr.35.2019.11.12.12.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 12:29:35 -0800 (PST)
Received: from minyard.net (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id 4A03118016D;
        Tue, 12 Nov 2019 20:29:33 +0000 (UTC)
Date:   Tue, 12 Nov 2019 14:29:32 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cminyard@mvista.com" <cminyard@mvista.com>,
        "asmaa@mellanox.com" <asmaa@mellanox.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
Subject: Re: [PATCH 2/2] drivers: ipmi: Modify max length of IPMB packet
Message-ID: <20191112202932.GJ2882@minyard.net>
Reply-To: minyard@acm.org
References: <20191112023610.3644314-1-vijaykhemka@fb.com>
 <20191112023610.3644314-2-vijaykhemka@fb.com>
 <20191112124845.GE2882@minyard.net>
 <7BC487D6-6ACA-46CE-A751-8367FEDEE647@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7BC487D6-6ACA-46CE-A751-8367FEDEE647@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 07:56:34PM +0000, Vijay Khemka wrote:
> 
> 
> ﻿On 11/12/19, 4:48 AM, "Corey Minyard" <tcminyard@gmail.com on behalf of minyard@acm.org> wrote:
> 
>     On Mon, Nov 11, 2019 at 06:36:10PM -0800, Vijay Khemka wrote:
>     > As per IPMB specification, maximum packet size supported is 255,
>     > modified Max length to 240 from 128 to accommodate more data.
>     
>     I couldn't find this in the IPMB specification.
>     
>     IIRC, the maximum on I2C is 32 byts, and table 6-9 in the IPMI spec,
>     under "IPMB Output" states: The IPMB standard message length is
>     specified as 32 bytes, maximum, including slave address.
> 
> We are using IPMI OEM messages and our response size is around 150 bytes
> For some of responses. That's why I had set it to 240 bytes.

Hmm.  Well, that is a pretty significant violation of the spec, but
there's nothing hard in the protocol that prohibits it, I guess.

If Asmaa is ok with this, I'm ok with it, too.

-corey

>     
>     I'm not sure where 128 came from, but maybe it should be reduced to 31.
>     
>     -corey
>     
>     > 
>     > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
>     > ---
>     >  drivers/char/ipmi/ipmb_dev_int.c | 2 +-
>     >  1 file changed, 1 insertion(+), 1 deletion(-)
>     > 
>     > diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
>     > index 2419b9a928b2..7f9198bbce96 100644
>     > --- a/drivers/char/ipmi/ipmb_dev_int.c
>     > +++ b/drivers/char/ipmi/ipmb_dev_int.c
>     > @@ -19,7 +19,7 @@
>     >  #include <linux/spinlock.h>
>     >  #include <linux/wait.h>
>     >  
>     > -#define MAX_MSG_LEN		128
>     > +#define MAX_MSG_LEN		240
>     >  #define IPMB_REQUEST_LEN_MIN	7
>     >  #define NETFN_RSP_BIT_MASK	0x4
>     >  #define REQUEST_QUEUE_MAX_LEN	256
>     > -- 
>     > 2.17.1
>     > 
>     
> 
