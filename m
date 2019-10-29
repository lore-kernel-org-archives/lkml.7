Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB72CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0875320679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBddjUwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfJ2RkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:40:20 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38621 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfJ2RkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:40:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id r14so5738054otn.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MioPHoHmZiJDkwtAxq/VI9F9tLNtqLzlol+i1u7r8fA=;
        b=oBddjUwbYuu4Lj3WVOqQL7mkyQMLeydeOVhksSLQRwe9Gir8Z4rWNR8jmLZshyqsmr
         /1yiueyFie5VvPJe/Q4QgS42MgJEgn9ZA8J4Ji2+x7vDNVyhxNfnT8zf6RJWL3YYYvlJ
         fXTuOlFGMXUyRIrC8dRLduwQ8vAstTWyOwJgD2Rnshy+cbZJsv17mEk9jozie5x7OCd/
         fak4Ujm7FgA2hP54yAMo6n4SJeh6V/iHkkAIBhcP1cZYOprBLFv3CxQuaiuNv7pBEtqG
         Gr9j9dasGtqQ3pR3heFnkqmYmkoKPRP8qa+NsIwHanpqw9tM2mih8uIb+JX0J6EoVq1o
         8l6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MioPHoHmZiJDkwtAxq/VI9F9tLNtqLzlol+i1u7r8fA=;
        b=YomGSQtGc9n7sK3qqrVAAyjs039Zn0bfeGKQlNaavlINYVly7dRlqQPR5eRp5lq36L
         hXto0ERKEwhAdAvWn2QjvOeSGYOYqGIv3v5TmB2IYRJG3dPZ7O43m3w4acLkslHGloQf
         oloiEyg2Dla7YFngYWJc//LQMoLeQFAPqCUV2f1qQrGu3pGm9BySu70koPiMJesS9Y0D
         kz8vMtvY9rglqp4DFNMyGN5p0mGbqj6FzaWtcKqlnY91B5OtxdJHU91OrMFen4z5A/01
         Sg9gBumKAqBGYpLzOSB8e4Wx/HmyMdZ0ipPktSb+Me5EWXsjaaCHRnxlHU3ovnURahBF
         jDvg==
X-Gm-Message-State: APjAAAVj9H7NK+Vey1lOkxqO3qhq91jBzcRZrDYfVmRHHFm7nke6G6NS
        8j1axgaXSk6YY5f4213pnvWzxXVyKQDIOlWGX08=
X-Google-Smtp-Source: APXvYqyqXgmonX3RdyxFqzASwZjNWMmFfA4UaGDLY5jPXzt3BII9S4iZpIJfcBI2c62BdFfIFo4EbQJ3tsnlssvGTuE=
X-Received: by 2002:a9d:630c:: with SMTP id q12mr7925015otk.332.1572370819510;
 Tue, 29 Oct 2019 10:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191026235214.GA11702@cristiane-Inspiron-5420>
In-Reply-To: <20191026235214.GA11702@cristiane-Inspiron-5420>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 29 Oct 2019 13:40:08 -0400
Message-ID: <CAGngYiXG1JbFcYLfnKDKYac=Ku+KAkOetPa_MkUCt7xXgJA-XA@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: anybuss: use devm_platform_ioremap_resource
 helper
To:     Cristiane Naves <cristianenavescardoso09@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 7:52 PM Cristiane Naves
<cristianenavescardoso09@gmail.com> wrote:
>
> Use devm_platform_ioremap_resource helper which wraps
> platform_get_resource() and devm_ioremap_resource() together. Issue
> found by coccicheck.
>
> Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
> ---
>  drivers/staging/fieldbus/anybuss/arcx-anybus.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
Tested-by: Sven Van Asbroeck <TheSven73@gmail.com>

Greg has already queued this patch, but the link embedded in
his commit message should point people here.
