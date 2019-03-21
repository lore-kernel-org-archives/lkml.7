Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76C9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879E621874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DglQfmF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfCURfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:35:23 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44579 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCURfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:35:21 -0400
Received: by mail-vs1-f67.google.com with SMTP id j184so4151693vsd.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TcANOQYRJqySqWQBCi+jiG/hbLxUkOBFHkNngCggkjs=;
        b=DglQfmF2nLfl6tSjgSOtRpLMl228Q6g4W3NNr2kOSav92yGPwuNFoLB9/wYlda/dQq
         +obp/0/bRbMq3zHfcHGW3CPwhht2mJcFdTKQuQDYQX1oO3DZyra2uMXFSjtViMDbIKM/
         G+IaVxJ5oiEEI1uOrqtSjpm2h7qkGk4HtI5CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcANOQYRJqySqWQBCi+jiG/hbLxUkOBFHkNngCggkjs=;
        b=Bszreq+856iS7WgvdF545vCclxaK9zqQ/jeUzPHJi3FUCa5zCyBf1RzCxnLMLwIb8o
         a0uprT11mSu3+Xl9O+0M1maXhqFnNVYy4bdSOXCgOzcbVMLeLYeBjX9XYydBu6S1lVYq
         njgghLwF38ffnVJ6tfpr7gwbFq1kczZfiLA0w40aaj6KpNz6EbVcF3rwhxgydWj1dVfS
         vtMhxPpyutoAs99ZhzgUvPUcNVbv94CdGRulIVnGQ2lc9erJasIRQgoRTl8rk9XAP5KN
         HLGZlqnpTDLszGQ6pxJlYe5whUB5CoGDiWt48xNOu4z7wimjm9CbIf/zJTZCqk3LBRSf
         1fhA==
X-Gm-Message-State: APjAAAWB8vUzFQCAng+Zuo0i8Nw+H9asTW7pYRxsk1pE9GxxcwA8gEIU
        YAzdTKsV8v0yFCULwqyuGc20u5ndpKqg7A==
X-Google-Smtp-Source: APXvYqwdLzwyv8a0l+bIdx7su91GUHGtk/rg9p5gh05NgVebimcuP7bpwojiMeyiYn24P2kn+n1/Yg==
X-Received: by 2002:a67:fc13:: with SMTP id o19mr2870409vsq.123.1553189719490;
        Thu, 21 Mar 2019 10:35:19 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id u200sm1579637vku.13.2019.03.21.10.35.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 10:35:18 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id n14so4137712vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:35:18 -0700 (PDT)
X-Received: by 2002:a67:6983:: with SMTP id e125mr2750631vsc.222.1553189717974;
 Thu, 21 Mar 2019 10:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <155316885201.29437.3428987891437242750.stgit@warthog.procyon.org.uk>
 <155316888615.29437.17558157678296689830.stgit@warthog.procyon.org.uk>
 <CAGXu5jJvSk=sJbjE+-6USvr4qXHxxwEOK64_FAWh74-eBkm+YQ@mail.gmail.com> <26699.1553187790@warthog.procyon.org.uk>
In-Reply-To: <26699.1553187790@warthog.procyon.org.uk>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Mar 2019 10:35:06 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJLOF3piYPZJWAEqbKUkM=rLmUipFO74Mw2UzCNgfi9Wg@mail.gmail.com>
Message-ID: <CAGXu5jJLOF3piYPZJWAEqbKUkM=rLmUipFO74Mw2UzCNgfi9Wg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/8] vfs: Convert pstore to fs_context
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 10:03 AM David Howells <dhowells@redhat.com> wrote:
>
> Kees Cook <keescook@chromium.org> wrote:
>
> > Why the separation between parse and apply now? Is this due to the
> > reconfigure calls? (i.e. why not call pstore_set_kmsg_bytes() in
> > pstore_parse_param()?
>
> Because parameter parsing is now done up front, before the creation of the
> superblock of the invocation of the reconfigure method - so there's still a
> bunch of places that can error out before you know you're going to be
> successful in creating/reconfiguring the superblock.

Thanks! Makes sense. :)


-- 
Kees Cook
