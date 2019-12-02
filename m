Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E47C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12468214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZR7294q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfLBUBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:01:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23645 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727586AbfLBUBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575316891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zacL8ZwUfm9ACoXwRxpaHO5nNuk5Pt/tAg3zBrg+MDU=;
        b=ZR7294q/DRN0lSDPxYCkF7aLSVYZU0ZQ4PBiPpfUDYkU7ORjRJkZNQDbopgrNvYaJ8o550
        THcHP8o+zIuztEwfo/bnoVYHRVoNDFWyCMcL3NVMPOP4y4kdy4hqt7ClgpMlTt43C48giW
        twVqlj6Ebnms2UdSDsFRrRpmiUZizeE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-n2vhfZ9JNKS5MpSsA09Vbg-1; Mon, 02 Dec 2019 15:01:28 -0500
Received: by mail-ot1-f71.google.com with SMTP id c9so249358otm.20
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 12:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijUXKcWVOy6uyc+9TN1aIhkDvnkVi2DmgHGgcMYXyg8=;
        b=jAgAyTHRans3w2ng2gdRTUAWxzoSuKJh3LRozAvWMCfJ47AGzC3otuWLR6GuFHDtQb
         LIDq4fH8rKhlyIQwnF79r+OPZ5ej35o29wC50zFKbV1N2vJhyDOi++XSCdqBRwVooSXj
         u9Wiq48aFtsxEC48fvqomlrcTrTZG8VOCMBq1uw1GmEDHKZukuJUtqmoDh4fRJ1DtuGQ
         7DM4AA/5U3bQoJvrOspgmzHmmdEzfPwTf94HpTF9uppzmEqGFxpKRAQqswZ37eXAOjWg
         c6Ga4mdqVbcn7KPwEaFadWdlsRy/Hhmv2eZWJBarCVycDzz5ohxvwv/vLqgDwACu1Spy
         QpPQ==
X-Gm-Message-State: APjAAAUKrSI/xwlHFY+fRsI/Xdfhkjh2jexiPRfbLTzw6CTvFoOrXDNA
        JjmAxLpLlG58wxdWrogjuIzMI8hQFH535Nv1EOjlUx56FbxS4U/k0SVFyBBsY0X4OYKTbspv15Z
        XiwfOSvLSY1LMhkzbPmeiVooUHMqJulJuamyrtSif
X-Received: by 2002:a9d:6842:: with SMTP id c2mr587959oto.336.1575316887646;
        Mon, 02 Dec 2019 12:01:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyMdBme1c9WpgSFSgNXAIaU6jfbxGCDDzMLm0j7YrB0Sco90y06wXmXOeN/FpJHGpZ/O6xcsvuz4LhYjQo9Iu8=
X-Received: by 2002:a9d:6842:: with SMTP id c2mr587947oto.336.1575316887450;
 Mon, 02 Dec 2019 12:01:27 -0800 (PST)
MIME-Version: 1.0
References: <1574324085-4338-1-git-send-email-clabbe@baylibre.com> <20191202133254.GA21550@Red>
In-Reply-To: <20191202133254.GA21550@Red>
From:   David Airlie <airlied@redhat.com>
Date:   Tue, 3 Dec 2019 06:01:15 +1000
Message-ID: <CAMwc25obOebugXGSNVWd1bjPN+tR82wwFJ6PgqnvZXK4O6xAFw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] agp: minor fixes, does the maintainer still there ?
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     airlied <airlied@linux.ie>, arnd@arndb.de, fenghua.yu@intel.com,
        "KH, Greg" <gregkh@linuxfoundation.org>,
        "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
X-MC-Unique: n2vhfZ9JNKS5MpSsA09Vbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 11:33 PM LABBE Corentin <clabbe@baylibre.com> wrote:
>
> On Thu, Nov 21, 2019 at 08:14:40AM +0000, Corentin Labbe wrote:
> > Hello
> >
> > This patch serie fixes some minor problem found in the agp subsystem
> > There are no change since v1 (posted two years ago)
> > This is simply a repost for trying to get an answer (gentle ping 6 mont=
h
> > ago got no answer also).
> >
> > Regards
> >
>
> Hello
>
> Does the AGP maintainer still maintain it ?

It's maintained but really loathe to touch it, I've no hw to validate
any changes on so making any changes to it really has to get past my
internal, I care enough about this change to risk applying anything to
AGP.

I'll try and look and apply those patches today.

Dave.

