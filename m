Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE43C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D27A218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptIE6cLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbfB1JsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:48:03 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39404 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfB1JsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:48:03 -0500
Received: by mail-ua1-f68.google.com with SMTP id s15so18256062uap.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 01:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Qg42lEb92IAFtEM163V3IbIWP2EydgJg/Abq5iGNqM=;
        b=ptIE6cLmEsjwglLkzHm84BELBoscHobXcahmFGODBiSV5Dub0DxvCKOLzgeFqeDRBk
         wxgniaCEjiKXDuD9oWLSftiowNnZR8zzWWq5FFTkTY2GGhAvezSA3HBHX5pXdvyuJdBY
         Ljd5nTGASR4qDUh6b4Lz2Mbj/CJuf1635xv0eS7vUHTAP2gmEiFpy8CR16igl64PqJLO
         tqhsouJwQhRo97Qnk+e97xfNqp2IFMc6hNalYXctB1ne6vwb/Rp4UW68vUix2E57NwGq
         1Bv1ezBucSfzlVLhafJ0uRiog/PO0toKcO/DbtZ1epPCJ6x0+2WfK3THL4dCkXFJ59b/
         h9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Qg42lEb92IAFtEM163V3IbIWP2EydgJg/Abq5iGNqM=;
        b=OPMsvCoOkaRzPAjiqCGJmh7lfvHDmZPEFfGg1mr0LdJIisv9HJkFJKz4R5L9IphJ5z
         YiJoBZoBWIOpGWmnX4dzOtgXNS6nm+On7ds1F6+5bqaomSmC2M5KMnQ1UYTfcc5qB2kd
         nyiWmXdJe+r+bu4dLpoWmhXVO8obX51paa1CQD+nXpKoCFRspCw4OZrw7WS17TIm9z/F
         jGKJDY+FOpQERiN3QO8e4B15xpvYnKl0ff35FajEof16J1S1wbNYxS55GPxOt2sP7Pds
         dfkMkaH7BQhpt5p/pxRgSN3K9JVruano96kGEa6TkZhEfFKBr9aQZ210cmWRG1Q4aMWB
         Nb1A==
X-Gm-Message-State: AHQUAuYnf86XE/wzQ3yqGyDmg0e8/fF8Rw/FeorAZ3pYgPhS5u/+pymG
        oT3K1OwIgIwYDbV96a/72Ay2JcQWX3vSNCrJUOMtLg==
X-Google-Smtp-Source: AHgI3IbieWuFzWBVrJAOMs70fBWl4NgvXptn9ixvMXAmcWkYCRhKxU0tU+8PZK7k8NifnV/8FzA0qjwBCGhEaWu+IvE=
X-Received: by 2002:a67:6849:: with SMTP id d70mr4339854vsc.61.1551347282008;
 Thu, 28 Feb 2019 01:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20190228084624.25288-1-oded.gabbay@gmail.com> <20190228084624.25288-12-oded.gabbay@gmail.com>
 <20190228093140.GA32514@kroah.com>
In-Reply-To: <20190228093140.GA32514@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 28 Feb 2019 11:47:35 +0200
Message-ID: <CAFCwf12GCWn-xJHcCU=Fk4eY9s=zRz0bvEW0nU4OVSd=kQCTKg@mail.gmail.com>
Subject: Re: [PATCH 11/15] habanalabs: print pointer using %p
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:31 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 28, 2019 at 10:46:20AM +0200, Oded Gabbay wrote:
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
>
> I can't take patches without any changelog text :(
>
ah, didn't know it was required for even this trivial change.
I'll resend this and another patch that is without commit message.

Oded
