Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABFCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A99204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="SKP7oCf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfCRJoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:44:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46953 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfCRJoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:44:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so12872131edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 02:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gtJhz+T6yhWz4Q0lswqgloB8spv5P7kk9/nOirIG984=;
        b=SKP7oCf+b68yq935JlZvfVCJs7+A3FntsgYQ3XJ9zwn9mNMk4wLN6F66/PM7D7OwSA
         8pjgRg7vHxdu/9ysWtkNQRT3iwrbiW2f95+K0hUrxOmxW83eTLg33vyZQvOgKtugLmDh
         R3Yf6al9zBQiOqQ6NlZ9Y3c3Vj6A+tntCSqQPpK2eAjAbYFrECway0zffLt+2P5eBneG
         hHgSlfj4djDYIhYOftmJNs8AMNjpj+uHwLVcwFaiLQbDgHMA99SY/vEnt+IwmIwrDQSC
         ZgcmklHb3Vli41SjU5vKBRziZ90x3t85J8g9XNtm4OksbC8Ibw/iqAasDpS3IZ0WXueI
         KzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gtJhz+T6yhWz4Q0lswqgloB8spv5P7kk9/nOirIG984=;
        b=Cd3EfVdOvknKclXCFXLc6OA5roZxjyKU53W4yVY31en9IqV4pJD7MI2hUHc8tqASol
         qco5YZvz961OOzEB0Zf8Ex5QceibvOnk75Wml02IbngLATDnyvqh6yG6YjNs72Y/bpCJ
         detSO5Glab0gVdzpd1eOmCk55pqNBvQzzbay+Hi9CI16B6u+KV8G+3bo2qIMrtIOUS9c
         gF8N5Fd/D2szRKlXD3vojpaTlCTLFPmEfgpco4UH8+Ix2NzUdtfwpWPfTUqCQg5wQv1F
         /vZo+vSHgEzuezwpl7uFq1t3ApWzX6jQiF3xBPlldwSM+sxdx+TKfFPoHxXrbt+KgOeI
         CLKg==
X-Gm-Message-State: APjAAAVpo3H+EEfC7a6TRYXA/jutYl65FVb9ooBH0AtQ0lweOa1WN9zN
        VVTwDyL/bZrgnGvlZiLWN7B8Pg==
X-Google-Smtp-Source: APXvYqydwhMXX4paajtBtGCGNCX2O5Sjddg4lcCJaFVHmOclBZtqL5+Blm1EaTOPitLzNRYI1Z4W9A==
X-Received: by 2002:a17:906:1c98:: with SMTP id g24mr3913100ejh.178.1552902254440;
        Mon, 18 Mar 2019 02:44:14 -0700 (PDT)
Received: from localhost ([94.1.148.67])
        by smtp.gmail.com with ESMTPSA id w9sm746377edw.41.2019.03.18.02.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 02:44:13 -0700 (PDT)
Date:   Mon, 18 Mar 2019 09:44:12 +0000
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, corbet@lwn.net, hpa@zytor.com, bp@alien8.de,
        mingo@redhat.com, tglx@linutronix.de, konrad.wilk@oracle.com,
        mfleming@suse.com, ross.philipson@oracle.com,
        daniel.kiper@oracle.com
Subject: Re: [PATCH] doc: add boot protocol 2.13 description to
 Documentation/x86/boot.txt
Message-ID: <20190318094412.GA18161@codeblueprint.co.uk>
References: <20190308114310.25041-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308114310.25041-1-jgross@suse.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Mar, at 12:43:10PM, Juergen Gross wrote:
> Documentation/x86/boot.txt is missing protocol 2.13 description.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  Documentation/x86/boot.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
> index f4c2a97bfdbd..223e484a1304 100644
> --- a/Documentation/x86/boot.txt
> +++ b/Documentation/x86/boot.txt
> @@ -61,6 +61,10 @@ Protocol 2.12:	(Kernel 3.8) Added the xloadflags field and extension fields
>  		to struct boot_params for loading bzImage and ramdisk
>  		above 4G in 64bit.
>  
> +Protocol 2.13:	(Kernel 3.14) Support 32- and 64-bit flags being set in
> +		xloadflags to support booting a 64-bit kernel from 32-bit
> +		EFI
> +
>  **** MEMORY LAYOUT
>  
>  The traditional memory map for the kernel loader, used for Image or
> -- 
> 2.16.4
 
Not sure if this has already been picked up but...

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
