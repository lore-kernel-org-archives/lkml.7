Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E38C46470
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C3420862
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bofh-nu.20150623.gappssmtp.com header.i=@bofh-nu.20150623.gappssmtp.com header.b="svnrBqWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfEWHxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:53:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38693 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfEWHxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:53:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id t5so4697876wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 00:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bofh-nu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zD/GCfFy3KEF6n+Sjktcq8mDi8VzZPrm8gqgABY6uSI=;
        b=svnrBqWh8OxI3mEIf6EoRMgxVrD2MtiofcSJUA8Q5xE2/JfxAtRQjTupHFu8KliEVw
         jKsHiiVmXcje+wjj3kYTof2a6oHkBwRaHYgqeYEPDpiA/47luPbcYqnYcipc5PW5Xl02
         BeSsSGHazNf97HW7TwPOH7ThV26XTyoJPQSUtZHo3Ltg/YiYnCYKKXUkXgqPVJ9d6dH9
         Q+I93kXOI0nVJfIsRLp81asaV6dS6vHwFGyxHJkZwgplxFMU8ij0fFRjmkKzA4fdH9Vm
         xC6e/oFIRx65QwqSUNy0r4rCHQ321owaLNv0KZ6IQ/Pj8yP8UrwmeibKwQuq8hHgsBzy
         HRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zD/GCfFy3KEF6n+Sjktcq8mDi8VzZPrm8gqgABY6uSI=;
        b=MvqkewIc/hkOKzrRy7E+vKtJzkSMWx6h39cFv++lKZ/sSW8veJrnEPtTCWSQ7FrPbX
         mb6m13R1u/Ucif6v7WdOUXdeLxfQyclXkv3fLwd5oOzPiBjm6JwXJ04X25/E2JUU7Cby
         rzt+NjZMtYg8DuXzh4TJtAN9t51Cij/W5bpc08ydEMtGtJcqGDcnTmn04GKxvGJmupHy
         NYgP9IOvDTiK84dfzWcb0BWbZOjCVBk26lCelNgYvwsKM60I91LZpp3ZsCcufGNQxwz2
         ZVvoAOLfnMz9tSdxfAWH5c/d6I+OJBx8TrzPqYwbRsXC2aD8pOAMlf1UlWFMQuAeRBfP
         xJzQ==
X-Gm-Message-State: APjAAAVe7p65rvvCjWjztS+b8TLA35nIKNugfEpH2UvWNxoGQAZE68wn
        s0wKJrOmKoNfLl4EQvDp+8dEu3p+zD3ksNzjuoGlIg==
X-Google-Smtp-Source: APXvYqztHHue+zVeZh26munVgEOjivv6QwpfJAZz+VlaWaXuY+VYHheE5Xb0YJmE6oQ8Swv+gRcFI3vK/cFGBkyJ8gw=
X-Received: by 2002:a1c:701a:: with SMTP id l26mr5342560wmc.32.1558598022177;
 Thu, 23 May 2019 00:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190515090659.123121100@linuxfoundation.org> <20190515090705.305124547@linuxfoundation.org>
In-Reply-To: <20190515090705.305124547@linuxfoundation.org>
From:   Lars Persson <lists@bofh.nu>
Date:   Thu, 23 May 2019 09:53:31 +0200
Message-ID: <CADnJP=v8Zn7dr11_KXFSWPwMtEc-rPTgFcRsbRy1mnBL5uDHvg@mail.gmail.com>
Subject: Re: [PATCH 4.14 082/115] cifs: fix memory leak in SMB2_read
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 1:19 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> [ Upstream commit 05fd5c2c61732152a6bddc318aae62d7e436629b ]
>
> Commit 088aaf17aa79300cab14dbee2569c58cfafd7d6e introduced a leak where
> if SMB2_read() returned an error we would return without freeing the
> request buffer.
>
> Cc: Stable <stable@vger.kernel.org>
> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  fs/cifs/smb2pdu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index fd2d199dd413e..7936eac5a38a2 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -2699,6 +2699,7 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
>                         cifs_dbg(VFS, "Send error in read = %d\n", rc);
>                 }
>                 free_rsp_buf(resp_buftype, rsp_iov.iov_base);
> +               cifs_small_buf_release(req);
>                 return rc == -ENODATA ? 0 : rc;
>         }
>
> --
> 2.20.1
>

This patch should not be in 4.14-stable because
088aaf17aa79300cab14dbee2569c58cfafd7d6e was for 4.18+.

Now we have a double-free crash in SMB2_read because there are 2 calls
to cifs_small_buf_release in the error path.

