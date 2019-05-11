Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47761C04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 16:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196FE2183F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 16:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557593549;
	bh=Xp854bi6/CQdP0iVHbcAsGDpX5gJrBJiR4ejGWJ31ig=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=Yv8CUF/WaPbTRZDEH0w3XPLLIWcUq8oBZQ/zE+oRyXycrFXsI3pJ183ELh9XjuQij
	 GDpNdrLYrBpRH60ly8OapCh3ex4Scn0Rcl0/ejnY2EZ4plPxy9p2GBXdewQkcMyUTj
	 R48uey3NKJSu+hDL6IT28AKgYv0gF5a/gV+a1BVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfEKQw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 12:52:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40893 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfEKQw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 12:52:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id d15so7582650ljc.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=8wz43C7jxGCUsHy9MfWjXgalwSWO3z1P/EsbM3jZ0KM=;
        b=GDi3fsBTBmf9X/8Hz0x1TQFBY0bhDBOVG947LRV8qCxSuuclixM+RZ23aQRJsD+7QL
         FFoQee+EIXhKJpQVIge77dug+vh6aZEAXj7EobIugSWNrnrQ+lfqlnR8Q37ZkFcIA5GB
         v7yQJ7MNZn/9ofUQykM+64Arse7i9M0xZTWTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=8wz43C7jxGCUsHy9MfWjXgalwSWO3z1P/EsbM3jZ0KM=;
        b=dwCxWJ9ftBJE3UJ81O3nExzWfv+Tcneg6HuqZ42e47hrATtofhMU0zHXxCSAKnJ1ZF
         2GQXwKv6q/5xPGi0xPaKA/7Sr/0tQhwr1CdG9tvt7pWr6hnkjXEIW2bFWRGgygf6Wpk1
         0u0DTjDa9z8p8rapDUMTPsr2yQyzLN/PJPtF8+yI5YI9DbQfyASlvgK6Oa+TWQy0UP9s
         gAt6xJmfDikuRTmWWbbXLrHqRujiIM+3zKPruIIYLzrp3CCtfn9RwG4kvHLHg1nmbAel
         R9ZiNNUBONpgLem6sHioj83ex96kj5UEo7qkvqL1BBkJiTk/BgPnp2PMyDLUKN5SkMLU
         V8Rw==
X-Gm-Message-State: APjAAAW92b5jTdppJ+f51bGzYpa7Vmt+pLRbxVvfaKQbJIDNYhaNaNEv
        oPxPks+DeUCFLCBh5zHRZfsGFcVF0uw=
X-Google-Smtp-Source: APXvYqyHewtZmTlNqJZQfu36UkkNiDlOIzuH2dYsk16W6zFGuqSAZMDVpcugfXk2iBO2AOm+gNEaKA==
X-Received: by 2002:a2e:281:: with SMTP id y1mr8906303lje.175.1557593544579;
        Sat, 11 May 2019 09:52:24 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id f25sm2217063lfc.46.2019.05.11.09.52.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 09:52:23 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id h13so6226304lfc.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 09:52:23 -0700 (PDT)
X-Received: by 2002:a19:5015:: with SMTP id e21mr9229137lfb.62.1557593542751;
 Sat, 11 May 2019 09:52:22 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 May 2019 12:52:06 -0400
X-Gmail-Original-Message-ID: <CAHk-=whbuwm5FbkPSfftZ3oHMWw43ZNFXqvW1b6KFMEj5wBipA@mail.gmail.com>
Message-ID: <CAHk-=whbuwm5FbkPSfftZ3oHMWw43ZNFXqvW1b6KFMEj5wBipA@mail.gmail.com>
Subject: Annoying gcc / rdma / networking warnings
To:     Jason Gunthorpe <jgg@mellanox.com>,
        David Miller <davem@davemloft.net>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason and Davem,
 with gcc-9, I'm now seeing a number of annoying warnings from the
rdma layer. I think it depends on the exact gcc version, because I'm
seeing them on my laptop but didn't see them on my desktop, probably
due to updating at different times.

The warning is because gcc now looks at pointer types for some
allocation sizes, and will do things like this:

In function =E2=80=98memset=E2=80=99,
    inlined from =E2=80=98rdma_gid2ip=E2=80=99 at ./include/rdma/ib_addr.h:=
168:3,
    inlined from =E2=80=98roce_resolve_route_from_path=E2=80=99 at
drivers/infiniband/core/addr.c:735:2:
./include/linux/string.h:344:9: warning: =E2=80=98__builtin_memset=E2=80=99=
 offset
[17, 28] from the object at =E2=80=98dgid=E2=80=99 is out of the bounds of =
referenced
subobject =E2=80=98_sockaddr=E2=80=99 with type =E2=80=98struct sockaddr=E2=
=80=99 at offset 0
[-Warray-bounds]
  344 |  return __builtin_memset(p, c, size);

because the "memset()" is done onto a "sockaddr_in6" (where it's not
out of bounds), but the rdma_gid2ip() function was passed a "sockaddr"
type (where it *is* out of bounds.

All the cases I found actually have good *allocations* for the
underlying storage, using a union of the different sockaddr types, and
includes a "sockaddr_in6". So the warning actually looks bogus from an
actual allocation standpoint, but at the same time, I think the
warning does show a real issue in the networking code.

In particular, a "struct sockaddr" is supposed to be a valid superset
of the different sockaddr types, and the rdma use is in that sense the
rdma use of "struct sockaddr *" is entirely sane.

BUT.

The Linux kernel sockaddr is actually just 16 bytes. While a
sockaddr_int is about twice that.

So if you look at the types like gcc does, then the rdma layer really
is passing a pointer to a 16-byte sockaddr, and then filling it with
(much bigger) sockaddr_ip6 data.

Arguably gcc is being stupid, and it should look at the actual
allocation, but that's not what it does. And I do think what gcc does
is at least understandable.

So David, arguably the kernel "struct sockaddr" is simply wrong, if it
can't contain a "struct sockaddr_in6". No? Is extending it a huge
problem for other users that don't need it (mainly stack, I assume..)?

Also equally arguably, the rdma code could just use a "struct
sockaddr_in6 for this use and avoid the gcc issue, couldn't it? It has
the type right there, and rdma_gid2ip() could just take that type
instead, since that's what it actually then uses anyway.

Comments?

               Linus
