Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A5FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DE720674
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFEFY2qW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfDRW6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:58:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38330 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfDRW6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 18:58:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so1753670pfo.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 15:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHksTS8uj6LgnVRr/W7+Jie87BJjsqBO+MRB/xckssk=;
        b=HFEFY2qWuThtw7vRwO1Oy4LoNNWDaHLcVzcUUKBI/CrYHkJH42z2PUi2HH+bjv3xt4
         qbQtn5O7jiy94A+PVonJUNCuHNp+MKHRZT0WHGvbb2MzuTRsmAVh9xF3vLC7K0Z0Tpfv
         wIkFtP86yVGoqsFW7wrCuwWcgI/p1ohCONlqB74eA82z7pJHJU8LaNLP9wa2DFd4yeQ4
         tecKWwl8kXMzBP7V0mYBbGZzZVJJggahX1LHw0TbtyKusfLSxLStLAqs+0/AW9EShDlW
         5jAu3yRKUx8z+R5Etv/+2v165b0YgwrZckJ+LovJnXeyHrWmi/zkNei4lp2rGpLWF7D3
         lIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHksTS8uj6LgnVRr/W7+Jie87BJjsqBO+MRB/xckssk=;
        b=XJ1w7kZ5cKPGXQCfLskRqFUhA0m624+j//7OKp3M7PGejnvoYOQrcI4U6ZNGjPWBH8
         PnYPISx7bm+l1xxJgDbjey1kplcT/c8nxi0HGO55nKmLGoZNKcDFl8Kg1Mb+gBuYh2GP
         U44HkN0EydEdSSlQo1sB8tcH9YxWqhCt26QfoP1bE/VYIwUzAYINHSxPprIOiAnpJcLt
         /2//3oHe9c7PooEcu6R53SJao36xfsQEPO8Os8npidYc6ZxTuLu/0Y2il5JzblOzlU8o
         OY8oGuWpbvBuWLse/h7rg69Pt/z1NxpswSJ68MRV+0B4x1wGcpxpNgAhHYL4VOwcUH1h
         RNkg==
X-Gm-Message-State: APjAAAUJdIdQDQtkdE97tERwAOXItJIhG2WPx4kU6kN/mkG09H9O+nMQ
        z7+4BMqnbIHtOWbofdoSpkw4t2tfP6Kfl9X6D+4=
X-Google-Smtp-Source: APXvYqzJWSzMC1D1b/OJS7TvYjAsQRrntS+B0MYq0eC2OI90oflw+W/RX2Ead5DTv3wCBRp1abgilw7YCs+3Ha93ma4=
X-Received: by 2002:aa7:914d:: with SMTP id 13mr211719pfi.149.1555627879623;
 Thu, 18 Apr 2019 15:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190418220229.32133-1-tony.luck@intel.com>
In-Reply-To: <20190418220229.32133-1-tony.luck@intel.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 18 Apr 2019 15:51:07 -0700
Message-ID: <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 3:02 PM Tony Luck <tony.luck@intel.com> wrote:
>
> Useful when running error injection tests that want to
> see all of the MCi_(STATUS|ADDR|MISC) data via /dev/mcelog.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

We saw the same problem, CONFIG_RAS hijacks all the
correctable memory errors, which leaves mcelog "broken"
silently. I know it is arguable, but until we can switch from
mcelog to rasdaemon, mcelog should still work as before.

I like this idea of disabling it at runtime, so:

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks.
