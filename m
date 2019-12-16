Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C5CC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91B42054F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="ccxiepF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfLPTE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:04:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53367 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLPTE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:04:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id m24so468191wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 11:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=HreaAo5M8CvrtSZKWU6iORgOZbccygQ9kHqwUNDqXjI=;
        b=ccxiepF0PZaIoCnbZMhHhtJVOJcDoDnpLsxQq2Esi4Fys3z+5aEPwmptpCD0CXXepi
         7RvXNuEQP5thW6W1dktFf4keY9zSrrHC27sWYeX/e1xZtzYxY+AvE36sDkY6IvsFpwuH
         NihoZ2SeHO0cr54rSEEcrI70oSHPNzQaJnjr+6ryzEM38B/C+c2f4XEZE07Ftb3u0uyK
         HxMsFwnvLzkX5zPDoWwI36JV0EVKNbkPAGVVapuxP+DHtCUIisfibvTdsXGMie/cntoC
         7dmXTmrJGzBAq/gTATNOO4zUAf0hdaOY4qm9TilcU/ERNhlhi4C5apvQZkVzQc959f9d
         8b6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HreaAo5M8CvrtSZKWU6iORgOZbccygQ9kHqwUNDqXjI=;
        b=kVTLQiDO8+zBhmiARldw2wWcZvS+O7B6BKDuhlhpEqYgHOTyOFVxIf2dEe7iR/CCbN
         SuMyYhjeEGYRxoZfoAk5b38ShUYOKNPvSTjoomcbR46tT9DtXPPlRdQUUMO3EoJ9Er7r
         eWtzijsRtEs4oXDIQZH8R52XqZTCZ01EFbMy0jkEI8KcFVwc6NPQPPtaNoS9MS3yIeIc
         5HO/9FMc+Io/N1z+YYxlUGaq+yOWJkeG/rlDF8aLgBQPjs1ya4SFes30R61DygTI4pBw
         mN5CTv2wiLg+YXjygqDFXwfOxlQxvwgRad2f/clk3bTLm1yrxvSt+a2p82H/HVCt7LBl
         M8Dg==
X-Gm-Message-State: APjAAAUh6LRNehQR18smx/FjCohOTbV2crbiEnH5Fq4c2wCKa+zcHxla
        MIWc80rKKwcZ7ZERzyufA1fEKWIEsUE=
X-Google-Smtp-Source: APXvYqx+Ds7ZcBGn0IHVNSpsgby08zvIWR/pPsSMl2BjkbtPwtv6wZ2+KM7qroHlkY+u0FBv4vpC+A==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr580143wmi.10.1576523096098;
        Mon, 16 Dec 2019 11:04:56 -0800 (PST)
Received: from linux.fritz.box (p200300D9970662004EE5DE74B236A15C.dip0.t-ipconnect.de. [2003:d9:9706:6200:4ee5:de74:b236:a15c])
        by smtp.googlemail.com with ESMTPSA id w20sm308960wmk.34.2019.12.16.11.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 11:04:54 -0800 (PST)
Subject: Re: [PATCH] Revert "ipc,sem: remove uneeded sem_undo_list lock usage
 in exit_sem()"
To:     Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>,
        akpm@linux-foundation.org, herton@redhat.com, arnd@arndb.de,
        catalin.marinas@arm.com, malat@debian.org, joel@joelfernandes.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        jay.vosburgh@canonical.com, ioanna.alifieraki@gmail.com
References: <20191211191318.11860-1-ioanna-maria.alifieraki@canonical.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <d66d41fe-212f-effd-905a-5966a96ddb6e@colorfullife.com>
Date:   Mon, 16 Dec 2019 20:04:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211191318.11860-1-ioanna-maria.alifieraki@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ioanna,

On 12/11/19 8:13 PM, Ioanna Alifieraki wrote:
> This reverts commit a97955844807e327df11aa33869009d14d6b7de0.
>
> Commit a97955844807 ("ipc,sem: remove uneeded sem_undo_list lock usage
> in exit_sem()") removes a lock that is needed.

Yes, you are right, the lock is needed.

The documentation is already correct:

sem_undo_list.list_proc: undo_list->lock for write.

[...]
> Removing elements from list_id is safe for both exit_sem() and freeary()
> due to sem_lock().  Removing elements from list_proc is not safe;

Correct, removing elements is not safe.

Removing one element would be ok, as we hold sem_lock.

But if there are two elements, then we don't hold sem_lock for the 2nd 
element, and thus the list is corrupted.

> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1694779
>
> Fixes: a97955844807 ("ipc,sem: remove uneeded sem_undo_list lock usage in exit_sem()")
> Signed-off-by: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
Acked-by: Manfred Spraul <manfred@colorfullife.com>
> ---
>   ipc/sem.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/ipc/sem.c b/ipc/sem.c
> index ec97a7072413..fe12ea8dd2b3 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -2368,11 +2368,9 @@ void exit_sem(struct task_struct *tsk)
>   		ipc_assert_locked_object(&sma->sem_perm);
>   		list_del(&un->list_id);
>   
> -		/* we are the last process using this ulp, acquiring ulp->lock
> -		 * isn't required. Besides that, we are also protected against
> -		 * IPC_RMID as we hold sma->sem_perm lock now
> -		 */
> +		spin_lock(&ulp->lock);
>   		list_del_rcu(&un->list_proc);
> +		spin_unlock(&ulp->lock);
>   
>   		/* perform adjustments registered in un */
>   		for (i = 0; i < sma->sem_nsems; i++) {


