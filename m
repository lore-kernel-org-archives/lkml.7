Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11EBC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84D0205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmj8AnZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfGIKMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 06:12:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35734 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfGIKMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 06:12:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so9837699plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 03:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RhoR5GKsIFoTSiglLtCPA0A3UUuVIpZh8wOmabYfUC8=;
        b=dmj8AnZuLaqSXh4uEkr1ENxbRurhbd7SgTiXb64qUqSn7UBNckooPSHNDizjJ54xma
         OJj/cKzNijTV2vlddX6zUQx1oNkKNvHF//HUww44WvA9nkkqxHg4eUr8QvJy/hOxagUu
         Xq6ZzJMn/GiN+X6TVEDHEDhDZNOcDlvFrYA/0iKtxk503kHJ96KyC5f/FHt0aEjCLFeZ
         +L1yOkxI7cS/nNa92OZu5SlhapqaoN8eEKWMXk9pBJBw3UE2JmkISmPgfCqh1mxXH/rT
         Kv7aQaqrqW6A96YYQdXRsaF5/S+7ECYessQ/8MRGcVrPPzeIDxLt8hBJdFovOV2J42ct
         HSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RhoR5GKsIFoTSiglLtCPA0A3UUuVIpZh8wOmabYfUC8=;
        b=DKqxcCVj2uI7kYb6EKt3rPsQXEJ7Xu+Xw6Q8+IYabsDAuPAzZKU3O23y1ufnMFuSxL
         wIjFWkQ3aAzcWVmh4vHZuEVuFS4OrExWHw2SFTofZEcuHRctBooHLLiH2qIQ2XjPDy9n
         zK0ExG1CFZYLF47bZ38QMJOQqtNBt66Aue+tOEuWzHHlXsn3hRNJ6TAjBJOwQR/EW5YJ
         JCSZMnYjEZQ7fc3OIZEqviE73zJHti1D449oZDbJFFWMvd+Jdpx8L71FsP0YYyRlAs6q
         EQ7w0/2e40qaRYxsHFmDtWkt/2lOie06OoMw94Dx3/eS1NxZpuOTMzjYaY/cS6T9UUzc
         g45Q==
X-Gm-Message-State: APjAAAVbgI2g1N4fj+/b2MecYkBMs/uoRPR0SgCeGxhm+oOc+qu/dcNG
        B9gDHREczX7dEBOPniONlgJh/TSe
X-Google-Smtp-Source: APXvYqxrlyide7O9/j67bE6YvuyRXra94KwadyVuZPptMBTR/P/TVevLXGFaTWQRfhzagFenfCErig==
X-Received: by 2002:a17:902:20ec:: with SMTP id v41mr29202567plg.142.1562667155186;
        Tue, 09 Jul 2019 03:12:35 -0700 (PDT)
Received: from localhost ([175.223.48.34])
        by smtp.gmail.com with ESMTPSA id 33sm18563562pgy.22.2019.07.09.03.12.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 03:12:34 -0700 (PDT)
Date:   Tue, 9 Jul 2019 19:12:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH] printk: Do not lose last line in kmsg dump
Message-ID: <20190709101230.GA16909@jagdpanzerIV>
References: <20190709081042.31551-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709081042.31551-1-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/09/19 10:10), Vincent Whitchurch wrote:
> A dump of a 64-byte buffer filled by kmsg_dump_get_buffer(), before this
> patch:
> 
>  00000000: 3c 30 3e 5b 20 20 20 20 36 2e 35 32 32 31 39 37  <0>[    6.522197
>  00000010: 5d 20 41 41 41 41 41 41 41 41 41 41 41 41 41 0a  ] AAAAAAAAAAAAA.
>  00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 
> After this patch:
> 
>  00000000: 3c 30 3e 5b 20 20 20 20 36 2e 34 32 37 35 30 32  <0>[    6.427502
>  00000010: 5d 20 41 41 41 41 41 41 41 41 41 41 41 41 41 0a  ] AAAAAAAAAAAAA.
>  00000020: 3c 30 3e 5b 20 20 20 20 36 2e 34 32 37 37 36 39  <0>[    6.427769
>  00000030: 5d 20 42 42 42 42 42 42 42 42 31 32 33 34 35 0a  ] BBBBBBBB12345.

[..]

> @@ -1318,7 +1318,7 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog,
>  		}
>  
>  		if (buf) {
> -			if (prefix_len + text_len + 1 >= size - len)
> +			if (prefix_len + text_len + 1 > size - len)
>  				break;

So with this patch the last byte of the buffer is 0xA. It's a bit
uncomfortable that `len', which we return from msg_print_text(),
now points one byte beyond the buffer:

	buf[len++] = '\n';
	return len;

This is not very common. Not sure what usually happens to kmsg_dump
buffers, but anyone who'd do a rather innocent

	kmsg_dump(buf, &len);
	buf[len] = 0x00;

will write to something which is not a kmsg buffer (in some cases).

	-ss
