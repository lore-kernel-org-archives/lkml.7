Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55998C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0252B24679
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="eNI6ibgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfLOTU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 14:20:27 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45880 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfLOTU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 14:20:26 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so2379275pgk.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 11:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TD8eJUgG1fhr01DWCx63pJF7m5T34fG5E5EbI/ICcoE=;
        b=eNI6ibgcFTrrNyxWgMtfTebJC9mSh5Q5F8xaII86wD8vHx73easJ4146o+yjnYIJbM
         ws2Wm0h3cDcDvR8T1BITJqBgIdPYKgD71N5Z03EQaCZJOZTSL40Ag1iWjun9L+3FIrQC
         fLyCzGpRUGC7oFuIUcsWFjggKnxODgBmUrT35/3w3isurbucshyLaooKntvVP4atoc0c
         OWbRW9VaCfpQ+vDkqbsbUhan7QMIQzB9pQSH4fyPfluSd6EmdIMb5lwrXTJ511AXBA9w
         M+RTcV+j4Yz2c4r4sAqzeigj7bd4z+7Xvw+pk5/JwhOBHdmXQDcMxFiWEzJb1ariwe9R
         4G3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TD8eJUgG1fhr01DWCx63pJF7m5T34fG5E5EbI/ICcoE=;
        b=EGnWtvciKQZS4nfKk8wsNsPMRWiaZrtKReBNec8oj96yvOGz8XADOZ9XZsV4EZHpIn
         k90XEmTLSJyyIOAHFSfJxucPcwPtdoaNO6e6FrTs8yzF+luHon4U3eSmy5sgNnlMw+vC
         QFgGbuIr5kAg97don26d4QswnEU2bxcEM0wCFctKw7Udzdn/V2P0FHqh61UtxlmJIidE
         U1BAKoampAUL7pnaoq060Iv5Q3Ka6wmscIPfwl4iYvyVNborAwA4kR7sbC8BHg4+VJ1M
         88YTpZb8yltOLoVtJB1p6RZ2ful9cz9siczvUSXICLxn/rNreuANYC6jBYdV+iUV8120
         IgGA==
X-Gm-Message-State: APjAAAWsbrl3zn5c5VBdRRw0YxSL1yENQTjn+Gburrz7ekx2eEe9IE+A
        CSiKo6usc9uWMVZAwWml6rdvPYKWIDUx6g==
X-Google-Smtp-Source: APXvYqwGMkQyRGWbisciu/rJbahasoESOgS7WFYgZZNlvWfCJRYa6aMtywa8svInvMnFMszi6MH1mg==
X-Received: by 2002:a63:dc41:: with SMTP id f1mr14067497pgj.119.1576437625797;
        Sun, 15 Dec 2019 11:20:25 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id d77sm20483423pfd.126.2019.12.15.11.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 11:20:25 -0800 (PST)
Date:   Sun, 15 Dec 2019 11:20:17 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hdlcdrv: replace assertion with recovery code
Message-ID: <20191215112017.07502383@hermes.lan>
In-Reply-To: <20191215175842.30767-1-pakki001@umn.edu>
References: <20191215175842.30767-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Dec 2019 11:58:41 -0600
Aditya Pakki <pakki001@umn.edu> wrote:

> In hdlcdrv_register, failure to register the driver causes a crash.
> However, by returning the error to the caller in case ops is NULL
> can avoid the crash. The patch fixes this issue.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/net/hamradio/hdlcdrv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/hamradio/hdlcdrv.c b/drivers/net/hamradio/hdlcdrv.c
> index df495b5595f5..38e5d1e54800 100644
> --- a/drivers/net/hamradio/hdlcdrv.c
> +++ b/drivers/net/hamradio/hdlcdrv.c
> @@ -687,7 +687,8 @@ struct net_device *hdlcdrv_register(const struct hdlcdrv_ops *ops,
>  	struct hdlcdrv_state *s;h
>  	int err;
>  
> -	BUG_ON(ops == NULL);
> +	if (!ops)
> +		return ERR_PTR(-EINVAL);
>  
>  	if (privsize < sizeof(struct hdlcdrv_state))
>  		privsize = sizeof(struct hdlcdrv_state);

It is good to remove BUG_ON's but this is not a good way to fix it.
The original code was being over paranoid.  There are only 3 places
this function is called in the current kernel and all pass a valid
pointer.  Better just remove the BUG_ON all together; it is not
worth carrying bug checks for "some day somebody might add broken code".
