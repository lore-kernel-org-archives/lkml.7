Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B984BC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F54A24676
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ia3AV9/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfLOTun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 14:50:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35451 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726146AbfLOTun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 14:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576439442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6tVaOgyXatmQH26p7/caUrdng9JSMRx7S2qrCQnm7LY=;
        b=ia3AV9/EFysFm9b42wx8uyGVSXI8iaDYgzOrGJeYGP1XOCvYd5GQvynWb2eQMYL10BIAd4
        l6jVEzRDGJS11FiJvoKyWP5WUFXDg9WdBP15lJKMZqaIUcjOc/OSPMLoIn9vFkTKJZoEK4
        TvNYP+tSOrpfCug3+8D9rdMjSriWTII=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-cyRXCybnMOijafUQ6SXVUQ-1; Sun, 15 Dec 2019 14:50:40 -0500
X-MC-Unique: cyRXCybnMOijafUQ6SXVUQ-1
Received: by mail-oi1-f197.google.com with SMTP id c4so4521406oiy.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 11:50:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tVaOgyXatmQH26p7/caUrdng9JSMRx7S2qrCQnm7LY=;
        b=uZHyMeui3thDeI2Gua+Dr4N//OM7EVvxv7nhyYzoiEp42wzaIGJO6cUzMh78vJyTBd
         nf0xzD4Z6Ujf6Mx4AwnWdqgkAVFcDJgNfvrTnERT3n4uOs5Kgm1pEis/b0e3O/Jg+BC8
         R0RegT7O3lDpWykgErsE74i5mYSI1Uh7x39J/QT70GWa39TUPVXi6+tbWXDNCmPrHxh6
         Mae71P4Egiqm34criwDk2dywJAQIrhtKcJ207vrtY11Ex0MFKqVScfqtEj9Z5BiAnvcu
         uJSRNqucJ10eKOITF9DcTP0Z1USg4M76d+1haaa+So2VCiD7bQ4Vfh3gjCfh3A03mjrL
         bF0A==
X-Gm-Message-State: APjAAAUlFFKXVMIsGqry/V5EWa68TXPuRgTA1gxZhrpxfknme3oVAB2B
        LVAaQEfiloPTkhrc75QAG0rPEUFhNUCsM/RnwM+uB6BSmSeGCws9qkDVsXhjSppsVj2QBiKcWa0
        o/P4uKbHH9oi1KF3tDNsXGrLWaXO03oLc489fJAsF
X-Received: by 2002:a05:6830:1707:: with SMTP id 7mr28936245otk.185.1576439439638;
        Sun, 15 Dec 2019 11:50:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8azUFsS0YiLJx5qdyennHbE2ZU2iqv+ztns6y8ioGhrrofGwHueFOtN7YNmlzbK8vpsYZm2HnSq+RUteKGSk=
X-Received: by 2002:a05:6830:1707:: with SMTP id 7mr28936223otk.185.1576439439504;
 Sun, 15 Dec 2019 11:50:39 -0800 (PST)
MIME-Version: 1.0
References: <20191215164621.25828-1-pakki001@umn.edu>
In-Reply-To: <20191215164621.25828-1-pakki001@umn.edu>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sun, 15 Dec 2019 20:50:28 +0100
Message-ID: <CAHc6FU6rduNDcS7Y6UiWm6EuuwxnVd+75ydG1jW4rfE-kLn4Sw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: remove assertion when journal_info is not empty
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Aditya,

On Sun, Dec 15, 2019 at 5:46 PM Aditya Pakki <pakki001@umn.edu> wrote:
> In gfs2_trans_begin, avoid crashing when current->journal_info
> is not empty. The patch fixes  the error by returning -EINVAL
> instead of crashing.

can you please explain when that patch is needed? Do you have a test
case to reproduce?

Thanks,
Andreas

