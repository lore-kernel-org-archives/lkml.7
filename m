Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD971C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E952068D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8z2hgFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfKURhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:37:19 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:47085 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfKURhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:37:19 -0500
Received: by mail-yb1-f195.google.com with SMTP id v15so1645592ybp.13;
        Thu, 21 Nov 2019 09:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4wBTKsuxv62YbRh7Tq2qblzfbjN9lJSjzh/rAD49oZk=;
        b=j8z2hgFH1kcv2oYgVNGxEwQNTUADtFjiBTeRlA0MAv+YUgVPv7IIaXUg1TogA8WFiD
         VfdHU9G9QhNs14/ErLqFbqEbZdsrT9kzmA/LsGXLA7FyQfIXNcqraPECj/ERrgEFqbr4
         OCChd+Ti1C0VsnlIk286Fht2Q2Yw7KeNMhVh3JFqbOYYPRPQcI4Q8trmNqcm8dDPsmzb
         cJJghEEcZm1CqJB9g5daQcqV0sv5cyhFpAh57WV0pfQSuEY+FejgRtVT7fU+Im2PJ4sW
         VUPfUMJ4lHzMHsC1QE1ZPt9ztlqZGCAIN6mBW8lZb5dL23Wl1HTf7BSSsYqfQlvDZy1k
         WorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4wBTKsuxv62YbRh7Tq2qblzfbjN9lJSjzh/rAD49oZk=;
        b=AY7M4VJvk5ApHb188uQkJBQWURlRLMDQWLLjPiXzWHqUbgbvXYtQIomCWuAla4fRGx
         S97ZgvN2WJGitq9cmxrJ8Vg5aArKxvzQOyy5rHXOUpmO2hQbwpmJKJCD4SwpTDtCOWJ0
         7tLvPpSqkQAugnxJimOR/ChIfHaU+LOVOW1ROg4hoRDOSTKBTqIqx/khGXjP6jZ5cN+i
         rxioSYZKxwAPlvR98kVeAn4d2nHSkSEtiXAwMwszpY+3ndqATPICttP4Z6HmqHV0zHxe
         sfOF++M6jhpG1UESy9HblZArF3mFXZw3ap0nSE1e/+pGx2LbfXL0gf5OyjthvHOGiAeR
         wXJg==
X-Gm-Message-State: APjAAAVUGxqqytMF/Z9wRxtB1cD7pxPOJurYwOABqJf34D9jD/1303vp
        hIPgqn0hRBzZ9OGslN+YITg=
X-Google-Smtp-Source: APXvYqy38DeCfwF9DCOcYXPadggMRknvbkN/JuNv+0s2uLQt0dgHSnCHYoYkII5E4uRdFJNY2dCR8Q==
X-Received: by 2002:a05:6902:4e7:: with SMTP id w7mr7040679ybs.409.1574357836660;
        Thu, 21 Nov 2019 09:37:16 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id b199sm1088226ywh.23.2019.11.21.09.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 09:37:16 -0800 (PST)
Subject: Re: [PATCH 2/2] of: overlay: fix target_path memory leak
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        pantelis.antoniou@konsulko.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>
References: <20191118132809.30127-1-vincent.whitchurch@axis.com>
 <20191118132809.30127-2-vincent.whitchurch@axis.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <b916ab0e-bb60-1476-b321-e931645df688@gmail.com>
Date:   Thu, 21 Nov 2019 11:37:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118132809.30127-2-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 11/18/19 7:28 AM, Vincent Whitchurch wrote:
> target_path is used as a temporary buffer in dup_and_fixup_symbol_prop()
> and should be freed even in the success path.
> 
> This was detected by kmemleak.
> 
>  unreferenced object 0x8598f6c0 (size 64):
>    backtrace:
>      __kmalloc_track_caller+0x17d/0x228
>      kvasprintf+0x2b/0x64
>      kasprintf+0x15/0x20
>      add_changeset_property+0x225/0x364
>      of_overlay_fdt_apply+0x42d/0x6b4
>      ...
> 
> Fixes: e0a58f3e08d4b7fa ("of: overlay: remove a dependency on device node full_name")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/of/overlay.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 5f8869e2a8b3..59455322a130 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -261,6 +261,8 @@ static struct property *dup_and_fixup_symbol_prop(
>  
>  	of_property_set_flag(new_prop, OF_DYNAMIC);
>  
> +	kfree(target_path);
> +
>  	return new_prop;
>  
>  err_free_new_prop:
> 

Reviewed-by: Frank Rowand <frowand.list@gmail.com>

I would suggest changing the subject to:

   of: overlay: dup_and_fixup_symbol_prop() memory leak

but I am also fine with you not changing the subject.

-Frank
