Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFBDC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F83214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ZVYIEgli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfDWMTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:19:23 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37986 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWMTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:19:21 -0400
Received: by mail-it1-f193.google.com with SMTP id q19so5223956itk.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 05:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hUSKaGSt9h5qNfk8EIDBY5Yvw16Lev5OZyj1+/PPe8=;
        b=ZVYIEgliXKpKE8kTzMq7j2mY4XgZ2rFmos7Ra5Cd/nPJouoN6f/jEZor1XWfExzwrJ
         c2ny2NypUxOh+XsmlB2leiEjcd00wdf4z7N7DzI0ssSNAbJkCypROK1AJv5ejtut9ldu
         sM4Q0WNbQwHtZ1DRO69KEFdm2b2zUzR2Q24AJOhdNm86DuZIknjlW9/qhGBoejmSapB7
         plXDETgak36roJzcefR+Tcpa6cfRzD6gXWrSME2ZinoyVrQiyTiRFhg+27SRHGtZByRv
         vCNJfi25F0CjW5/mGLjIqMb83f5kMUmMruo/aLjf8a7584T4TXnW8JkaZyXggF45xV/M
         tdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hUSKaGSt9h5qNfk8EIDBY5Yvw16Lev5OZyj1+/PPe8=;
        b=GgK0Sw5eA1gy8W0SvjAZIY2oIKCGHn+GsgP+BjmNZrDCnLcZlqglabwjiKWaweChmm
         4glyPtTYljG1/7JKf8496sYwa+TgjuEVGe9BwWAaYmzZo6cj5u/S3sbbZ/OC4InHymKc
         nrd6XHz8pM9CDLkOppp3EvDlYLM3IeLcH0ETBZASVkEtBM/IE6ms6xYK3sNe3MQpmxaz
         9BNqrD/5wyIHPxha6sNrlb4PXYzNuOlZBClBmUHG1dT9JC3J2LmoDSbOXBkO3zSA3Hmh
         n59JpqbP+utLmXvhlM6jyuqAc99Cy/U5MKo8Ml94x3nZV1tp5JuJwO/YaloCpDWwGq6h
         JMGw==
X-Gm-Message-State: APjAAAXQcmgi09bdXvET8bHsdKFMB87bvjjca0zKWZZ+gGzJ86tL3+3N
        z7gvC28D+jucDI+0X5XMUWS5v6qPQGAUsf4nnj0wzoVb
X-Google-Smtp-Source: APXvYqzX64dHMqlyacNPZ/MFk2IoNXhgQwgmcQmawb6FAREL5PVHcgX2sCrtruCFuTujBwjjF6VD33xpkjcQcmC6TQE=
X-Received: by 2002:a02:ba0e:: with SMTP id z14mr14462342jan.87.1556021960857;
 Tue, 23 Apr 2019 05:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190423072634.57cdf8b0@canb.auug.org.au>
In-Reply-To: <20190423072634.57cdf8b0@canb.auug.org.au>
From:   John Hurley <john.hurley@netronome.com>
Date:   Tue, 23 Apr 2019 13:19:10 +0100
Message-ID: <CAK+XE=k_qv4DDku8HBKRuqWKsze5z0W_pZuqa+jRaJKXZq8SOQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 10:26 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   7d26c96052cd ("nfp: flower: fix size_t compile warning")
>
> Fixes tag
>
>   Fixes: a6156a6ab0f9 ("nfp: flower: handle merge hint messages")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Did you mean
>
> Fixes: dbc2d68edc98 ("nfp: flower: handle merge hint messages")
>

Hi Stephen,
Yes, the fixes SHA1 tag you have is correct.
I have no idea how the incorrect one went in!
Thanks,
John

> --
> Cheers,
> Stephen Rothwell
