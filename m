Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE81C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FC520989
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuXvBtYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfEJJsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 05:48:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46531 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfEJJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:48:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id f37so4543038edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=BmS+YypmTH70NsRGDtlhScKeOjsqeldkuJn7h8AAN6c=;
        b=cuXvBtYbowHAlEPUTiQUTRleTW6shxpAvzPebDGFO0ru7nxN3G+8tX+gUwr6KqEZYh
         8zXUQqcbGWyQxwp6TzfrFzJzlF/NHyVOcY31l5WmzJgU/dSONGbTjqeQZX0L2gjOjJTo
         geF4IZHqzOpNZszfVl6YIgnEWnWVDvZfWHOjSz62tYxRSN7vo7+qK9BnTfj8hFT+k3pC
         0lw98VmvoYUNn6WUBzNs14DSSKHyabeDHgGhpiYiJbwxHIiOvrsrijzuep35p/Vsx6h9
         UzxcMhhAeUvHvTtRNm/W6OP+kjCBRz/ETg+XoRMrKzrEDtgjib9J9mSDngZkDbS+8BBm
         SrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=BmS+YypmTH70NsRGDtlhScKeOjsqeldkuJn7h8AAN6c=;
        b=PpCVzQ+ep6LlV+/wxrHa2a//dkvyQHTPyTqP7ft8XAvcO1TCbfghUtujsCdh8ZdrJg
         LbvDXidXwDA81xP5OISVwUyb6XDNStK1A9XYEfgWNslgHqfeBrtkkXU3UqFL9J0zvcYU
         zfPM2XtS+j75bRICnUBS5gX+oWIIy5mBF5Pir4iEVnUyP8yzqyKWlQGXLMvuIydHMSoK
         3PjrbjNxV62A89Lq5jLfTvleo3lTKSUSoXjbgEBJ85UnL363dU2s4fglMQyCFZjpg7vJ
         wNanossVkr0QNrO+4K43Cfd9Yp3berhMSwEG6Fz6fNYERQrTAmmwPPmVML0/LG23a37L
         vkdg==
X-Gm-Message-State: APjAAAXFagEuGOQj2gEaryx5nsgQQUhFxyvCAjZ6HlYzGicDLRyU9via
        Y5VmOwmH5xEsY/7K7X0GF+i5ZppTzU8=
X-Google-Smtp-Source: APXvYqyjzXIRVVWmITXFTDZUL5xGIiCwXuBtZWZd4wR+9isCZ0p2Yrs1EyP5Mecs+ps1R8B6u1NRNg==
X-Received: by 2002:a50:d2d4:: with SMTP id q20mr9928677edg.120.1557481703345;
        Fri, 10 May 2019 02:48:23 -0700 (PDT)
Received: from [192.168.178.43] ([88.130.159.71])
        by smtp.gmail.com with ESMTPSA id o34sm1289914eda.97.2019.05.10.02.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 02:48:22 -0700 (PDT)
Date:   Fri, 10 May 2019 09:44:53 +0000 (UTC)
From:   Roderick <hruodr@gmail.com>
To:     Poul-Henning Kamp <phk@phk.freebsd.dk>
cc:     linux-kernel@vger.kernel.org, misc@openbsd.org,
        freebsd-current@freebsd.org
Subject: Re: Danish FreeBSD Developer hates jews collectively
In-Reply-To: <2052.1557444762@critter.freebsd.dk>
Message-ID: <alpine.BSF.2.21.9999.1905100843270.999@fbsd.local>
References: <49cfcff55fe21d5d01df916e9f9531f1@redchan.it> <2052.1557444762@critter.freebsd.dk>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Poul-Henning!

I do get your point. I do not think you are an antesimite. I would think
the opposite: most antisemites hide behind their israel-friendliness.

I appreciate your involvement on what is happenning in the near east.
From the end of WWI the situation of the palestinians got only worse
and worser, and with the last developements, faster.

You got it, it was not a skilled use of twitter, but unfortunately
not only that: you made some errors. It is perhaps not your guilt,
because these errors are promoted by the israeli propaganda.

From the very beginning there was jewish oposition to the zionist
enterprise, due to different reasons, from so called secular jews
and from religious ones. Many as radical as the most radical
palestinian. In the internet era this should be clear to you:
I suppose you are new in the thema. This is why one cannot
use the word "jews" to name a party in the conflict, unless in a
very restricted context. The AIPAC is not a jewish political lobbying
organization, but a zionist one, a israeli one.

The zionist propaganda always told that all jews are behind israel,
that they represent all jews, it equates zionist with jewish, and
opposition to zionism with antisemitism. It seems you fell in their
trap.

The other error is perhaps to consider jews as a religious group,
that they freely chose to be that: it is irrelevant in the context
of the conflict. Arabs see them as a religious group, but zionists,
antisemites and perhaps most europeans see them as a people.
But even among them there are discussions about it (Shlomo Sand). I
once met a very anti-israel jew that very proudly considered her
ethnicity as "ashkenazy". How they define their collective identity
is mainly their issue.

As said, I appreciate your involvement, but I think you were also
not prudent. While these guys kill without scrupples in the near east,
hidden behind heavy weapons, elsewhere their favourite weapon even
against the most weak opposition is diffamation.

Best regards
Rodrigo


On Thu, 9 May 2019, Poul-Henning Kamp wrote:

>
> You forgot to include this link:
>
> 	http://phk.freebsd.dk/sagas/israel/