=============================================================================
BUG cifs_small_rq (Tainted: G    B      O   ): Object already free
-----------------------------------------------------------------------------

INFO: Allocated in mempool_alloc+0x35/0xe4 age=1 cpu=0 pid=21107
kmem_cache_alloc+0x131/0x218
mempool_alloc+0x35/0xe4
cifs_small_buf_get+0x1d/0x3c [cifs]
smb2_new_read_req.constprop.2+0x29/0xd0 [cifs]
SMB2_read+0x39/0x17c [cifs]
cifs_readpage_worker+0x13f/0x470 [cifs]
cifs_readpage+0x67/0x1b8 [cifs]
generic_file_read_iter+0x269/0x904
cifs_strict_readv+0xa3/0xc8 [cifs]
__vfs_read+0x97/0xbc
vfs_read+0x61/0xc8
SyS_pread64+0x4d/0x6c
ret_fast_syscall+0x1/0x64
INFO: Freed in cifs_small_buf_release+0x19/0x90 [cifs] age=0 cpu=0 pid=21107
cifs_small_buf_release+0x19/0x90 [cifs]
SMB2_read+0x83/0x17c [cifs]
cifs_readpage_worker+0x13f/0x470 [cifs]
cifs_readpage+0x67/0x1b8 [cifs]
generic_file_read_iter+0x269/0x904
cifs_strict_readv+0xa3/0xc8 [cifs]
__vfs_read+0x97/0xbc
vfs_read+0x61/0xc8
SyS_pread64+0x4d/0x6c
ret_fast_syscall+0x1/0x64
INFO: Slab 0xbf6fe800 objects=12 used=1 fp=0x8cf00d40 flags=0x8101
INFO: Object 0x8cf01d00 @offset=7424 fp=0x8cf002c0

Redzone 8cf01ce0: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
................
Redzone 8cf01cf0: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
................
Object 8cf01d00: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01d10: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01d20: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01d30: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01d40: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01d50: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01d60: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01d70: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01d80: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01d90: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01da0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01db0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01dc0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01dd0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01de0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01df0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01e00: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01e10: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01e20: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01e30: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01e40: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01e50: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01e60: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01e70: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01e80: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01e90: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01ea0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
kkkkkkkkkkkkkkkk
Object 8cf01eb0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5
kkkkkkkkkkkkkkk.
Redzone 8cf01ec0: bb bb bb bb                                      ....
Padding 8cf01f68: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
ZZZZZZZZZZZZZZZZ
Padding 8cf01f78: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
CPU: 0 PID: 21107 Comm: pool-indexer Tainted: G    B      O
4.14.120-axis5-devel #1
Hardware name: Axis ARTPEC-7 Platform
[<8010d031>] (unwind_backtrace) from [<80109f21>] (show_stack+0x11/0x14)
[<80109f21>] (show_stack) from [<8051e1d1>] (dump_stack+0x69/0x78)
[<8051e1d1>] (dump_stack) from [<802179cd>] (free_debug_processing+0x289/0x2b4)
[<802179cd>] (free_debug_processing) from [<80217b81>] (__slab_free+0x189/0x26c)
[<80217b81>] (__slab_free) from [<80217dc5>] (kmem_cache_free+0x161/0x1ec)
[<80217dc5>] (kmem_cache_free) from [<7fad04c1>]
(cifs_small_buf_release+0x19/0x90 [cifs])
[<7fad04c1>] (cifs_small_buf_release [cifs]) from [<7fae1e43>]
(SMB2_read+0xd3/0x17c [cifs])
[<7fae1e43>] (SMB2_read [cifs]) from [<7fac5aeb>]
(cifs_readpage_worker+0x13f/0x470 [cifs])
[<7fac5aeb>] (cifs_readpage_worker [cifs]) from [<7fac6127>]
(cifs_readpage+0x67/0x1b8 [cifs])
[<7fac6127>] (cifs_readpage [cifs]) from [<801dc855>]
(generic_file_read_iter+0x269/0x904)
[<801dc855>] (generic_file_read_iter) from [<7facb193>]
(cifs_strict_readv+0xa3/0xc8 [cifs])
[<7facb193>] (cifs_strict_readv [cifs]) from [<8022855f>] (__vfs_read+0x97/0xbc)
[<8022855f>] (__vfs_read) from [<802285e5>] (vfs_read+0x61/0xc8)
[<802285e5>] (vfs_read) from [<80228a4d>] (SyS_pread64+0x4d/0x6c)
[<80228a4d>] (SyS_pread64) from [<80106d81>] (ret_fast_syscall+0x1/0x64)
FIX cifs_small_rq: Object at 0x8cf01d00 not freed
