Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F995C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FF4206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552254745;
	bh=270oAS8jwhkTZYClGebtp4naBFwLokvfN7qNCMTBJZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bm5FrTgdfeIyW+mcHjA5IcUwfCPu3oj8W8+KcQn4iwKvnerVJhnx4Q3g7W+WD0j7R
	 n+LKXulVajsHQ7Q8EJYiUAmGj+eUrtRAUQkGi1lv9f7x1WfxAIHUxo5ZYqwDAXB7HQ
	 svQFvfILRikY0LOoJusbUea8dzVSD79JaAXqKQAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfCJVwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 17:52:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36198 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfCJVwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 17:52:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id 197so1950109lfz.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 14:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NyeJ7Cz7OVFFVWx5bQAkAfhDav0AeXJ87ovkml/Ry9o=;
        b=GGohqfGO+4FAdoxntll7ioOcao5K/rrK8kwyEUll3oPId7UrDO1pZ61E+WgCOxEzJJ
         x+1jhKsCXCA4/MqCXqP7zQxhHautgZC2JGwM+21sbJbLyFes0DwErKrjlcgIZYlOMJx1
         zZ7H7BNC4OEAFbX9Io0/M9/joAQq0FTQau9Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyeJ7Cz7OVFFVWx5bQAkAfhDav0AeXJ87ovkml/Ry9o=;
        b=MMPtLy7G7EA1azoxMwwMr7Bzg6pAytkOavABECUucYCBdVv+7KTdOAlz3+KRDiYkCZ
         9UDSCmKvWgDWzlKqIK3/rTJDIvUaTj3/9CwVOeGUZM1x5F9QTpZF7DnlpH7sZFhXOW6d
         TGcDI1D7xQQ9dSAp1cx2KJTXbTxAGseXK3XN20wvsTRpYpoEvXrYQdHE2okQcYpIntmA
         rH09i+LNgRtiRjYw0co69Rpa7y5W6WVlRuVUBvCoSyXZVcDNPJ3M2o/+OtH1oPH4n3fN
         2fpLzHCLjcD8qOCte58QsSKJtjNlFEVblfEQ6NpiAlcYk/puYm/DqPqpzTNvbd3whGbF
         G4ZQ==
X-Gm-Message-State: APjAAAWjJ4irXViF86vZECSqBi8SvLB34IBO+u0kvX6tKC6mUSsEHWHi
        GMglrEjcExSGZImlowReq3vgszG/GYc=
X-Google-Smtp-Source: APXvYqylWPAyN6D+mMjgFMwSCXYddAyBYp3w4ktwocaz80EcSXefUZU9Od/p7AZ2AY0SR5OQP+nvXQ==
X-Received: by 2002:a19:40c8:: with SMTP id n191mr2491132lfa.22.1552254740163;
        Sun, 10 Mar 2019 14:52:20 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id r18sm696652ljd.35.2019.03.10.14.52.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 14:52:19 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id h6so1952838lfc.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 14:52:18 -0700 (PDT)
X-Received: by 2002:a19:700e:: with SMTP id h14mr15359334lfc.67.1552254738370;
 Sun, 10 Mar 2019 14:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <155223448227.4075.6846910559654700796.stgit@buzz>
 <155223699287.4075.13184771244455866778.stgit@buzz> <9da44b6b-49c1-3383-e272-d61065f81de4@rasmusvillemoes.dk>
In-Reply-To: <9da44b6b-49c1-3383-e272-d61065f81de4@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Mar 2019 14:52:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj95tXzuox8eXPhBtJtV_NzWksxyQ+nPPty1atWH2T-xg@mail.gmail.com>
Message-ID: <CAHk-=wj95tXzuox8eXPhBtJtV_NzWksxyQ+nPPty1atWH2T-xg@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] lib: scanf: handle integer overflows in vsscanf
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 2:06 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> IIRC, this has been attempted before, causing a userspace regression
> because some sysfs/procfs file matched with %u or %x, and somebody wrote
> -1 to get 0xffffffff .

.. which is correct anyway. That's how scanf is supposed to work.

If somebody needs overflow checking, they shouldn't be using scanf.

                  Linus
