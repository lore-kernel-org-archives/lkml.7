Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30352FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037D221882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573230344;
	bh=67/UMm0rGLq0V5nl2UPkIOb+qrI1KdNLoWkd4u1AUqc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ohpiJPZcsloywIYs73dfnOQYP4ZKpaGi/7kdKVGNbJ0y2xpamD1MdZ64yKXSoW/tg
	 Hc+lKglh9FICRn6D122Y+Qjpp3703BciA5mpPSSs6jaMK0QR5WOAdPWgxRstfMqgSt
	 H1UVUB6Dz7RepIqvrgnSnpnp5OoQlHhE5TASfjdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKHQZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:25:42 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:39051 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfKHQZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:25:42 -0500
Received: by mail-il1-f195.google.com with SMTP id a7so5212015ild.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 08:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dwQjkTfEo5yMh2KjfAIAPwSKju01x/vYIT2La5SAaIA=;
        b=eMX3g/EjzOypweNcA48oOtiPYva4EQWEgJJuKt9JhEv3IDAUNpMuL7rPN/vglJopKJ
         rSwogNBf7Cvq0A8VwOMXAIRMkKs9WT5jchAsF+OmEvi8cYAbbhiapdN8r5Y4TwBBewjt
         knlJkJm8WdYhHhloNM7t7CSqnRuCLO9nLdNcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dwQjkTfEo5yMh2KjfAIAPwSKju01x/vYIT2La5SAaIA=;
        b=CKSoKHSQGDyWhoc73QUL5S2r69zQZIN0cCWgUAV/Xyd4kHg50O0uEW44GOHT4xat6R
         +04IhONQmrkDNmrdVsZ0V7m8XXduAeQBTfBQV3WGp5C/TGi+cmHqzMAXY8Wa86PPgU+q
         orbgqWiTDg5aqBKYhm+F2+fWxuyzTi/s2VmIlCIHEVIiFwPoHWhouVwraTxbS1Qb+kwz
         7XRGa0tscI3L78N1UZp5yYG/DhHLnE5MWyCI7Ot70WGAqp1ukFeN1wFR3P25v/qRBvLe
         XBQOqRJNBgXV0POhBiNzfmqGRu6mrzsHC0bmfDegaQMeJJi10+IvVM7WtvXftJ6j07y2
         gwig==
X-Gm-Message-State: APjAAAWjI/jSh/d9vA/idsye069TEgCxFvU0vbg12mEWCUyTFgdrSP49
        3WHVnt01ialEZAV7eBUcoQAmyg==
X-Google-Smtp-Source: APXvYqy+5R4GLsuIev8Yy2Nzugz/LzGn+LI63xwyEloVOR+4yKTkT4TiqNzpEzFkzLyWPzhbYKOiwg==
X-Received: by 2002:a92:bf08:: with SMTP id z8mr12550558ilh.11.1573230341536;
        Fri, 08 Nov 2019 08:25:41 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d1sm522953iod.16.2019.11.08.08.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 08:25:40 -0800 (PST)
Subject: Re: [PATCH] media: dvb_dummy_fe: Fix ERROR: POINTER_LOCATION
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, mchehab@kernel.org,
        gregkh@linuxfoundation.org, rfontana@redhat.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20191108035835.7607-1-dwlsalmeida@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d0f23eea-c5e9-8055-49be-73bd0c9ffa11@linuxfoundation.org>
Date:   Fri, 8 Nov 2019 09:25:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108035835.7607-1-dwlsalmeida@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/19 8:58 PM, Daniel W. S. Almeida wrote:
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Change foo* bar to foo *bar to avoid ERROR: POINTER_LOCATION in checkpatch.pl

Can you include the error message from checkpatch.pl in the commit log
and send v2.

Changes look good to me. I assume checkpatch error disappeared with this
patch.

> 
> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---

thanks,
-- Shuah

