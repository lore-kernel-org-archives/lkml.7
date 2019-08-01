Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C92C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A90206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mv6z0bTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfHAUmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 16:42:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45465 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfHAUmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 16:42:44 -0400
Received: by mail-io1-f66.google.com with SMTP id g20so147368928ioc.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 13:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMH0PSgx6Uw521Ile0FkmOu1AQ4AnGl2b2LD6f0V7lw=;
        b=Mv6z0bTWhcWzmPMAa8WNgTytLenPwtsKNMFXZbhEFXwGK9nEL4W7vFZkrsetALCbR5
         1UflM2NczBPJTIJW91GKL5lQq5uKXTi5ca9vnhB2PqvKWOiK89zTHeshqpXAFDCL7GP3
         gGXc1zgIXdCQxmZly30bpM177mxVOUDZ8gu9XBpVtobSV3JEob0ErTrX059NXvy/H712
         osyOy8nMACpzq+vrxTk9JljUUTn/bsD9s703uJBNV1960EiqM5aO44zhny6vx8iJuiH4
         zOfSQmiqdyo/LZ0ZZkbuqV44qbcCj7cYppuARx7uUHsNlY2J3ThTI1h7aZO5rG7JDe98
         s0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMH0PSgx6Uw521Ile0FkmOu1AQ4AnGl2b2LD6f0V7lw=;
        b=G9U0uDpq5TCTw1jM255tDildrk8BuMvDsslv2UvCJp4fU4lRSEaio87dgtuaKqeqRV
         PIBSlYAlBq/kb+PtQ035rPysS6odp3vfXPu1zyiS+gPazH2nPm3mJvUlDS55sEFQksuA
         UQJen0GM3p8nokxvfccRwM2OkS6bkffBv1JEbCYDiqZW1ryYYPpZLyEU7Zat0bRWhoSf
         GiTvj9+vt7d8BDNXlD4fwCWv6Quf/lYK8sKVZXOEZ7tcBAz0GnfP7dSPCDvHJ2h5aaTK
         dw9zsFP3N6HnYGsxF+bWwx+IvxSU9weSjzph24yOgNHdWX1NuDwnvzGM3UZB4MVHoJ/0
         r9OA==
X-Gm-Message-State: APjAAAUko4/O0tsZ42a1m2Zb9H3H7bN/WQxtV4wHgjqmUWGnby/SwgCu
        UbfpHlZmw9xxXLk6V8VdPtOHWn+qE8lqtwttmE1S5Q==
X-Google-Smtp-Source: APXvYqyNsdIo5cG3iRn2E0sXHOsTfshbx+8l5Wey772GDb6fRSzjMH0UCH36mDLfCqY4G9IrrYkaCqzTJWi0i8V9iYc=
X-Received: by 2002:a5d:968b:: with SMTP id m11mr74306975ion.16.1564692162904;
 Thu, 01 Aug 2019 13:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
 <20190731221617.234725-5-matthewgarrett@google.com> <20190801142157.GA5834@linux-8ccs>
In-Reply-To: <20190801142157.GA5834@linux-8ccs>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 1 Aug 2019 13:42:31 -0700
Message-ID: <CACdnJusD_9W9tFqwKptDTA8fZU8HrSvsEQhKo0WS9QxLpgz5tA@mail.gmail.com>
Subject: Re: [PATCH V37 04/29] Enforce module signatures if the kernel is
 locked down
To:     Jessica Yu <jeyu@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 7:22 AM Jessica Yu <jeyu@kernel.org> wrote:
> Apologies if this was addressed in another patch in your series (I've
> only skimmed the first few), but what should happen if the kernel is
> locked down, but CONFIG_MODULE_SIG=n? Or shouldn't CONFIG_SECURITY_LOCKDOWN_LSM
> depend on CONFIG_MODULE_SIG? Otherwise I think we'll end up calling
> the empty !CONFIG_MODULE_SIG module_sig_check() stub even though
> lockdown is enabled.

Hm. Someone could certainly configure their kernel in that way. I'm
not sure that tying CONFIG_SECURITY_LOCKDOWN_LSM to CONFIG_MODULE_SIG
is the right solution, since the new LSM approach means that any other
LSM could also impose the same policy. Perhaps we should just document
this?
