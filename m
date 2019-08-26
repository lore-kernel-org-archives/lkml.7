Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CBFC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCA421872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUktPM/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733069AbfHZRkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 13:40:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41182 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbfHZRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 13:40:38 -0400
Received: by mail-io1-f65.google.com with SMTP id j5so39276876ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07FbLzlU1Ecz43EkldpfmQ01c+welin2T9Ux9RN+VOA=;
        b=jUktPM/+OKebsv6P/ehphnW7txXBARqsKU0ruH32PE1OiNAW7yGvUkyq4+ekbKnfoJ
         18QQJJJ0+ms68LlNYQJyAwMDc0wrtDZn0oZLbAcZGMdhLqJq1DWNt159dVv1RGCYGbZp
         4Cv8usiDzHIi6fraaFOJtNw2wQAGBDlbgdOs2kD5USWeBiv1vh7d3eDQ/z3VHHDMfcKY
         kmNp1wOZna+Ll+lQTmfx06KtrFNjR9AdjQ/TmSbd9IHGlY+g1WnWfUOtMSjlYvoNq3ZD
         ssgcOGtDlKDQBjLxRqnAjffKFcmGA1bDuGNwzkBERb3jVo6YvYKWaqX6j7+NoqjHNg0R
         i4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07FbLzlU1Ecz43EkldpfmQ01c+welin2T9Ux9RN+VOA=;
        b=RDPu0TtOo5cnBljOZsaXqAfdPp6G5WvmyUOGjUmq6/dSpN6+ELiOqa2CZt6IKWVs3z
         x6j1rZUDrPVX7E85MvT49rxLXi1ACSs05ARiBTqZfwhcbcr3fAoylS1D0E4omS/quR/7
         scZ9ku7AgED3nWuFpYPwNfAOpw3YCgN/ojQjdgKegXs55jHQKSHmXIozyzZcOxHVS9jz
         f2P3sWSLFx2GlX99Y0wbZvRBOFvTsk7KUaoSTxIYGoFmUy0//LvzT64lHUVhepjTBZ7W
         vfqi8dBl1Inx2yQrF8Oe26ZKsZ/zWgR6YE87TP7AeVsUoxF8W2cVsf7v+vjvToJJRNj1
         EUNA==
X-Gm-Message-State: APjAAAWsn7tbT8hRAaKLc8+hIWtR5qCGOMyOb1LDwmQZ/8fVQYCttVo7
        EUqOJhwGhr9MR88n9KrQmr1412gnLJPTj1qrTaWceSk2fbg=
X-Google-Smtp-Source: APXvYqww5diAuNUdEkTEcBBDnreTmON4tALCdYa3hUfAPKmUmf9O2eXoldlz14FrKT+I0D8//8NJYLuMJIA0RpfUjGI=
X-Received: by 2002:a6b:bcc4:: with SMTP id m187mr13841450iof.16.1566841237601;
 Mon, 26 Aug 2019 10:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190826081752.57258-1-kkamagui@gmail.com>
In-Reply-To: <20190826081752.57258-1-kkamagui@gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 26 Aug 2019 10:40:25 -0700
Message-ID: <CACdnJutomLNthYDzEc0wFBcBHK5iqnk0p-hkAkp57zQZ38oGPA@mail.gmail.com>
Subject: Re: [PATCH] x86: tpm: Remove a busy bit of the NVS area for
 supporting AMD's fTPM
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 1:18 AM Seunghun Han <kkamagui@gmail.com> wrote:
> To support AMD's fTPM, I removed the busy bit from the ACPI NVS area like
> the reserved area so that AMD's fTPM regions could be assigned in it.

drivers/acpi/nvs.c saves and restores the contents of NVS regions, and
if other drivers use these regions without any awareness of this then
things may break. I'm reluctant to say that just unilaterally marking
these regions as available is a good thing, but it's clearly what's
expected by AMD's implementation. One approach would be to have a
callback into the nvs code to indicate that a certain region should be
handed off to a driver, which would ensure that we can handle this on
a case by case basis?
