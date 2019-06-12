Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444BDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B0C20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="VUFgYUy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388390AbfFLT7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:59:18 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40560 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387605AbfFLT7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:59:17 -0400
Received: by mail-vk1-f195.google.com with SMTP id s16so3570684vke.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Ybob6G4/RgxkIUDWvbYn3Dj2Z5pOioBKuJ32kUZtOb4=;
        b=VUFgYUy/L2lnjtYNdM6Qtqgd/edTRKpJPk3wvG+vRsDfwQblECyair288QVyMWN6Xx
         2KCbIUt80VMbCkDhwsem9Z7I9ThHvXOb6KwzE+b2Bf2WiZr2ZAoYxkpz8zlbB9pEZDiy
         QdF8tDPqWu0zQiHNUX7yWE2wL0OJt6jrZQ3X7MJbrI1+obKoB9hgX2cAycK9l2jG/E93
         /0YXsl6PD/jGQ4zqqx/uhocrfyYaHR0RbnZj5xAwLV/isuQi6sLZ6lnjBPO1koSNo79U
         YR3VHsiMtrCBF0iBW6mt2YyKndEjR8C3GNxLJ/eYnsWXCCRbGLquLt6Z0LiYMoUckT66
         fZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Ybob6G4/RgxkIUDWvbYn3Dj2Z5pOioBKuJ32kUZtOb4=;
        b=cPOIyf7jQMj4JEYSAjwrE1goy//y43yXBn0Rm+XSEGxrw9nnnbEhcv1zJfzMkxIfGi
         0eIQtg9sxKGjHaK1IfgHeXNWMSSH+5c7cWegbO1ZhXTIsgIZ9E7SRXAuIOYvIcblm9iM
         PwqXpM0Wsz3W3xqsjvNjLKGTWlQeMO54HQTtaoWjPurk3rzYGWXkEFlkf4h1R9aL4ovV
         Da8LHqvWo3sYh/1VzCT/szW64oJntm0NY+mM1VNNgE23ZxEetYtDHWGNzKp7ORDC/B8+
         QsEMhnbPWnBzfQ9jwgTPcnMVerL+F5UDfSC6sPuGBzLttsKRsy7wFXysCZNJsxfeTOKN
         Ph4g==
X-Gm-Message-State: APjAAAUB6d/l8KVoXw6lsJ6cBJqxTjicGffVK3RYkWs7THj1t+v5hEwr
        DEPlNS2YmStxa+nC4xLezotSvg==
X-Google-Smtp-Source: APXvYqzf7zquRH5DAjzGb65HiAYfn8puj5zPaUOZhtehgtgFrm66azwNRJtGNYQxusE1XqozQ7PZMg==
X-Received: by 2002:a1f:6347:: with SMTP id x68mr19508435vkb.64.1560369556242;
        Wed, 12 Jun 2019 12:59:16 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id g41sm461937uah.12.2019.06.12.12.59.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:59:16 -0700 (PDT)
Date:   Wed, 12 Jun 2019 12:59:11 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     peterz@infradead.org, netdev@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH] locking/static_key: always define
 static_branch_deferred_inc
Message-ID: <20190612125911.509d79f2@cakuba.netronome.com>
In-Reply-To: <20190612194409.197461-1-willemdebruijn.kernel@gmail.com>
References: <20190612194409.197461-1-willemdebruijn.kernel@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 15:44:09 -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> This interface is currently only defined if CONFIG_JUMP_LABEL. Make it
> available also when jump labels are disabled.
> 
> Fixes: ad282a8117d50 ("locking/static_key: Add support for deferred static branches")
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> 
> The original patch went into 5.2-rc1, but this interface is not yet
> used, so this could target either 5.2 or 5.3.

Can we drop the Fixes tag?  It's an ugly omission but not a bug fix.

Are you planning to switch clean_acked_data_enable() to the helper once
merged?

Thanks!

> diff --git a/include/linux/jump_label_ratelimit.h b/include/linux/jump_label_ratelimit.h
> index 42710d5949ba..8c3ee291b2d8 100644
> --- a/include/linux/jump_label_ratelimit.h
> +++ b/include/linux/jump_label_ratelimit.h
> @@ -60,8 +60,6 @@ extern void jump_label_update_timeout(struct work_struct *work);
>  						   0),			\
>  	}
>  
> -#define static_branch_deferred_inc(x)	static_branch_inc(&(x)->key)
> -
>  #else	/* !CONFIG_JUMP_LABEL */
>  struct static_key_deferred {
>  	struct static_key  key;
> @@ -95,4 +93,7 @@ jump_label_rate_limit(struct static_key_deferred *key,
>  	STATIC_KEY_CHECK_USE(key);
>  }
>  #endif	/* CONFIG_JUMP_LABEL */
> +
> +#define static_branch_deferred_inc(x)	static_branch_inc(&(x)->key)
> +
>  #endif	/* _LINUX_JUMP_LABEL_RATELIMIT_H */

