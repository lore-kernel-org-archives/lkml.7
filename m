Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6A3C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B022064A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwXW3sQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403896AbfHBNB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:01:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34251 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfHBNB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:01:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id b29so45658062lfq.1;
        Fri, 02 Aug 2019 06:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPjbHLrTX3WXA9Ntzf5RZ9TssASBW6mGGuFC8KEUjyw=;
        b=dwXW3sQ1gZHh+gRq6qCK5o3eZJpyhGlJgFFZayH/Sya/bRwtGnN4CZqKyF+rKZku/P
         udMzRXLJ7pEPcXL7stFEsO47l0qXmt920GmdWDAMVDj18RfIPqn3pQ1y0QlrdLo1ArCK
         uavw0gIWYA1LuPoZYwcLgbvRIRwuz+vCT5+LNq2RpaEjv9OjwgrGKbiO/tkpurZW3svz
         1OZynV3nZj7x2TH+6swuahUxFAANgqT+irGrMK1f+X12Q0DlfRN4zbJ5QH8E8xOrTDb8
         e3/eG5XaEyNjVAUo+W3h1jZmIWKc44WXRaZumTyqyN/PWbCnt+xltuWeDj+uJcXe2R7u
         eq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPjbHLrTX3WXA9Ntzf5RZ9TssASBW6mGGuFC8KEUjyw=;
        b=C8AYtRdqoUTdOaWHWLW+Bkxdk4K6/yrQ12JI4EL18Im1aQeRt8uVJQPd44IkFm8AaG
         KvjBevzQ9Rd/d4l1EizQXpmaH7fQFQDJpTaIVMg7byezH1QBzZNpv2yFAUHpvHiHMj9A
         hFS0zmkgzILrdWOZ7Zb8yC9ZuE2Dow8/4AO56Vgyn+nvg8Rl3+6p0jVFIgLkrGTIqOW/
         DPUWWXs5s2yPkhFsaIfEhj4fXw4Nk4b9hM2kPIZGbj55WXZDraBux2UMMhMgeJeMMFmD
         ENwX5UxTzLsU7Vq/vDDb+mKNmE5rTWaNRthpZnf7Hyeg8pp0vjNfzBJ2A76aDGb6s/6l
         IoAA==
X-Gm-Message-State: APjAAAXzm8H1thMIWu9AYlhDapL68I0RL8GneWepIoS/9BfTvPm+oagW
        xD3fO+mz3QxwLB1vXZjmuPDNmsreaJptPW/juAd3MUIR
X-Google-Smtp-Source: APXvYqxiKkwBi4xLTfvgUAojfGuzhW4u7kOwlwxiEYsHNcEGsyCBb4vsdI8em1/OEli/xASVhzr7eSFPuDI0ByvqFpQ=
X-Received: by 2002:a19:e006:: with SMTP id x6mr63042828lfg.165.1564750884322;
 Fri, 02 Aug 2019 06:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <259986242.BvXPX32bHu@devpool35> <20190606185900.GA19937@kroah.com>
 <CANiq72n2E4Ue0MU5mWitSbsscizPQKML0QQx_DBwJVni+eWMHQ@mail.gmail.com>
 <4007272.nJfEYfeqza@devpool35> <CANiq72=T8nH3HHkYvWF+vPMscgwXki1Ugiq6C9PhVHJUHAwDYw@mail.gmail.com>
 <20190802103346.GA14255@kroah.com> <CANiq72kcZZwp2MRVF5Ls+drXCzVbCfZ7wZ8Y+rU93oGohVAGsQ@mail.gmail.com>
 <20190802112542.GA29534@kroah.com>
In-Reply-To: <20190802112542.GA29534@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 2 Aug 2019 15:01:13 +0200
Message-ID: <CANiq72mSLmP-EaOgY0m2qgTMVsAnyE6iuW5Kjdw5mSy1ZH0y-A@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Linux_4=2E9=2E180_build_fails_with_gcc_9_and_=27cleanu?=
        =?UTF-8?Q?p=5Fmodule=27_specifies_less_restrictive_attribute_than_its_targ?=
        =?UTF-8?Q?et_=E2=80=A6?=
To:     Greg KH <greg@kroah.com>
Cc:     Rolf Eike Beer <eb@emlix.com>, stable@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 1:25 PM Greg KH <greg@kroah.com> wrote:
>
> But it still doesn't work for 4.14.y and 4.19.y, so we are probably
> missing something there.  So if you want to fix that up, I'd appreciate
> patches to do so :)

Hm... For 4.19.y and 4.14.y, I cannot see the init/exit_module
warnings under GCC 9.1.1. What do you mean it does not work?

Cheers,
Miguel
