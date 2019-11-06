Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE27C5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728C120869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573066366;
	bh=fjKtNnyNz+S6JoMlVQcHXx7cLqb0ybRjImKny3mhM6Y=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=FOWx3XuHSXSE+LeJFHK02/RE6zr8YdYpoX5brTRoVQWFnII6d8H8VHZHGidRFJmK0
	 N16185e3ai1uAO72pVpUSYJZBB7fpHE3mlp8agsdYXdx9/OpL4tLIKAs4+x3CGQz0g
	 txq3AoPr6sW0T28ODp4LstxtZExTgfEtHPg4veDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfKFSwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:52:45 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37798 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfKFSwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:52:45 -0500
Received: by mail-io1-f68.google.com with SMTP id 1so28140015iou.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 10:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/ZzLR2F6tfjOhdzyMma7tGcYKCX8XKZyirBptOmBxKs=;
        b=GA1ySZuvdUORrM1Qq8tw6QmDRnjqEHfhR/MoQ94qfNvEfKgoSJCgMWeTYHca5LQxCg
         5Bntq3f4KZ2Iwq3L75238zCqZjZM9EDpXCJSmvSkSdpG0hZD1DOzVaczwRwVDYV9jxlU
         46PJZhKEV20NdekLqEhWcVIbahBVAbmRwH2+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ZzLR2F6tfjOhdzyMma7tGcYKCX8XKZyirBptOmBxKs=;
        b=GLZCMOrTcViHGJI1WeZvQB2o5sSBZyn0bpCeaeCcXnUJIP7UJa8oWWIcppSXRCOX2r
         aqyHIwa1u+cQYrxgHB2s6uKwqwV0hboSGfw/GX2NFqQI5znXx0jrHnP6gMv5n8F6GH/1
         cLCqARHSdWoPdH5zMgYhVIq37UtimiY9GpKVzoJAv0DaU4pn087V9McMZxpoTL9G2WdD
         BRLPcb5yzjaey6YYyatRP9yzepw7MONgwng227abrEQOALBrAFeTt7jfJ6nCkLIlS4ef
         xUYWeSyNY8MiUcjzIcwdphhhya01/1HHVjTjx8SzMihWING8Je8gBDSZbEjZfK6pP16R
         oK6w==
X-Gm-Message-State: APjAAAW98YVLsIia0evQ/lGsjn7YZjqonYXpRZrvlwC4O0wzvCaj9m1v
        pgSgw7FnXJ35yOZBc1Dayd/Qag==
X-Google-Smtp-Source: APXvYqy30aHLB5dpLSN1yJ4la5hl9Fe1NLhLQ35UtpfuJel5YqdqGeLM4v5Xep72MPPY0QG18Oo8Yw==
X-Received: by 2002:a6b:39d5:: with SMTP id g204mr34340025ioa.279.1573066364331;
        Wed, 06 Nov 2019 10:52:44 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h14sm348153ilc.87.2019.11.06.10.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 10:52:43 -0800 (PST)
Subject: Re: [PATCH] media: dvb_dummy_fe: place EXPORT_SYMBOL below
 corresponding function
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, mchehab@kernel.org,
        rfontana@redhat.com, gregkh@linuxfoundation.org,
        allison@lohutok.net, kstewart@linuxfoundation.org,
        tglx@linutronix.de
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20191106183716.29170-1-dwlsalmeida@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <543fdbda-22ca-617a-952c-3707e0b288b4@linuxfoundation.org>
Date:   Wed, 6 Nov 2019 11:52:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106183716.29170-1-dwlsalmeida@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/19 11:37 AM, Daniel W. S. Almeida wrote:
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 

You are missing the commit message. :)

> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---
>   drivers/media/dvb-frontends/dvb_dummy_fe.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/dvb_dummy_fe.c b/drivers/media/dvb-frontends/dvb_dummy_fe.c
> index 4db679cb70ad..909dac2345c4 100644
> --- a/drivers/media/dvb-frontends/dvb_dummy_fe.c
> +++ b/drivers/media/dvb-frontends/dvb_dummy_fe.c
> @@ -121,6 +121,7 @@ struct dvb_frontend* dvb_dummy_fe_ofdm_attach(void)
>   	state->frontend.demodulator_priv = state;
>   	return &state->frontend;
>   }
> +EXPORT_SYMBOL(dvb_dummy_fe_ofdm_attach);
>   
>   static const struct dvb_frontend_ops dvb_dummy_fe_qpsk_ops;
>   
> @@ -138,6 +139,7 @@ struct dvb_frontend *dvb_dummy_fe_qpsk_attach(void)
>   	state->frontend.demodulator_priv = state;
>   	return &state->frontend;
>   }
> +EXPORT_SYMBOL(dvb_dummy_fe_qpsk_attach);
>   
>   static const struct dvb_frontend_ops dvb_dummy_fe_qam_ops;
>   
> @@ -155,6 +157,7 @@ struct dvb_frontend *dvb_dummy_fe_qam_attach(void)
>   	state->frontend.demodulator_priv = state;
>   	return &state->frontend;
>   }
> +EXPORT_SYMBOL(dvb_dummy_fe_qam_attach);
>   
>   static const struct dvb_frontend_ops dvb_dummy_fe_ofdm_ops = {
>   	.delsys = { SYS_DVBT },
> @@ -253,7 +256,3 @@ static const struct dvb_frontend_ops dvb_dummy_fe_qpsk_ops = {
>   MODULE_DESCRIPTION("DVB DUMMY Frontend");
>   MODULE_AUTHOR("Emard");
>   MODULE_LICENSE("GPL");
> -
> -EXPORT_SYMBOL(dvb_dummy_fe_ofdm_attach);
> -EXPORT_SYMBOL(dvb_dummy_fe_qam_attach);
> -EXPORT_SYMBOL(dvb_dummy_fe_qpsk_attach);
> 

