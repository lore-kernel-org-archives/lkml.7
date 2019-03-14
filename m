Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDD7C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2255A204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZ2CHrOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfCNVEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:04:15 -0400
Received: from mail-it1-f175.google.com ([209.85.166.175]:55111 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfCNVEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 17:04:14 -0400
Received: by mail-it1-f175.google.com with SMTP id w18so7010718itj.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 14:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/584qEVZ34MgPe0XR5WKf2sRo/jZ4h83aaIDZjCgi4=;
        b=SZ2CHrOQHtyEd/T6fUxaOgECELgJoBbA4SovNoY/rTObhOR3lIRO6IwCW8cvBRN1i4
         cEFAJPY6C0QdnfVYOjYA04UmJyWmHt+6v7e4EQINhq+izbvLaNj5NFvw4srb5KX8wG5C
         ZhMLIhor0GPTL6L3tpgCFrZhI3M7MBGYAHIbf9LlnKil6qUhWpaLu5Be7dxGaupn8pTS
         fHF3ADChT8uciJEXaj6CcS/0H60gRdaGNlRe6dxdIYd1dyGy2bWh7WwUrRIgMu2FX9yk
         Y0LgdFW72jj4UUfj7ssqe4fMiadCpzeKbsq7PlxuREbefWTMQnpdHCC2gCqM3jHVijZj
         ASPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/584qEVZ34MgPe0XR5WKf2sRo/jZ4h83aaIDZjCgi4=;
        b=rMOU0Q65x/9uQvclXqN73ozDFm+SlsWxUWy2fbqu/ISYexQ+X6P28sbJB1PQkQavRj
         U9cWKjyUBfd4X6hFU3ALjlV9gmYdbvTvbLKdCwYto4k8Ys0Nte7p3ubdDJFdBQUIsv15
         hmTtnQcYoVQyRvsiZPDFfiElpBAQEDGsuYZNhnupa7X0giqHOdRoX+tUoczZwi/jP2rV
         02BXlVECfch7Gc0NOuzrLyS1bIruE4EfQ1VR7+Ft6mW9JhS9bj/p3TiQ3bd2efg3XLHj
         lXzHuKZZq8q4lDbNriKKhyI0Hd3X0Uc8qYk97hxe5mMdMh/UTxZ0TnMQEwdji7HYhPj8
         /YOQ==
X-Gm-Message-State: APjAAAUheqydJGlbo0TVXjyBDQYUpmHE8gA08WHUvxjmIDJiPQGF2be1
        At+XeavsTU1MVWr2C0HhtTC6oMd3WD0H5b88za/voQ==
X-Google-Smtp-Source: APXvYqwi/gC2tRuVoVXL6D/BduZh85HZttJXo5L2Nt3CxGmOKZXf5+ALHeiAbdAISNsOFx7oNtG6oh9zGbJaS1tnA3o=
X-Received: by 2002:a24:7908:: with SMTP id z8mr403403itc.16.1552597453231;
 Thu, 14 Mar 2019 14:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190227202658.197113-1-matthewgarrett@google.com> <20190314093515.GA11165@linux.intel.com>
In-Reply-To: <20190314093515.GA11165@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 14 Mar 2019 14:04:02 -0700
Message-ID: <CACdnJuuWMg6c1GJHR3EMobaZ1CwquNudjcgxwXNWczE=3DbQTg@mail.gmail.com>
Subject: Re: Add support for TCG2 log format on UEFI systems
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 2:35 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Feb 27, 2019 at 12:26:54PM -0800, Matthew Garrett wrote:
> > Identical to V4, but based on tpmdd-next
>
> This is not found /sys/kernel/security/tpm0/ascii_bios_measurements

That's expected - the existing kernel TCG2 log code doesn't expose
ascii_bios_measurements, only binary_bios_measurements. This patchset
doesn't change that.
