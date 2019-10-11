Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24400ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B502089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="xKc0p3VV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfJKNCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:02:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38798 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfJKNCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:02:07 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so21291983iom.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 06:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCbZq/hUyP5r2jjZatlAcl9+75dsbkKkMGSPwgSLeag=;
        b=xKc0p3VVbNkClZxg4MXb8L+cjBdPdHB+cAxWfLyH8qRvTvSF4cxkqJvQLCwzBMvmz6
         UVaNWQyPCQY2NshBqYqdq+Jbcya24xawk45Cb9cMYqMmRJSoBjzAdsI1PRm2gl2lxof8
         4LAYm3v3k+s2+csOVkkMnt+ZDZLdElleOU+g1NdtSqiDe12Y9b/InR3id/uQti9QhFwQ
         5MbSioC1pWtu8jZPohDrqQBThiixpAGrku7thnRLrynn+PAahln65WEVxUhPnT3EX5jb
         gAzC5FZ3IKbU7RgOzoEuUBIXwznrMMIVwM2EGJYHD3/fZRJIXHYWvl4OwO9fYA+3+9nw
         pEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCbZq/hUyP5r2jjZatlAcl9+75dsbkKkMGSPwgSLeag=;
        b=MUGidZvCQKgFqZdi8XywALTyho8j9+NVg4/9QKhoLQs6gyNEl5NBuoLThpT4jBOHNr
         ZExMclH+zzUhediM6BSVyYGCqiC01hVunPqgEl3LpRzZpskhgOdK6fR5faMC0kRRAB9f
         LibsI7RXB8+XlTOpd2T7q/u34MI4ON3NXNd+o2yLj2uS8IZ1rJVAOvXQpLr0XzXWQ+yA
         rWfw3OiBlUxnLgdzCap9c7jINit6ezf2d/TzZV+3jmoOiazp5EcwHgv8hMDpGUiG55pM
         GEHx7ywCVUZnSMxo9N6plNwTgWydid/Z2x+lk8OsxTS6g0I7kzLI6oDAhK4kCyPnnav+
         ozUQ==
X-Gm-Message-State: APjAAAU8TZDFlUxI+87+iZdT1eAuQP4ipnboRlH6ncMmf/MpKHBFh9ma
        /m9rJwjuW+ZUJIk7Bt396Ipbccw6vko4KQzgmjyi8SLIzvo=
X-Google-Smtp-Source: APXvYqzsIXbsyYmQrLrE55mSFNo7u08nfXsRmH8x4jRYXyeC1UW6Rss6a6oq++/s62jkWP3tbV9E4VzF8mSHRfIkfDo=
X-Received: by 2002:a5e:8209:: with SMTP id l9mr17704585iom.84.1570798926690;
 Fri, 11 Oct 2019 06:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR04MB70236211F170522DD456553AEE940@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <20191011122409.23868-1-joel.colledge@linbit.com> <VI1PR04MB70239DA9EED5F689645071E9EE970@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB70239DA9EED5F689645071E9EE970@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   Joel Colledge <joel.colledge@linbit.com>
Date:   Fri, 11 Oct 2019 15:01:55 +0200
Message-ID: <CAGNP_+Wkya-wn-ckAmCoC0Mda=3cBDi4vYeZj-9SWT0EF8ja4w@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/gdb: fix lx-dmesg when CONFIG_PRINTK_CALLER is set
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 2:47 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> This struct printk_log is quite small, I wonder if it's possible to do a
> single read for each log entry? This might make lx-dmesg faster because
> of fewer roundtrips to gdbserver and jtag (or whatever backend you're
> using).

I think this is already covered. utils.read_memoryview uses
inferior.read_memory and I think that reads the entire log buffer at
once (at most 2 reads, one for each half).
