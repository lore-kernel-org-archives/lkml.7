Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96451C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A58E2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UirvTOjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfF1Hnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:43:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40424 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfF1Hnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:43:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so5176659wre.7;
        Fri, 28 Jun 2019 00:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HXfG5Nnu4DCUe0/zJ0AVWy2789Wi/T9UvlwPaiFOk5E=;
        b=UirvTOjZqnExNLkv8S4B1E8Eg5xFoMapg2iqaXTgb2nyjGYhQ0h4zkpfS4W+8kzjoH
         EwGbwrpJE3cotezoXtKkfiBA2jxRmjEpa6tLFhCrcReBJIUmJpcOsbvzY1Xwy5I9g2d8
         y4liYrWvah3fcDtyfmh3fWZlE6FQvJPOJf7RXXkQceL6OAodsDbF5vss0xKo2twOjhfQ
         cnCPuGoMV/amQ9k3c6P6T8UHZR7DUFmlfuwUuPQKPdXsjeaQ24YKgMO84XGwiInhRgYA
         ruLTUX2aY1TYvezXgQVwVOG4KCCOohzfeF6wBseen5cWylAwpgVZSVVsRF42H2CVsETs
         7a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HXfG5Nnu4DCUe0/zJ0AVWy2789Wi/T9UvlwPaiFOk5E=;
        b=gn4CvYayz/TOBjTineL+TNBy0hv1F71rjwAJkS7gl0f604F6vBXKYi9tNSSR4PUQWT
         QfX7SW762gpuffld+O/HWM/teJDmvqs6dDMZgwhFAMgeSChb8JvcYbJjtwnDWnBxAF5J
         fWz5bVOfW/J2JfECIDjMRQmNb+wQg+X2vYeMUfRL6V8nyhoJn7yOFfXlwoBMTPqtWU2H
         ceE71NA8w48JNPgmvggdmH0TumGR1pVfb1NyusG4nYqoCPEbmrdgKAMSwZfONLN5wd8k
         RvUcf4ANKP9IOpRhovc/nAvaeyMcYprz6f9Lo/XMZ5IWp+RWNjlUGIcQNoVRx37f17hd
         KH2w==
X-Gm-Message-State: APjAAAVP8UXVjqP93zhESxK3gIUZbhxxi2xBZXRBlxzSx8MJoEvdmMhX
        tYe8iQk4xymmtgGX7lQUKXc=
X-Google-Smtp-Source: APXvYqxHEEIfmm7OPcifOsFPNBvXtC1vhzuAx0WHo37sOnOgHXz5WHwXM7OBqM2FIzcKCVgsBVZ0DQ==
X-Received: by 2002:adf:f951:: with SMTP id q17mr6481855wrr.173.1561707830123;
        Fri, 28 Jun 2019 00:43:50 -0700 (PDT)
Received: from localhost ([197.210.35.74])
        by smtp.gmail.com with ESMTPSA id x16sm1925251wmj.4.2019.06.28.00.43.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 00:43:49 -0700 (PDT)
Date:   Fri, 28 Jun 2019 08:43:44 +0100
From:   Sheriff Esseson <sheriffesseson@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
Subject: Re: [linux-kernel-mentees] [PATCH v2] Doc : doc-guide : Fix a typo
Message-ID: <20190628074129.GA31006@localhost>
References: <20190628060648.25151-1-sheriffesseson@gmail.com>
 <20190628063342.27613-1-sheriffesseson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628063342.27613-1-sheriffesseson@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 07:33:42AM +0100, Sheriff Esseson wrote:
> fix the disjunction by replacing "of" with "or".
> 
> Signed-off-by: Sheriff Esseson <sheriffesseson@gmail.com>
> ---
> 
> changes in v2:
> - cc-ed Corbet.
> 
>  Documentation/doc-guide/kernel-doc.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
> index f96059767..192c36af3 100644
> --- a/Documentation/doc-guide/kernel-doc.rst
> +++ b/Documentation/doc-guide/kernel-doc.rst
> @@ -359,7 +359,7 @@ Domain`_ references.
>    ``monospaced font``.
>  
>    Useful if you need to use special characters that would otherwise have some
> -  meaning either by kernel-doc script of by reStructuredText.
> +  meaning either by kernel-doc script or by reStructuredText.
>  
>    This is particularly useful if you need to use things like ``%ph`` inside
>    a function description.
> -- 
> 2.22.0
> 

make respose inline.
