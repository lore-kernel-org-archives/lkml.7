Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBCCC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1629920880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H6GHYM7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfHERJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:09:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42621 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbfHERJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:09:56 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so35880821iob.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=018C6jHlTx5pLyIhrEjm9kpmOgEmjnR9kBk7qmzQVkM=;
        b=H6GHYM7hzdKYPL2c+tZTMPNJU+8m2+VmnqBloTMUkI5NH+LGmDItrmwuUYW3z2qsX8
         624aAL4XC0Yq3vNVcF5dvCwZretsO2Uy1UX7NPLM8UmQ3lG8ixxdMHMU+LzcnqfZH2MO
         TwypQXIMwHpbnO1i81xPU+GwzocZRJPpjqFYJ+OJ0+THd4Pyab4Z7bHh3cS4yyDLlcSu
         ivZfijBYylYD9JQs+3isnBJpCotFSDdJ5gZihp8NIvIm7KMn0w5LLhOht7TGr6/7VqzN
         nGnd6yvfOMXo9SRLcHq+Gum9cJcx4st5Uu/hyPXTd0iFAPaFOo4KcJuTgWGscHTXVp4x
         2WrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=018C6jHlTx5pLyIhrEjm9kpmOgEmjnR9kBk7qmzQVkM=;
        b=G8HQTlsSE0hUo26iGEvU9C4EGKXmSqfvgXHj3CLJ7pa51YKPfxLBgSvBTi4mlYg5E0
         sCl4S19AMGpt5LsR/GWgGRpdTmefFM4CCqg+udpYEV9RnF4A2rUG8JgEY2n9hn4j95Za
         XV0gF60r6+seZbdhPCHtrRhabMphfV9yYPUweJJ+fRvekwGjQZN6Fq3Bnx6RpulaO1NL
         9Jh/sJuLaJVVO/c9tvNG2YaChxc2HSwSE6D4qvi9On0MS/KJ2wR8jU1xbfiuNRhEXwtu
         GxfB/XMv27MLpdvNpl8+XjX8JUYf34LIS++n21aNsvPOdGsPWM9b0i2SqixLV9ZrSR68
         A0vw==
X-Gm-Message-State: APjAAAVekUowQhCJP0VrwR1ayZ6zcdW9JY2pczG/UgNsb2vEc6IphDKI
        gqQExZCw7YtlcSJTY34QYXzjwwztgigHEIIFI4gH5g==
X-Google-Smtp-Source: APXvYqwUIDoOPzK/UGhFLeOEw0eLzgrCZBa6U/bBdYFAisisQYms4Qs0WnkPy0WoviQxJJROLL6VBUpmsq7e/Q4Zjvk=
X-Received: by 2002:a02:cc6c:: with SMTP id j12mr109429024jaq.102.1565024994837;
 Mon, 05 Aug 2019 10:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 5 Aug 2019 10:09:43 -0700
Message-ID: <CACdnJusRUnhmOLdowqbGoM9Z-tWsKrhZ8sFfQUUmjyKmRVN+vw@mail.gmail.com>
Subject: Re: [PATCH] do not clean dummy variable in kexec path
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bhsharma@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 1:36 AM Dave Young <dyoung@redhat.com> wrote:
>
> kexec reboot fails randomly in UEFI based kvm guest.  The firmware
> just reset while calling efi_delete_dummy_variable();  Unfortunately
> I don't know how to debug the firmware, it is also possible a potential
> problem on real hardware as well although nobody reproduced it.
>
> The intention of efi_delete_dummy_variable is to trigger garbage collection
> when entering virtual mode.  But SetVirtualAddressMap can only run once
> for each physical reboot, thus kexec_enter_virtual_mode is not necessarily
> a good place to clean dummy object.

I agree that this isn't necessarily the best place to do this in the
kexec case, but given we control the firmware, figuring out what's
actually breaking seems like a good plan.
