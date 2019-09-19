Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CD7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE0E21907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="VMTVNpct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390462AbfISNBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:01:49 -0400
Received: from first.geanix.com ([116.203.34.67]:38038 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388846AbfISNBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:01:48 -0400
Received: from [192.168.8.20] (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 9D2CA681A9;
        Thu, 19 Sep 2019 13:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568898101; bh=OrlqwK2SAAOFsSpde8lIVUxGZTfhMzH/o/6acmAaHjI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VMTVNpct4R2DY9WcONYPhvK8BXJr00zsIoaxhp+QQWifLueiubH76/o0AlhZWUuxo
         tZme9uFVopJPka55N1+YWsyOZSKTsRmLuqgiCQjB+NrsAdiTdLc96XE35cTLcigvvd
         B02Fd+zWCrsSEGRrHccJaNYaQXTevCxxpgRFp0dNTbzKdjytQXc7xDt2yoQ7bYl47V
         /Z0ua95vYF47BdBcqAfugjrRcx4hxscWSkeQUwPfekmwF7UUIexKa5ym6DZlSOSDJF
         k39+oPCcjz6Ixz/7/yPkcvSmaoS0lPtQ3ws52MXlC4r+yXGNG+lnyUSLSuZKxAOXNJ
         3mEfLOjp8nPVA==
Subject: Re: [PATCH] tty: n_gsm: avoid recursive locking with async port
 hangup
To:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Esben Haabendal <esben@geanix.com>,
        =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean@geanix.com>
References: <20190822215601.9028-1-martin@geanix.com>
 <4fd2d737-14a8-6fe6-16a1-c5e6d924f9e6@geanix.com>
 <a1c42b28-6e00-7c1f-9e4b-cf089c17e050@suse.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
Message-ID: <4e206e1c-4f6d-bdc1-a435-9f4e8bb004ee@geanix.com>
Date:   Thu, 19 Sep 2019 15:01:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <a1c42b28-6e00-7c1f-9e4b-cf089c17e050@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2019 10.18, Jiri Slaby wrote:
> On 29. 08. 19, 21:42, Martin Hundebøll  wrote:
>> On 22/08/2019 23.56, Martin Hundebøll wrote:
>>> When tearing down the n_gsm ldisc while one or more of its child ports
>>> are open, a lock dep warning occurs:
>>>
>>> [   56.254258] ======================================================
>>> [   56.260447] WARNING: possible circular locking dependency detected
>>> [   56.266641] 5.2.0-00118-g1fd58e20e5b0 #30 Not tainted
>>> [   56.271701] ------------------------------------------------------
>>> [   56.277890] cmux/271 is trying to acquire lock:
>>> [   56.282436] 8215283a (&tty->legacy_mutex){+.+.}, at:
>>> __tty_hangup.part.0+0x58/0x27c
>>> [   56.290128]
>>> [   56.290128] but task is already holding lock:
>>> [   56.295970] e9e2b842 (&gsm->mutex){+.+.}, at:
>>> gsm_cleanup_mux+0x9c/0x15c
>>> [   56.302699]
>>> [   56.302699] which lock already depends on the new lock.
>>> [   56.302699]
>>> [   56.310884]
>>> [   56.310884] the existing dependency chain (in reverse order) is:
>>> [   56.318372]
>>> [   56.318372] -> #2 (&gsm->mutex){+.+.}:
>>> [   56.323624]        mutex_lock_nested+0x1c/0x24
>>> [   56.328079]        gsm_cleanup_mux+0x9c/0x15c
>>> [   56.332448]        gsmld_ioctl+0x418/0x4e8
>>> [   56.336554]        tty_ioctl+0x96c/0xcb0
>>> [   56.340492]        do_vfs_ioctl+0x41c/0xa5c
>>> [   56.344685]        ksys_ioctl+0x34/0x60
>>> [   56.348535]        ret_fast_syscall+0x0/0x28
>>> [   56.352815]        0xbe97cc04
>>> [   56.355791]
>>> [   56.355791] -> #1 (&tty->ldisc_sem){++++}:
>>> [   56.361388]        tty_ldisc_lock+0x50/0x74
>>> [   56.365581]        tty_init_dev+0x88/0x1c4
>>> [   56.369687]        tty_open+0x1c8/0x430
>>> [   56.373536]        chrdev_open+0xa8/0x19c
>>> [   56.377560]        do_dentry_open+0x118/0x3c4
>>> [   56.381928]        path_openat+0x2fc/0x1190
>>> [   56.386123]        do_filp_open+0x68/0xd4
>>> [   56.390146]        do_sys_open+0x164/0x220
>>> [   56.394257]        kernel_init_freeable+0x328/0x3e4
>>> [   56.399146]        kernel_init+0x8/0x110
>>> [   56.403078]        ret_from_fork+0x14/0x20
>>> [   56.407183]        0x0
>>> [   56.409548]
>>> [   56.409548] -> #0 (&tty->legacy_mutex){+.+.}:
>>> [   56.415402]        __mutex_lock+0x64/0x90c
>>> [   56.419508]        mutex_lock_nested+0x1c/0x24
>>> [   56.423961]        __tty_hangup.part.0+0x58/0x27c
>>> [   56.428676]        gsm_cleanup_mux+0xe8/0x15c
>>> [   56.433043]        gsmld_close+0x48/0x90
>>> [   56.436979]        tty_ldisc_kill+0x2c/0x6c
>>> [   56.441173]        tty_ldisc_release+0x88/0x194
>>> [   56.445715]        tty_release_struct+0x14/0x44
>>> [   56.450254]        tty_release+0x36c/0x43c
>>> [   56.454365]        __fput+0x94/0x1e8
>>>
>>> Avoid the warning by doing the port hangup asynchronously.
>>
>> Any comments?
> 
> I did not manage to reply before vacation, and after having "work =
> NULL" in my head, I forgot, sorry.
> 
> At the same time, I am a bit lost in the lockdep chain above. It mixes
> close (#0), open (#1) and ioctl (#2), so how is this a "chain" in the
> first place?

The close is from my cmux program, that configured the line discpline.

The open could be from my other process reading the virtual tty 
(gsmtty1)? Or is it a lock taken during the opening of the physical tty?

Can the ioctl call used to configure the line discipline take a lock 
that is not released until the line discipline is changed back?

> BTW, do you see an actual deadlock? And what tty driver do you use for
> backend devices? I.e. what ttys do you set this ldisc to?

After the first deadlock, I can use the UART, and configure GSM0710 
multiplexing again, but the virtual tty's don't work:

   root@iwg26:~# cat /dev/gsmtty1
   cat: can't open '/dev/gsmtty1': Protocol driver not attached

This is on an i.MX6 ULL using its imx uart driver 
(drivers/tty/serial/imx.c).

> See also the comment below.
> 
>>> Signed-off-by: Martin Hundebøll <martin@geanix.com>
>>> ---
>>>    drivers/tty/n_gsm.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
>>> index d30525946892..36a3eb4ad4c5 100644
>>> --- a/drivers/tty/n_gsm.c
>>> +++ b/drivers/tty/n_gsm.c
>>> @@ -1716,7 +1716,7 @@ static void gsm_dlci_release(struct gsm_dlci *dlci)
>>>            gsm_destroy_network(dlci);
>>>            mutex_unlock(&dlci->mutex);
>>>    -        tty_vhangup(tty);
>>> +        tty_hangup(tty);
>>>              tty_port_tty_set(&dlci->port, NULL);
> 
> I am afraid there is changed semantics now: the scheduled hangup will
> likely happen when the tty in tty_port is set to NULL already, so some
> operations done in tty->ops->hangup might be a nop now. For example the
> commonly used tty_port_hangup won't set TTY_IO_ERROR on the tty and
> won't lower DTR and RTS on the line either.

Is the hangup for the physical uart (ttymxc0), or the virtual ttys 
(gsmtty1)? In the latter case there wouldn't be any control lines to reset.

Thanks,
Martin
