Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC012C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1212073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIf3zdGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfDPH4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:56:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40851 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfDPH4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:56:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so9984046pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJ+DGUUAR/cgssbsvPwjVxv6zYtArthbZx+hG0US5s4=;
        b=bIf3zdGa8MVzf0TkTHtlt/iFQm3iJPUyuorR1fwKW6OTRJDL1fkd6bWALsCYkpF3gI
         zzJzqq6pHasKAyvSAo8MN3MrPh5VeB98yBJDLuPA1qCU8jcTDJDoOY/bOYgKsfSZHBgm
         hkLX03BGdLRHMtnLqTWh1RCob0c5NB1vT2/V1v6k+Be/hSAPfqowW33pDGOE53Z3UqoY
         zaXK14rXMCkWrt93sCETpO0vrHebsDV3rQzZtrExQNsiP6agoTXrnDlrpToxqN0VHTJo
         bBNu4/oms0sr8eBGU5D4OwoGJjcT4Im1MFZeT5jB51mMyifDt+6t5mmaN73WlKohjMYu
         QwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJ+DGUUAR/cgssbsvPwjVxv6zYtArthbZx+hG0US5s4=;
        b=DbK4mJJsWCMhzRfeOR3umQ5PJrWrjf+B4/g2iImC1mxFtTU3f1VOr7tiBnfBhWXCnt
         SlaPMazWa8cHRiZ3DacG/ORwsK7oMuNWK4WLAuc/XKt4LFTa8WU8EQHu5uihL7mTCMb1
         TcC0eH4sfLY8HDvLUYMEE95//Z/AT0ZZGRQIYIkMoR01PUQ/o8CvQSLgxMzS7b1VcY9u
         3lwoWyDQtATPXzpiP8t9ehaHcxHsQeIF6kmM9ZIpEKvFuoJGjHJsqqJGfe1+Jcjpi3G4
         nQvJa30/F8WNxk1knA9l/86jzz6yOVDZB81acBwKw0b1ndiODQQ0hf2AZ4xYoQZhtImb
         abIg==
X-Gm-Message-State: APjAAAX0GhZZUDTQZ64I4HJzUsPKL5ZDz4D9JeZ16e8RMnm17r4LGQca
        wtDcLBXC4xu3LhDiWg4w3E1FEbrmgCocBhjRKyE=
X-Google-Smtp-Source: APXvYqyMqZZm6tTD8P/Zb5lniXFifnxVVvzJkfklXTBalVIt2LtKXodht8h7/h6Tcafyy1uLt4K/cFyEQ3tp2GSpU9s=
X-Received: by 2002:a63:fd49:: with SMTP id m9mr75550616pgj.16.1555401361365;
 Tue, 16 Apr 2019 00:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190409151100.16027-1-andriy.shevchenko@linux.intel.com> <CAE=gft7VK=7gV3PV1QdjRPOccEYmL-341fUNX+wXGUfrvzUDfw@mail.gmail.com>
In-Reply-To: <CAE=gft7VK=7gV3PV1QdjRPOccEYmL-341fUNX+wXGUfrvzUDfw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Apr 2019 10:55:50 +0300
Message-ID: <CAHp75Vfw8-jfzgOBwyTk6E5sqsSxh1NVPnLdQHyZJZneruT3uA@mail.gmail.com>
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Intel Comet Lake PCI IDs
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 6:10 AM Evan Green <evgreen@chromium.org> wrote:
> On Tue, Apr 9, 2019 at 11:11 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Intel Comet Lake has the same LPSS than Intel Cannon Lake.
> > Add the new IDs to the list of supported devices.

> >  static const struct pci_device_id intel_lpss_pci_ids[] = {
> > +       /* CML */
> > +       { PCI_VDEVICE(INTEL, 0x02a8), (kernel_ulong_t)&spt_uart_info },
> > +       { PCI_VDEVICE(INTEL, 0x02a9), (kernel_ulong_t)&spt_uart_info },
> > +       { PCI_VDEVICE(INTEL, 0x02aa), (kernel_ulong_t)&spt_info },
> > +       { PCI_VDEVICE(INTEL, 0x02ab), (kernel_ulong_t)&spt_info },
> > +       { PCI_VDEVICE(INTEL, 0x02c5), (kernel_ulong_t)&bxt_i2c_info },
> > +       { PCI_VDEVICE(INTEL, 0x02c6), (kernel_ulong_t)&bxt_i2c_info },
>
> How come it's not cnl_i2c_info?

This is a good question, that's why Jarkko asked Lee to hold on until
we have confirmation about i2c timings.

-- 
With Best Regards,
Andy Shevchenko
