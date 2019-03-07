Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B78C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABE52063F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5EvuoEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfCGRch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:32:37 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50231 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCGRcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:32:36 -0500
Received: by mail-it1-f195.google.com with SMTP id m137so16519850ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lt2JT5l5LUhhefC+Y0bm0OU49KNxlP1Kty5xofOfsHM=;
        b=d5EvuoEIAtB4Sj7ZF7TDiNW9bw8P7yQoVDzkfeNjJIi0McC5KbC1Sa/sqE5+NbCS+S
         XzZb8uIZpqzxuYbJzBcefKicB+5tDdu+1leGuslYiWfPmHvB0akJ6OW3y5QyANLJQayp
         gfhpb4TbJZa+zAqM9367mu6xLBwQzoWXiDvnt1xjxy3Py5n5KaTU093dmx8Z01pfDcda
         h9RemOELBvsuhDHjJJc2iEgN0D1BFjHU0alXGJUCms4xsygxqL2zgOQU5w/RfpZkUJvq
         qCRDRvaFMj5YAp6QsfoOiWeme0EUrTAr1n4n+wQwABohJPQVxTMgECCfvecmQGmXwsXs
         aKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lt2JT5l5LUhhefC+Y0bm0OU49KNxlP1Kty5xofOfsHM=;
        b=MfN5E7tV+PwjwGWtgOLZWjcUhr/u2slHvjkug9SgKP+bYyHPYyI+XkJf/0hVKrdczn
         ySIGRc6085/NjC3GXCFgv5+57FMBFfSJIWtHGZZSYVEW24fN6X1bWJi68GqzS5i6lSdk
         tCS9XujtDtUsYmgdE9+KSATOTfs25RhnzvHs+pdrs/3x5IArUDBxFV4TRgdmpH2HzziO
         yTceKG8swcrIVv1Iw9EdcVClNGvOvRVtuE/CM4ZJfdBAeaOPt8wVZnG4VZUK1YwGh5+B
         5Cy8tOIoIjD6o0E2Ln1HeHMevkispIdkHhWVIlwJoxGpDrPXbKHeTT/VeA4PMQRBowYi
         1mAg==
X-Gm-Message-State: APjAAAVSi7yjtX3YjOtZ2bjEqOleJQ1NpdJCgq3tfjj91i4Q1ex45B5y
        How++/M2d0bWm1ZjtzW6wiZBYhs9MoNCemAY0zNyFg==
X-Google-Smtp-Source: APXvYqySeJgEqNTgssHe9bDXQasxMSyg00kzVK0V2BsklpbM41jrUYElIJaRgQ5SP+pqVh9Sf5lSO19D7geZCmh1CjU=
X-Received: by 2002:a24:43d1:: with SMTP id s200mr5909827itb.118.1551979955393;
 Thu, 07 Mar 2019 09:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
 <20190306235913.6631-10-matthewgarrett@google.com> <20190307145528.24c1b4d3@alans-desktop>
In-Reply-To: <20190307145528.24c1b4d3@alans-desktop>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 7 Mar 2019 09:32:24 -0800
Message-ID: <CACdnJuutrCYOoppScar53nfNnsrE6Oq36ayRGnJRLgh202aasw@mail.gmail.com>
Subject: Re: [PATCH 09/27] hibernate: Disable when the kernel is locked down
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     jmorris@namei.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 6:55 AM Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>
> On Wed,  6 Mar 2019 15:58:55 -0800
> Matthew Garrett <matthewgarrett@google.com> wrote:
>
> > From: Josh Boyer <jwboyer@fedoraproject.org>
> >
> > There is currently no way to verify the resume image when returning
> > from hibernate.  This might compromise the signed modules trust model,
> > so until we can work with signed hibernate images we disable it when the
> > kernel is locked down.
>
> That one is a bit worrying since whilst the other stuff may be useful in
> some business environments, mandatory hibernate not suspend to RAM is a
> common corporate IT policy because of concerns about theft and recovery
> of memory contents.

Suse have a solution for this that I'd like to see pushed again, but
from a practical perspective enterprise distributions have been
shipping this for some time without significant obvious customer
complaint.
