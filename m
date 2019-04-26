Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D6EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7C9212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mM2gNYUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfDZSI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:08:58 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55951 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDZSI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:08:57 -0400
Received: by mail-it1-f195.google.com with SMTP id y134so7258731itc.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSDUm6zaly7/6QejATEjb8e1RQYiq+vEm5C7j7vxPK4=;
        b=mM2gNYUi/70Hohs3RgWqrz/IAXrbekJ+xfzhbMuc83HLnonIIOAND8fNLzPeKY7OuX
         zTZ2ysZFPHaq/GVmztzTKZpMaUVgb/a2UKfMV7n9uNEsnfJJpnoOIlObqAPabtxxM5BF
         8EkrQ4g60BXzRK3XIivpMG6AUJWmUF7YNBMjXBlwvXzDninFtVk7kcZROUswKjpscx+S
         k8FmnA06rbRfLjsHTVczdHxUFYFcdvCgt3MOHEPjiL0iwEqb+kqxeS6AyPfeUJFAeoEj
         BwKjLi7+5pGLTI/Pt+0JEphCU0qFdZ0G0ONukVUui6NTbN0xkLJtSGm7UZbKvqf0UVBw
         kAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSDUm6zaly7/6QejATEjb8e1RQYiq+vEm5C7j7vxPK4=;
        b=XvU2JHLjtVuvPBzzAqkRXtaZjRLRk2m2I4f47VeYOO/tgtDq+mIkk/evbYiHGN6DBf
         disMDG0cBI9liMWhr8esnBA90CH9VcKd55wWM8HGxBGyQRfw3z8ZieA1fUTCf44z5jiB
         YIdK/qnghk/6wvbMe5GHI/lSI6mpJMwCLsT8VS3Feb5po/Fm70ro8IdwS3Quy8PFsh2K
         X5m/bhf1gS+asHfnEvIgi7TUXnJk5p28pjALJnxZjFNSQry+MdvP16BgKXHHe5CK9EwD
         PC//NA+lDqDFnXzUka/agRWgX9MRPqMdpXq2+W59r5qEKiFqCIEouj+5df1yhYxAs4Gq
         dtjw==
X-Gm-Message-State: APjAAAW6nIJhxLLBMFZNqEv2SpFNCXeO18EVYynyQxzZuqKJlyVuEvgM
        ch7xfG8zynMriywEaTEnsMK4xCENfh/QuUwbHw643kw1TMM=
X-Google-Smtp-Source: APXvYqx1qt1n85QyABwVrqqSHtIju7qNaLOVL6vf8Pqs1UiBmO+nbB9VvzxmxR7qT0ggofA6H7kWVyqXfSIUdYPiYTE=
X-Received: by 2002:a24:eb04:: with SMTP id h4mr7779231itj.16.1556302136456;
 Fri, 26 Apr 2019 11:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJuup-y1xAO93wr+nr6ARacxJ9YXgaceQK9TLktE7shab1w@mail.gmail.com>
 <20190424211038.204001-1-matthewgarrett@google.com> <20190425121410.GC1144@dhcp22.suse.cz>
 <20190425123755.GX12751@dhcp22.suse.cz> <CACdnJuutwmBn_ASY1N1+ZK8g4MbpjTnUYbarR+CPhC5BAy0oZA@mail.gmail.com>
 <20190426052520.GB12337@dhcp22.suse.cz>
In-Reply-To: <20190426052520.GB12337@dhcp22.suse.cz>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 26 Apr 2019 11:08:44 -0700
Message-ID: <CACdnJutweLKsir_r9EgP9g=Eih-hbhq20N8zHzKawR8=awnENw@mail.gmail.com>
Subject: Re: [PATCH V2] mm: Allow userland to request that the kernel clear
 memory on release
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:25 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 25-04-19 13:39:01, Matthew Garrett wrote:
> > Yes, given MADV_DONTDUMP doesn't imply mlock I thought it'd be more
> > consistent to keep those independent.
>
> Do we want to fail madvise call on VMAs that are not mlocked then? What
> if the munlock happens later after the madvise is called?

I'm not sure if it's strictly necessary. We already have various
combinations of features that only make sense when used together and
which can be undermined by later actions. I can see the appeal of
designing this in a way that makes it harder to misuse, but is that
worth additional implementation complexity?
