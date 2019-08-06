Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0771C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4A72189E
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="N6BSRdRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfHFVne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:43:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40175 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfHFVn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:43:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id w196so47521373oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 14:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vhe3NIF3L0LjxKZNqf8InaUKQ77kVe6kvjOAn65IGds=;
        b=N6BSRdRniocyn4ejlcjwILFWDY5joDFEbRQhIX1AV3bb0FBmT0j9KxUwDXMLa++MZs
         k6h1ebPWOtIsRz3NyUJPFrWYFFSMrBfHbu7E0A0KAwLWVPEXCD5plJjT63hJZzL3fxkt
         0yGnwzx1sYkDaa71qYxpu9NQ+QsI7pM68XvRIndMRxUXHCIqf5cPo+e3lRuARXbeyiVV
         736nExQHV6Kj2t1IUCEAAagart90x4gg/BeRVdQ5n0OaSBrQan67Z1S/vbmTVNgUmQIk
         sRWsPm+iIlVEXks8xrRmyl7uoe4YSOmZXNLgrQS0eddPTf0aawpGHZaP+O0PVSuFqe7f
         P/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vhe3NIF3L0LjxKZNqf8InaUKQ77kVe6kvjOAn65IGds=;
        b=A/sKLxlUP6lvLCruY65uf6wRHVyhGzFqu5RT61/rm4sKhdKk1eKXlY2x1sKaoICVDu
         7OXx4O9c287cnb0/PzFq+zr1JdBTeKvKhxKXysyAwjmTjYq0wM7Qapb8k/KfAUgM3Ouq
         EFehoSbhwTIQyvk6G4qlE6Dr3ITNwXCdcvacD7PyTpjSgoyRDF3u8VH9cx6p6lzX2epd
         0kO030xKY6I1+ycNUduO98NJKl12tjrkPXQFc8rG/cnNxvviNFQR4s21mg1y27avsliM
         +3KmKtIGx0z4C13ZbrghNY38vS8wXMhuErQfNjK1QOmvktUuYXilvrzErcnzmkm5N6gY
         Ps5g==
X-Gm-Message-State: APjAAAV2G5cFljVk2ABmgTzsTTiDL+4ZILPcK7dHSxEVQXexAWI09sii
        jWfKaevPiPJRulDwAKbGmRrzpA==
X-Google-Smtp-Source: APXvYqyktUJakypJR/fPYCChZtne19bHMs3XPkuT+lRzZxUNjA+2z6Ue4aq5O1qokA7WMUjW9h+gzQ==
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr6748787jan.90.1565127806394;
        Tue, 06 Aug 2019 14:43:26 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id d25sm73339652iom.52.2019.08.06.14.43.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 14:43:25 -0700 (PDT)
Date:   Tue, 6 Aug 2019 14:43:25 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 4/4] dt-bindings: Update the riscv,isa string
 description
In-Reply-To: <20190803042723.7163-5-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1908061443140.13971@viisi.sifive.com>
References: <20190803042723.7163-1-atish.patra@wdc.com> <20190803042723.7163-5-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019, Atish Patra wrote:

> Since the RISC-V specification states that ISA description strings are
> case-insensitive, there's no functional difference between mixed-case,
> upper-case, and lower-case ISA strings. Thus, to simplify parsing,
> specify that the letters present in "riscv,isa" must be all lowercase.
> 
> Suggested-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Thanks, queued for v5.3-rc4.


- Paul
