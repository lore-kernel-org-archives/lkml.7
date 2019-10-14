Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7D7C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700282089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="O3lfujFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbfJNUR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 16:17:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40662 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732419AbfJNUR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 16:17:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id v38so15892952edm.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TmTTVnr6ZM5whoKrUx/7AN+GKz0T5h8z5E2EWOl+iVg=;
        b=O3lfujFHY1PPhG36UaRRX0oF/gqIf4OJ7/Z7pncf/y1kQw+1Yf4DaEkSOtilUuphko
         QiXu0p6CRky10fDxScNgTGhmP/VoFUCWu+K8BLIDBiBCSLSlni54d7sTdNA4u3bjITmb
         HXf4iHHY913FxNdPUjO6B+7sc3g/01oWt6nOLJqc5k1Qww+Aup9TDtnzlzhogbwCpfol
         Tq/jjI/mxoqvnGhJ77/qr6geWk7CBfvDvp4qs3HLvS0Xc80ZfoJfEBLnF24hWbcMncp5
         FuP6cTxRRJwDuYG0CWnmkPIm+XUJLGEWEOLxTpxfMH9CbtCt9Nt5AuYyefm9nQuJQKte
         5v5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmTTVnr6ZM5whoKrUx/7AN+GKz0T5h8z5E2EWOl+iVg=;
        b=PYo9kb4c18wHRZBkTAxNgoENVNQsX8pwz/R53Os/sNpghvjoHN74NJnaED9M0ljtJh
         4tZwyLG60ND4VBu+a5iXW9g6pzJ8GKHr7TWRF8gpUL6TXcsACBtCg5VkokNjeArsEAZb
         pOvafEbNuZ60vZFdERMFaqr7Lg1psXkmxtNd0+94ush2vtEMXqDK226I6QoxL+sRb2yq
         5SnvhgLJEsx8PCQFuVXrt511PJv8/kXyiaEtfM1dnT+66LaX+uJDBNDKGNdwekHyvsRq
         56PggP2ZtCdAkjj0j/APXugYI7uQAISNZ7zfJK+Dx8X4k1oNzKGwcyBT7mLLfcwajW/o
         CtkQ==
X-Gm-Message-State: APjAAAUF7zbQVMLiASoRYf1esW1cZCLACABX66+DDLtCoDoRf/xBWOPc
        VPP9N7wddsZ5V1lqy4YmQ8LqtJTdnBudVT4Uv5L2Pg==
X-Google-Smtp-Source: APXvYqxl9VbaNXdm1ZF2nw1U0O1w4RLqxmng5mXqFU2kIdhflAZ5y6fd8Qij4k7/mkA271HB67h7UEOiXMdnN9Ig5Ts=
X-Received: by 2002:a05:6402:68f:: with SMTP id f15mr29322899edy.170.1571084277286;
 Mon, 14 Oct 2019 13:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191011145721.59257-1-pasha.tatashin@soleen.com> <20191014200309.GM15552@linux.intel.com>
In-Reply-To: <20191014200309.GM15552@linux.intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 14 Oct 2019 16:17:46 -0400
Message-ID: <CA+CK2bCeO_2XkVLAbe5857F3wv-zJQdc9HLyedi3u2+xO9dDFA@mail.gmail.com>
Subject: Re: [PATCH] ftpm: add shutdown call back
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        peterhuewe@gmx.de, jgg@ziepe.ca,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 4:03 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Oct 11, 2019 at 10:57:21AM -0400, Pavel Tatashin wrote:
> > From: thiruan <thiruan@microsoft.com>
> >
> > add shutdown call back to close existing session with fTPM TA
> > to support kexec scenario.
> >
> > Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>
> Use the correct tag in the short summary (tpm/tpm_ftpm_tee).

Hi Jarkko,

Thanks, I will address your comments and send out a new patch soon.

Pasha
