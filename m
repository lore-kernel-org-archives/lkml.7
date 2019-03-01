Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1119C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B102D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551456931;
	bh=OYbSvu8htsvxMMTaECqiDpWvsWfJarNKG6pzPJt4ljE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kiz5km9UP+1fnbuwkBophrM3rGDMiC3aKGBMaye2CBtBnKDFTyW3OTLvxZYkOQKP0
	 6nlfuT0GQbbtwEAvfGe9Fr6PUHtVfMdk+/TLAb5RvG+ciSzk92AvscN5L9ITftasWI
	 sf0udZrBFBJJWfAZflX7dn7slsb9kKoWl+Ehxw9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbfCAQPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:15:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44801 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfCAQP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:15:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id q128so20856158ljb.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TB2WNfItDh5tDSnagxb0cKOBLcV9amE7pWTa29E2ntc=;
        b=TvC7HZfqXEiJ064TzP5lEIHq/SsMlkQR+LcoWNsAuJSkuy3rv38sLqYDqdQHrAJGsZ
         OJTIcDDYj6hPDNkwTOCEEiboyxKk57MrljN0dawYPBwkn6Lt7164X4HJ1ZbJrajWK4aX
         dNlBINxU9LnkytaKMNc2c2chaPbKEZRIDAx4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TB2WNfItDh5tDSnagxb0cKOBLcV9amE7pWTa29E2ntc=;
        b=EDIroaZ7rfS2j+b4jfv8Bvgh7pHNBmW/pNujwVoVS57xt939AB5cf4RZJkH4lxNvh5
         D61hazWXCDaBz2o8d1pPLou/jKAPq0mpyG/jr54Av6HHfcbTLEzOtfyTaRtHN4nUGQSg
         KxyoS82IejpplT8YTJ8lZzLfoiBFliLjyYwwRSP0JoF+T26+5bnmuf27xGJq5RTZhJz5
         RoBGxBkmh/7X8U6RCp/Gevea5ndFT+Vs7gqfqn/UTonhWkvvymh8KFtAdYN+6fi0HZLN
         CpB2xrH2/7xymuPhBglgJhpQCrjrRFYo841+ZE95Wdr9YS2QHwL5K9fBFSUmGQrR/nXu
         F91w==
X-Gm-Message-State: APjAAAW8Anb8VI8FIF8JfK7z0boJ/d3hc3lCfCyw6bxslWSgO3y/yoaX
        LTg5uBB83pbqqoWpTVz3JgyE3vI3xAA=
X-Google-Smtp-Source: APXvYqy/mDns/3nXvDRuuggbD9kAixJceY6imc/UQl7I9TTf0kwxWL7W52ikygjBT3/jmF8oO3D1ng==
X-Received: by 2002:a2e:5518:: with SMTP id j24mr3254057ljb.80.1551456927211;
        Fri, 01 Mar 2019 08:15:27 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 77sm541269ljc.88.2019.03.01.08.15.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 08:15:26 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id a17so20855766ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:15:25 -0800 (PST)
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr3273103ljc.22.1551456925561;
 Fri, 01 Mar 2019 08:15:25 -0800 (PST)
MIME-Version: 1.0
References: <20190228145450.289603901@infradead.org> <20190228150152.540038736@infradead.org>
 <CAHk-=wgsSXxL5c2Lbmbai=bcCgN0G=jPO+gWhQ3a+wx-LTaFkQ@mail.gmail.com>
 <20190228175114.GG32494@hirez.programming.kicks-ass.net> <20190228180154.GO32534@hirez.programming.kicks-ass.net>
 <CAHk-=whJww5smbSU2VzvcR7tajNqp=i9ZBYHK3RvwVXbs+V_JQ@mail.gmail.com>
 <20190228190111.GI32494@hirez.programming.kicks-ass.net> <20190301103452.GQ32534@hirez.programming.kicks-ass.net>
 <20190301122745.GR32534@hirez.programming.kicks-ass.net> <20190301125718.GS32534@hirez.programming.kicks-ass.net>
In-Reply-To: <20190301125718.GS32534@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Mar 2019 08:15:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=whi3C93GP3urxAMZcEP3cqHP9Z1F54b8H9P-e47=BB73g@mail.gmail.com>
Message-ID: <CAHk-=whi3C93GP3urxAMZcEP3cqHP9Z1F54b8H9P-e47=BB73g@mail.gmail.com>
Subject: Re: [PATCH 6/8] i915,uaccess: Fix redundant CLAC
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 4:57 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Or.. we move the thing to assembly. Of course, I suck at (writing) asm,
> so the below is probably broken in various ways.

Looks sane, and makes sense. I feel that the old "mixed C and asm" was
much worse.

My only comment is that I think you should remove the ENTRY() one,
because you don't actually want that symbol to be global any more,
because I think it's all from inside copy_user_64.S now.

So just

     ALIGN
     copy_user_handle_tail:
          .. code goes here..

Hmm?

               Linus
