Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFD5C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4E52184D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPYA6Buq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfHLS6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:58:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33662 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfHLS6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:58:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id z17so10836186ljz.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 11:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XV0UlagKcYI/dSWN2RIEbTBVB4N2U7HC4RPWZDMN5dQ=;
        b=lPYA6BuqU/tW6rZoQXKkz6SRm7C6IgwTOuxoQ/pa63u5Gaz0retqGG3TWUxt/lN0Zv
         lz0pl+NJX0byWI4yNFo3h+JdpHleSJmblNwQyu8Y/2benfhIbq3xSrruaLywyP4Iwpy4
         SIEF4qNh0kROYt7adyptww57etsb6GM7rjIQI2KKSh3pnysnJjL/Ny+EPXItO1ZD2kV6
         rq21SyErSrz/tASuS7pnUgOgL11LgHgcOl3uD+mVjnoMUi9KKviBo2ZQfKTEsCdkq1T/
         4u4ba9IaaU/BVMd68CiL4kpm9nMBuRxyIztaw7Lpw/phPrOzwi9rxysr34YOTi+JwPKj
         FGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XV0UlagKcYI/dSWN2RIEbTBVB4N2U7HC4RPWZDMN5dQ=;
        b=qhWEoHQ5M/aal9NpYEuVHJUt3pgY+QlmHYIB319IEU4F21bdKYz/fXuycQKWnk9ypS
         gogFRXu/ODcdrTjUOiEq1SwDZntg5RVfnPPhxVqUWGVi0YkFlXch66IEgYp8ZkssaJHG
         TQBn5H7/rUbzMtTtTNbFFxgd9zIIZyd9D6lOvt/IxPn0Xwu1Bk80FjBNod1AuQEfQyHT
         sXWzABwK2ZB5taCsk7MYuhKGfqTA7cO05HO1O2B8+LdhuY9GmV3JQoMHNHl3lXLxC+Zd
         vK4Cwlyd2iu3VspUDCOoviiI0UaX2316LKEI0KZL63gelfvpzl9pX7iM+cgKS6Bem6em
         R8Tw==
X-Gm-Message-State: APjAAAX3ao5MljTFZqkupbLdKDJlSweDdpRHI0V1DlIVYdBIZiKrQtMo
        ZBFNE8/N9Flj5IIYFg2zkjvVzo98HtfCTx3aZco=
X-Google-Smtp-Source: APXvYqx99k2gjqxIOYNDWCRTFvROjOjJQ3LiYvNiul19dvAoN28vw0OWHsS770OWjhh7hZLzWNEuCWOD54X8roaPRnc=
X-Received: by 2002:a2e:9905:: with SMTP id v5mr1878067lji.162.1565636278067;
 Mon, 12 Aug 2019 11:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAM_iQpXvuYKn94WjJ9nSjzhk8DzYAvDmdgxsi6cc9CdBfkdTnw@mail.gmail.com>
 <20180223121456.GZ25201@hirez.programming.kicks-ass.net> <20180226203937.GA21543@tassilo.jf.intel.com>
 <CAKA=qzYOU-VtEC5p6djRNmVS0xGe=jpTd3ZgUr++1G3Jj1=PTg@mail.gmail.com> <alpine.DEB.2.21.1908121933310.7324@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908121933310.7324@nanos.tec.linutronix.de>
From:   Josh Hunt <joshhunt00@gmail.com>
Date:   Mon, 12 Aug 2019 11:57:46 -0700
Message-ID: <CAKA=qzY=F-wj8YXhb-B7RahNceeab0rSA=06qBc8+7V-SyY-+Q@mail.gmail.com>
Subject: Re: Long standing kernel warning: perfevents: irq loop stuck!
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "Liang, Kan" <kan.liang@intel.com>, jolsa@redhat.com,
        bigeasy@linutronix.de, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 10:55 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 12 Aug 2019, Josh Hunt wrote:
> > Was there any progress made on debugging this issue? We are still
> > seeing it on 4.19.44:
>
> I haven't seen anyone looking at this.
>
> Can you please try the patch Ingo posted:
>
>   https://lore.kernel.org/lkml/20150501070226.GB18957@gmail.com/
>
> and if it fixes the issue decrease the value from 128 to the point where it
> comes back, i.e. 128 -> 64 -> 32 ...
>
> Thanks,
>
>         tglx

I just checked the machines where this problem occurs and they're both
Nehalem boxes. I think Ingo's patch would only help Haswell machines.
Please let me know if I misread the patch or if what I'm seeing is a
different issue than the one Cong originally reported.

Thanks
-- 
Josh
