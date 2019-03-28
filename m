Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78442C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4881A20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NzaIE6ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfC1SIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:08:12 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38487 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfC1SIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:08:11 -0400
Received: by mail-it1-f195.google.com with SMTP id f22so7574806ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhh689jASFqwg5CvKSsCVL3z97Hnu8T15rPfSQcYnLE=;
        b=NzaIE6uxYbEDkPgRduGRI2AmLoA943ZKQwON8MKRRwREEvb5qNVErkZCYnkweT35XG
         e/O50ZrnBInnKAyC64xIr32xixDaFfMBKPnppk60M3Z7IhKhmnk67EraFP20e5+8nrrq
         u7x2D0n6yzuz6kVMulwBnHknl0YxdSQseu0SDRAQ9jkC3E22SlWVHt/iiW47AXTfR5WZ
         DW4uHzhy1IVQV4n3rBuDUBPFrYo1Tqkksa02PunTAKwn+pffrTVlejqP3HWdmf0fI5b4
         K4a+K8+DLDH1prvJEI240MgQMecSe+I7Zit4ejZ5jACKbSpX9hc9ROI9L7OagEDqsYFe
         6OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhh689jASFqwg5CvKSsCVL3z97Hnu8T15rPfSQcYnLE=;
        b=btyj8MxONxpWmJ7THGr3a0RbbO6ClRJm/FoZZr3azm3GzJor+cXzk+ufwUbkhH/8xP
         MJaqaV3kkdPlGjZsVZOL9WEY3xevrWicDeYPyWFxDpfK4sz4d0yuPj2ozsy/VQ+YeYiN
         TN/eJs76cIP8nO4rYFMQDLgCxn1+0qmVp/5DpmYBzipYYzVx13MWYxvHIwueZTNAkv3c
         nhWQUow8e7zqAxLpYfdcf5vno02iVPRz+0TNFIH345QOFyPnmACBa7nAJ6Np8xZ4PxqM
         bt/KZq34/OwtReuWw844b3P04Dy7oNX5d4q+hwvuW1BV+23y5ghfGjesSwu87DD7Zyzz
         atRQ==
X-Gm-Message-State: APjAAAUODkXJ3wfxM2IQKQGF/9SaNiMa9gKs5tK6jY1NJkshgO7gZvUf
        d7LKUEkrZHu+lmiGkHiXrCXVg9ssv3m2JFjzNtTmNQ==
X-Google-Smtp-Source: APXvYqw0Yrl3ZUNwrlKzql9TEGxfkebPkeGnm+q1biuWu2OO1H/hFDzrOmoZ0cn9r/fiozl40FPBUnC8VmVOXNlu6HI=
X-Received: by 2002:a02:3d84:: with SMTP id n126mr26134078jan.102.1553796489486;
 Thu, 28 Mar 2019 11:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
 <20190325220954.29054-24-matthewgarrett@google.com> <20190325164221.5d8687bd@shemminger-XPS-13-9360>
 <CALCETrU=EqqRwyQGBT0=_N9-E_pBM53=z+WJrd9OzV7g6xJa0A@mail.gmail.com>
 <alpine.LRH.2.21.1903270523240.5235@namei.org> <CALCETrUZ+oP0xxNt4mwN=AZA+zvkkfPZiAsFmAuqUD48pOHbBg@mail.gmail.com>
 <alpine.LRH.2.21.1903281403540.27561@namei.org>
In-Reply-To: <alpine.LRH.2.21.1903281403540.27561@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 28 Mar 2019 11:07:58 -0700
Message-ID: <CACdnJusbi1jB+G0wMcj43wNik9Fiv3QCc8v30ztrFWg5-P-0iQ@mail.gmail.com>
Subject: Re: [PATCH 23/27] bpf: Restrict kernel image access functions when
 the kernel is locked down
To:     James Morris <jmorris@namei.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 8:15 PM James Morris <jmorris@namei.org> wrote:
> OTOH, this seems like a combination of mechanism and policy. The 3 modes
> are a help here, but I wonder if they may be too coarse grained still,
> e.g. if someone wants to allow a specific mechanism according to their own
> threat model and mitigations.

In general the interfaces blocked by these patches could also be
blocked with an LSM, and I'd guess that people with more fine-grained
requirements would probably take that approach.

> Secure boot gives you some assurance of the static state of the system at
> boot time, and lockdown is certainly useful (with or without secure boot),
> but it's not a complete solution to runtime kernel integrity protection by
> any stretch of the imagination.  I'm concerned about it being perceived as
> such.

What do you think the functionality gaps are in terms of ensuring
kernel integrity (other than kernel flaws that allow the restrictions
to be bypassed)?
