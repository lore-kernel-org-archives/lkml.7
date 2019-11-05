Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68305CA9ED9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E2820717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBAoHlIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387898AbfKEHmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:42:36 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37356 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387678AbfKEHmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:42:35 -0500
Received: by mail-ed1-f68.google.com with SMTP id k14so6452135eds.4;
        Mon, 04 Nov 2019 23:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bq/oMc1w9CZddX2/C9nXQ3BMFHPgQLCdmRfeuuGrMCk=;
        b=dBAoHlIfAFubuAAkCQ1bOLzFinxVvIQv3YIsEA8WSu/W6D4AoT2tuQVVEsHCGIZbrs
         L7/dVxXRnZHC20Fjy6lhXs4P14zhLRHeNR+eDHhQtc22epbXPYPkEETJI1ubRAxcxsg3
         D3OArLLX68Wt7NZ7KTH/1rl1c7RttEOCrBfppGBS5sAkgelzbVa933Scmpp+h+pKP9/M
         4Qhhw6fW5xjDrYzBQtZ+NYhxo6hFz7JIE9Kt1uSyDt6zuxsWS8aOcWB2kRdemZ/GqijK
         GuIJt4n8PA49nr/V3XzIPmpXaAoWcvWOHqwPTmUVgDph2tBWFmY3d0in9KDo/jIKf/R2
         3fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bq/oMc1w9CZddX2/C9nXQ3BMFHPgQLCdmRfeuuGrMCk=;
        b=pD7kq2m1kjGXONEX4lrWICnifyvoLJOR3blF/dih0K/nxJv38yGsPDfv3ooNWaEyul
         iMV9fMeOR5BvIersRTSYDBdTMFNhVF1Jqz4rRfc2QqYcdwW0Vp6+B3J61InCxa48m/BC
         T0aA0/fA0AnJUYeYeHnhFqvqTL1IWBDXDHn/vCJY9aWudXvIrxB1TuZZuknN1ERqyugn
         YaFWBhpvsWLnMNqESPB4x73GuBYWcCLHZ4YesXa5ov1nXFZuOG7ZEo0ELJb6QLoiXgVb
         4L1eVR8GEw9d1SqVIxMWUhTJg1XBKwmEJg1/pnLnskfR++obSdFmAEAzwGbxgMUDJXRL
         sltw==
X-Gm-Message-State: APjAAAUWW9HuAoVK8u/DOMGHnr4h07Sd5m0TLOUBXrzVBCKKlgj1rJI0
        HjBbqRuAimaHy+OMEAaNR5gkgCE78SAj0L8iOQ4=
X-Google-Smtp-Source: APXvYqxHxoo2BcLosgwrlvaNTgVtaxbho2YuMgoaxCXaCLIGhgwth9sUWzs89I66sMY4WMTPxx22c3XCPdwtZ1DX830=
X-Received: by 2002:a17:906:780e:: with SMTP id u14mr27332804ejm.97.1572939754050;
 Mon, 04 Nov 2019 23:42:34 -0800 (PST)
MIME-Version: 1.0
References: <20190219012447.5900-1-sxauwsk@163.com>
In-Reply-To: <20190219012447.5900-1-sxauwsk@163.com>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Tue, 5 Nov 2019 13:12:22 +0530
Message-ID: <CAKfKVtEwHcydp=+hNhG91h3qbMoYOPq7jEYjbuAVrWXT53DC3Q@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: cadence: try reset when master receive
 arbitration lost
To:     Shikai Wang <sxauwsk@163.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shikai,

On Tue, Feb 19, 2019 at 8:19 AM Shikai Wang <sxauwsk@163.com> wrote:
>
> When the adapter receive arbitration lost error interrupts,
> cdns_i2c_master_xfer return to the caller directly instead of resetting
> the adapter which resulted in the adapter being out of control.
>
> So when driver detect err_status such as arbitration lost,
> then try to repair and fix it.
>
I am missing the issue that you are facing.
You are having a multimaster scenario and getting arbitration lost.

the current code would attempt a retry did that lead to any issues?

Can you explain the issue that you are facing?
