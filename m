Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68408C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B80F2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiWbXQlU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbfB1NA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:00:27 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36196 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732021AbfB1NA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:00:26 -0500
Received: by mail-ua1-f66.google.com with SMTP id e15so17578122uam.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NicHpirE+8kSZp6bEH0qrk0aMy2RfvuagIUhqS/V9Q=;
        b=eiWbXQlUUVV2nEo31MmQAV92htVJeMq3sqmBodJNwQMQfIyHpceRcYge5YXHKeACZ5
         fht43RAEKrawbeKp1gng9rMTZEyRVyB5EqZrEnbMfPcS1XNvPAc+QsZ7JgtoOiB5vUSW
         NOVcmrvGZptCZ2BsjWxvivMB1YG+OHzr0QfAXkPQeGOZ5G7J3ileZlQEOIL8NFylOK0G
         r4oQ3oDvSwHj1QsQq7K+0HkX283jrPnOQAv9gfrJDF7DObQ3i6xCFpNl+xTzt1ATr77+
         zwlNuYgkIarf8Ag9W5V4HntVudIu5P0clOQJzpkveuTwv6kohoJ7eqnyR+KgBd6SvXqI
         cGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NicHpirE+8kSZp6bEH0qrk0aMy2RfvuagIUhqS/V9Q=;
        b=AwwTFLncKtqxDcPW9Ajb/W2oW0j/GODsx4Ot3tB5yNnUJdLPYTMjiLtXm9qLfs+4AI
         5GuGhgNs2XUjhVbLIxNrcdWxJk81aDYV2sT2FNePPQx5yNpAjPkEgaSprCryin57WAM7
         I/z006oszUJKERHc98dSYw51k4E8BM28gLftCV6hScW/H04q/wRutRTvMSig2ACKsuuV
         /kogpWeDmWxCsIFx0duOgBltOd71RimxRdfBuba/TiB1AZOYOjoE+QXVbwIvkm/Vum4q
         iw8FcGND0HuCe/Rs9RrkZ4jeC3UH8MRM2lo7KuOu3qw07JzK14tvqVb2ib8yb2/iQf9Y
         xJPw==
X-Gm-Message-State: AHQUAuYfTgkvZZ7ERw8uzC3ILCcmkaj1j786WMc6Qb9Gi28pbBFaAV5R
        BhGCOuMJe8rQY/GMmu43zDjbCOH/G6k0V6AfVl4lsg==
X-Google-Smtp-Source: AHgI3IYXh9NY0rRxqkeBoSHls48sqagXOUPaTJdGPsgae715Qn8zYd0//XEeID00PofcBRDfrEtMoRGNq7/TLZ2uHg0=
X-Received: by 2002:ab0:7292:: with SMTP id w18mr4831145uao.56.1551358825266;
 Thu, 28 Feb 2019 05:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20190228095545.30842-1-oded.gabbay@gmail.com> <20190228095545.30842-2-oded.gabbay@gmail.com>
 <20190228120150.GB7489@kroah.com>
In-Reply-To: <20190228120150.GB7489@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 28 Feb 2019 14:59:59 +0200
Message-ID: <CAFCwf11AGfyGitSQ5QROWRvZL4g94aXs7v9cmGFYcUvjTkY34Q@mail.gmail.com>
Subject: Re: [PATCH 11/15] habanalabs: print pointer using %p
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 2:02 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 28, 2019 at 11:55:45AM +0200, Oded Gabbay wrote:
> > Don't cast pointer to u64 to print it. Instead, print the pointer using
> > %p.
> >
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > ---
> > Changes in v2:
> >   - Add changelog in the commit message
>
> This isn't marked "v2" :(
Yes, sorry about that, will do better next time.

>
> Anyway, I'll try to piece this all together, next time it's easier to
> just resend the whole series...
Got it,
Thanks,
Oded
>
> greg k-h
