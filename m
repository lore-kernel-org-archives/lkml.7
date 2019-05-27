Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFED1C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A495B20883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558985659;
	bh=a7UNaarFqcWecY0dZg0HeR72T3ZHI5ImyW/WL96bG80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zw6SrAn+TYefuBGZMWSjrDTTqYU3I67B/E3PjWWCEB6UJUydFxyi1ERYXRDCCWslc
	 BT+l9zgJUV7u+Na4IBSGFd1hZcaVjX+ldTTdgcE0Wgntumf1deaPiP4XkSpOcnzj4f
	 VdjZ8U8cscJP3rsmrPb889z5LT1ptMbU+yMdVg4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfE0TeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 15:34:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43464 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfE0TeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 15:34:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id z5so15539322lji.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 12:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kre0Es/yKlsYi+IHH4KEeUS1CqkAvEHYl2+afvp4/1k=;
        b=eeCf7ecg51/FYLge8TNO58pjRHJ4tdX6UaSrUoZX+tfItsH/toMl6OBx0OP4y88HRF
         r3OjzQNG//M6Gg0Zlku+eoRhK1NIpswilYsfx6FtTB7jJrI7+qW5a8MIUaWItP3SpU+E
         aWljlBTZZsZBBJ8KXlcm5t9/lyRuoHgwltBWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kre0Es/yKlsYi+IHH4KEeUS1CqkAvEHYl2+afvp4/1k=;
        b=qKufpak62llHB1sAWqH0hNMQdc6tuRwxc0zevCj36h4skWctFh+8SQf0H+PS9b6fkl
         lZa/0VXMA0aF5NeEgWnN8ur1iqVMV3Cqn9TPZvfovem1GhfRQazn8bry4mzzETWV1ecs
         oakzaqIK1x0bASDh47IsRIoq3vA3VlpVHEEC0/T8njs5QuSBX/0r4JPFuBRtUVIPiubB
         onL711TdnRlb41eVx1LDOWHTCGHSbk3N1U2gWHzCcO9a+3M26Jnr9N+vBUtogC7c1HyK
         6RAp39aXWlgFwxtIjDyt7nJuiGCnvwBs8XRqhUJqPlKJjblNiquY2LbwBs1Jz8BaLYmh
         mSMw==
X-Gm-Message-State: APjAAAXX1NGeeRUZapULVy6tuvIjV+dy/NIWO6E0BGFv5ONHL52nYIbN
        YCroZEYQOSlAGFznJLO33hebYVcZ/ck=
X-Google-Smtp-Source: APXvYqz4P5r5Xz//pM2zBzkulB2YpmICNQpkHOX4OXBGiCmI37fKPw+aDBcLUYSM5DFkH2OITO22ow==
X-Received: by 2002:a2e:8988:: with SMTP id c8mr52702983lji.99.1558985655564;
        Mon, 27 May 2019 12:34:15 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id k21sm2862614lji.81.2019.05.27.12.34.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 12:34:13 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id n22so5069605lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 12:34:12 -0700 (PDT)
X-Received: by 2002:a19:ae01:: with SMTP id f1mr21220611lfc.29.1558985652245;
 Mon, 27 May 2019 12:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190524194222.8398-1-longman@redhat.com> <20190527082326.GP2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190527082326.GP2623@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 May 2019 12:33:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgr-2kxGU=AXFbW=00qOHCA0eb_Ky0Bq9aeBKOegaFxNg@mail.gmail.com>
Message-ID: <CAHk-=wgr-2kxGU=AXFbW=00qOHCA0eb_Ky0Bq9aeBKOegaFxNg@mail.gmail.com>
Subject: Re: [PATCH v4] locking/lock_events: Use this_cpu_add() when necessary
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 1:23 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> That's disguisting... I see Linus already applied it, but yuck. That's
> what we have raw_cpu_*() for.

Ahh, I tried to look for that, but there was enough indirection and
confusion that I wasn't sure they were generically available.

And the "raw_cpu_*()" functions are rare enough that I'd never
encountered them enough to really be aware of them. In fact, we seem
to have exactly _one_ user of "raw_cpu_add()" in the whole kernel, and
a handful of "raw_cpu_inc()".

But ack on your patch, and a heartfelt "yeah, that's the right thing". Thanks,

                Linus
