Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09997C76195
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 14:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F9F217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 14:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyP+Gltk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfGTOL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 10:11:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45392 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbfGTOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 10:11:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so16997400plr.12;
        Sat, 20 Jul 2019 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=11ShUFBUz0HNBtYxl5TBnDhpTQxhxuDz8GhFY3JRxMA=;
        b=oyP+GltkpKNTXSWKR+W0SzdxZV7ciNYCMgSa+kBO7BH9rWSjj6w2pDVpi1SkuxSXUZ
         yeHF9R+7Ty+OMSPbRp808LSO6IArjB0c8ZwdhAbKvmebqmoZmWXzmoAvmaSgesI2U/wq
         xldTTi8gghCMXhUUPWC16k53tacBkLaSWF90N5VcCSs3GFmrsReWdJiCvVlSMD4+7Po/
         qECJa+rYZRw0fmDuarQmt1uz/xopE99yXAF9i+sROkFhL8HZUs8hSOJ+Kjbkr6xu4Awk
         LA76G4cYn1+lsoS2GibMSuZc6IawIJtZ9hEQTJED7JBvsqKO9ur7SFh0jq1qiuvIroJW
         OEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=11ShUFBUz0HNBtYxl5TBnDhpTQxhxuDz8GhFY3JRxMA=;
        b=PQo7sbruQq/sGc87LwYuF+CtBzHacxDpVG2AOT5npqdehKmDmoSlY0Har3XPvUPxoO
         1c4GUwPuqUlXKzrTjcZel7tVkJPDTGNJt0c9cnW2P8hO92LURGWgokLfvt2BsOryMXwu
         UU+1QuJQpGZ2f4a5pIQ+4GPLacUHYt7ZTldwP8s3jFnC5wPky3fGgYuRTxF0DAq8JvYt
         rQvFT1qn93Ca8bcErJYss6y76FOGFbyTeTlNn12m2+C4qA1KKVnEMRmaQ7l0BwYBPAMK
         Zxo8OkBlqp8/SbD2p2Ty1HVQDtIouWa/C89plJdwgNs4DtH+OkftZWwgVQNxnJT4IL4b
         kcfA==
X-Gm-Message-State: APjAAAX8Jt5kkIKQcMIl6vw/zEKi77VeED2ur+iqHwTtuAypAisUTUxl
        ALxXBwrF+UPHMW61fPqZtk1DKQYi
X-Google-Smtp-Source: APXvYqwJ9oaku+wrWFn8jH2YrJTsqd+igBfq69Qm9AZcciSmEBQvc53l7K2ZDxYOgxkGQwzqn5PflQ==
X-Received: by 2002:a17:902:e6:: with SMTP id a93mr63126317pla.175.1563631885295;
        Sat, 20 Jul 2019 07:11:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j6sm19641504pfa.141.2019.07.20.07.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 07:11:24 -0700 (PDT)
Subject: Re: [PATCH 2/2] hwmon: (k8temp) documentation: update URL of
 datasheet
To:     Robert Karszniewicz <avoidr@firemail.cc>,
        Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1563522498.git.avoidr@firemail.cc>
 <7139bc7707c24bd4dd7eb323e2da90105a3de9c1.1563522498.git.avoidr@firemail.cc>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <da0ff0ba-eddd-7ea5-91a0-8edb0099a80c@roeck-us.net>
Date:   Sat, 20 Jul 2019 07:11:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <7139bc7707c24bd4dd7eb323e2da90105a3de9c1.1563522498.git.avoidr@firemail.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/19 6:16 AM, Robert Karszniewicz wrote:
> The old URL is dead.
> 
> Signed-off-by: Robert Karszniewicz <avoidr@firemail.cc>

Applied.

Thanks,
Guenter

> ---
>   Documentation/hwmon/k8temp.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/k8temp.rst b/Documentation/hwmon/k8temp.rst
> index 72da12aa17e5..fe9109521056 100644
> --- a/Documentation/hwmon/k8temp.rst
> +++ b/Documentation/hwmon/k8temp.rst
> @@ -9,7 +9,7 @@ Supported chips:
>   
>       Addresses scanned: PCI space
>   
> -    Datasheet: http://support.amd.com/us/Processor_TechDocs/32559.pdf
> +    Datasheet: http://www.amd.com/system/files/TechDocs/32559.pdf
>   
>   Author: Rudolf Marek
>   
> 

