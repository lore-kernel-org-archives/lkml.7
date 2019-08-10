Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3428C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 00:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FF12166E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 00:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9+sM2gW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfHJApC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 20:45:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43025 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfHJApC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 20:45:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id e3so96874440edr.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 17:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CBUazHhddmZsxB0Hoiw4zvE6oiR+uVF7ClLhkcMSvXE=;
        b=o9+sM2gWtH4nJNfa/ID1tZFd5YZrs+EQ2XTzzc8MRVuVVTA5BwAGFAlnpd5iZ8kUuY
         JFIOeVjTsxEDmWNk1ERHIkLM/axY1dpLapJEOzNmRgXTAGACf3SsCI80WvZc0gOd9L2y
         Qj+VO3ouupoO4iMEo2OJll/NQGly6ipuRh8ZC1kuBniID9Lx/WsK18+Vytqlskug7+xg
         teu1x5AG7k/kuPR1d6mzzEuc/jvvVxJvo4iCHfrP1yM++mAx6jFoQtW+Ychtq3IMvA6n
         Qk+TtA7XOZqiZE7xt3miSyeyC4Hi2Zob6bbWIjGp0PHxO4+Wx+GnO0VDeFxDUWxn89nm
         nhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CBUazHhddmZsxB0Hoiw4zvE6oiR+uVF7ClLhkcMSvXE=;
        b=aw1t9GN/JNjkcYm1pMq44jyyledtsUIzSvQp3NeHUz+F1tZzOWmjuCxLMy1LFi3YCM
         1P7gYUk7G92ylweRAJbAZ8AgTnz0lbrSMxWjmMIO77saMsc7awsiUl72PF7gHPcGeeW9
         8Dj4TOXH9o/psTNwGfkqdPMy20EtQ0fcR8ARsQoEPHhNkSG9ZewKAHi83F3ogVM4UyaX
         Mlc38/2qoSP4bgE8JG4ne+xtGuwRcoQxhf8jGBOtVnlwjNQVUppiGQaHTExtVHKUnalY
         w/AReRUr2vsGN+Zq+26zy7JQzbh5YKYkgy4cyU2t5LeNqYht8zxy+i+9mJ/P6eMmlEPV
         TFoA==
X-Gm-Message-State: APjAAAXeN/rw3NYUJNOKinVP8kqmrJA8nCPCCjfaG8TWXXqXAxkY2wdC
        9RFrwdtEn9BBbHSjfJSDQNA=
X-Google-Smtp-Source: APXvYqwc5zeDof/0wVv2MTgVSE/98pvnyBzX5Dlh2llXGxDkO7mButCFccinA+hkG1IkLj7WC+uq8Q==
X-Received: by 2002:a17:906:2401:: with SMTP id z1mr20929355eja.292.1565397900414;
        Fri, 09 Aug 2019 17:45:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id u9sm22940007edm.71.2019.08.09.17.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 17:44:59 -0700 (PDT)
Date:   Sat, 10 Aug 2019 00:44:58 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        "bp@suse.de" <bp@suse.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: Resend [PATCH] kernel/resource.c: invalidate parent when freed
 resource has childs
Message-ID: <20190810004458.mio4vp3nk6jl2hyh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1565278859475.1962@mentor.com>
 <1565358624103.3694@mentor.com>
 <20190809223831.fk4uyrzscr366syr@master>
 <CAHk-=wi_9sdMxurjZ1MbNnxt-pA=dqoyf8Fdn9aYc8xvjjnTBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_9sdMxurjZ1MbNnxt-pA=dqoyf8Fdn9aYc8xvjjnTBg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 03:45:59PM -0700, Linus Torvalds wrote:
>On Fri, Aug 9, 2019 at 3:38 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>>
>> In theory, child may have siblings. Would it be possible to have several
>> devices under xhci-hcd?
>
>I'm less interested in the xhci-hcd case - which I certainly *hope* is
>fixed already? - than in "if this happens somewhere else".
>

Agree, this is what I want to say.

>So if we do want to remove the parent (which may be a good idea with a
>warning), and want to make sure that the children are really removed
>from the resource hierarchy, we should do somethiing like
>
>  static bool detach_children(struct resource *res)
>  {
>        res = res->child;
>        if (!res)
>                return false;
>        do {
>                res->parent = NULL;
>                res = res->sibling;
>        } while (res);
>        return true;
>  }
>
>and then we could write the __release_region() warning as
>
>        /* You should not release a resource that has children */
>        WARN_ON_ONCE(detach_children(res));
>

I am thinking about why this could happen.

To guard the core kernel code, it looks reasonable.

>or something?
>
>NOTE! The above is entirely untested, and written purely in my mail
>reader. It might be seriously buggy, including not compiling, or doing
>odd things. See it more as a "maybe something like this" code snippet
>example than any kind of final form.
>
>               Linus

-- 
Wei Yang
Help you, Help me
