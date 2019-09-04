Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6E8C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D2721670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asWc2sqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbfIDQ6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:58:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34104 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731564AbfIDQ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:58:04 -0400
Received: by mail-io1-f68.google.com with SMTP id s21so45824338ioa.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4AEVHZWDKj5M3XNGlUJpNgGM5Z1l9AtMPF1Hqde4DM=;
        b=asWc2sqIHddJtfzpGPSflNT5pALrlHIbgF4I0kHpFB1oZPYM9gDBwVZGGi7OtxWdXG
         PPLjQaihV0MOd2qP3s+pRow5caaVDzoXH65KvyTmbH6UL6DMpMt+2d17Z1AfLZjo8ep3
         hMdZZxJELA2F5afBUr10xth92mqJc8bLt5d+nWpYIUhxfUurKK4W4Emy+SQnkZRhYi4G
         hjZKiEtB39XoumJNkg1WOWUEmIA6i+ZwBZtg7rStpIivhqv8ekIGDdUZmtoLo/uQshqW
         SgwZHF7mgB/lRouNZ4D25erP6OjzyBkkz78zvxvjAEX6cR1uHIpXgziTDvHHsZpY0+ny
         O8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4AEVHZWDKj5M3XNGlUJpNgGM5Z1l9AtMPF1Hqde4DM=;
        b=ex4B+GDqieMOWMS3ku+HmPNAH/vOxvcMJS6yQRr2NxBRfBS8EGtjS7gQTm6kJraOwb
         e2ukJG42bOPTyxoad5MP/tMJLsqMwAw4dTvFQRJA8Bb26+rvBS+EBIevc3DmVqAE4QJR
         N/SKIWpRg+6RgthvjKtW+kFhOpvMrJq4co2z53dHI9BOV/aveM9EFW93+XLd5RgmiLuO
         KFBWu8ElDAu2ho13cLs3vZBJbQcwNfH5oaQmooJDmb7O3FkGirUyr03XDhjvnnByRW+X
         qQ686MAAidq3vztiVMuZYuDEBI8oc6MqWsSudffNr+CBHQeYsO92G2i8D6T+a/OvvZJ0
         vl4Q==
X-Gm-Message-State: APjAAAWVpwndjYL1c1Rg4jMC8TEZaNWeks8XFf63AJ59+TFkR5RlzQLI
        rGhGACiyOBcj+/JaJ6W4JHYli4F16JI16v8Rpp35sQ==
X-Google-Smtp-Source: APXvYqzIbsuE/yut9DVBnXppG4ta1mqNva3WuZnN1oWipNNP7O4N/45Gr53DC/XHb8eNNMFecqOhTbvf220xSgyYutU=
X-Received: by 2002:a02:354b:: with SMTP id y11mr17856473jae.53.1567616283414;
 Wed, 04 Sep 2019 09:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-5-matthewgarrett@google.com> <3638.1567182673@warthog.procyon.org.uk>
In-Reply-To: <3638.1567182673@warthog.procyon.org.uk>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 4 Sep 2019 09:57:52 -0700
Message-ID: <CACdnJuuTRQM9SQvLMqW+C=6ukQPpvkwqFZ6U+wnL4uYxcG14Ww@mail.gmail.com>
Subject: Re: [PATCH V40 04/29] lockdown: Enforce module signatures if the
 kernel is locked down
To:     David Howells <dhowells@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 9:31 AM David Howells <dhowells@redhat.com> wrote:
>
> Matthew Garrett <matthewgarrett@google.com> wrote:
>
> >  enum lockdown_reason {
> >       LOCKDOWN_NONE,
> > +     LOCKDOWN_MODULE_SIGNATURE,
> >       LOCKDOWN_INTEGRITY_MAX,
> >       LOCKDOWN_CONFIDENTIALITY_MAX,
> >  };
>
> Aren't you mixing disjoint sets?

The goal is to be able to check whether any given lockdown reason is a
matter of integrity or confidentiality in a straightforward way.

> > +     [LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
>
> Wouldn't it be better to pass this string as a parameter to
> security_locked_down()?

I thought about that, but it's not how any other LSM hooks behave. I
think it's probably easier to revisit that when we see how other LSMs
want to make use of the data.
