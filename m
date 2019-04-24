Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D45C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA27320835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H71LRfRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388421AbfDXS6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:58:30 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36158 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfDXS62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:58:28 -0400
Received: by mail-it1-f195.google.com with SMTP id y10so8073224itc.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/T1HbxMN+ndVKYcaRHpxcbbsgU7fYHok3PpEnUoeplU=;
        b=H71LRfRpXjOawAclrjyT7fhPMqFOBOoNK2XAXlDKv3IuwkWprFIjQS8CTPb3Q8HlnA
         YrHBEl4Qs737X8U5ZnYDQyO5r9tPwvf0AyTiFp1OqPYsodGcp0lot3Kgul+apeYsCiJm
         PEWJSulmnEHM9BKAJSpgR/kB8MYzPxZ3GvV7LjWaXHJAsSmAYe6GsIj89eJZ4JUOM0kt
         GildtIh80ZbFgsl6E0EDjLJAecayxtc7zhFCD5vyzzdfZJC/EfsmXgcb5x4mfIPheSqJ
         ZZCZ/HeMD54FqNQ7wQzC36Kq6cIvxLHwQVXJktuxupjo9PyVZJYz7uZSiHZEGSeT+5Iv
         MN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/T1HbxMN+ndVKYcaRHpxcbbsgU7fYHok3PpEnUoeplU=;
        b=jg0pDCvTQWMaR/vR3SQn74CkgawfCIeU/yumK6WAMgrWHNeEhnubXPs/R+RtPNHFdZ
         SNGE4BiTZNn6VNnyd9HCH++2E8t+qWIIkjPY8GkAGio3cXrzzSWojqhug+yXWwBqwpKk
         PUUqFfDd88HRe2ct/nq4bot5GINtSebHuODSmYli01BLeGBxk9VJmrqShFcvEYdOd4Km
         qJPJRwCm8nZ9svpNolT7wTCWWGQlDQRm9VxM10n9PtLNh98HSxyY8fNmvBhApqBPXptR
         UBz+uYD6em6Ei2ETV+u1RtAXOgrD+vS6g8yX85xrauyJK1BZ25okQwCTkY4bd9GyNblC
         2uyQ==
X-Gm-Message-State: APjAAAXU+mqi58dlokDQkgcZAgcVbOmW03jH97si00nwtoqQT9YoFks9
        ovZ0qHBdslXkqLo+R8kz2mvaYg==
X-Google-Smtp-Source: APXvYqz/ZiejlNwq5qfqJFkIbFpH8jXSloDXM+ua64jl8aMMMGziS7/ZV48R7ZX/9TlMjnBd9u00+Q==
X-Received: by 2002:a24:3a13:: with SMTP id m19mr439055itm.88.1556132308063;
        Wed, 24 Apr 2019 11:58:28 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id s8sm1075669iot.55.2019.04.24.11.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 11:58:27 -0700 (PDT)
Date:   Wed, 24 Apr 2019 11:58:26 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Kevin Hilman <khilman@baylibre.com>
cc:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver
 for the SiFive FU540 UART
In-Reply-To: <7h5zr9dcsi.fsf@baylibre.com>
Message-ID: <alpine.DEB.2.21.9999.1904241157300.10713@viisi.sifive.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <7hmukmew5j.fsf@baylibre.com> <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com> <7h5zr9dcsi.fsf@baylibre.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Fri, 19 Apr 2019, Kevin Hilman wrote:
> Atish Patra <atish.patra@wdc.com> writes:
> > On 4/18/19 4:22 PM, Kevin Hilman wrote:
> >> Paul Walmsley <paul.walmsley@sifive.com> writes:
> >> 
> >>> This series adds a serial driver, with console support, for the
> >>> UART IP block present on the SiFive FU540 SoC.  The programming
> >>> model is straightforward, but unique.
> >>>
> >>> Boot-tested on a SiFive FU540 HiFive-U board, using BBL and the
> >>> open-source FSBL (with appropriate patches to the DT data).
> >>>
> >>> This fifth version fixes a bug in the set_termios handler,
> >>> found by Andreas Schwab <schwab@suse.de>.
> >>>
> >>> The patches in this series can also be found, with the PRCI patches,
> >>> DT patches, and DT prerequisite patch, at:
> >>>
> >>> https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v5.1-rc4

...

> I've just updated to u-boot master branch with SMP enabled, and build a
> new openSBI (also from master branch) with u-boot payload. Using your
> v5.1-rc4_unleashed branch, I see 4 CPUs booting:
> https://termbin.com/kg13

Now that the serial driver is working for you, care to send a Tested-by: ?


thanks,

- Paul

