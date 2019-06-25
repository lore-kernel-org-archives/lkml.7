Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6999C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCC720659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHf6EO0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfFYG2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:28:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32899 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbfFYG2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:28:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so1503620wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 23:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jYVUnCLGEGCUpVkgskMbM5l204GoA4GJjZWfAQ7T790=;
        b=uHf6EO0v81KbLqZc9T/v2LfMVfAudfWpOhn1h+GxiuKg3fsfjYBI78axu41gZCS0rz
         WjqENquq3Dui+obgw8H/lBjZhnyX9UeDgDf898QsfpbKjPctGa/2rEaOh8p2RYnwF+ic
         go3lcxlr2HKQCoGYUt/Ms3VvtcDlGg6fYUBXvs+1P2Clc4YEPo9v4dIbJnLcpugC7/o1
         gtM/dUvu/aEKzmvaqULoDNCoAxb9JZT15vl7J8IEHTAjIxJvZeqEo3z55rQs/PLt0HbB
         VZCda5tWZ+2uZAZsGdkuNO2DXC9GMouf3/EIYnrO82rHZiTfo0Pe+6cK1L5QXvxY4idL
         7wCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jYVUnCLGEGCUpVkgskMbM5l204GoA4GJjZWfAQ7T790=;
        b=dYbn6INqDTxBNZo6QTwuIG19uZ5JeOAGsUd9MSBYfThuOj12Fo2vRxkyz22g24klOc
         cTXvhFxQ/7BEzCB6u2i6+nEOBJ88E+Tav+LrpL3oZokxI3z5l5MtW3zRu0su8AN6YMsO
         YGeV1U/5X2QTclj0usf8ZoFnehD97+iwKZaIEeYECVsG8kobRtX2sgoHGSQQHu+r79DT
         rZ3DCV/IkVMb7Nza+bROpxI7OnyU0YYdglsb6yVowTcQPOP6G/JCWdX6H+pZFTRUY+1n
         J5D80iUzMwjpwh+uz50Q0jGK+xlILGL7Xgq1EJqvKfmFe8sQLamAymTrUlQgrY6GJcMH
         ho4Q==
X-Gm-Message-State: APjAAAWFCXXysZyi85EuK1uLQQaklhin0xDiNudMxLpegpNez4/A1JaQ
        ltLXFt2cNKYWqpKJSrdk875LT8c1GZY=
X-Google-Smtp-Source: APXvYqwDDHlVUs0Sv2fotsOCsTsvr4n8mQcOb1k9DUZlvHWhwbczJsUtkdinqz2PFNEzEvG4KQn4bA==
X-Received: by 2002:a1c:c747:: with SMTP id x68mr18614715wmf.138.1561444090302;
        Mon, 24 Jun 2019 23:28:10 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id s3sm2555102wmh.27.2019.06.24.23.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 23:28:09 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:28:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL v2] MFD fixes for v5.2
Message-ID: <20190625062808.GC21119@dell>
References: <20190617100054.GE16364@dell>
 <20190624143411.GI4699@dell>
 <CAHk-=wjFZr5xfa-8t=5nhcMDzXQeu4wBggJ1htc7Z5T84dQkXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjFZr5xfa-8t=5nhcMDzXQeu4wBggJ1htc7Z5T84dQkXA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019, Linus Torvalds wrote:

> On Mon, Jun 24, 2019 at 10:34 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Hopefully this is more to your liking.
> 
> I would actually have preferred you to throw the old buggy "fix" away,
> and just do the final state.

You okayed the follow-up patch, so I took it as-is.

> But the end result looks sane, so I pulled it.

Sounds good, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
