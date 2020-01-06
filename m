Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA665C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9783D21734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578297543;
	bh=fsfR2IbX3Uzgstapmtoa2ruP0FZK/NNrd21+oHoghF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ab9KZsYwR+BPEm/FztcWYwK0+9wthSZ7vVdG77vf1XhdgKI5GBy6f1JbSDB19Qe5f
	 V0QR+bhxtPtOIiWA+15ywZo7aBLGO+YmZk7wmJUlm2Byzm0ewnJ9LJzzX4GYKgyXTS
	 GJQvsZ4F3/KUMr7sOGwmqZoH6tpbGKGvk8Ev59/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgAFH7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:59:02 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38784 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFH7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:59:02 -0500
Received: by mail-ed1-f67.google.com with SMTP id i16so46717066edr.5;
        Sun, 05 Jan 2020 23:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=shX2EL3hEDUKUPyK9slyF9fPOfxblBV1rDmKHdnGIro=;
        b=cf24onDgS/hE56kWcaUtSTavyFoiMUG0VVBb+0q4YEgTsvUn5+Hrr3443oN5u4XRxE
         u5UVvKJvoYt1LfaPsQdeVMpzISpidcehneZnSaCsjqy/AS8vR9FGC7zVlSJK3xW7gjK8
         FscuOj5+8UewxKzHzI+MptYHVe0RS8nnBeKM7DyoZ9l9CUbfrTwPJtgCONODHQwaW3AU
         2iqKJo9YJGxpscqRz2G7CPzL8lGi+9hIUI/fuDPnQUBZiaMKjUyx426vYhB33ngBh8uU
         XzyPVkmMoC7mh9yxo0exlfpQRDhV05jDAvOu6cwzY58EdH8uy0Ly3q6gdUQ/x3SsD4lC
         2SMw==
X-Gm-Message-State: APjAAAX1JCZWh7E9UKOG9zr+RPPniVh+5EU+tdewvpUXxe63f20O7DGA
        SJ+yFjnZDl6+5RwzNj0ynZk=
X-Google-Smtp-Source: APXvYqz6BzoBH5eS9cIT73CTasbNOaO7wb2JgFWK3mKQ8G90HFNewbThd8aAYjv20+JBO1pkDPP+LQ==
X-Received: by 2002:a05:6402:1484:: with SMTP id e4mr59115716edv.286.1578297540599;
        Sun, 05 Jan 2020 23:59:00 -0800 (PST)
Received: from pi3 ([194.230.155.149])
        by smtp.googlemail.com with ESMTPSA id p18sm7961240ejx.80.2020.01.05.23.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 23:58:59 -0800 (PST)
Date:   Mon, 6 Jan 2020 08:58:58 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: linux-next: build warning after merge of the usb tree
Message-ID: <20200106075858.GA13634@pi3>
References: <20200106144122.01f51be9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200106144122.01f51be9@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 02:41:22PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the usb tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
> 
> WARNING: unmet direct dependencies detected for PHY_DA8XX_USB
>   Depends on [n]: ARCH_DAVINCI_DA8XX
>   Selected by [m]:
>   - USB_OHCI_HCD_DAVINCI [=m] && USB_SUPPORT [=y] && USB [=m] && (ARCH_DAVINCI_DA8XX || COMPILE_TEST [=y]) && USB_OHCI_HCD [=m]
> 
> WARNING: unmet direct dependencies detected for PHY_DA8XX_USB
>   Depends on [n]: ARCH_DAVINCI_DA8XX
>   Selected by [m]:
>   - USB_OHCI_HCD_DAVINCI [=m] && USB_SUPPORT [=y] && USB [=m] && (ARCH_DAVINCI_DA8XX || COMPILE_TEST [=y]) && USB_OHCI_HCD [=m]
> 
> WARNING: unmet direct dependencies detected for PHY_DA8XX_USB
>   Depends on [n]: ARCH_DAVINCI_DA8XX
>   Selected by [m]:
>   - USB_OHCI_HCD_DAVINCI [=m] && USB_SUPPORT [=y] && USB [=m] && (ARCH_DAVINCI_DA8XX || COMPILE_TEST [=y]) && USB_OHCI_HCD [=m]
> 
> Introduced by commit
> 
>   88eaaecc4446 ("usb: host: Enable compile testing for some of drivers")

+Cc,

Hi Stephen,

Thanks for the report.  I already sent a patch for it for the phy:
https://lore.kernel.org/lkml/20200103164710.4829-2-krzk@kernel.org/

Best regards,
Krzysztof
