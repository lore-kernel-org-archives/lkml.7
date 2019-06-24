Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10DDC4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966802077C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUXUAlmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfFXX4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:56:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45242 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbfFXX4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:56:38 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so1049608ioc.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 16:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbOrnIupVUW58CvYWuTxi+TaCWansJx4UnWPnwoZyJY=;
        b=HUXUAlmqADW2TvklcTS8vLxmQ564rKI+gpHW3ckU8mFGROi3j1s/fMq9zvwOcD+GR/
         Ejy70MnCirzz9M9UbGuGbPLeezKbqoKj5JhUclzQLUQP28sgxW820TLZ5lbacxE8hQVj
         x4uw9hzl639jgHDZ9UO3wpxo8Un3RGw4P0LCSzGhvIDVlg6UdGz3N8h2s5TUacfgJvvt
         Pfjo3cZvMqWAUxDZP8GviI08ewLTXJMN/ALlSa5C0CgSVWdjy2beq6N+kPRv2Nus+C56
         PN1V00fo3fGRDTYnUHm3vvref5BiDeYLvYvEoZngc27qwYQ8qOB4lozFsNR4aA/IipUt
         kA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbOrnIupVUW58CvYWuTxi+TaCWansJx4UnWPnwoZyJY=;
        b=m+PXKyqCPEoHJrrMnYCV+YWhsrwU+zEl9cYWB70qebGXOBZEe2prEs4aSjxhpu8nKa
         vodvOsFxmsE2qgBld0WN4hz+4NNO6ZfT6kaLPU2Xj/uOUEF/xwWGGvrYJ89pi8sJJw6j
         CjF00eljOX1Y4mrxzpweYPfyvZHPA2+TCelDnGx/Z3tlmdNGRekC5iyHKWuau3Vmj8fV
         fw5Z+U0zlDOX8yqbGRXDLBuJRBhmgPNkbEo4Os64Vv3of/UrTKftiJgzTH1AnyBGWxuK
         mv9RwI7qbRMSR9sJIUyH4kcZ5ad+ZIz9f4PdkWVF0OZlcjyZYV6U9+DrtiluytjdmsVw
         3ZjQ==
X-Gm-Message-State: APjAAAWpkBsHioKOEEgiXF9g3zIb5LAU7msIneNIqUWbSQewW7cmrhYb
        v+GraqOuoMwCCbVaEu7hBQnB+ByuKa/c9hFFdyVtMUDELiw=
X-Google-Smtp-Source: APXvYqyJ78ZTsA34HUGlgKawtoKMfnBRG3TGL+IoK1XwzWW+xnzC8aP35qDBpYttWG4XrxgtQu1mEyJbU+viiisuDtA=
X-Received: by 2002:a6b:8dcf:: with SMTP id p198mr8001652iod.46.1561420597592;
 Mon, 24 Jun 2019 16:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com> <alpine.LRH.2.21.1906250853290.7826@namei.org>
In-Reply-To: <alpine.LRH.2.21.1906250853290.7826@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 24 Jun 2019 16:56:25 -0700
Message-ID: <CACdnJut2erF9ZKeJQ+uvWZeEnHh=stmEioi_P36DF9mN5i2RGQ@mail.gmail.com>
Subject: Re: [PATCH V34 00/29] Lockdown as an LSM
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Andy Lutomirski <luto@amacapital.net>,
        John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 4:01 PM James Morris <jmorris@namei.org> wrote:
>
> On Fri, 21 Jun 2019, Matthew Garrett wrote:
>
> > Minor updates over V33 - security_is_locked_down renamed to
> > security_locked_down, return value of security_locked_down is returned
> > in most cases, one unnecessary patch was dropped, couple of minor nits
> > fixed.
>
> Thanks for the respin.
>
> We are still not resolved on granularity. Stephen has said he's not sure
> if a useful policy can be constructed with just confidentiality and
> integrity settings. I'd be interested to know JJ and Casey's thoughts on
> lockdown policy flexibility wrt their respective LSMs.

This implementation provides arbitrary granularity at the LSM level,
though the lockdown LSM itself only provides two levels. Other LSMs
can choose an appropriate level of exposure.

> These are also "all or nothing" choices which may prevent deployment due
> to a user needing to allow (presumably controlled or mitigated) exceptions
> to the policy.

Distributions have been deploying the "all or nothing" solution for
several years now, which implies that it's adequate for the common
case. I think it's reasonable to punt finer grained policies over to
other LSMs - people who want that are probably already using custom
LSM policy.
