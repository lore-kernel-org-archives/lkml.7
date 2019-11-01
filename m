Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630F6CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CB421897
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572646371;
	bh=R3zHF33lXpbXV7nnsIRwzSf5C2VJ9cDXB6diPjhN9b0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y81RyaCEpSGoCvayINgGpzDaODeyX6jyfoWhmGid2BrilxEaFHEb/yCPecb25pSlq
	 SmAIudy7ZvgRgqiqacB3AIWi8vH8b9U7BSY2SHQj5lhIYr62Z2eOgW8w5KIArSjl7y
	 4Yx1kXBtRUcU253iTyLXwzDH/HGgBA69sNgYoGEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfKAWMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:12:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41476 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfKAWMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:12:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id m9so11654289ljh.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgYt+P3xDWHpqkCDVDLjgLKgMrsRwGebg6HQkCjAc5w=;
        b=O3mYYvlU9vmiWCuVM7D5zeynWjET9sBTNe2UP3ZA3GeXbBriHFMqoPk2kJgyTgcAeI
         BstBtBLU16kkJaWSMcP9+57VaYHHgUIqojJCqULremk/l27m2Dlyko2Sd9hhC3Y74UKd
         ZPG4og+yRVtEHOd/O+5D/qMCxYtxUKUSxHi24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgYt+P3xDWHpqkCDVDLjgLKgMrsRwGebg6HQkCjAc5w=;
        b=fMwGSA8HyY3ywdv1CyEQRrq7O5mUaC0swckWrXkc3plWgzjggzkZuIZvDKGSZrLVVn
         FBrDD6Y7QKmq6OU56wYiCo5+YdxW9004okl48OTb/RGVe1Ui/9eDOY7UaF1hkZY+yQHt
         vDL0XNj4fL4f6faAOMWQDysZJPVhTUh55lGkZF9y8lL8GmzsJIz218l+pe6t4tOhC0CH
         B+BRil3PzSfPaptalCZiR3k71St9jiSCNzwewQNyU+2VTPmi39Wb16w/5kWlI0RE62Cd
         Pjo119pLJp4SDqVUj0MPv+Zdf77M845H4h+uYlCW3VS/RPALRvlNFPLWq4Rm+ftybZyz
         xPSg==
X-Gm-Message-State: APjAAAWz0+Rq+MYTw6NEJr+dLk1rSptCR1ZvdgFhPPD/4yvsdKST39j1
        p+HqJVLkP7CpOzRXuMcb5na9Gw1SyqA=
X-Google-Smtp-Source: APXvYqzRumcJO/rHQti+b+yv46r41fvgbAR17Ptc1+BrEy23nCyM/g/zVvoi4CfEahK4p1WkX9wZiQ==
X-Received: by 2002:a2e:8ec8:: with SMTP id e8mr9526296ljl.83.1572646362477;
        Fri, 01 Nov 2019 15:12:42 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id a26sm4074232lfg.50.2019.11.01.15.12.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 15:12:40 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id v4so8242950lfd.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:12:39 -0700 (PDT)
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr8678681lfc.79.1572646359613;
 Fri, 01 Nov 2019 15:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
 <CAHk-=wjqx4j2vqg-tAwthNP1gcAcj1x4B7sq6Npbi8QJTUMd-A@mail.gmail.com> <13964.1572645926@warthog.procyon.org.uk>
In-Reply-To: <13964.1572645926@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Nov 2019 15:12:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_Fb-WdcD-cbJjwZaPCNK4WZ+Ak4KTSDhopD-_=+t=9Q@mail.gmail.com>
Message-ID: <CAHk-=wg_Fb-WdcD-cbJjwZaPCNK4WZ+Ak4KTSDhopD-_=+t=9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] pipe: Notification queue preparation [ver #3]
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 3:05 PM David Howells <dhowells@redhat.com> wrote:
>
> Changing those to non-sync:

Your benchmark seems very insensitive to just about any changes.

I suspect it is because you only test throughput. Latency is what the
pipe wakeup has been optimized for, and which tends to be much more
sensitive to other changes too (eg locking).

That said, I'm not convinced a latency test would show much either.

               Linus
