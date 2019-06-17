Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59DDC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90159208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560795386;
	bh=BXIfIttiJtOA6YWH1p8/K0KVhWvzFEYS16cbSAAq3TA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ThozjOA1OA+WH1T9PNOOV4rds0eE3AQPGRtaXdg7flR1b7YHzmiw+UQoSGkcVQvqT
	 Os+dNwDmoPER8xbAb3wNehGIAKbTGcMs07CVuYiblXZd2cRbwSWhFvMHvn1ox1X1Ms
	 4hnzgJgVxISswKYy2PKZYXAuqWXe6IopAWvWeQ84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfFQSQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:16:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44695 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFQSQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:16:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so10216781ljc.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 11:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KbGZcl0Gi0jNy9coPKcSJr5heE7ZQLRdeNj3JGzwpA=;
        b=T15jTJllZ2uRduB3YrgRGX6wMT+z9NIUkv1VPJmC8yz0PENs8is1UxhM80bHpn8Wjc
         LHml4nVfexaFPrpvousJxFP6ZKHWn6WTtjuwP5+9yj+P/JOWZf04CZCjP8YosgpSq8m6
         YDg70VW3sT3LWCqjEU3XU9676uzdpl6cv7EhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KbGZcl0Gi0jNy9coPKcSJr5heE7ZQLRdeNj3JGzwpA=;
        b=eWNwSny6epwDZ5lR2FwCTFWX0oVxQGS+kV3cneMKgzXn5f7NNIl/8yplTqVoLUNxw6
         hLqWS3J6NvjjTZzq0VSy2iXobWZPL112WOsgo9VkbsR7YtPacmmCkAgluLMNRomYW/4A
         c4IoHYGAEmVHjhjdRlRw1OBoOB+IUgy54dXp6+M+Q6u+zSjTGhaIsIdG0AuxO4Uly1TI
         mdhZ5TR9SeKpB7dR2EfYj7e9idrZ0xtMB5vw1Q/4pcWfppHfHMSpuuJxZJVqBSbiSAms
         rpCUiGFeuQdJcG8TqRihzk4PHnF1BVOthi+EpkP/2gtCPldL3NmcP0v4BKKVgqKXEECW
         PFzQ==
X-Gm-Message-State: APjAAAX+ObPUMw661Z1DNq9MFmS4Kj7JLLkrY4DnsrI3k+V0hah0BwVu
        zLwnsWByFcrZa5xAK1bJtWsTcj6WzFE=
X-Google-Smtp-Source: APXvYqxHnB1UbKmB3eRJZvwSjlvuIwfuMBL7dcnZ1kWC8iP5c9YPvObjRwOl7qz12ZKlLIHX+Re2vg==
X-Received: by 2002:a2e:50e:: with SMTP id 14mr41612890ljf.5.1560795381890;
        Mon, 17 Jun 2019 11:16:21 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id v7sm2253520ljj.3.2019.06.17.11.16.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:16:19 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id v18so10271242ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 11:16:19 -0700 (PDT)
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr30169158ljm.180.1560795379164;
 Mon, 17 Jun 2019 11:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190319165123.3967889-1-arnd@arndb.de> <alpine.DEB.2.21.1905072249570.19308@digraph.polyomino.org.uk>
 <87tvd2j9ye.fsf@oldenburg2.str.redhat.com> <CAHk-=wio1e4=WUUwmo-Ph55BEgH_X3oXzBpvPyLQg2TxzfGYuw@mail.gmail.com>
 <871s05fd8o.fsf@oldenburg2.str.redhat.com> <CAHk-=wg4ijSoPq-w7ct_VuZvgHx+tUv_QX-We-62dEwK+AOf2w@mail.gmail.com>
 <87sgs8igfj.fsf@oldenburg2.str.redhat.com> <CAHk-=wjCwnk0nfgCcMYqqX6o9bBrutDtut_fzZ-2VwiZR1y4kw@mail.gmail.com>
 <87k1dkdr9c.fsf@oldenburg2.str.redhat.com> <CAHk-=wgiZNERDN7p-bsCzzYGRjeqTQw7kJxJnXAHVjqqO8PGrg@mail.gmail.com>
In-Reply-To: <CAHk-=wgiZNERDN7p-bsCzzYGRjeqTQw7kJxJnXAHVjqqO8PGrg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jun 2019 11:16:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkCOVzXeju8H8iWeh-vWorpWSZG6USFKcOWQ36XokZMA@mail.gmail.com>
Message-ID: <CAHk-=whkCOVzXeju8H8iWeh-vWorpWSZG6USFKcOWQ36XokZMA@mail.gmail.com>
Subject: Re: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Paul Burton <pburton@wavecomp.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:13 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That one we might be able to just fix by renaming "fds_bits" to "__fds_bits".

That said, moving it to another file might be the better option anyway.

I think fd_set and friends are now supposed to be in <sys/select.h>
anyway, and the "it was in <sys/types.h>" is all legacy.

                 Linus
