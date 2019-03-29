Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC9FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0DF206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfW+aNyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfC2Eft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 00:35:49 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:42438 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfC2Eft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 00:35:49 -0400
Received: by mail-vs1-f47.google.com with SMTP id f15so548434vsk.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 21:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FQldz48vNW9OK2WukSjYAj0Z3f4ho6mRKqeWeKRw6S4=;
        b=hfW+aNyMRbnhcFHa7lWN0c1ol7wSlH59DIrPmm0djOhy9KvmajraXPQar5D56yZpVr
         j6C/QcdVRHtXtWz+Zi9jPM5wdhd6HT4nIMwGRd0LuAYvdJ5c9zzU9d4ozMAyUCSjRTV2
         IGOIcCDbZBOehVa9RQB2KZTGScVecqaF5/GEFvoQhErnsUD0Fh6Vpt97PnBy1hZWcmpr
         SUtnTDBA0lQJAi/cCCJ6gHa2GATNTd0NR2d+YLazsTDc9rrb2l5uU95AO5GzEryTghSK
         Hv19JZqsPxVCPDyW9H5SjsBxufrfoMY8uqsFMF4r6qeetraQsoa7KFgXxuw/OwsyHWVT
         navw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FQldz48vNW9OK2WukSjYAj0Z3f4ho6mRKqeWeKRw6S4=;
        b=CkEDLK1YFHv1DO2H8iqGeGdM2kbg/gvFTT5dk3AW+AcuuXN/+JVTKA/NbpT880V9Yw
         bX6u9tGEmFlGPVObcHIfIkTV2vVPneukyRS5BAA9r/i8/EziA1TE2ZaszPH4+dE+2+WS
         DNvZNhhaqVLVr7lMWFKBBOVlcwfFZcc4ZqhyDTHJ4rW364obVTP5RHtVu11dr/A/00Rc
         r1jTKjkIzE0WC9VeQVN0/NE915xjlks1W9TXzUaT64nKWLc3cFQtIJyHZzmUYIcQR+Fx
         GEH22o2cGf46+CS60NFUuWwi7T7dRU/m8bgyOarZA6yhZmXoittqDItkQYxBCaO8J4Yo
         XC5A==
X-Gm-Message-State: APjAAAUnE00b4TIjv+FSKzUOGYLqhaRIbHXJMAp6uGgA3ZkpAGCFfuX3
        AaNrX0yt0IpYEg2tvcVtcyRkKvjl6FOkE334DXv28A==
X-Google-Smtp-Source: APXvYqwAgP1RO6q/wf0ficLCpBB/CXMBTQELWG0on2MuOd9jFio35zl4rYh/kPK1NVHuzyplCez5B+gF4iimGznmLGg=
X-Received: by 2002:a67:f694:: with SMTP id n20mr28203411vso.9.1553834147852;
 Thu, 28 Mar 2019 21:35:47 -0700 (PDT)
MIME-Version: 1.0
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Fri, 29 Mar 2019 10:05:36 +0530
Message-ID: <CAHP4M8VDaAQF=5DTNX2SoMmytNwjsa82i1qfx3FnFvpjH4eYVg@mail.gmail.com>
Subject: Query on how WWAN and Modem interact
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.

I am sorry upfront if this might seem like a stupid question.
I am wanting to have some insight on how a modem plugs into the
linux-kernel at architecture level.

First a bit of history.
I have prior experience of using an onboard-modem on a ubuntu, via
support from modem-manager. There, after the modem was (successfully)
set up via "mmcli", the "wwan" interface started showing in
"ifconfig", which then presented itself to be used just like any other
wifi/ethernet listings in "ifconfig".

Now, we are in a bit of situation, where only the AT-interface (of the
modem) might be available to us (via a serial /dev/tty interface).
Also, using AT-commands to actually set up sockets is also fine.

Now, my query is once the AT-commands succesfully set up a socket, how
does that link to "wwan" interface in "ifconfig" listings.


Will be grateful to have the experts throw some light on this.



Thanks and Regards,
Ajay
