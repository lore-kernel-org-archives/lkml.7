Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2AAC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF6F214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IwmGp9KX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfCMMgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:36:14 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35423 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfCMMgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 08:36:14 -0400
Received: by mail-it1-f196.google.com with SMTP id 188so2586141itb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 05:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8M7jpcAWxt1MRSZjQz5VUxSxh/NDSR9u4xI/RScLgBo=;
        b=IwmGp9KXuoK4baC8xTq7eUnQK5GFL6kN5Yig6lfmLORi8CzJLIb/yz9EEFkZqY4bw5
         9D/0SS9bTiPtlcf6BBdH0PZutAzdRoC1hTzvuIRqdFizHG0AKGbfpRhu/84fUtHW0fRu
         vmgjbRaNwT95jVfmE1c2IhQoW2w4H6Eu1ryAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8M7jpcAWxt1MRSZjQz5VUxSxh/NDSR9u4xI/RScLgBo=;
        b=WHzTDtXp2BllDl6LdZgaB3usIbNeasdNOyHLzK72RAJWrOcz3usT6qU3KmkLhq+8mj
         kJKPCItcyGwu7x++zRA/XsEWrIV3csW7ON7U/gP22PqhQ3qhWwy/oan+Jp0UaXZzVIyA
         yAOiLKUHm3LPu1lJhXwcngm16lrNDMf3ixKGDQGitfQNx1gwF1wW8BCjms8a3quVomeP
         phDn25Fs6+okgkm3Imxvzx5jI/lN/0fqmESraJCo+Pi8ICvhfxrCiw2sYhAwAUpZJzwF
         Yo0ViAXhre7/jwGYED7WqHEOiqbGbKaGprxMPO9xUTY00VXpxd/gkx6+zC3f5YwK4SKm
         dY4A==
X-Gm-Message-State: APjAAAUfhdcpaKmzWc/XAGNIutdOYjkpZXZOwpczPsN9xP/aKKMn3UfB
        0xK0ktQbse7Hj6745EhNwiXrVWOpmunbT3WizHU20g==
X-Google-Smtp-Source: APXvYqy6HeF1gaVvt80UsoOefmNeUlO9TNupTdH1L7e6NcD8TTnM0KcZ6lh3JntKf6eHMY7MTht3otAZa36ky7M8bGQ=
X-Received: by 2002:a24:4161:: with SMTP id x94mr1490157ita.69.1552480572920;
 Wed, 13 Mar 2019 05:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <4603533.ZIfxmiEf7K@blindfold>
In-Reply-To: <4603533.ZIfxmiEf7K@blindfold>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 13 Mar 2019 13:36:02 +0100
Message-ID: <CAJfpegsy31D+=VJ+By2a9TLCvZJwvAUpb+_bJ5JVTsmsbZJTKQ@mail.gmail.com>
Subject: Re: overlayfs vs. fscrypt
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 1:31 PM Richard Weinberger <richard@nod.at> wrote:
>
> Hi!
>
> overlayfs and fscrypt are not friends.
> Currently it is not possible to use a fscrypt encrypted directory as upper
> directory with overlayfs.
> The reason for that is, fscrypt implements ->d_revalidate().
>
> From fscrypt's point of view having ->d_revalidate() makes sense because it
> wants to hide/show encrypted filenames if someone loads or unlinks a key.
>
> On the other hand, overlayfs makes sure that the upper directory cannot
> change beneath it. Therefore it checks whether the upper directory is a remote
> filesystem by checking for ->d_revalidate() and refuses to mount if so.
>
> In my little embedded Linux world it is common to use both UBIFS and
> overlayfs. Now with UBIFS being encrypted using fscrypt, overlayfs is a
> problem.
> My current hack is not using fscrypt_d_ops in UBIFS. This works because on a
> typical embedded target you setup your crypto keys exactly once, right before
> you mount overlayfs in an initramfs.
>
> But I'm sure this problem will hit sooner or later users of ext4 and f2fs too.
> Therefore I'd like to discuss possible solutions.
>
> So far I see two options:
>
> 1. Get rid of ->d_revalidate() in fscrypt.
> Maybe we find a way to return a dentry via ->lookup() which is not cached at
> all and therefore no ->d_revalidate() is needed. If unreadable and encrypted
> filename lookups are slow, so what?
> AFAIU this approach is impossible in the current dcache design since it is not
> allowed to have more than one dentry to the same file.

I don't get it.  Does fscrypt try to check permissions via
->d_revalidate?  Why is it not doing that via ->permission()?

>
> 2. Teach overlayfs to deal with a upper that has ->d_revalidate().
> Given the complexity of overlayfs I'm not sure how feasible this is.
> But I'm no overlayfs expert, maybe I miss something.

I don't think it would be too complex.  But first I'd like to
understand exactly why fscrypt is (ab) using d_revalidate().

Thanks,
Miklos
