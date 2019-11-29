Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB7DC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BBA20869
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOujqduo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfK2STE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 13:19:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35501 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726985AbfK2STE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 13:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575051542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FiyrhdgENs34vIhSRSTGRDggmyyimwC96XAb9yeIB6k=;
        b=UOujqduoFl5F6cHcKxnZjs1qcby4eEY4Tt0in3X1YCGHUodQrG5w4h/blIJTOOevuSO6OP
        b0VRJttUgq9awq/cWbkfdCln2xGDVo2riC3QUx+HdvwEi9HCKQpexl5zerfFM9gQnZ9gYi
        vhe5CrIxKNKL6JWE74mPzjpHxl8tzPI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-1ElAC_rqPYePiuniWpSP8w-1; Fri, 29 Nov 2019 13:19:01 -0500
Received: by mail-wr1-f70.google.com with SMTP id y1so16043576wrl.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 10:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FiyrhdgENs34vIhSRSTGRDggmyyimwC96XAb9yeIB6k=;
        b=W+mYRNl4EHIJHS86W/aI5wRX6kbiK+DvGIhYcE8uNTgUOG3ws+3bhB9z5nGBksiohO
         c5gVSfhbt03xFZAIPf8/RN1V2XdILye34c8x+f+JtuoQj9PoyGB9QzDVH73bJ7Q3LA9F
         tv5CbUnVhGGJJx9d9wcnAvsFYs3UYSDtvJVSvh/Z4Bx1VaGQPpHP+C/Ee3fT8oJxfmg2
         wu23X2oKrNM5yGuM8Wlb4za7GWJZ8fqn9fjsX5IEAfDeYYXbIPJOoSeJMETzcjfoAEIo
         LvpNVo40e3ScK9Y0fdzECoAZgi2u9XaoYBhHxf4m/AQglwNV91QHFx3s/1fDazZa+Z0z
         PEcw==
X-Gm-Message-State: APjAAAVaLDKv62i1KJyFgONU8STypAYnW+tlEkfI4+YOXKPRw85yuSQI
        tVNQbUtELKIb9rloyMcUq+T8R7nn7Sl2joCsWAaBeI/jxGbsANFa4nstgxiAKtW4fbNNdckmGab
        47c1lTzGUWHhB0Zkt8pQAhXkb
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr7028874wrn.101.1575051540404;
        Fri, 29 Nov 2019 10:19:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqzBCDg/+xrc9KqzOZsoX1fdWUXz3f/n/RYBgMN+X+O1eMFce6efVhgwcEb8hu7gTdmmmfm3sg==
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr7028844wrn.101.1575051540104;
        Fri, 29 Nov 2019 10:19:00 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:56e1:adff:fed9:caf0? ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
        by smtp.gmail.com with ESMTPSA id m3sm13546140wrs.53.2019.11.29.10.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 10:18:59 -0800 (PST)
Subject: Re: [PATCH] Documentation: kvm: Fix mention to number of ioctls
 classes
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>,
        rkrcmar@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20191129181730.15037-1-wainersm@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <67bb9781-98a5-fcad-b958-04abe42b37fb@redhat.com>
Date:   Fri, 29 Nov 2019 19:18:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129181730.15037-1-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: 1ElAC_rqPYePiuniWpSP8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/19 19:17, Wainer dos Santos Moschetta wrote:
> In api.txt it is said that KVM ioctls belong to three classes
> but in reality it is four. Fixed this, but do not count categories
> anymore to avoid such as outdated information in the future.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  Documentation/virt/kvm/api.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.txt b/Documentation/virt/kvm/api.txt
> index 4833904d32a5..4e3d22429b19 100644
> --- a/Documentation/virt/kvm/api.txt
> +++ b/Documentation/virt/kvm/api.txt
> @@ -5,7 +5,7 @@ The Definitive KVM (Kernel-based Virtual Machine) API Documentation
>  ----------------------
>  
>  The kvm API is a set of ioctls that are issued to control various aspects
> -of a virtual machine.  The ioctls belong to three classes:
> +of a virtual machine.  The ioctls belong to the following classes:
>  
>   - System ioctls: These query and set global attributes which affect the
>     whole kvm subsystem.  In addition a system ioctl is used to create
> 

Queued, thanks.

Paolo

