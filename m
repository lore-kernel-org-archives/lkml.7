Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E36C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 02:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EB320663
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 02:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575772691;
	bh=8mgPzHZzKvYJ806I0wHDu1FGsN/YycYQJkEG3Ub5PCc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W5jx2OHGfkjmjWRE6eCFvZq7uxXaQu4Oa8zhd2rWyMZ1+4bo5CbUvJloERwb5v9j7
	 aOye6kt63Ks9YXDXvTrYbNQ2ZLBXm9kXfCySBm+D5wPC+EN8TSG/foElu4+17Rzz2c
	 m8QoXqICaTgcVb4Fb2x29dD6gNWuk3x0FJerCmjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfLHCgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 21:36:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37222 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfLHCgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 21:36:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id u17so11769896lja.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 18:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a4jfnZBW3KpYqP1Bv2BekVx6xqeSOyyCAahQiCKEzmI=;
        b=gpm7ue+/WAaHJLspUVE0QHZjp9pYnUFrx5hP6CyG9vZV3BGNG87eo+wyaHng0ZzJyV
         jwWpyon4dyyOqUTtTihxUTSW+iJMhK07xO1DeUKTKVkKWMa83YkTFgGKGBaOvMPc64jq
         rHKtDEzG8fl2ltu7L9C5jlkLv2jd0uaLNnonY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4jfnZBW3KpYqP1Bv2BekVx6xqeSOyyCAahQiCKEzmI=;
        b=mDRC7OvKVREjU/hxhD/bHVfBqeVoLzdBQ2fea3tfmWmAwiamTF44urA/SVsy50rCRW
         Ydc6qn8Z0F0XrINsEcWnUff/Zmoyr0eC7qO4u0HI2fhroPDg49U9EoE0OeKKCjbQJR/h
         R6zw55nViKbJ3+3VgI6I+E5FOBqMZEd0jEq81MBBOi8LYEoIypkBVkrrsMKQikM4P1B7
         eITm15Rx7wLM/HL14yz4Xr0w/G29rhZ2SpYVSQCHOJ9p9cr8BInkf73hADhg0kU5ZCbY
         ZzIv3vN0HJfjUzslWXr2PggqPEa5sfk7xaTSk+h07iXg2fEOFlX3dHlqCTjB+uT2iPZh
         i/Zw==
X-Gm-Message-State: APjAAAVBWoxPFVLcv9PcX7Cw5KUpjHHBqbFvGhfDE909lHnhG25DBYT9
        zbzwoZVr0ZY46VVszloots9IyP20zJg=
X-Google-Smtp-Source: APXvYqx1h7tuusPTCW93ag0Z8q8EJN6wOdQuk2Bjjk1UCzrux55A0IRpx/kUPBxAyZYuUH52fUEFxw==
X-Received: by 2002:a2e:88c4:: with SMTP id a4mr12265216ljk.174.1575772569419;
        Sat, 07 Dec 2019 18:36:09 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id r20sm8722369lfi.91.2019.12.07.18.36.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 18:36:08 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id n12so8109352lfe.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 18:36:08 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr11709241lfk.52.1575772567987;
 Sat, 07 Dec 2019 18:36:07 -0800 (PST)
MIME-Version: 1.0
References: <20191207202733.GA153817@dtor-ws>
In-Reply-To: <20191207202733.GA153817@dtor-ws>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Dec 2019 18:35:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNz9CtHCobs+WNKeCcgd23adbRtPzoBk7WwEw_Z=i5wA@mail.gmail.com>
Message-ID: <CAHk-=wiNz9CtHCobs+WNKeCcgd23adbRtPzoBk7WwEw_Z=i5wA@mail.gmail.com>
Subject: Re: [git pull] Input updates for v5.5-rc0
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 7, 2019 at 12:27 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> - one can now poll uinput device for writing (which is always allowed)

Well, except the code says "if there is data to be read, then it's
_only_ readable, and you can't write to it".

Is that what you wanted/meant?

                Linus
