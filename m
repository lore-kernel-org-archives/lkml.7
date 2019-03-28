Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296EDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA59206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smkGQZIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfC1RIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:08:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44424 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfC1RIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:08:48 -0400
Received: by mail-qt1-f193.google.com with SMTP id w5so23909622qtb.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qd0t00eC2iONuirdaj+w0zePjQU67FNRgdalc2QG/ew=;
        b=smkGQZIfUdf8DLhjPEu/U/ToZj4WmH6Z8k2l4BH3th9CJAbRIhUVJRvoZN4qITUR2q
         PwmOMtkwqpHrW+a7aqtk1ZYNaWhQE333A17h4eDgSB47wS41uquXV7p9sm9SjFbwMkb+
         lBqhXm6f3KEC+ROYcljg24f9nJm/n18Y88sjaIZNugcIRR2xyVje8x0OjtKTZNnnZ+N9
         Oq4+4S8DPKjqc+9g0Wfo1aB5N3vuaQD7adPUUPNcI9/NE1lcWhNEfIuk4D8cLUY6ZDjN
         kScEIaIALkqpFy01q6JnmgjIDv3xuKe6rp98M8wJLtdA8RPVK7QzLhQmnvga2RbK6aX3
         HFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qd0t00eC2iONuirdaj+w0zePjQU67FNRgdalc2QG/ew=;
        b=JemP4TDJmHI04BM38eLlORMQKkgNbj1UQB4CMCN1tCEWme/PqvRLbM3P6wX2TpKVYg
         w6ihLIhpPL3VYpboby2wQ/kPYhMGfCQ9XFUbYIvotboWEfda95Vu+WpqXtzi/4y3aXxC
         oasH34Gg81wRecy+Ww+830+gjtlQ13lcQT8oRoEefb777cPWrF7bKKWrKEUtLAuiMHGT
         g9mfqmJoXOJe0iBPCKoR63oA8qFxBILXRs/CgkuPKLYB/GIFYweNLe5LsWGjke/2mSYL
         pq1hM9pBlZV9OhOY+qi2xYmJPhcv/aM1QmWPsLeLdKry2FWAsEJ3x3JVlmqp/jFswY/5
         X6WA==
X-Gm-Message-State: APjAAAXSMCb1KpzGKaEKfOvy+MdFIQ2tMH5Qu5VU+QDv/ltcO9piYWKK
        //0Prm2u0I4WeS/OaQRsucbH9LZHb/b2yZTZPOk=
X-Google-Smtp-Source: APXvYqzRHPDL0XKHPVzxDwLSdiloeJ1PA5f7Gqn9M/FfRO3hhGmC7zRjeRJufgig/9mHqfVc/tJ1q5jZyWRFtJ1SlqE=
X-Received: by 2002:a0c:bec4:: with SMTP id f4mr2459467qvj.17.1553792927732;
 Thu, 28 Mar 2019 10:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <1553648174-24913-1-git-send-email-v.mayatskih@gmail.com>
 <20190327164914.GE27283@stefanha-x1.localdomain> <CAGF4SLiKv06rzuGprfpWg-EOi8y+DW+cTybCkoT_9OoE+y8tcQ@mail.gmail.com>
 <20190328163647.GE18536@stefanha-x1.localdomain>
In-Reply-To: <20190328163647.GE18536@stefanha-x1.localdomain>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Thu, 28 Mar 2019 13:08:36 -0400
Message-ID: <CAGF4SLiZxXcWskZXmGbwO11MnwyMAK_Bpbn0ugZzK6jSMHdiog@mail.gmail.com>
Subject: Re: [PATCH] vhost: zero vhost_vsock memory on allocation
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 12:36 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:

> vsock->hash is only read if vsock->guest_cid has already been set and
> hence vsock->hash has been initialized too.  I don't see where the
> problem is.
>
> Was your tree missing commit a72b69dc083a931422cc8a5e33841aff7d5312f2
> ("vhost/vsock: fix uninitialized vhost_vsock->guest_cid")?
>
> Are you sure the crash can be reproduced on linux.git/master?

You are right: we hit it on 4.14.91 while the guest_cid fix was
backported in 4.14.93.
Thus not a real issue. Sorry for confusion, vhost is something still new to me.

> Sounds good.  Please send a v2 that also removes the explicit zero
> initialization since it's no longer needed with zalloc.

I changed my mind, all the rest is initialized explicitly, let's keep
it that way.
Will send the patch shortly.

-- 
wbr, Vitaly
