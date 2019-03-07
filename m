Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396BFC10F10
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 04:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012CF20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 04:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E6QVJZDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfCGEZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 23:25:02 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44332 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfCGEZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 23:25:01 -0500
Received: by mail-io1-f65.google.com with SMTP id y13so12279690iop.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 20:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5JAUl0FVB+VVNf0yhyK9ff2iEsW2J8uCrHoT4H8zsA=;
        b=E6QVJZDS+1GrR0e5Pm5ScO1W5W3c789MRjV82HXBP/8Lx1Ynk5/0BHYXahFRaOd2rY
         YJt4rn56we9ewblS/uhEQzrfHV/Sdpv3nxCbdeqNMz4yhcPGB4fNMfCA3LwQ+ujz+Hf0
         sCDFXo6P3lxdKL1UiOgC09AZV7lvL1XdBJTG8APy37gUcc2pgk1irnnd1zJrT0G+7Jw+
         Jl9e5ys3gsomLlB09u22GOTnsrtz5HzmhP3D9FONnQXqE8mzeCraHvPj/zyQj/0uOKB5
         POAWdfH1FQFen+Xi/AlWCZVW9VQeskLaKPHajs/+uDTxjsN+mj7hrbwYpeo5WudcVzmE
         mphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5JAUl0FVB+VVNf0yhyK9ff2iEsW2J8uCrHoT4H8zsA=;
        b=fFJoUqzVrjA3CY+hOzM7szUfrF8nEfmr/zgzAeAHPuXeF0XZXxrKM4iX12XN07aKUI
         oooDk2pBSAqrNAjBxvF5Q1mwYhvqVOReYwOuIf3BZMGfC6xMqUd6iB/Xa4mt86WTivHn
         ju/UPo0ZGPtkMjhePbFRl1B7PqoGtyAVjDyGv7+ZW/cL0U/Hu/5HOeCcG4ewiserYhst
         j/D3Y2o6PryWOfx4XIW9qejwO/G0k+58tVNONTqOXhv+PYWAcyimq5usqY3aggt9QfOg
         qfaRkShanbDXsanrr/HOyTdyGGQoQuQBni8ZZ/riLS17DlQy9aaed6wSYSbFMrzhtJAM
         DnRQ==
X-Gm-Message-State: APjAAAXd493Wo0uxT1dq6y0j298PQTwsIX0lGj6EiR1u6SI1ggEFplCD
        iN3RZOFeSucu9XOO6tLbVO96uhN0fQMW2qqnpoZZDw==
X-Google-Smtp-Source: APXvYqwsQqeejPjsiArIHEFwgAhFD8OLr63TXCyxa6kBq6FS1ggXb8k7TDsl0iE7/2PTRLbZhoT+OFDlfaFJ6+G9cd8=
X-Received: by 2002:a5d:9254:: with SMTP id e20mr5358753iol.88.1551932700449;
 Wed, 06 Mar 2019 20:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com> <1551930990.31706.279.camel@linux.ibm.com>
In-Reply-To: <1551930990.31706.279.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 6 Mar 2019 20:24:49 -0800
Message-ID: <CACdnJuuib7kYEw1o0Bh1p=X+MmJH+pqupECWnWTJ2e2jE2XRkg@mail.gmail.com>
Subject: Re: [PULL REQUEST] Kernel lockdown patches for 5.2
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     jmorris@namei.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 7:56 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> The kexec and kernel modules patches in this patch set continues to
> ignore IMA.  This patch set should up front either provide an
> alternative solution to coordinate the different signature
> verification methods or rely on the architecture specific policy for
> that coordination.

Hi Mimi,

I'm working on a patch for this at the moment which can then be added
to either patchset. Is there a tree that contains the proposed Power
architecture policy? I want to make sure I don't accidentally end up
depending on anything x86.
