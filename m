Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7E9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE9420811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0DGpMKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfDWLOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:14:40 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44024 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWLOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:14:40 -0400
Received: by mail-lf1-f67.google.com with SMTP id i68so11416169lfi.10;
        Tue, 23 Apr 2019 04:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ZdAYYTQTE6CwxicfOwg//XFX9eyEJGiAoUEgu4DC8Y=;
        b=L0DGpMKM6Z16Ym1N/bwzrtCFgJ3XEJyF6CP+VYK9ZFjAW4m5Jnt/rlqA+1B1NWONqI
         BeZJlgxfKjsM9/rkm0fo9kyIS4LRm4fKAteEEKtnLXxFquXKQtOpt2DUb0oyzBitOMJR
         INP3rtAztLw4swqP0D8bV9rsdUu4/qIcGu3OGrqCxWEDflbstkjhvl3Mr/Mo7y7C49CR
         1OLkmZ4BogmJ4Yatt0yENzoqeWGPMkUFfToMwieIQNiKgn8VxaIYNbqWfI2VlceGKdqJ
         mReJPaWLs1WBSrtIS1TIxsvoovxaIcebaCbNygzR4QHYlKz1cEgeBUPHNKMiPcKIFdft
         3Lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ZdAYYTQTE6CwxicfOwg//XFX9eyEJGiAoUEgu4DC8Y=;
        b=dxXNFmZHMlA/ECMTLu04LZWNv8OA1+mCOo4kCK+eVBdTLnHkNX2w/YDB3Z9RdTnwJs
         Ydp1mG6/J/+tPrsO8Spk55CAjIP8pPjydIdPQ+OaZNHti89x/qNnzs72dOrCzT1zJixW
         ZhwpND4z7sAzDbcECtiUO2G8AGOlmPrs4q6Q4fzxxWLtJB/1jPHsOLNkBtjRqdcvz/G8
         2gkUGK2T+q5IIP3JwP+rzYJLWlbRytRmcTHGm939GShD9CI092ZcbaqTn6sZhHpEjs2l
         tiMyvwgbc4uZKxnDba29hOVQ34VDBmFX7lf1DnTLXzhogocvTHftHwU5FX1ygDYA8CS1
         UU2A==
X-Gm-Message-State: APjAAAUXMdqxrymrGaKabIRU2P8K+zcyoy7uZvawKZXnxbla1hFIt+W/
        BOT2yqIpjhMX0IDI1aSjr4gG98gmB3nSRnDOLCm6nT9k
X-Google-Smtp-Source: APXvYqwUWQRDZPa/J4NO75cD0/eZcPcek5T0bLIbu9yQQ/N44LPbDDhuCVot5PFbH5E3Amd5yY5zAnFfyQZ6JUcJZkg=
X-Received: by 2002:a19:f001:: with SMTP id p1mr14429836lfc.27.1556018077647;
 Tue, 23 Apr 2019 04:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190423104649.24483-1-xiaoning.wang@nxp.com> <20190423104649.24483-2-xiaoning.wang@nxp.com>
In-Reply-To: <20190423104649.24483-2-xiaoning.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 23 Apr 2019 08:14:35 -0300
Message-ID: <CAOMZO5CQW5MvrTVGsoByUUcOWmSVowMUKcMzBhybAx2noHakbQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] spi: lpspi: add NULL check when probe device
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

On Tue, Apr 23, 2019 at 7:47 AM Clark Wang <xiaoning.wang@nxp.com> wrote:
>
> Add a NULL check for device node and lpspi_platform_info when lpspi
> device probe.

Please explain why you are adding such check.
