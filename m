Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF4AECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E651020684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570476281;
	bh=EeYeT/C9KSGwj13ZSBHnEcV3VWK3637QLNmyj9tb6PE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xBHerlcKHWqM4lbJeeLHVlTCgmbEyctfxK+4UaRT9EvgsezwHhSPQGvC5ZRF7BFMK
	 gH54yiAcdKzG6cs2fHSVJP7WkOetVh2q/mpcH44sCoFod4GaJUlw/9eGWTlWpwY1oP
	 ZQSGk5RY6YwTzIsVdfwyOdowKLLTigU7wJZMELWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfJGTYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:24:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45488 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbfJGTYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:24:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id r134so10070459lff.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUUs7b6PD8mcHjewbbum0tiJ7HoN2TPQShKmb2T5xhY=;
        b=WYlynf8xVO5LbzpJUIuvhqsohiHzM0zAN1btD4PdVDolJNn5Cjm+iynkHY3rtZiLHh
         ixmIHCJQWK03omwq1m6/B8gvANY//JkkapfhKwFxSnzpbJpcdDW8HdDmDOwC6lkvWvi5
         eq8n7gzdQvqVRNXNtbMAJ6QyKUe0Y8Oh/D37A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUUs7b6PD8mcHjewbbum0tiJ7HoN2TPQShKmb2T5xhY=;
        b=PX4dPwBmw8+TKYv0Wlzh4qgnCnIFaLq/TGoGk+XTIyiGyQXyGUNRxJQ3i7+kdssVUZ
         vtkVo6WQp2vVNUCqO2ua/LN0Ano36j39OpM+MVrJ3ztIaU7sIT+Q+P6aatixxQKoVa8A
         nm9iMLqK0VtXhv4mZgIS3Msh+xn7sdY/SCjrKzXlKlt4WZ2PQ+7n/74Pf71bWtSvv97J
         6RmnDBSQ4yYaxBfr/janfRKXkQsGshoY7AacuVT/Pkdih8SHW+rgAxsY+7JzSltNXrHW
         0HGkiXWG+TWPOIZZUhrcaMwhZju0b29HN/IQ97+Qudrjm/j3vvJl19kU5LmpNVaAMrxN
         l84g==
X-Gm-Message-State: APjAAAXWh652DwJLaWgLo66oU5Ls/z5hwNk2jL+FX40xF2rGbIgiDJ7J
        jng6wPlagg9VeL4X1UlYyXd8p+hcl7M=
X-Google-Smtp-Source: APXvYqzBnHBpRSN7U6JJ/SdcAtH002K8o7uCyrpAm8H78m9f6fpwZPhc/L/aS+pAG2WccHNRQ+A1vw==
X-Received: by 2002:ac2:5633:: with SMTP id b19mr17620302lff.103.1570476276592;
        Mon, 07 Oct 2019 12:24:36 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id m6sm3314795ljj.3.2019.10.07.12.24.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 12:24:35 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id v24so14957043ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:24:35 -0700 (PDT)
X-Received: by 2002:a2e:551:: with SMTP id 78mr20008997ljf.48.1570476275275;
 Mon, 07 Oct 2019 12:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006b7bfb059452e314@google.com> <20191007190747.GA16653@gmail.com>
 <CAHk-=whtA4bWH=8xY8TAejDR4XyHDux0xH7_y-0jzft0XkvMfw@mail.gmail.com> <20191007191918.GD16653@gmail.com>
In-Reply-To: <20191007191918.GD16653@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 12:24:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqU_k5Sai0Zvi4wACK7CqhhfhdMq8La30oq-8O=6H_yg@mail.gmail.com>
Message-ID: <CAHk-=wjqU_k5Sai0Zvi4wACK7CqhhfhdMq8La30oq-8O=6H_yg@mail.gmail.com>
Subject: Re: WARNING in filldir64
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+3031f712c7ad5dd4d926@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 12:19 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> So it seems to have generated a corrupt filesystem image and tried to mount it.

Ok, then everything is working as expected.

Let's ignore the syzbot one for now, and see if some other load triggers this.

             Linus
