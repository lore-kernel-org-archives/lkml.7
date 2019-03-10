Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618DBC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 20:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192D5206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 20:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552249366;
	bh=uT94/XI455OSN1Qk6RXREHsSQWlSnSmH8Dy5a7z5cao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ue1bwIbpBJTFITMPixLLRhBDbUiNnPpN+54Ia+AGPVp7vJlgmaabTRLLMMp+26kSL
	 Zzlw2CyPCfZnM8G/qZsyhyjTejsyAxCJSeLZ0vKUbhBCshVkkCIE100Qb4C7bbeHvC
	 CAPcaquVzvJoT+p/dKT3E9zGsyq5JoXSSgxAzB+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfCJUWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 16:22:44 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:40199 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfCJUWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 16:22:44 -0400
Received: by mail-lj1-f170.google.com with SMTP id w6so2223160ljd.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 13:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLmUvidvPC3xbWGNWgKlgUsZUa/nY09YfQHkOAtVVgg=;
        b=bTvNg8ZrJGdp/BXbp4cXMXKAEs3PGHTglSqVw9G2IXbhh0P4OwlHFWidYM494bsg6+
         AXY/nUmgDyVvREeBNMex1ZG5fcBxI5izZFbPkj5jJ8F+7LZ1nWoqAYVGcWOkQVr8uC8l
         01NqKGQYYQkG+Pd4KOvVPzthLeHq7e/8XF9kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLmUvidvPC3xbWGNWgKlgUsZUa/nY09YfQHkOAtVVgg=;
        b=pVAyf9pCJSpJHlDs168gBBnv6nUIc8cXLVKH8TQewsWANzs4i7mjAbOtyXCMiHIHQy
         yoKq4ZD+6BaVT6Yt6vNF7S7dfGfd2imO/rE63KcY+d/3HY7nufss03+YvsPxwebRew0Q
         XsPuK1zsuTBe8wlILhK//Zc0+VnBG9umXAU+BUlWAQlK77/KY87N1iGGsEV4malPRcRP
         TOt7Ywygbghyzd8g1EQr4WoXWRcWRg1ZocX0xpHaNCf6c1wYlGw3IiEaMa9vpyOLvx45
         ZA9SzgfhLnyu55ElLxXRWbZMZTxgS1ETjOyd4fgY33K/GzlJQ3sHEdNDCroP6PuRUKzK
         dTQQ==
X-Gm-Message-State: APjAAAVZU1CCtqGxTfCcUKJ5r/iJfUZ8CAfn0bCUsIL5UHqcKXwBvOpS
        N3GV6AJz6P+2mOkXAf3sR/vO90IMFpw=
X-Google-Smtp-Source: APXvYqwjUZeKcEoO4/teJqXf3vKwVpCwTDrZSTSWlZ2+5WyjtFIh3ii0BEU/BRzN3PNGMDJrppb3Kg==
X-Received: by 2002:a2e:888c:: with SMTP id k12mr14659573lji.63.1552249361669;
        Sun, 10 Mar 2019 13:22:41 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id e18sm667078ljb.2.2019.03.10.13.22.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 13:22:40 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id q128so2212323ljb.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 13:22:40 -0700 (PDT)
X-Received: by 2002:a2e:8018:: with SMTP id j24mr14123184ljg.118.1552249360276;
 Sun, 10 Mar 2019 13:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190308203326.GA48374@wrath>
In-Reply-To: <20190308203326.GA48374@wrath>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Mar 2019 13:22:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvQKUtE1fzTPMwSjNR3nLQBw_DVRVvZEqW5tdTvG63HQ@mail.gmail.com>
Message-ID: <CAHk-=whvQKUtE1fzTPMwSjNR3nLQBw_DVRVvZEqW5tdTvG63HQ@mail.gmail.com>
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.1-1
To:     Darren Hart <dvhart@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 12:33 PM Darren Hart <dvhart@infradead.org> wrote:
>
> The wmi mod alias changes collide with a similar series for TEE based devices.

Anyway, you also used a *very* new subkey. Can you please mention it,
so that I don't then get taken by surprise when I find a key that was
used to sign this and I don't have it?

Yes, yes, I will download it anyway, but basically I want the pull
request to give me enough information that when I do the pull I'm not
surprised by the result.

That's why the shortlog and diffstat exists of course, but that "don't
surprise Linus" also covers things like "oh, and the tag will be
signed with a key you've never seen before".

                Linus
