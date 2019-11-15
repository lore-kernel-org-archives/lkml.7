Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96D7C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB2B2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WvPEQM25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfKOIBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:01:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41088 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOIBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:01:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id m4so4729640ljj.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 00:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K7AVtvzUjcO1cH7HI4QDDaRMFMqYOvK9VjNlChoFy28=;
        b=WvPEQM25nYZqJtCFviyiD5ljzM/UmkIClduWS5T64tJiWhNJmgokv03NvNrxgyQS+y
         +5ABXTxPcvc7NSKvwma9diqktx6g7QSNjbcBVdIQbuLjNfOH8c/sfbAmpgxGbu3j8NvN
         SWQP/Ey72K1GHGzEJeMzAkIbyO7FCT+amG3Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K7AVtvzUjcO1cH7HI4QDDaRMFMqYOvK9VjNlChoFy28=;
        b=ZVTQ7mPw6fPuDYF2I084NR+gqjjcDGaMYPXKVYu9dnVhE0jQwNcT34fpP1Yj+N2Tyv
         XuVLfLgOC2APbtklsEHqwduiE89+M+JUefHx7eKHGXT5x+xANl+eOiPovRRm+8dbzWuj
         6mQwlsAmzR2Auy9eIwtK1rQbTAI9Z2jie6+zTLrtFFjMBR4DBMEGpCydYqFVHR9Q/QRK
         up7OSBETwtepSkhjVj3FIUTt9oZTU+/x9ju38i+fvbfxaXawnkP+Oi3dgAXRGBSXNfM+
         CY+FnAnfTKa4gMsTn95LJl1cM1vIMidzifeAIC6uyVH4SZ5to3j/gomf3uT9KDFAHbeS
         cm9Q==
X-Gm-Message-State: APjAAAUBOAp+5mkIRNw2OsRS6booPjlYQHBqoKnpBssZBp8Tr/MFnVdT
        X+HOM+nTyfUEhOdQTy0poO1PcA==
X-Google-Smtp-Source: APXvYqzc04JNvBuLcN/d5H0lWI5kqLrC+8YRwhm+xzIsLHtvpNLGSz16bdRnRpDrrXnxVQ4J/enZ6Q==
X-Received: by 2002:a2e:9ecf:: with SMTP id h15mr10034052ljk.173.1573804870160;
        Fri, 15 Nov 2019 00:01:10 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a11sm3426309ljm.60.2019.11.15.00.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 00:01:09 -0800 (PST)
Subject: Re: [PATCH v4 32/47] serial: ucc_uart: use of_property_read_u32() in
 ucc_uart_probe()
To:     Timur Tabi <timur@kernel.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-33-linux@rasmusvillemoes.dk>
 <CAOZdJXU1ELqQh7TitAJW7bsmnj89wq3opJGVizC2B19nL_3_rQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <9f1a846b-c303-92fa-9620-f492ef940de7@rasmusvillemoes.dk>
Date:   Fri, 15 Nov 2019 09:01:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOZdJXU1ELqQh7TitAJW7bsmnj89wq3opJGVizC2B19nL_3_rQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2019 14.57, Timur Tabi wrote:
> On Fri, Nov 8, 2019 at 7:03 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> -       if (*iprop)
>> -               qe_port->port.uartclk = *iprop;
>> +       if (val)
>> +               qe_port->port.uartclk = val;
>>         else {
>>                 /*
>>                  * Older versions of U-Boot do not initialize the brg-frequency
>>                  * property, so in this case we assume the BRG frequency is
>>                  * half the QE bus frequency.
>>                  */
> 
> This bug in older U-Boots is definitely PowerPC-specific, so could you
> change this so that it reports an error on ARM if brg-frequency is
> zero, and displays a warning on PowerPC?
> 

That would be a separate patch, this patch is only concerned with
eliminating the implicit assumption of the host being big-endian. And
there's already been some pushback to adding arch-specific ifdefs (which
I agree with, but as I responded there see as the lesser evil), so
unless there's a very good reason to add that complexity, I'd rather not.

Rasmus
