Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349CFFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7FB21928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="EriZvZ61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406329AbfJPQcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:32:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35240 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406213AbfJPQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:32:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id v8so21836039eds.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=li50XsAB2VPn+/18ATYBNIxXsxb19ToHWwK0bY8hLFo=;
        b=EriZvZ61/49DnW9dz1N6YVkL3EQI5Lg969vC0qrzamzjwn6BZXK3mNc4zXESop9Ht8
         8CjEtCmCXmbrJcvEsIaAU4PbtYeSSh1vqiydCkR7uNOqvco0uLwmWDNiUqc58T+V/BVX
         zjwg4IrLhgbyuro1W0BPs5bCjB2isSWb676pC92EDjFaSKG30Zuw+1BdmwJJu+6y04yu
         7R1KsXWcYZK5Lp4CsSMcotyzL4pJOleBxBdHGW4asmvOliAE6Kqn+ecZ5W05gayLDD9d
         nNkhDX3nBZ8evYz4uk7Ikv23R+7+0wiHE/WJDnHEynPy/NHBOzzfeF9q3unVifwjicuU
         zGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=li50XsAB2VPn+/18ATYBNIxXsxb19ToHWwK0bY8hLFo=;
        b=tKtm2w6XcfwAOpeEnbyiHq5QGnjg4ge5+d1uCT5ey6CAfsiZ62o14A4R85rLRsaVJ7
         GMUxhUVBwKrj0WBH4iCTAxD4b2/MopDTtaTf/W5qbYraeIL71C7qdcoLPJpJ//9UsF9D
         Rwmi1PJxGytxu2oXUvDdYXjFjCzoSvWKa/ymcCaypTUqHBPS5EM9v8pd5HEDfagCd0/2
         A+zhHM0yFP0WKOHHRAn3Fn/gbuX9Ki4zOw3dt8rKluI5D8JKt8G44/ak1Dwcjix3NXlT
         bvfZfFmXntVvWjVpYhNAMng/AR2c2cr4Ro63dojrE9WdO2v6PP+k6+4PHVigMpeWAL2w
         G8iA==
X-Gm-Message-State: APjAAAVKjsgRJfWhX2KR0NaRURX7aC8ssqWYxzMMeVVTTw/nQ02OfRu1
        gpcEzQhKZQtjUbo2zAJ1jSKuYbToiLQAShggA6hYdA==
X-Google-Smtp-Source: APXvYqwxzVM4CYtWezB0pwXW5mwnwa3o7i3cBWeQj1ynMkvyu/Uz7CIBBn53oyJLn/r2ogqRCDiHREeACm67YSs9mBk=
X-Received: by 2002:a50:cbc2:: with SMTP id l2mr41075561edi.304.1571243524399;
 Wed, 16 Oct 2019 09:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191014202135.429009-1-pasha.tatashin@soleen.com> <20191016151246.GA4261@linux.intel.com>
In-Reply-To: <20191016151246.GA4261@linux.intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 16 Oct 2019 12:31:53 -0400
Message-ID: <CA+CK2bB+q4HLnW4Yf+0yFPb0K6B-kMdP17jnh9NjYpLWj=yBgw@mail.gmail.com>
Subject: Re: [PATCH v2] tpm/tpm_ftpm_tee: add shutdown call back
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

On Wed, Oct 16, 2019 at 11:12 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Oct 14, 2019 at 04:21:35PM -0400, Pavel Tatashin wrote:
> > add shutdown call back to close existing session with fTPM TA
> > to support kexec scenario.
>
> Sentences start in English with a capital letter :-)
>

OK

*
> > + * ftpm_tee_shutdown - shutdown the TPM device
>
> A function name has to have parentheses in kdoc. I know this not
> consistently done in the subsystem ATM but this is what is documented
> here:
>
> https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt
>

OK.

A new version is sent out.

Pasha
