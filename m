Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCEFC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D7522CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfIDITF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:19:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55778 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfIDITE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:19:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id g207so2213306wmg.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 01:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wXlhTHnCqCuoS2oZOppVtx2C0vLH0wnifUMnQtFNdrw=;
        b=ZznL0+wCy9mDEamIk82dUbMr4JhTw8jBTe/6+kyVnTLpJmnYojGSc6v7vS6ZqJzF6W
         b7ipmLKP3stIiJxSkmURI28Pit++EUK+QHtK1LVF3ZaSVj9Gc5lLp3AW4czmCyCudHhV
         IUEyurkkMFEn/O1ldFHtV5r7YhqBHhMm8Rsnyho+zk5CI7ddkfPxKJnZH3AKtjMgclOn
         GX7c+A6VybsRxBLHWqeJP3RO+nj2TPxbQol1SlrYTiTTLhVYV6PzY9tX+F7MpSRMOQYC
         qzvbBaBS1jz+f87j+VV5PVFm3JbVHDfliHmToxltutvLOXXlcgmc4JCKmHe66OIlxwjR
         0AXg==
X-Gm-Message-State: APjAAAU+AwqfrjDtFnzqp4RGxxlgb6nJoOt9XkR7eWBxTSCQRaNLDeHq
        sM787/jhHWHLQUESwEIM/0to93rm884=
X-Google-Smtp-Source: APXvYqzvK/DYD26ehAagOvlGSkySEFHZUGrHkiV5FMaKX+/gG8fu3v81exkklRhW7Bn77Tz6OkH0QA==
X-Received: by 2002:a1c:6a0a:: with SMTP id f10mr3208579wmc.121.1567585141750;
        Wed, 04 Sep 2019 01:19:01 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id j18sm16173614wrr.20.2019.09.04.01.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 01:19:00 -0700 (PDT)
Subject: Re: [PATCH] tty: n_gsm: avoid recursive locking with async port
 hangup
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Esben Haabendal <esben@geanix.com>,
        =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean@geanix.com>
References: <20190822215601.9028-1-martin@geanix.com>
 <4fd2d737-14a8-6fe6-16a1-c5e6d924f9e6@geanix.com>
From:   Jiri Slaby <jslaby@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a1c42b28-6e00-7c1f-9e4b-cf089c17e050@suse.com>
Date:   Wed, 4 Sep 2019 10:18:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4fd2d737-14a8-6fe6-16a1-c5e6d924f9e6@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29. 08. 19, 21:42, Martin Hundebøll  wrote:
> On 22/08/2019 23.56, Martin Hundebøll wrote:
>> When tearing down the n_gsm ldisc while one or more of its child ports
>> are open, a lock dep warning occurs:
>>
>> [   56.254258] ======================================================
>> [   56.260447] WARNING: possible circular locking dependency detected
>> [   56.266641] 5.2.0-00118-g1fd58e20e5b0 #30 Not tainted
>> [   56.271701] ------------------------------------------------------
>> [   56.277890] cmux/271 is trying to acquire lock:
>> [   56.282436] 8215283a (&tty->legacy_mutex){+.+.}, at:
>> __tty_hangup.part.0+0x58/0x27c
>> [   56.290128]
>> [   56.290128] but task is already holding lock:
>> [   56.295970] e9e2b842 (&gsm->mutex){+.+.}, at:
>> gsm_cleanup_mux+0x9c/0x15c
>> [   56.302699]
>> [   56.302699] which lock already depends on the new lock.
>> [   56.302699]
>> [   56.310884]
>> [   56.310884] the existing dependency chain (in reverse order) is:
>> [   56.318372]
>> [   56.318372] -> #2 (&gsm->mutex){+.+.}:
>> [   56.323624]        mutex_lock_nested+0x1c/0x24
>> [   56.328079]        gsm_cleanup_mux+0x9c/0x15c
>> [   56.332448]        gsmld_ioctl+0x418/0x4e8
>> [   56.336554]        tty_ioctl+0x96c/0xcb0
>> [   56.340492]        do_vfs_ioctl+0x41c/0xa5c
>> [   56.344685]        ksys_ioctl+0x34/0x60
>> [   56.348535]        ret_fast_syscall+0x0/0x28
>> [   56.352815]        0xbe97cc04
>> [   56.355791]
>> [   56.355791] -> #1 (&tty->ldisc_sem){++++}:
>> [   56.361388]        tty_ldisc_lock+0x50/0x74
>> [   56.365581]        tty_init_dev+0x88/0x1c4
>> [   56.369687]        tty_open+0x1c8/0x430
>> [   56.373536]        chrdev_open+0xa8/0x19c
>> [   56.377560]        do_dentry_open+0x118/0x3c4
>> [   56.381928]        path_openat+0x2fc/0x1190
>> [   56.386123]        do_filp_open+0x68/0xd4
>> [   56.390146]        do_sys_open+0x164/0x220
>> [   56.394257]        kernel_init_freeable+0x328/0x3e4
>> [   56.399146]        kernel_init+0x8/0x110
>> [   56.403078]        ret_from_fork+0x14/0x20
>> [   56.407183]        0x0
>> [   56.409548]
>> [   56.409548] -> #0 (&tty->legacy_mutex){+.+.}:
>> [   56.415402]        __mutex_lock+0x64/0x90c
>> [   56.419508]        mutex_lock_nested+0x1c/0x24
>> [   56.423961]        __tty_hangup.part.0+0x58/0x27c
>> [   56.428676]        gsm_cleanup_mux+0xe8/0x15c
>> [   56.433043]        gsmld_close+0x48/0x90
>> [   56.436979]        tty_ldisc_kill+0x2c/0x6c
>> [   56.441173]        tty_ldisc_release+0x88/0x194
>> [   56.445715]        tty_release_struct+0x14/0x44
>> [   56.450254]        tty_release+0x36c/0x43c
>> [   56.454365]        __fput+0x94/0x1e8
>>
>> Avoid the warning by doing the port hangup asynchronously.
> 
> Any comments?

I did not manage to reply before vacation, and after having "work =
NULL" in my head, I forgot, sorry.

At the same time, I am a bit lost in the lockdep chain above. It mixes
close (#0), open (#1) and ioctl (#2), so how is this a "chain" in the
first place?

BTW, do you see an actual deadlock? And what tty driver do you use for
backend devices? I.e. what ttys do you set this ldisc to?

See also the comment below.

>> Signed-off-by: Martin Hundebøll <martin@geanix.com>
>> ---
>>   drivers/tty/n_gsm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
>> index d30525946892..36a3eb4ad4c5 100644
>> --- a/drivers/tty/n_gsm.c
>> +++ b/drivers/tty/n_gsm.c
>> @@ -1716,7 +1716,7 @@ static void gsm_dlci_release(struct gsm_dlci *dlci)
>>           gsm_destroy_network(dlci);
>>           mutex_unlock(&dlci->mutex);
>>   -        tty_vhangup(tty);
>> +        tty_hangup(tty);
>>             tty_port_tty_set(&dlci->port, NULL);

I am afraid there is changed semantics now: the scheduled hangup will
likely happen when the tty in tty_port is set to NULL already, so some
operations done in tty->ops->hangup might be a nop now. For example the
commonly used tty_port_hangup won't set TTY_IO_ERROR on the tty and
won't lower DTR and RTS on the line either.

>>           tty_kref_put(tty);

thanks,
-- 
js
suse labs
