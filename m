Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D706BC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 20:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A629B2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 20:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="LUYUbRUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfHJUW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 16:22:26 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45037 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfHJUWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 16:22:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id b7so95428659otl.11;
        Sat, 10 Aug 2019 13:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryjR/5sVF4k8OUE8aoNbAbrqtw63+/RLHmgm/pYAmck=;
        b=LUYUbRUEwnX9kQvFpsJC/gcyI8YpJgnRB8yu3goKuSYOmtLYJPQVrsYMqvDamn044/
         mlw/PaByR3/nLrDm1oPcVg9rPp/kda+ezuqxeKxHUqCE7dE419s/pHj9No7Pc8pLV/uN
         T78vdBOOaohteauXwJz+ZBIbmtnTKpjswBESxbwoh1fTlyL8/5EfPNQKj53oxHdppocu
         qcIwandk+ggWqqUoc7wPz2MzoBbJRYWCf4ojbgiVagm+Wbt+YI9RfMNNo79LW/e6bFrz
         MkpSpIsMZRQBDHvV1rxn+uwfbbgPmRHFGRxvO2yz+GKXRWlnIGRfd5Ohlrr4LOjOeYH4
         3vPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryjR/5sVF4k8OUE8aoNbAbrqtw63+/RLHmgm/pYAmck=;
        b=PApFP95dVH+kOEJdzYraNGHbKLv5m0fOcsA2yMU0xNGKfyUBwM93Txi/bU09HHAukO
         geErIwjDYeBgTQfGD8CH0HWdbuVz4wazpoJVK49eHxB1bqLp1CV8Lew8bPYkJovoWuKr
         dzdoOK5Uf2pvsoGwhYknPAPlDeuFMlKOIlmfHBdztJlhouekPi2UrozEIo01irpTCPAv
         ulpyIsHG05ndoVRbuX9IhLJGTdsxK5OgLHQnC4aeJypUTdGltLp1Q1NgbSXJBAZUySyU
         Y2E8uNYrGjgPWoqt0ekVmcpY1GRJvu7GCYfL85xIQKw0XmY8ij0yglmgvz93gdE6CX33
         jmdA==
X-Gm-Message-State: APjAAAUHaGh7L/CjGW1BHTO2KLX++HdWUwSn8Z8LOqsToDvn97ZNg+n+
        oa4NboDBscdigZMehEeoMqSh2yWVscUlhRNv5KfiENHC
X-Google-Smtp-Source: APXvYqyEIk1DmcSAs8YpHMHKQCwsHmItBok1sqSNYoCs+LM7S6AC4kvyuJ4ByJosTOL5VyElUy+5Fvz4a7te7GpNHxM=
X-Received: by 2002:a6b:3102:: with SMTP id j2mr11895173ioa.5.1565468544448;
 Sat, 10 Aug 2019 13:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190808202415.25166-1-stephend@silicom-usa.com> <20190810074317.GA18582@infradead.org>
In-Reply-To: <20190810074317.GA18582@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 10 Aug 2019 13:22:12 -0700
Message-ID: <CAA9_cmcm_0tzBLQeEH7KsZxK4fggfSu2zDYRieajtoYS5ZidBA@mail.gmail.com>
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI device ID
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Stephen Douthit <stephend@silicom-usa.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 12:43 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Aug 08, 2019 at 08:24:31PM +0000, Stephen Douthit wrote:
> > Intel moved the PCS register from 0x92 to 0x94 on Denverton for some
> > reason, so now we get to check the device ID before poking it on reset.
>
> And now you just match on the new IDs, which means we'll perpetually
> catch up on any new device.  Dan, can you reach out inside Intel to
> figure out if there is a way to find out the PCS register location
> without the PCI ID check?

I'll ask. One guess for now is that num_ports >= 8 indicates the new
layout since the old layout ran out of space, but that might fall over
if the SOC uses the new layout, but implements fewer ports.
