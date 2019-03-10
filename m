Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8229BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 20:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47ABA20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 20:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uqwG6wLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfCJU1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 16:27:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40634 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfCJU1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 16:27:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id w6so2228508ljd.7;
        Sun, 10 Mar 2019 13:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0EmxybyCAnqQi7gWm2elX578Yzdd5MZ8eTuLF0rGB5k=;
        b=uqwG6wLLsqw/AzvDnu8MhjGWmHFjAebHTvpoJYssG2cf56Dfe/e7O+UCwsBmHigrfE
         NZoVMh9dx97+K/s9M01GwlYAnzAbfUHURP3fQAvaka5yPi3Db7+jiY44iJJrlxgS3usm
         4jm9+VYdydxyFjLKxHs0RpfeftY7klvjw4fs5oq86bigGCvOKBUMNizK8yq4rBMVK0Ex
         YgI0vmVvm8aJ4E35qbyJwHJDZR08FX7azISC0PqxMUn9enc5NZ9e+jkaO9bJnwNYo1ms
         aScS0aVKR4AAoMz4+PN3s+xm+q5Wl5fH1DO851s4T4UlMLStmrj5GbCPe3mcmsEG+iGg
         H0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0EmxybyCAnqQi7gWm2elX578Yzdd5MZ8eTuLF0rGB5k=;
        b=eLoPpz5gD6wsgXtUFCJWAGkISdgEb1NRu5pCnd+S0YGYjNFRPoj9ZTvQTePoLtCIt8
         5QEqr12PxDhkGLts3P8QlehnbP9Y1pzjP1BXJOTNEDYvn9SNlozmYntWsrIDKpOaG2ql
         mOZWCOKSghqj+DvVF66uRoCCzoltwvi3djMeZKy79Z4tCXKR1p6VTsL6bROJbxoQjfDV
         npxmVIA/Bcr2J6/Pr7a33X8W1TJybmqjtqR9eHoEqqy5VeIXHK04gXWJhdfiVL1QbUqg
         HJBN/LaEsRhDUnOPOu1prUK8aDvfHE56hoWUnWOpRB270COfQiFtgW/ideLgXm5nR4Pj
         tYFQ==
X-Gm-Message-State: APjAAAWneGKS9QCpBCXHa3tqgpYb9sioe/Iyh27MwRVygNalL46SFN/d
        o7HT1dSPr4CkNbU9IVJJvO2Ezek6
X-Google-Smtp-Source: APXvYqx0DzHjN8kTGsqp4IjK0OkW3BQPwz5GzS17c7lbd1V3sifyUZCt7/7b9H5DnngXu72ipztx3w==
X-Received: by 2002:a2e:3c10:: with SMTP id j16mr12953131lja.113.1552249668458;
        Sun, 10 Mar 2019 13:27:48 -0700 (PDT)
Received: from [192.168.1.18] (cka136.neoplus.adsl.tpnet.pl. [83.31.76.136])
        by smtp.gmail.com with ESMTPSA id u3sm670268lje.61.2019.03.10.13.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 13:27:47 -0700 (PDT)
Subject: Re: [PATCH] leds: fix a potential NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Riku Voipio <riku.voipio@iki.fi>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190309060411.29074-1-kjlu@umn.edu>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <8c616b91-8f0d-f53b-af10-4d768063c5a0@gmail.com>
Date:   Sun, 10 Mar 2019 21:27:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190309060411.29074-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kangjie,

Thank you for the patch.

On 3/9/19 7:04 AM, Kangjie Lu wrote:
> In case of_match_device cannot find a match, the fixes returns
> -EINVAL to avoid NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   drivers/leds/leds-pca9532.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
> index 7fea18b0c15d..4b0335591728 100644
> --- a/drivers/leds/leds-pca9532.c
> +++ b/drivers/leds/leds-pca9532.c
> @@ -513,6 +513,7 @@ static int pca9532_probe(struct i2c_client *client,
>   	const struct i2c_device_id *id)
>   {
>   	int devid;
> +	const struct of_device_id *of_id;
>   	struct pca9532_data *data = i2c_get_clientdata(client);
>   	struct pca9532_platform_data *pca9532_pdata =
>   			dev_get_platdata(&client->dev);
> @@ -528,8 +529,11 @@ static int pca9532_probe(struct i2c_client *client,
>   			dev_err(&client->dev, "no platform data\n");
>   			return -EINVAL;
>   		}
> -		devid = (int)(uintptr_t)of_match_device(
> -			of_pca9532_leds_match, &client->dev)->data;
> +		of_id = of_match_device(of_pca9532_leds_match,
> +				&client->dev);
> +		if (unlikely(!of_id))
> +			return -EINVAL;
> +		devid = (int)of_id->data;
>   	} else {
>   		devid = id->driver_data;
>   	}


Applied to the for-5.2 branch of linux-leds.git.

-- 
Best regards,
Jacek Anaszewski
