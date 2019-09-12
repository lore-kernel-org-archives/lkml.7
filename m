Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B179DC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8642081B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="U+948HHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732705AbfILOfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:35:30 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46578 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732444AbfILOfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:35:30 -0400
Received: by mail-oi1-f196.google.com with SMTP id v16so384574oiv.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Io9DNJGsYP/EoLiKkjBJ1rL6MkBN0phNsCUNsDEUxEA=;
        b=U+948HHkOKyR9d/hZ4xXOolDklm6ZxogihkXVaQXIlZ2Jp0xAfPiOiDR1eeKLcxhsb
         5Ay9oW8x4gAF/ScNXFJ5/uAfJF+x96sJU8OdlshGaW/ZPcVv2a7utPAsbHVt+K7wGEci
         YUXtY8qTKYk7tEFBAN1BU43HEsU51Txu+WY53MJcV8TMBMcRyutk9IeYeB1U6/3OlFCH
         mfYbjUizrBISPJmIzcvtuPtT0BpSFs641NcVqIFAcIqAXsmFg3PhladJynRdijim3v/X
         gt+S7+ZPfO6uJ3ZlnHessp7AGmoSuDuPfxVxgNmgtymXoTgmvpzeZhtJHNboAqN989Wf
         4Z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Io9DNJGsYP/EoLiKkjBJ1rL6MkBN0phNsCUNsDEUxEA=;
        b=fYEBydnW9DjCsn+FAcqVoZ8esBtf09jWU8+8OOHsVBriwDFk3UFRjYwdzja4L/1+zo
         B4SNiljo7AOWXJ0Sn7t9YEZbPRYoM90l96ZS6HwU2fZMmQ5JKyjMCK+iDtGQD9eniK6H
         sNwSXnPjWv0+DIyQ+STr97u844H125ijo0GBjOuflpmSMpuQMJRE2N48dOCIVTQHEQUp
         wmfu9xzmFLhJW87DAZnuJD6YYJNkcxH0E/+S8RMlI7iOvoX/AH3WSg5erKReenLyIVvY
         LmHBUxrUOnjV2+mfq2WG2tMHXFFTz5+jXvZ9EUbg+9lXM4qt2/27wOAcvVpi8oPg5cSy
         Kd7Q==
X-Gm-Message-State: APjAAAUDqUjRZ3okjE0XoPniJK5HjV/b33ptlWBBM1TjC9wfP/p0c01n
        wmmBHgfaMm+/TVZx1mfgXcXpt6m6qBBqU+trW08Ywg==
X-Google-Smtp-Source: APXvYqzD2zpg+CObBviUAPj5DEJdMDbUroz5eIu/ODnjvin5v1n6Ap2TxZcFLLZZWfJmGy580oftPSIZHc19EMV+U8Y=
X-Received: by 2002:aca:1b11:: with SMTP id b17mr380825oib.0.1568298929503;
 Thu, 12 Sep 2019 07:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568256705.git.joe@perches.com> <x498sqtvclx.fsf@segfault.boston.devel.redhat.com>
 <16d91aa0-e353-843b-2e94-efd5a26e145d@suse.de>
In-Reply-To: <16d91aa0-e353-843b-2e94-efd5a26e145d@suse.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 12 Sep 2019 07:35:18 -0700
Message-ID: <CAPcyv4hhZZ558baVow9HdGbjFupg6xjyT-Zpvjs99neDwOPA9A@mail.gmail.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Jeff Moyer <jmoyer@redhat.com>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 7:06 AM Johannes Thumshirn <jthumshirn@suse.de> wrote:
>
> On 12/09/2019 16:00, Jeff Moyer wrote:
> > I'd rather avoid the churn and the risk of
> > introducing regressions.  This will also make backports to stable more
> > of a pain, so it isn't without cost.  Dan, is this really something you
> > want to do?
>
> I'm a 100% with Jeff on this!

Agree, see my other response here:

https://lore.kernel.org/r/CAPcyv4iu13D5P+ExdeW8OGMV8g49fMUy52xbYZM+bewwVSwhjg@mail.gmail.com/
