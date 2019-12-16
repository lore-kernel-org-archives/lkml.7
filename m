Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B7FC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C33206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576515995;
	bh=0oFBkKBOjKD2USSrZRJLZXFmdvrGm5lzKV5pWXW+h40=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FMu5bbllEwnBsV46t4T9B7QhdrZTsSXX+olaWxQQwXAnILmVSAVL6OyKknuklZtM4
	 6kTWopQt59YCzSoot4lQCantQkSGXI5v0rxZsChCwsLSR++oMEluVZgS0RB6SiE4HN
	 7mu+9uVHfqTomt4aet96RitCUzJf9u2EyLTDXX+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfLPRGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:06:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39465 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfLPRDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:03:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id e10so7603672ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 09:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIdISGJGzaJQCx+QFJwKYDn4eFwlu/KmTgZK+KGXtHQ=;
        b=FisnqkZLHGXU1116n34+W+++BJdXYXOirmyu3COj1Poy7sgqkkMzkwIqNqD2BJgXgp
         7bJbstoeV3IIxqy5UfVfnC6h1ipDwDqg3zT7NIwOmZblVCoykHaLLgUB9CCSMHXcX6wr
         99dslGhvIxyUYoXqIGnH5vu5CdG8apoTfqsaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIdISGJGzaJQCx+QFJwKYDn4eFwlu/KmTgZK+KGXtHQ=;
        b=DqOfVoTeq2nsz6NQXjFjju20eDVPDZVvokMGhPF+q5Mr9rzBoBHBePVA/bDXeMAT36
         BdW6syb14lXGzL02L3u4z9CAN9S4PrudSV6Fuj2H3d1ZyKnuWESyxwuG2JlOsQfyZbxY
         QmkjRbsKTTKCEd9i658nG4u97vgewG4ZIP5Ch2udK04++TVEDTUGSnuaYlaos+D+ZQDI
         luQQr/EyOCDHd9sfjxb/u00q0crkSIaHiesqidcAS6vMGMcmd5z/8oMyGk6smeXsgX6+
         ryZI01jqbIpXFfx7QigRqozYRKt+A+7/BHtWiGqA6ZsRMktFHYBRaWoBnuzKCFgj7iKe
         dETw==
X-Gm-Message-State: APjAAAVXHZvqpSkWnM07LdxgJUUrjn/dDg253gDxGfo+eICUQOHVPiXY
        RY00tHqKiMswzzI6C0eVbIeM54+N5ss=
X-Google-Smtp-Source: APXvYqzc4Vpl0jQV1g9vK8Li5uQ9kSwPTprjS8c0F1ZnZGUCkJF5WwrH1bbqzWJVnLD5QBZ2+nEFzA==
X-Received: by 2002:a2e:9587:: with SMTP id w7mr96268ljh.42.1576515827226;
        Mon, 16 Dec 2019 09:03:47 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id i9sm5646125lfd.6.2019.12.16.09.03.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 09:03:46 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id c19so7577052lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 09:03:45 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr84697ljj.148.1576515825433;
 Mon, 16 Dec 2019 09:03:45 -0800 (PST)
MIME-Version: 1.0
References: <20191126102743.3269-1-eric.auger@redhat.com> <0DE725CD-01CD-4E01-B817-9CC7F4768FBC@lca.pw>
 <80da76c4-395a-18cc-1ffa-c3a0471921b0@redhat.com>
In-Reply-To: <80da76c4-395a-18cc-1ffa-c3a0471921b0@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Dec 2019 09:03:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi7hqWOGhDopCFojBXm_K+p7Duyxp6Sjy=2HG=LqM8GbA@mail.gmail.com>
Message-ID: <CAHk-=wi7hqWOGhDopCFojBXm_K+p7Duyxp6Sjy=2HG=LqM8GbA@mail.gmail.com>
Subject: Re: [PATCH v3] iommu: fix KASAN use-after-free in iommu_insert_resv_region
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        eric.auger.pro@gmail.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@lst.de>,
        iommu <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 6:36 AM Auger Eric <eric.auger@redhat.com> wrote:
>On 12/16/19 3:24 PM, Qian Cai wrote:
> >
> > Looks like Joerg is away for a few weeks. Could Andrew or Linus pick up this
> > use-after-free?

I've taken it.

> Note the right version to pick up is the v4, reviewed by Jerry:
> https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg36226.html

Btw, please use lore.kernel.org, it's much more convenient for me
(faster, and a single interface for me so that I don't have to always
figure out "what's the incantation to get the original raw email" that
so many archives make it hard to get).

                   Linus
