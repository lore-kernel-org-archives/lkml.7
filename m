Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F330C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4922084D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QWAqqTMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfFNSMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:12:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43163 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFNSMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:12:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so1320166plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:from:subject:cc:user-agent:date;
        bh=ScI87c0IlyAE4jve6HhJl87g8VW2jGMqM1x+hPj+aK4=;
        b=QWAqqTMajs/XZNhqs6M7SHMK0Vph4q8kiNiYzc74G7ZO/RNh4key5pn13WMRBtEX1X
         AAQX0gnsntNJzdMwktj7O8ph/WnIPp1JEOab3RHbCzN3Qd9OBSBOBdU524+ULyLfVB0/
         ofIM0+OkjC5qOQAiggLyxuXOR3JXrI1aDZnS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:from:subject:cc
         :user-agent:date;
        bh=ScI87c0IlyAE4jve6HhJl87g8VW2jGMqM1x+hPj+aK4=;
        b=PNaR7WQMMx+BnS5lH5z2+YSAt1DEki1kfm5XYjgcgyk8mR04kZR6wqjeclLHEHlKxt
         02JYTT96PEzpcLDBLkpFdELmo1YfiGfC3K2Gvqm5dvVz2o2LFu6IXeNDiTqbrM5t3+d8
         C8IxDlswzK0bn0G7S8zd90T9R01IfA8P7MJaJH1ZmMmhmRfxXmNGYQPijZ32qQZZ7qdo
         3WnydSN8TYq/yeKnXjFLkwI+CHtcGArfgy7TaqTWH9NhZG9fWJJ4tKOkSOThY0dyQ0W7
         c5R0jxrCXlUimKWhOEpQufRc/LU7cdloD07NAtqPZTeiP+1rQJXz9WoFra3QYzPzCgEt
         gYeg==
X-Gm-Message-State: APjAAAUZiqf1J0uyJNPC7eUf/AAFEhWltFhsX3GNU2fW6OUc6cpOAGQj
        votb2Qm/tExAMIHOCp8uAqwwHA==
X-Google-Smtp-Source: APXvYqxHj8VADlpF2bda26NGYbtU+zSPrYY7vRhzkruDiV7jwCROz0D4JYe3qNdSl1UeO/wmCq5KMg==
X-Received: by 2002:a17:902:15c5:: with SMTP id a5mr96105932plh.39.1560535957521;
        Fri, 14 Jun 2019 11:12:37 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a3sm4154500pje.3.2019.06.14.11.12.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 11:12:36 -0700 (PDT)
Message-ID: <5d03e394.1c69fb81.f028c.bffb@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190613232613.GH22901@ziepe.ca>
References: <20190613180931.65445-1-swboyd@chromium.org> <20190613180931.65445-2-swboyd@chromium.org> <20190613232613.GH22901@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 1/8] tpm: block messages while suspended
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 14 Jun 2019 11:12:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jason Gunthorpe (2019-06-13 16:26:13)
> On Thu, Jun 13, 2019 at 11:09:24AM -0700, Stephen Boyd wrote:
> > From: Andrey Pronin <apronin@chromium.org>
> >=20
> > Other drivers or userspace may initiate sending a message to the tpm
> > while the device itself and the controller of the bus it is on are
> > suspended. That may break the bus driver logic.
> > Block sending messages while the device is suspended.
> >=20
> > Signed-off-by: Andrey Pronin <apronin@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >=20
> > I don't think this was ever posted before.
>=20
> Use a real lock.
>=20

To make sure the bit is tested under a lock so that suspend/resume can't
update the bit in parallel?

