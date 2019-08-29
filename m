Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13238C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E742166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="TNKynVNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfH2TnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:43:00 -0400
Received: from first.geanix.com ([116.203.34.67]:42302 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbfH2TnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:43:00 -0400
Received: from [192.168.8.20] (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id A7AAC4A4FE;
        Thu, 29 Aug 2019 19:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1567107731; bh=LI7AINWs1O4PAuNh6qexIw7OqcMSg2BsIF/WH/+bAxo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TNKynVNWYyxvMlW+JOM7ZB6+wkHVpZDy99aZLPZtxkXLPFM23FZa9dAmC2gXvPAyS
         fTmwJSw5kRyztXI5j3uLTEp/QDSJJK9mgfNgRKNl+QzqrvRhrfoNPdAbfI6GWMlN3u
         foBaYSpLaIEAVeI0TdEYvSRPuScptqxK6nslwD3ZX99difhTGxNaZrsJvgijUHNQyl
         j8wItxYzFR4XqaPOhy2NjqcnyypZBBKDgFkCgGidN4sYKg8lap7T42F3qrrzEAaayp
         V4tLwdQnJ5dFblOafNkzmj0Ao5oy8tnSEL6b46MQBdQl787jCyMLJLVIDvBO8Wh22e
         iD7zdrRJcA0KQ==
Subject: Re: [PATCH] tty: n_gsm: avoid recursive locking with async port
 hangup
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
References: <20190822215601.9028-1-martin@geanix.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
Message-ID: <4fd2d737-14a8-6fe6-16a1-c5e6d924f9e6@geanix.com>
Date:   Thu, 29 Aug 2019 21:42:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822215601.9028-1-martin@geanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2019 23.56, Martin Hundebøll wrote:
> When tearing down the n_gsm ldisc while one or more of its child ports
> are open, a lock dep warning occurs:
> 
> [   56.254258] ======================================================
> [   56.260447] WARNING: possible circular locking dependency detected
> [   56.266641] 5.2.0-00118-g1fd58e20e5b0 #30 Not tainted
> [   56.271701] ------------------------------------------------------
> [   56.277890] cmux/271 is trying to acquire lock:
> [   56.282436] 8215283a (&tty->legacy_mutex){+.+.}, at: __tty_hangup.part.0+0x58/0x27c
> [   56.290128]
> [   56.290128] but task is already holding lock:
> [   56.295970] e9e2b842 (&gsm->mutex){+.+.}, at: gsm_cleanup_mux+0x9c/0x15c
> [   56.302699]
> [   56.302699] which lock already depends on the new lock.
> [   56.302699]
> [   56.310884]
> [   56.310884] the existing dependency chain (in reverse order) is:
> [   56.318372]
> [   56.318372] -> #2 (&gsm->mutex){+.+.}:
> [   56.323624]        mutex_lock_nested+0x1c/0x24
> [   56.328079]        gsm_cleanup_mux+0x9c/0x15c
> [   56.332448]        gsmld_ioctl+0x418/0x4e8
> [   56.336554]        tty_ioctl+0x96c/0xcb0
> [   56.340492]        do_vfs_ioctl+0x41c/0xa5c
> [   56.344685]        ksys_ioctl+0x34/0x60
> [   56.348535]        ret_fast_syscall+0x0/0x28
> [   56.352815]        0xbe97cc04
> [   56.355791]
> [   56.355791] -> #1 (&tty->ldisc_sem){++++}:
> [   56.361388]        tty_ldisc_lock+0x50/0x74
> [   56.365581]        tty_init_dev+0x88/0x1c4
> [   56.369687]        tty_open+0x1c8/0x430
> [   56.373536]        chrdev_open+0xa8/0x19c
> [   56.377560]        do_dentry_open+0x118/0x3c4
> [   56.381928]        path_openat+0x2fc/0x1190
> [   56.386123]        do_filp_open+0x68/0xd4
> [   56.390146]        do_sys_open+0x164/0x220
> [   56.394257]        kernel_init_freeable+0x328/0x3e4
> [   56.399146]        kernel_init+0x8/0x110
> [   56.403078]        ret_from_fork+0x14/0x20
> [   56.407183]        0x0
> [   56.409548]
> [   56.409548] -> #0 (&tty->legacy_mutex){+.+.}:
> [   56.415402]        __mutex_lock+0x64/0x90c
> [   56.419508]        mutex_lock_nested+0x1c/0x24
> [   56.423961]        __tty_hangup.part.0+0x58/0x27c
> [   56.428676]        gsm_cleanup_mux+0xe8/0x15c
> [   56.433043]        gsmld_close+0x48/0x90
> [   56.436979]        tty_ldisc_kill+0x2c/0x6c
> [   56.441173]        tty_ldisc_release+0x88/0x194
> [   56.445715]        tty_release_struct+0x14/0x44
> [   56.450254]        tty_release+0x36c/0x43c
> [   56.454365]        __fput+0x94/0x1e8
> 
> Avoid the warning by doing the port hangup asynchronously.

Any comments?

// Martin

> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> ---
>   drivers/tty/n_gsm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index d30525946892..36a3eb4ad4c5 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -1716,7 +1716,7 @@ static void gsm_dlci_release(struct gsm_dlci *dlci)
>   		gsm_destroy_network(dlci);
>   		mutex_unlock(&dlci->mutex);
>   
> -		tty_vhangup(tty);
> +		tty_hangup(tty);
>   
>   		tty_port_tty_set(&dlci->port, NULL);
>   		tty_kref_put(tty);
> 
