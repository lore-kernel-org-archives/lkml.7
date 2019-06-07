Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51263C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EB5208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Z8ebDry0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfFGFYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 01:24:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33432 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGFYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 01:24:36 -0400
Received: by mail-pl1-f196.google.com with SMTP id g21so375892plq.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 22:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wqe6kl8DbEpNzk+gxBdngVVPGBYURaHyfgLLC4qaii0=;
        b=Z8ebDry0731Ww7qRvJu1pqbm3GJ+szf2+j7eytajaqJtwAmW3D6btMQIC9TE6+64jo
         O+/0zIVJSEEkB0+07WKzaru0XazGerN1yQ9YckR5JZUneUhZIFdtEbAnT7tC7DvMpJKJ
         rpQFIFw6hao9QHiivNPi/3R/tftDhjPcTDJ1N7wOsNPKGhUmguPFRRG9J1gM/spcEeXV
         qIZEhuP55biu4fwH99gVGj7NKohBhWO26CnMlm8NVHmCypHSY+A9TCeJylTpXyV6YY6X
         IJ8lwnD03PZ7c65ptZXQcHsUXprO4wtMuHRCQcZBRQ8U7A10xh2EIzznYo7A9WKotKJr
         sD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wqe6kl8DbEpNzk+gxBdngVVPGBYURaHyfgLLC4qaii0=;
        b=NUeLjTY8QIH//ck0h3QKz3uDHwcQBERyBQ+ODZuEjsicRRubMXM9un1w18VXIjjqAR
         8HEtjbNCirbYCYfA61IDsFRMOnqnarL6xyKW7ciTyCWQ9v6DhHa2OrRCWiRyhNCKSxNc
         tZNlh/grKRzdKaKFE5m3FDaDjSEwGM5W4VyiIYJ7ioRr7A9wDGcdBRrgVnZuwPElZGBM
         ECcRwswIi2oowVn3sec/YpgnfpwU3Y8gCeCIhx6uFCx3XSvmjmXYRXPIMcQ18VZOetgq
         LRVnn4KpIS9xOg9zLkm582vEfQsu6eIugjK2a6iZZGMUVOyLXM2T3Pq4jiz9UrARa7Ul
         iarw==
X-Gm-Message-State: APjAAAXKX3JKAiQvvzwzDMA5y3Rnwnf9R2VSovPoYJxF+ssWvwCoGJO/
        nUys2TPvTkiH/1vco9vFeZN3MA==
X-Google-Smtp-Source: APXvYqzQFNiED7FnxJJgBrM9ljjzZaPd8GsA5Es9uz10QhQqODIm1yA+jRKiFrpyJIhkn2S/CAFDyQ==
X-Received: by 2002:a17:902:9a84:: with SMTP id w4mr54404661plp.241.1559885076185;
        Thu, 06 Jun 2019 22:24:36 -0700 (PDT)
Received: from localhost ([14.141.105.52])
        by smtp.gmail.com with ESMTPSA id t187sm881078pfb.64.2019.06.06.22.24.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 22:24:35 -0700 (PDT)
Date:   Thu, 6 Jun 2019 22:24:33 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        robh@kernel.org, mark.rutland@arm.com
cc:     linux-riscv@lists.infradead.org, Atish Patra <atish.patra@wdc.com>,
        palmer@sifive.com, linux-kernel@vger.kernel.org
Subject: Re: Patches for v5.2-rc and v5.3 merge window
In-Reply-To: <7hr288exi7.fsf@baylibre.com>
Message-ID: <alpine.DEB.2.21.9999.1906062219490.28147@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1905201019010.15580@viisi.sifive.com> <7hr288exi7.fsf@baylibre.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Rob, devicetree@, Mark

On Wed, 5 Jun 2019, Kevin Hilman wrote:

> Paul Walmsley <paul.walmsley@sifive.com> writes:
> 
> > Palmer has asked me to collect patches for the v5.2-rc releases and v5.3 
> > merge window, so I'll be doing so.  This is just a heads-up so no one is 
> > surprised to see 'patch queued' responses from me.
> 
> Speaking of v5.2-rc, any chance your DT series will make it for v5.2?

Ideally it would be nice to get acks from the DT folks first for:

https://lore.kernel.org/linux-riscv/20190602080500.31700-3-paul.walmsley@sifive.com/T/#u

https://lore.kernel.org/linux-riscv/20190602080500.31700-4-paul.walmsley@sifive.com/T/#u

If those come soon, I'd be fine with submitting them for v5.2-rc.  But if 
that stretches much further into the v5.2-rc series, it seems best to 
schedule it for v5.3.


> I'm hoping to have upstream v5.2 ready for testing in kernelCI, and
> that's one of the last missing pieces.  I just tested it on v5.2-rc3 and
> it's working great with mainline u-boot.

OK, great.  Thanks again for your testing help.


- Paul
