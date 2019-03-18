Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA3AC10F05
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8B62085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWON7Ab8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfCRD03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 23:26:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35735 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbfCRD02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 23:26:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id z13so8840603qki.2;
        Sun, 17 Mar 2019 20:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWreJHc2NYzyVo4TqtOSjg0yztt5GvwwXMC5xzBD3uo=;
        b=eWON7Ab8XxYsxTpdI50uWhQ7Krrk/YTCbD/HCDux6fBwbTgVzHThD3+4UQLJJjJArW
         NkqZ2t+Q3185P5MSkJBZbUZ+5qQyv/WamOjDBxYAywHpruR6+6daAb1E+GKbTysN5iap
         IsEk8FpZSbb3PjezkCMJPYnC3mUqxY4agw31lrNZFTnJ9tW/L6JAUdL0c07+trMusqND
         rtWGPgN4bNRxBJwbf3BkbTGSfYKyVSWY80nTjA1UsxGYfLD9oynZq3IzWEtdwLfM6B9F
         r2JhiqRLcofbZw90Bixt+sgcSyOH3/UFQnXd/DBnGMKW4Gxc5fK3iAKVLskCgQmXhqBt
         eR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWreJHc2NYzyVo4TqtOSjg0yztt5GvwwXMC5xzBD3uo=;
        b=HAt7XEktDAycqDW43xW+d0TN9QOjLMDLb+wWBSRk7vLNs/ZQH9D5iAqa7gWNQssVCX
         wTEgyDdIPxlFHV6dt9R7GlqSHhLv1e0noRQPGf7Fitgsnq3rI2rShV2IVU4RQUJfi5rf
         E6odqTi3+QOcRiBIO2iC5Afe/BoGPbm+JoFooAZMd6lwdPt9DeU18b0/jNbhusP9AtWN
         Edx7JGZMPu0SEkpQfG9MrQ2mLLP0B3iISbNFQHbitt7y4wnoRftY3jWBckYfx7tzXHFP
         JUBq5LvVpKtPjDsPqyfS1habs9K6pm67llEipNze6rRMLOrYNIXDWR2fPYHD8oNvGZKT
         CH5A==
X-Gm-Message-State: APjAAAWEOZiCPK1L2ne2r/dIQFqCgPoucRlcxdthpTJrNuHGlUchHxSX
        dcwzRZR47GaTcpwawpna9tqCdYAqIstkKNpsE5+Tzzcp2/Vk+g==
X-Google-Smtp-Source: APXvYqymbrbH72wqvL/UF11y455o8r2b60MTXqPhLx+pGZ10hOJ3pHLk4bsmck2MIPM1o2MoqTzckx/A/iR5w+LiXqs=
X-Received: by 2002:a05:620a:1348:: with SMTP id c8mr11479013qkl.246.1552879586774;
 Sun, 17 Mar 2019 20:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190315111107.15154-1-lhenriques@suse.com>
In-Reply-To: <20190315111107.15154-1-lhenriques@suse.com>
From:   "Yan, Zheng" <ukernel@gmail.com>
Date:   Mon, 18 Mar 2019 11:26:15 +0800
Message-ID: <CAAM7YAnD_dK2py+95N8Z7T+Vgr2ZbBJne+tNYivEeUGObhpiCQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: Fix a memory leak in ci->i_head_snapc
To:     Luis Henriques <lhenriques@suse.com>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 7:13 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> I'm occasionally seeing a kmemleak warning in xfstest generic/013:
>
> unreferenced object 0xffff8881fccca940 (size 32):
>   comm "kworker/0:1", pid 12, jiffies 4295005883 (age 130.648s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000d741a1ea>] build_snap_context+0x5b/0x2a0
>     [<0000000021a00533>] rebuild_snap_realms+0x27/0x90
>     [<00000000ac538600>] rebuild_snap_realms+0x42/0x90
>     [<000000000e955fac>] ceph_update_snap_trace+0x2ee/0x610
>     [<00000000a9550416>] ceph_handle_snap+0x317/0x5f3
>     [<00000000fc287b83>] dispatch+0x362/0x176c
>     [<00000000a312c741>] ceph_con_workfn+0x9ce/0x2cf0
>     [<000000004168e3a9>] process_one_work+0x1d4/0x400
>     [<000000002188e9e7>] worker_thread+0x2d/0x3c0
>     [<00000000b593e4b3>] kthread+0x112/0x130
>     [<00000000a8587dca>] ret_from_fork+0x35/0x40
>     [<00000000ba1c9c1d>] 0xffffffffffffffff
>
> It looks like it is possible that we miss a flush_ack from the MDS when,
> for example, umounting the filesystem.  In that case, we can simply drop
> the reference to the ceph_snap_context obtained in ceph_queue_cap_snap().
>
> Link: https://tracker.ceph.com/issues/38224
> Cc: stable@vger.kernel.org
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/caps.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 36a8dc699448..208f4dc6f574 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1054,6 +1054,7 @@ int ceph_is_any_caps(struct inode *inode)
>  static void drop_inode_snap_realm(struct ceph_inode_info *ci)
>  {
>         struct ceph_snap_realm *realm = ci->i_snap_realm;
> +
>         spin_lock(&realm->inodes_with_caps_lock);
>         list_del_init(&ci->i_snap_realm_item);
>         ci->i_snap_realm_counter++;
> @@ -1063,6 +1064,12 @@ static void drop_inode_snap_realm(struct ceph_inode_info *ci)
>         spin_unlock(&realm->inodes_with_caps_lock);
>         ceph_put_snap_realm(ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc,
>                             realm);
> +       /*
> +        * ci->i_head_snapc should be NULL, but we may still be waiting for a
> +        * flush_ack from the MDS.  In that case, we still hold a ref for the
> +        * ceph_snap_context and we need to drop it.
> +        */
> +       ceph_put_snap_context(ci->i_head_snapc);
>  }
>
>  /*

This does not seem right.  i_head_snapc is cleared when
(ci->i_wrbuffer_ref_head == 0 && ci->i_dirty_caps == 0 &&
ci->i_flushing_caps == 0) . Nothing do with dropping ci->i_snap_realm.
Did you see 'reconnect denied' during the test? If you did, the fix
should be in iterate_session_caps()
